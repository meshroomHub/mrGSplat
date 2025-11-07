# -*- coding: utf-8 -*-

import os
import json
from pathlib import Path

from typing import Union, List, Dict, Tuple
from typing import Any, Dict, List, Optional

import numpy as np
import torch

from gsplatInterface.avImage import AvImage
from .interface import SfmReader, SfmPose, SfmLandmark
from .views import SfmView
from .camera import SfmIntrinsic
from ..normalize import (
    align_principle_axes,
    similarity_from_cameras,
    transform_cameras,
    transform_points,
)

from ..mesh import Mesh


class SfmSceneManager:
    def __init__(self, path: Union[str, Path]):
        if isinstance(path, str):
            path = Path(path)
        self._path = path
        self._sfmData = SfmReader(path)
    
    @property
    def intrinsics(self) -> List[SfmIntrinsic]:
        """
        Intrinsics are the camera parameters
        """
        return self._sfmData.intrinsics
    
    @property
    def views(self) -> List[SfmView]:
        """
        Views are the images we feed to the photogrammetry to get poses, landmarks, etc
        """
        return self._sfmData.views
    
    @property
    def poses(self) -> Dict[int, SfmPose]:
        """
        Poses are all the viewpoints extracted by the photogrammetry process
        """
        return self._sfmData.poses
    
    @property
    def landmarks(self) -> List[SfmLandmark]:
        """
        Landmarks are the reconstructed points in the 3D environment
        """
        return self._sfmData.landmarks
    
    @property
    def poseId_to_viewId(self) -> Dict[int, SfmView]:
        if getattr(self, "__poseId_to_viewId", None) is None:
            poseKeys = self.poses.keys()
            # Add poses that have views
            self.__poseId_to_viewId = {view.poseId: view.viewId for view in self.views if view.poseId in poseKeys}
            # Add poses with no views
            for poseId in poseKeys:
                if poseId not in self.__poseId_to_viewId.keys():
                    self.__poseId_to_viewId[poseId] = None
        return self.__poseId_to_viewId
    
    @property
    def viewId_to_poseId(self) -> Dict[int, SfmView]:
        if getattr(self, "__viewId_to_poseId", None) is None:
            self.__viewId_to_poseId = {view.viewId: view.poseId for view in self.views}
            for viewId, poseId in self.__viewId_to_poseId.items():
                if poseId not in self.poses:
                    self.__viewId_to_poseId[viewId] = None
        return self.__viewId_to_poseId
    
    @property
    def viewId_to_view(self) -> Dict[int, SfmView]:
        if getattr(self, "__viewId_to_view", None) is None:
            self.__viewId_to_view = {view.viewId: view for view in self.views}
        return self.__viewId_to_view
    
    @property
    def name_to_image_id(self) -> Dict[str, int]:
        if getattr(self, "__name_to_image_id", None) is None:
            self.__name_to_image_id = {}
            for view in self.views:
                imagePath = Path(view.imagePath).stem
                self.__name_to_image_id[imagePath] = view.frameId
        return self.__name_to_image_id
    
    @property
    def intrinsics_dict(self) -> Dict[int, SfmIntrinsic]:
        if getattr(self, "__intrinsics_dict", None) is None:
            self.__intrinsics_dict = {}
            for intrinsic in self.intrinsics:
                self.__intrinsics_dict[intrinsic.intrinsicId] = intrinsic
        return self.__intrinsics_dict
    @property
    def landmarkId_to_viewId(self):
        if getattr(self, "__landmarkId_to_viewId", None) is None:
            self.__landmarkId_to_viewId = {}
            for landmark in self.landmarks:
                observation_ids = landmark.observations.keys()
                # observation_ids = [obs.viewId for obs in landmark.observations.values()]
                self.__landmarkId_to_viewId[landmark.landmarkId] = observation_ids
        return self.__landmarkId_to_viewId


class Parser:
    def __init__(self,
                 sfmFile: str,
                 factor: Optional[int] = 1.0, 
                 normalize: Optional[bool] = False,
                 masksFolder: Optional[str] = None,
                 mesh: Optional[str] = None,
                 metadataFolder: Optional[str] = None,
                 image_alpha: bool = False):
        self.sfmFile = sfmFile
        self.factor = factor
        # TODO : not convienient to use different poses when we have normalization that depend on dataset
        self.normalize = False  # normalize  
        self.image_alpha = image_alpha
        
        manager = SfmSceneManager(self.sfmFile)
        
        self.masks_exist = masksFolder and os.path.isdir(masksFolder)

        # Extract extrinsic matrices in world-to-camera format.
        w2c_mats = []
        camera_ids = []
        Ks_dict = dict()
        imsize_dict = dict()  # width, height
        missing_poses = set()
        
        for k, view in enumerate(manager.views):
            pose = manager.poses.get(view.poseId, None)
            if pose is None:
                missing_poses.add(view.poseId)
                continue
            # Cam matrix (extrinsic)
            w2c = pose.get_w2c()
            w2c_mats.append(w2c)
            # Intrinsic
            camera_id = view.intrinsicId
            imsize_dict[camera_id] = (int(view.W // factor), int(view.H // factor))
            camera_ids.append(camera_id)
            intrinsic = manager.intrinsics_dict[camera_id]
            K = intrinsic.get_K()
            K[:2, :] /= factor
            Ks_dict[camera_id] = K
        
        print(f"[Parser] {len(manager.views)-len(missing_poses)}/{len(manager.views)} views, taken by {len(set(camera_ids))} cameras.")
        if len(manager.views)-len(missing_poses) <= 0:
            raise ValueError("No usable view !")

        w2c_mats = np.stack(w2c_mats, axis=0)

        # Convert extrinsics to camera-to-world.
        camtoworlds = np.linalg.inv(w2c_mats)
        
        # Image names
        image_names = [v.imageName for v in manager.views if v.poseId not in missing_poses]
        image_paths = [v.imagePath for v in manager.views if v.poseId not in missing_poses]
        # Reorder lists to sort by order of image
        inds = np.argsort(image_names)
        image_names = [image_names[i] for i in inds]
        image_paths = [image_paths[i] for i in inds]
        camtoworlds = camtoworlds[inds]
        camera_ids = [camera_ids[i] for i in inds]
        
        # Load external configuration (self.extconf) and bounds (self.bounds that is used in the trainer)
        self.extconf = {
            "spiral_radius_scale": 1.0,
            "no_factor_suffix": False,
        }
        self.bounds = np.array([0.01, 1.0])
        if metadataFolder:
            self.load_extconf(metadataFolder)
        
        # 3D points and {image_name -> [point_idx]}
        points = np.array([p.position for p in manager.landmarks])
        points_rgb = np.array([p.color for p in manager.landmarks])
        
        point_indices = {}
        for point_id, viewIds in manager.landmarkId_to_viewId.items():
            for viewId in viewIds:
                view = manager.viewId_to_view.get(viewId, None)
                if view is None:
                    continue
                point_indices.setdefault(view.imageName, []).append(point_id)
        point_indices = {
            k: np.array(v).astype(np.int32) for k, v in point_indices.items()
        }

        # Normalize the world space.
        self.T2 = None
        if self.normalize:
            # T1
            self.T1 = similarity_from_cameras(camtoworlds)
            camtoworlds = transform_cameras(self.T1, camtoworlds)
            points = transform_points(self.T1, points)
            # T2
            self.T2 = align_principle_axes(points)
            camtoworlds = transform_cameras(self.T2, camtoworlds)
            points = transform_points(self.T2, points)
            # Transformation matrix
            transform = self.T2 @ self.T1
        else:
            transform = np.eye(4)

        self.image_names = image_names  # List[str], (num_images,)
        self.image_paths = image_paths  # List[str], (num_images,)
        self.camtoworlds = camtoworlds  # np.ndarray, (num_images, 4, 4)
        self.camera_ids = camera_ids  # List[int], (num_images,)
        self.Ks_dict = Ks_dict  # Dict of camera_id -> K
        self.imsize_dict = imsize_dict  # Dict of camera_id -> (width, height)
        self.points = points  # np.ndarray, (num_points, 3)
        self.points_rgb = points_rgb  # np.ndarray, (num_points, 3)
        self.point_indices = point_indices  # Dict[str, np.ndarray], image_name -> [M,]
        self.transform = transform  # np.ndarray, (4, 4)
        
        self.mesh = Mesh(mesh)
        
        self.apply_scale()

        # size of the scene measured by cameras
        camera_locations = camtoworlds[:, :3, 3]
        scene_center = np.mean(camera_locations, axis=0)
        dists = np.linalg.norm(camera_locations - scene_center, axis=1)
        self.scene_scale = np.max(dists)
    
    def save_cameras(self, path):
        to_write = ""
        # Intrinsics
        to_write += "# == INTRINSICS ==\n"
        for cam_id, Ks in self.Ks_dict.items():
            params = []
            to_write += f"{cam_id} : K=[" + " ".join(list(map(str, Ks.flatten()))) + "] -> params=[" + " ".join(list(map(str, params))) + "]\n"
        # Poses
        to_write += "\n"
        to_write += "# == POSES ==\n"
        for imName, cam_id, c2w in zip(self.image_names, self.camera_ids, self.camtoworlds):
            to_write += f"# [Image {imName}] Cam={cam_id} -> c2w=[" + " ".join(list(map(str, c2w.flatten()))) + "]\n"
        with open(path, "w") as fo:
            fo.write(to_write)

    def load_extconf(self, metadataFolder):
        """
        TODO : we don't provide such files atm
        """
        # Load extended metadata. Used by Bilarf dataset.
        extconf_file = os.path.join(metadataFolder, "ext_metadata.json")
        if os.path.exists(extconf_file):
            with open(extconf_file) as f:
                self.extconf.update(json.load(f))
        # Load bounds if possible (only used in forward facing scenes).
        posefile = os.path.join(metadataFolder, "poses_bounds.npy")
        if os.path.exists(posefile):
            self.bounds = np.load(posefile)[:, -2:]
    
    def apply_scale(self, s_height=1, s_width=1):
        """ Sometimes the intrinsics corresponds to 2x upsampled images so we need to use this
        
        s_height = actual_height / colmap_height
        s_width  = actual_width  / colmap_width
        """
        if s_height==1 and s_width==1:
            return
        for camera_id, K in self.Ks_dict.items():
            K[1, :] *= s_height
            K[0, :] *= s_width
            self.Ks_dict[camera_id] = K
            width, height = self.imsize_dict[camera_id]
            self.imsize_dict[camera_id] = (int(width * s_width), int(height * s_height))
        # TODO : apply scale to mesh ?


class PoseParser(Parser):
    def __init__(self,
                 sfmFile: str,
                 factor: int = 1.0, 
                 normalize: bool = False,
                 masksFolder: str = None,
                 metadataFolder: str = None):
        self.sfmFile = sfmFile
        self.factor = factor
        # TODO : not convienient to use different poses when we have normalization that depend on dataset
        self.normalize = False  # normalize  
        
        manager = SfmSceneManager(self.sfmFile)
        
        self.masks_exist = masksFolder and os.path.isdir(masksFolder)

        # Extract extrinsic matrices in world-to-camera format.
        pose_ids = []
        w2c_mats = []
        camera_ids = []
        imsize_dict = dict()  # width, height
        intrinsicsDict = dict()
        
        for poseId, pose in manager.poses.items():
            # Cam matrix (extrinsic)
            pose_ids.append(poseId)
            w2c = pose.get_w2c()
            w2c_mats.append(w2c)
            viewId = manager.poseId_to_viewId.get(poseId, None)
            if viewId is None:
                camera_ids.append(None)
                continue
            view = manager.viewId_to_view[viewId]
            camera_ids.append(view.intrinsicId)
        
        for camera_id, intrinsic in manager.intrinsics_dict.items():
            imsize_dict[camera_id] = (int(intrinsic.W // factor), int(intrinsic.H // factor))
            K = intrinsic.get_K()
            K[:2, :] /= factor
            intrinsicsDict[camera_id] = K
        
        print(f"[BaseParser] {len(w2c_mats)} poses, taken by {len(set(camera_ids))} cameras.")
        if len(w2c_mats) <= 0:
            raise ValueError("No usable pose !")

        w2c_mats = np.stack(w2c_mats, axis=0)
        # Convert extrinsics to camera-to-world.
        camtoworlds = np.linalg.inv(w2c_mats)
        
        # Create order from pose ID
        inds = np.argsort(pose_ids)
        # Reorder lists
        pose_ids = [pose_ids[i] for i in inds]
        camtoworlds = camtoworlds[inds]
        camera_ids = [camera_ids[i] for i in inds]
        
        # Find images linked to poses if they exist
        image_names = []
        image_paths = []
        for poseId in pose_ids:
            viewId = manager.poseId_to_viewId.get(poseId, None)
            if viewId:
                view = manager.viewId_to_view[viewId]
                image_names.append(view.imageName)
                image_paths.append(view.imagePath)
            else:
                image_names.append(None)
                image_paths.append(None)
        
        # Load external configuration (self.extconf) and bounds (self.bounds that is used in the trainer)
        self.extconf = {
            "spiral_radius_scale": 1.0,
            "no_factor_suffix": False,
        }
        self.bounds = np.array([0.01, 1.0])
        if metadataFolder:
            self.load_extconf(metadataFolder)
        
        self.pose_ids = pose_ids  # List[str], (num_poses,)
        self.image_names = image_names  # List[str], (num_poses,)
        self.image_paths = image_paths  # List[str], (num_poses,)
        self.camtoworlds = camtoworlds  # np.ndarray, (num_poses, 4, 4)
        self.camera_ids = camera_ids  # List[int], (num_images,)
        self.Ks_dict = intrinsicsDict  # Dict of camera_id -> K
        self.imsize_dict = imsize_dict  # Dict of camera_id -> (width, height)
        
        self.apply_scale()


class Dataset:
    def __init__(
        self,
        parser: Parser,
        patch_size: Optional[int] = None,
        load_depths: bool = False,
        pre_load_images: bool = False,
    ):
        self.parser = parser
        self.patch_size = patch_size
        self.load_depths = load_depths
        self.indices = np.arange(len(self.parser.image_names))
        # Load images
        self.images = {}
        # Pre-load images
        if pre_load_images:
            for index in self.indices:
                self.get_image(index)
        # Masks
        if parser.masks_exist:
            raise ValueError("Parser mask is not supported. We use alpha to store masks")
            # self.masks = {}
            # self.mask_paths = {index: mask_path(self.parser.image_paths[index]) for index in self.indices}
            # # Pre-load masks
            # if pre_load_images:
            #     for index in self.indices:
            #         self.get_mask(index)
    
    def __len__(self):
        return len(self.indices)
    
    def get_image(self, index) -> AvImage:
        if index not in self.images.keys():
            self.images[index] = AvImage(self.parser.image_paths[index], alpha=self.parser.image_alpha, open=True)
        return self.images[index]
    
    # def get_mask(self, index):
    #     if index not in self.masks.keys():
    #         mask = AvImage(self.mask_paths[index], greyscale=True, open=True).pixels
    #         if len(mask.shape) == 2:
    #             self.masks[index] = mask
    #         elif len(mask.shape) == 3:
    #             self.masks[index] = mask[...,0]
    #             print(f"[Caution] Mask (index={index}) is not in greyscale : shape={mask.shape}")
    #         else:
    #             raise ValueError("Mask (index={index}) has shape {mask.shape} which is not handled")
    #     return self.masks[index]
    
    # def get_landmark_coordinates(self, item: int) -> Dict[int, Tuple[int, int, int]]:
    #     """ For each item (image index) get the coordinates of each landmark
    #     :return: { landmarkId: (x, y, depth), ... }
    #     """
    #     # Get camera matrix, intrinsics, image name and size
    #     index = self.indices[item]
    #     image_name = self.parser.image_names[index]
    #     camera_id = self.parser.camera_ids[index]
    #     W, H = self.parser.imsize_dict[camera_id]
    #     K = self.parser.Ks_dict[camera_id].copy()
    #     camtoworld = self.parser.camtoworlds[index]
    #     # Projected points to image plane
    #     worldtocam = np.linalg.inv(camtoworld)
    #     point_indices = self.parser.point_indices[image_name]
    #     points_world = self.parser.points[point_indices]
    #     points_cam = (worldtocam[:3, :3] @ points_world.T + worldtocam[:3, 3:4]).T
    #     points_proj = (K @ points_cam.T).T
    #     points = points_proj[:, :2] / points_proj[:, 2:3]  # (M, 2)
    #     depths = points_cam[:, 2]  # (M,)
    #     # filter out points outside the image
    #     mask = np.ones((len(point_indices)))
    #     if self.parser.masks_exist:
    #         maskImg = self.get_mask(index)
    #         mask[:] = maskImg[points[:]] < 0.01
    #     selector = (
    #           (points[:, 0] >= 0)
    #         & (points[:, 0] < W)
    #         & (points[:, 1] >= 0)
    #         & (points[:, 1] < H)
    #         & (depths > 0)
    #         & (mask[:] > 0)
    #     )
    #     point_indices = point_indices[selector]
    #     # Get final result
    #     landmarksCoords = {}
    #     for landmarkId in point_indices:
    #         x, y  = points[landmarkId]
    #         depth = depths[landmarkId]
    #         landmarksCoords[landmarkId] = (x, y, depth)
    #     return landmarksCoords

    def __getitem__(self, item: int) -> Dict[str, Any]:
        index = self.indices[item]
        # Load from disk:
        # image = imageio.imread(self.parser.image_paths[index])[..., :3]
        # All in memory:
        image = self.get_image(index)
        pixels = image.pixels
        camera_id = self.parser.camera_ids[index]
        K = self.parser.Ks_dict[camera_id].copy()  # undistorted K
        camtoworlds = self.parser.camtoworlds[index]
        # Load from disk:
        # mask = imageio.imread(mask_path)[..., :3]
        # mask = self.get_mask(index) if self.parser.masks_exist else None
        mask = None
        if image.hasAlpha:
            mask = image.get_alpha_mask()
        image_name = self.parser.image_names[index]

        if self.patch_size is not None:
            # Random crop.
            h, w = pixels.shape[:2]
            x = np.random.randint(0, max(w - self.patch_size, 1))
            y = np.random.randint(0, max(h - self.patch_size, 1))
            pixels = pixels[y : y + self.patch_size, x : x + self.patch_size]
            K[0, 2] -= x
            K[1, 2] -= y

        data = {
            "K": torch.from_numpy(K).float(),
            "camtoworld": torch.from_numpy(camtoworlds).float(),
            "image": torch.from_numpy(pixels).float(),
            "image_id": item,  # the index of the image in the dataset
            "image_name": image_name,
        }
        if mask is not None:
            # Rounding up to avoid compression issues (frequent with JPG format)
            mask = np.round(mask).astype(np.uint8)
            data["mask"] = torch.from_numpy(mask).bool()

        if self.load_depths:
            # projected points to image plane to get depths
            worldtocams = np.linalg.inv(camtoworlds)
            image_name = self.parser.image_names[index]
            point_indices = self.parser.point_indices[image_name]
            points_world = self.parser.points[point_indices]
            points_cam = (worldtocams[:3, :3] @ points_world.T + worldtocams[:3, 3:4]).T
            points_proj = (K @ points_cam.T).T
            points = points_proj[:, :2] / points_proj[:, 2:3]  # (M, 2)
            depths = points_cam[:, 2]  # (M,)
            # filter out points outside the image
            selector = (
                (points[:, 0] >= 0)
                & (points[:, 0] < pixels.shape[1])
                & (points[:, 1] >= 0)
                & (points[:, 1] < pixels.shape[0])
                & (depths > 0)
            )
            points = points[selector]
            depths = depths[selector]
            data["points"] = torch.from_numpy(points).float()
            data["depths"] = torch.from_numpy(depths).float()

        return data
