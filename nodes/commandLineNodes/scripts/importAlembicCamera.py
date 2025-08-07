
import os
import argparse
import numpy as np
from numpy.linalg import inv as invert

from shutil import copy
import cask
import imath
from scipy.spatial.transform import Rotation as R


class Quaternion:
    def __init__(self, x, y, z, w):
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    
    @classmethod
    def from_matrix(cls, matrix):
        r = R.from_matrix(matrix)
        # return cls(*r.as_quat(scalar_first=True))
        return cls(*r.as_quat())


class Vector:
    def __init__(self, x, y, z):
        if isinstance(x, np.ndarray):
            x, y, z = map(lambda val: val[0], (x, y, z))
        # Directly correct axis
        self.x = x
        self.y = y
        self.z = z


class CameraIntrinsics:
    # TODO
    
    def __init__(self):
        pass
    
    def toDict(self):
        pass


class CameraPoses:
    def __init__(self):
        # {frame_id : matrix}
        self.poses = {}
    
    def add_pose(self, frame_id, mat):
        assert isinstance(mat, imath.M44d)
        
        T = np.identity(4)
        for i in range(4):
            for j in range(4):
                T[i][j] = mat[j][i]

        # convert from computer graphics convention (opengl-like) to computer vision
        M = np.identity(4)
        M[1][1] = -1.0
        M[2][2] = -1.0
        
        T2 = invert(np.matmul(np.matmul(M, T), M))
        
        rotate = np.zeros((3, 3))
        translate = np.zeros((3, 1))
        for row_i in range(3):
            # Rotation
            for col_i in range(3):
                rotate[row_i][col_i]   = T2[row_i][col_i]
            # Translation
            translate[row_i] = T2[row_i][3]
        self.poses[frame_id] = (Quaternion.from_matrix(rotate), Vector(*translate))
    
    def get_pose(self, frame_id):
        pose = self.poses[frame_id]
        av_pose = None
        # TODO : create pose for alicevision format
        return av_pose


def get_poses_from_sfm(archive, path) -> CameraPoses:
    poses = CameraPoses()
    # /mvgRoot/mvgCameras/camxform_*/camera_camxform_*
    cameras = list(map(
        lambda x: (x, list(x.children.values())[0]),
        list(archive.top.children[path].children.values())
    ))
    for cam, cabObj in cameras:
        frame_index = cabObj.properties[".geom/.userProperties/mvg_frameId"].values[0]
        transform = cam.properties[".xform/.vals"].values[0]
        # mat = cabObj.properties[".geom/.core"].values[0]
        poses.add_pose(frame_index, transform)
    return poses


def create_sfm_with_poses(cameraPoses: CameraPoses, intrinsics: CameraIntrinsics) -> dict:
    poses = []
    for frame_id in cameraPoses.poses.keys():
        poses.append(cameraPoses.get_pose(frame_id))
    sfmData = {
        "intrinsics": [intrinsics.toDict()],
        "poses": poses,
    }
    return sfmData


def get_poses_from_abc(archive, path) -> CameraPoses:
    poses = CameraPoses()
    cam_poses = archive.top.children[path].properties[".xform/.vals"].values
    for frame_index, matrix in enumerate(cam_poses):
        poses.add_pose(frame_index, matrix)
    return poses


def main(args):
    # Find alembic file
    srcAlembicFilePath = args.alembicFile
    alembicPath     = args.alembicPath
    camerasFromSfm = False
    
    if not srcAlembicFilePath:
        camerasFromSfm = True
        sfmData = args.sfmData
        if os.path.splitext(sfmData)[1] == ".abc":
            srcAlembicFilePath = sfmData
        else:
            # Might be the sfm folder
            filename = "sfm.abc"
            if not os.path.exists(os.path.join(sfmData, filename)):
                filename = "cloud_and_poses.abc"
            srcAlembicFilePath = os.path.join(sfmData, filename)
        alembicPath = "mvgRoot/mvgCameras"
    
    if not os.path.exists(srcAlembicFilePath):
        # chunk.logger.error(f"Could not find alembic file {srcAlembicFilePath}")
        raise ValueError(f"Could not find alembic file {srcAlembicFilePath}")
    
    # Copy alembic file to output folder
    print(f"Copy the alembic file to the output folder : {srcAlembicFilePath}")
    alembicFilePath = os.path.join(args.result_dir, os.path.basename(srcAlembicFilePath))
    copy(srcAlembicFilePath, alembicFilePath)
    
    # Open alembic archive
    archive = cask.Archive(alembicFilePath)
    
    # Get poses
    cameraPoses = get_poses_from_sfm(archive, alembicPath) if camerasFromSfm else get_poses_from_abc(archive, alembicPath)
    
    # Export to file
    outputFile = os.path.join(args.result_dir, "sfmData.sfm")
    cameraPoses.exportToFile(outputFile)


if __name__ == "__main__":
    """
    gsPrepareCamera --result_dir output
    Then either :
        --sfmData sfmDataFolder
    or :
        --alembicFile alembicFile --alembicPath alembicPath
    """
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--result_dir", type=str, required=True, help="Output folder"
    )
    parser.add_argument(
        "--sfmData", type=str, required=False, help="SFM data folder"
    )
    parser.add_argument(
        "--alembicFile", type=str, required=False, help="Alembic file"
    )
    parser.add_argument(
        "--alembicPath", type=str, required=False, help="Path in the alembic file"
    )
    
    args = parser.parse_args()
    
    main(args)
