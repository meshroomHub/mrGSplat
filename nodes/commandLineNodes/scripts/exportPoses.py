import argparse
import os
import sys
import json
from pathlib import Path

import numpy as np
from numpy.linalg import inv as invert
from scipy.spatial.transform import Rotation as R

import torch
import torch.nn.functional as F


OUTPUT_FOLDER = "/tmp"


class SfmView:
    def __init__(self, viewId: int, viewDict: dict):
        self.viewId = int(viewId)
        self.__view = viewDict
    
    @property
    def imageName(self):
        return os.path.basename(self.__view.get("path"))
    
    @property
    def poseId(self):
        return int(self.__view.get("poseId"))


class SfmPose:
    def __init__(self, poseId: int, poseDict: dict):
        self.__poseId = int(poseId)
        self.T = None
        self.R = None
        self.C = None
        self.load_extrinsics(poseDict)
    
    def load_extrinsics(self, poseDict):
        transform = poseDict.get("pose", {}).get("transform", {})
        rotation = transform.get("rotation")
        center = np.zeros((3, 1))
        for i, el in enumerate(transform.get("center")):
            center[i] = float(el)
        
        T = np.identity(4)
        for i in range(4):
            for j in range(4):
                if i < 3 and j < 3:
                    T[i][j] = rotation[j + 3*i]
                elif j==3 and i<3:
                    T[i][j] = center[i]
        
        T2 = invert(T)
        
        rotate = np.zeros((3, 3))
        translate = np.zeros((3, 1))
        for row_i in range(3):
            # Rotation
            for col_i in range(3):
                rotate[row_i][col_i] = T2[row_i][col_i]
            # Translation
            translate[row_i] = T2[row_i][3]
        
        self.T = translate
        self.R = rotate
        self.C = center
        
    def get_w2c(self):
        bottom = np.array([0, 0, 0, 1]).reshape(1, 4)
        rot = self.R
        trans = self.T.reshape(3, 1)
        mat = np.concatenate([np.concatenate([rot, trans], 1), bottom], axis=0)
        return mat


class SfmSceneManager:
    def __init__(self, path):
        if isinstance(path, str):
            path = Path(path)
        self.sfmFile = path
        self.__content = {}
        self.load()
    
    @staticmethod
    def convert_to_json(filepath: Path):
        try:
            from pyalicevision import sfmData
            from pyalicevision import sfmDataIO
        except Exception as _:
            raise ImportError("[Sfm Reader] Could not import pyaliceVision (required ot convert format {filepath.suffix} to JSON)")
        print(f"Convert SFM {filepath} to JSON")
        ouput_json = os.path.join(OUTPUT_FOLDER, "save_sfm.json")
        dataAV = sfmData.SfMData()
        if sfmDataIO.load(dataAV, str(filepath), sfmDataIO.ALL):
            if sfmDataIO.save(dataAV, ouput_json, sfmDataIO.ALL):
                return ouput_json
            else:
                raise SystemError(f"Could not save SFM file to {ouput_json}")
        else:
            raise ValueError(f"Could not read SFM file {filepath}")
    
    def load(self):
        print("Loading SFM from file {self.sfmFile}")
        if self.sfmFile.suffix == ".json":
            print(f"Read SFM Json file {self.sfmFile}")
            with open(self.sfmFile, "r") as fo:
                self.__content = json.load(fo)
        else:
            self.sfmFile = self.convert_to_json(self.sfmFile)
            self.load()
    
    @property
    def views(self):
        if getattr(self, "_views", None) is None:
            self._views = []
            for viewDict in self.__content.get("views", []):
                viewId = viewDict.pop("viewId")
                self._views.append(SfmView(viewId, viewDict))
        return self._views
    
    @property
    def poses(self):
        if getattr(self, "_poses", None) is None:
            self._poses = {}
            for poseDict in self.__content.get("poses", []):
                poseId = int(poseDict.pop("poseId"))
                self._poses[poseId] = SfmPose(poseId, poseDict)
        return self._poses
    
    @property
    def poseId_to_viewId(self):
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
    def viewId_to_view(self):
        if getattr(self, "__viewId_to_view", None) is None:
            self.__viewId_to_view = {view.viewId: view for view in self.views}
        return self.__viewId_to_view


class PoseParser:
    def __init__(self, sfmFile, factor=1.0):
        self.sfmFile = sfmFile
        self.factor = factor
        
        manager = SfmSceneManager(self.sfmFile)
        
        pose_ids = []
        w2c_mats = []
        for poseId, pose in manager.poses.items():
            pose_ids.append(poseId)
            w2c = pose.get_w2c()
            w2c_mats.append(w2c)
        
        w2c_mats = np.stack(w2c_mats, axis=0)
        # Convert extrinsics to camera-to-world.
        camtoworlds = np.linalg.inv(w2c_mats)
        
        # Create order from pose ID
        inds = np.argsort(pose_ids)
        # Reorder lists
        pose_ids = [pose_ids[i] for i in inds]
        camtoworlds = camtoworlds[inds]
        
        # Find images linked to poses if they exist
        image_names = []
        for poseId in pose_ids:
            viewId = manager.poseId_to_viewId.get(poseId, None)
            if viewId:
                view = manager.viewId_to_view[viewId]
                image_names.append(view.imageName)
            else:
                image_names.append(None)
        
        self.pose_ids = pose_ids        # List[str], (num_poses,)
        self.image_names = image_names  # List[str], (num_poses,)
        self.camtoworlds = camtoworlds  # np.ndarray, (num_poses, 4, 4)


def rotation_6d_to_matrix(d6):
    a1, a2 = d6[..., :3], d6[..., 3:]
    b1 = F.normalize(a1, dim=-1)
    b2 = a2 - (b1 * a2).sum(-1, keepdim=True) * b1
    b2 = F.normalize(b2, dim=-1)
    b3 = torch.cross(b1, b2, dim=-1)
    return torch.stack((b1, b2, b3), dim=-2)


class CameraOptModule(torch.nn.Module):
    def __init__(self, n: int):
        super().__init__()
        # Delta positions (3D) + Delta rotations (6D)
        self.embeds = torch.nn.Embedding(n, 9)
        # Identity rotation in 6D representation
        self.register_buffer("identity", torch.tensor([1.0, 0.0, 0.0, 0.0, 1.0, 0.0]))

    def zero_init(self):
        torch.nn.init.zeros_(self.embeds.weight)
    
    def forward(self, camtoworlds, embed_ids):
        # TODO : test with a raise error here, becaus ewe should not use the forward func in this script
        assert camtoworlds.shape[:-2] == embed_ids.shape
        batch_shape = camtoworlds.shape[:-2]
        pose_deltas = self.embeds(embed_ids)  # (..., 9)
        dx, drot = pose_deltas[..., :3], pose_deltas[..., 3:]
        rot = rotation_6d_to_matrix(
            drot + self.identity.expand(*batch_shape, -1)
        )  # (..., 3, 3)
        transform = torch.eye(4, device=pose_deltas.device).repeat((*batch_shape, 1, 1))
        transform[..., :3, :3] = rot
        transform[..., :3, 3] = dx
        return torch.matmul(camtoworlds.float(), transform.float())


@torch.no_grad()
def update_poses(model, poses, image_names):
    device = "cpu"
    # Get camtoworlds and image_ids
    camtoworlds = torch.from_numpy(poses).to(device)
    image_ids = torch.from_numpy(np.arange(len(image_names))).to(device)
    # Load CameraOptModule
    module = CameraOptModule(model["embeds.weight"].shape[0])
    module.zero_init()
    module.load_state_dict(model)
    # Update camtoworlds
    camtoworlds = module(camtoworlds, image_ids)
    return camtoworlds.numpy()


def create_sfm(inputSfmFile, poses):
    poseIdsIndex = {int(p_id): i for i, p_id in enumerate(PoseParser(inputSfmFile).pose_ids)}
    with open(inputSfmFile, "r") as f:
        sfm_data = json.load(f)
    for pose in sfm_data["poses"]:
        poseId = int(pose["poseId"])
        updated_pose = poses[poseIdsIndex[poseId]]
        rot    = updated_pose[:3,:3].reshape(9)
        center = updated_pose[:3, 3].reshape(3)
        # Extract rot and center
        # Get pose dict
        poseDict = {
            "rotation": [str(x) for x in rot   ],
            "center"  : [str(x) for x in center]
        }
        pose["pose"]["transform"] = poseDict
    return sfm_data


def main(modelPath, inputSfmFile, outputPoseFile, outputSfmFile):
    # Load view and poses
    poses = PoseParser(inputSfmFile)
    # Load model
    model = torch.load(modelPath, map_location='cpu')['pose_adjust']
    # Get new poses
    new_poses = update_poses(model, poses.camtoworlds, poses.image_names)
    # Save poses
    np.save(outputPoseFile, model)
    # Create sfm
    sfm_data = create_sfm(inputSfmFile, new_poses)
    with open(outputSfmFile, 'w') as f:
        json.dump(sfm_data, f, indent=4)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("model", type=str, help="Model")
    parser.add_argument("sfmInput", type=str, help="Input SFM")
    parser.add_argument("outputFolder", type=str, help="Output folder")
    args = parser.parse_args()
    
    OUTPUT_FOLDER = args.outputFolder
    outputPoseFile = os.path.join(args.outputFolder, "poses.npy")
    outputSfmFile = os.path.join(args.outputFolder, "sfm.json")
    main(args.model, args.sfmInput, outputPoseFile, outputSfmFile)
