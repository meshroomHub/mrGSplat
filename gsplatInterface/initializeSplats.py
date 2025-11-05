# -*- coding: utf-8 -*-

import os
import json

from common import CameraState, createProgressBar, createProgressBarRange

from dataclasses import dataclass
from typing import Dict, Optional, Tuple, Union, Literal

import numpy as np
import torch
import torch.nn.functional as F
from datasets.sfm import Dataset, Parser
from torch import Tensor
from utils import knn, rgb_to_sh, set_random_seed
from sklearn.neighbors import NearestNeighbors

from gsplat.distributed import cli, all_gather_tensor_list
from gsplat.cuda._wrapper import fully_fused_projection
from gsplat.rendering import rasterization
from gsplat.strategy import DefaultStrategy


@dataclass
class Config:
    # Path to the dataset, masks and metadata folders
    sfm_file: str = "sfm.json"
    result_dir: str = ""
    metadata_folder: str = ""
    # Use Segmentation masks
    use_masks: bool = False
    
    # Downsample factor for the dataset
    data_factor: int = 1
    # Random crop size for training  (experimental)
    patch_size: Optional[int] = None
    # A global scaler that applies to the scene size related parameters
    global_scale: float = 1.0
    # Camera model
    camera_model: Literal["pinhole", "ortho", "fisheye"] = "pinhole"

    # Sfm
    init_type: str = "sfm"
    # Initial number of GSs. Ignored if using sfm
    init_num_pts: int = 100_000
    # Initial extent of GSs as a multiple of the camera extent. Ignored if using sfm
    init_extent: float = 3.0
    # Degree of spherical harmonics
    sh_degree: int = 3
    # Initial opacity of GS
    init_opa: float = 0.1
    # Initial scale of GS
    init_scale: float = 1.0

    # Use packed mode for rasterization, this leads to less memory usage but slightly slower.
    packed: bool = False
    # Use sparse gradients for optimization. (experimental)
    sparse_grad: bool = False
    # Anti-aliasing in rasterization. Might slightly hurt quantitative metrics.
    antialiased: bool = False

    # Enable depth loss. (experimental)
    depth_loss: bool = False


def create_splats_with_optimizers(
    parser: Parser,
    init_type: str = "sfm",
    init_num_pts: int = 100_000,
    init_extent: float = 3.0,
    init_opacity: float = 0.1,
    init_scale: float = 1.0,
    scene_scale: float = 1.0,
    sh_degree: int = 3,
    device: str = "cuda",
    world_rank: int = 0,
    world_size: int = 1,
) -> Tuple[torch.nn.ParameterDict, Dict[str, torch.optim.Optimizer]]:
    if init_type == "sfm":
        points = torch.from_numpy(parser.points).float()
        rgbs = torch.from_numpy(parser.points_rgb / 255.0).float()
    elif init_type == "random":
        points = init_extent * scene_scale * (torch.rand((init_num_pts, 3)) * 2 - 1)
        rgbs = torch.rand((init_num_pts, 3))
    else:
        raise ValueError("Please specify a correct init_type: sfm or random")

    # Initialize the GS size to be the average dist of the 3 nearest neighbors
    dist2_avg = (knn(points, 4)[:, 1:] ** 2).mean(dim=-1)  # [N,]
    dist_avg = torch.sqrt(dist2_avg)
    scales = torch.log(dist_avg * init_scale).unsqueeze(-1).repeat(1, 3)  # [N, 3]

    # Distribute the GSs to different ranks (also works for single rank)
    points = points[world_rank::world_size]
    rgbs = rgbs[world_rank::world_size]
    scales = scales[world_rank::world_size]

    N = points.shape[0]
    quats = torch.rand((N, 4))  # [N, 4]
    opacities = torch.logit(torch.full((N,), init_opacity))  # [N,]

    params = [
        # name, value, lr
        ("means", torch.nn.Parameter(points), 1.6e-4 * scene_scale),
        ("scales", torch.nn.Parameter(scales), 5e-3),
        ("quats", torch.nn.Parameter(quats), 1e-3),
        ("opacities", torch.nn.Parameter(opacities), 5e-2),
    ]

    # color is SH coefficients.
    # colors = torch.zeros((N, (sh_degree + 1) ** 2, 3))  # [N, K, 3]
    # colors[:, 0, :] = rgb_to_sh(rgbs)
    # params.append(("sh0", torch.nn.Parameter(colors[:, :1, :]), 2.5e-3))
    # params.append(("shN", torch.nn.Parameter(colors[:, 1:, :]), 2.5e-3 / 20))

    splats = torch.nn.ParameterDict({n: v for n, v, _ in params}).to(device)
    
    return splats


def get_landmarks_visibility(landmarks, maxRadius=1, minRadius=0.5):
    """ For a given image get the visibility of each landmark. (i.e. an estimation of chances that 
    the landmark is directly seen by the camera)
    
    :param landmarks: list of projected coordinates on image plane
    :param maxRadius: search radius for neighbors
    :param minRadius: if distance to neighbor is under this we estimate that both will land on the same pixel 
                      for this image
    """
    maxRadius = float(maxRadius)
    # landmarks = { landmarkId: (x, y, depth), ... }
    landmarkKeys = list(landmarks.keys())              # [ 0, 3, 5, 6, 8, ...]
    landmarks    = np.array(list(landmarks.values()))  # [ (x, y, depth), ... ]
    landmarksPos   = landmarks[:,:2]
    landmarksDepth = landmarks[:,2]
    nbrs = NearestNeighbors(n_neighbors=len(landmarksPos), algorithm='ball_tree').fit(landmarksPos)
    distances, indices = nbrs.radius_neighbors(landmarksPos, radius=maxRadius, return_distance=True, sort_results=True)
    visibility = []
    for k, (pts_i, pts_d) in enumerate(zip(indices, distances)):
        k_index = landmarkKeys[k]
        k_depth = landmarksDepth[k]
        # Order surrounding points : distance to k < depth < index
        closestPoints = sorted([(_d, landmarksDepth[_i]) for _i, _d in zip(pts_i, pts_d) if _i != k])
        if len(closestPoints) == 0:
            visibility.append((k_index, 1))
            continue
        ptWithLowerDepth = min(np.array(closestPoints)[:,1])
        closestToKDist, closestToKDepth = closestPoints[0]
        # print(k, [tuple(landmarksPos[k].tolist()), k_depth], "->", closestPoints)
        if k_depth <= ptWithLowerDepth:
            # k is the nearest point in its surroundings
            visibility.append((k_index, 1))
        # Else a point in k's surrounding is closer to the camera than k
        elif closestToKDist <= minRadius:
            # point is really close to k (~ same pixel)
            visibility.append((k_index, 0))
        else:
            # k is surrounded by a closer point but that might not completely cover k
            visibility.append((k_index, closestToKDist/maxRadius))
    return visibility


class Runner:
    def __init__(self, cfg: Config) -> None:
        self.cfg = cfg

        # Load data: Training data should contain initial points and colors.
        self.parser = Parser(
            sfmFile=cfg.sfm_file,
            factor=cfg.data_factor,
            normalize=False,
            metadataFolder=cfg.metadata_folder,
        )
        self.dataset = Dataset(
            self.parser,
            patch_size=cfg.patch_size,
            load_depths=cfg.depth_loss,
        )
    
    def create_structure(self):
        # A. For each pixel of every image we want 1 landmark at most, the closest one
        # B. For each landmark we need at least an image (but not necessarily the image from which the landmark is closest)
        # How to do that :
        # - First for each image assign landmarks (with depth info) to their pixels
        # - Then for each landmark try to see if there is a landmark in the near pixels with lower depth
        # - Parametrize the search on a specific numbber of surrounding pixels (it will mostly depend on mesh density)
        # - If the landmark is probably below another pixel then depending on how far it is lower the visibility percentage
        #   -> landmark is directly seenand no surrounding landmarks -> visibility=MAX
        #   -> landmark is directly below another one (same pixel, higher depth) -> visibility=0
        #   -> landmark is indirectly below another one (neighbor pixel, higher depth) -> visibility=N (N=distance to pixel that could cover it)
        # - Now for each landmark, choose the image with higher visibility
        # - Now for each landmark, choose the image with higher visibility
        imageLandmarksInfos = {}  # { img_index: { landmarkId: (x, y, depth), ... } }
        landmarksVisibility = {}
        for img_index in range(len(self.dataset)):
            # landmarksPos = { landmarkId: (x, y, depth), ... }
            landmarksPos = self.dataset.get_landmark_coordinates(img_index)
            imageLandmarksInfos[img_index] = landmarksPos
            for landmarkId, visibility in get_landmarks_visibility(landmarksPos):
                currentVisibility, _ = landmarksVisibility.get(landmarkId, (None, None))
                if currentVisibility is None or visibility < currentVisibility:
                    landmarksVisibility[landmarkId] = (visibility, img_index)
        # landmarksVisibility = { landmarkId : img_index }
        # landmarkToImage = {landmarkId: landmark_vis[1] for landmarkId, landmark_vis in landmarksVisibility.items() if landmark_vis[0] == 1}
        landmarkToImage = {landmarkId: landmark_vis[1] for landmarkId, landmark_vis in landmarksVisibility.items()}
        structure = {lid: {img_index: imageLandmarksInfos[img_index][lid][:2]} for lid, img_index in landmarkToImage.items()}
        return structure
    
    def create_model(self, local_rank: int, world_rank, world_size: int):
        device = f"cuda:{local_rank}"
        scene_scale = self.parser.scene_scale * 1.1 * cfg.global_scale
        print("Scene scale:", scene_scale)
        splats = create_splats_with_optimizers(
            self.parser,
            init_type=cfg.init_type,
            init_num_pts=cfg.init_num_pts,
            init_extent=cfg.init_extent,
            init_opacity=cfg.init_opa,
            init_scale=cfg.init_scale,
            scene_scale=scene_scale,
            sh_degree=cfg.sh_degree,
            device=device,
            world_rank=world_rank,
            world_size=world_size,
        )
        print("Model initialized. Number of GS:", len(splats["means"]))
        return splats
    
    def export_sfm(self, structure, path):
        # structure : { landmark_id : { image_id : (x, y) } }
        # Open input sfm
        with open(self.parser.sfmFile, "r") as fo:
            content = json.load(fo)
        # Create image_id -> index
        image_name_to_id = {}
        for image in content.get("views"):
            view_id = image.get("viewId")
            image_name = os.path.splitext(os.path.basename(image.get("path")).lower())[0]
            image_name_to_id[image_name] = int(view_id)
        view_id_to_index = {}
        for i, im_name in enumerate(self.parser.image_names):
            image_name = os.path.splitext(im_name.lower())[0]
            image_id = image_name_to_id[image_name]
            view_id_to_index[image_id] = i
        # Create new structure list
        newStructure = []
        for landmarkDict in content.get("structure"):
            landmarkId = int(landmarkDict.get("landmarkId"))
            landmarkDict["descType"] = "dspsift"
            observationsList = landmarkDict.get("observations")
            newObservations = []
            for observationDict in observationsList:
                view_id = int(observationDict.get("observationId"))
                image_id = view_id_to_index[view_id]
                if image_id not in structure[landmarkId]:
                    continue
                x = structure[landmarkId][image_id]
                observationDict["x"] = [str(x[0]), str(x[1])]
                observationDict["scale"] = "1.0"
                newObservations.append(observationDict)
            landmarkDict["observations"] = newObservations
            newStructure.append(landmarkDict)
        content["structure"] = newStructure
        with open(path, "w") as fo:
            json.dump(content, fo, indent=4)


            
def main(local_rank: int, world_rank, world_size: int, cfg: Config):
    set_random_seed(42 + local_rank)
    # Create runner
    runner = Runner(cfg)
    # Init model
    structure = runner.create_structure()
    # # Create model
    # model = runner.create_model(local_rank, world_rank, world_size)
    # Export model
    sfm_path = os.path.join(cfg.result_dir, "sfm.json")
    runner.export_sfm(structure, sfm_path)


if __name__ == "__main__":
    import sys
    from argparse_dataclass import ArgumentParser

    # Config objects we can choose between.
    # Each is a tuple of (CLI description, config object).
    configs = {
        "default": ( "Gaussian splatting initialization", Config() )
    }
    parser = ArgumentParser(configs, prebuilt=True)
    cfg = parser.parse_args(sys.argv[1:])
    
    cli(main, cfg, verbose=True)
