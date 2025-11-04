import os
from collections import OrderedDict
from typing import Union

import numpy as np

from datasets.normalize import (
    transform_cameras,
)

from datasets.sfm.sceneManager import SfmSceneManager
from datasets.sfm.camera import SfmExtrinsic



class Cam:
    def __init__(self, extrinsic: SfmExtrinsic):
        self.__extrinsic = extrinsic

    @property
    def R(self):
        return self.__extrinsic.R

    @property
    def C(self):
        return self.__extrinsic.C

    @property
    def t(self):
        return self.__extrinsic.T


class CameraManager:
    def __init__(self, cam_poses: Union[str, SfmSceneManager]):
        if isinstance(cam_poses, str) and os.path.exists(cam_poses):
            self.cam_poses_path = cam_poses
            self.cam_poses = None
        elif isinstance(cam_poses, SfmSceneManager):
            self.cam_poses = cam_poses
            self.cam_poses_path = cam_poses._path
        else:
            raise ValueError(f"Cannot get poses from {cam_poses}")
        self.poses = OrderedDict()
        self.pose_id_to_img_name = {}

    def load(self):
        if self.cam_poses is None:
            sfmFilePath = self.cam_poses_path
            if os.path.isdir(sfmFilePath):
                sfmFilePath = os.path.join(self.cam_poses_path, 'sfm.json')
            if not os.path.isfile(sfmFilePath):
                raise FileExistsError(f"Could not find Sfm file in {self.cam_poses_path}")
            self.cam_poses = SfmSceneManager(sfmFilePath)
            self.cam_poses_path = self.cam_poses._path
        print(f"load poses from {self.cam_poses_path}")
        # Load poses from SFM file
        self.poses = OrderedDict()
        for view in self.cam_poses.views:
            pose = self.cam_poses.poses[view.poseId]
            self.poses[view.poseId] = Cam(pose.extrinsic)
            self.pose_id_to_img_name[view.poseId] = view.imageName
        print(f"found {len(self.poses)} poses")


class CameraParser:
    def __init__(self, pose_file: str, factor: int = 1, normalize: bool = False, normalizeMatrices = None):
        self.pose_file = pose_file
        self.factor = factor
        self.normalize = normalize

        assert os.path.exists(pose_file), f"Camera poses file or folder {pose_file} does not exist."
        manager = CameraManager(pose_file)
        manager.load()
        
        # Extract extrinsic matrices in world-to-camera format.
        w2c_mats = []
        camera_ids = []
        image_names = []
        bottom = np.array([0, 0, 0, 1]).reshape(1, 4)
        for pose_id, pose in manager.poses.items():
            rot = pose.R()
            trans = pose.tvec.reshape(3, 1)
            w2c = np.concatenate([np.concatenate([rot, trans], 1), bottom], axis=0)
            w2c_mats.append(w2c)
            # support different camera intrinsics
            camera_id = pose.camera_id
            camera_ids.append(camera_id)
            image_names.append(manager.pose_id_to_img_name[pose_id])
        
        w2c_mats = np.stack(w2c_mats, axis=0)

        # Convert extrinsics to camera-to-world.
        camtoworlds = np.linalg.inv(w2c_mats)
        
        sorting_list = camera_ids
        for n in image_names:
            if not n or "unknown" in os.path.basename(n).lower():
                break
        else:
            sorting_list = image_names
        
        inds = np.argsort(sorting_list)
        camera_ids = [camera_ids[i] for i in inds]
        camtoworlds = camtoworlds[inds]

        # Normalize the world space.
        if normalize and normalizeMatrices is not None:
            T1, T2 = normalizeMatrices
            if T1 is not None:
                camtoworlds = transform_cameras(T1, camtoworlds)
            if T2 is not None:
                camtoworlds = transform_cameras(T2, camtoworlds)

        self.camtoworlds = camtoworlds  # np.ndarray, (num_images, 4, 4)
        self.camera_ids = camera_ids  # List[int], (num_images,)
