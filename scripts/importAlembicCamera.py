
import os
import argparse
from shutil import copy
import json

import cask
import imath
import numpy as np
from numpy.linalg import inv as invert
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
    
    def __str__(self):
        return f"<Quaternion {self.w:.05f} {self.x:.05f} {self.y:.05f} {self.z:.05f}>"


class Rotation:
    def __init__(self, matrix):
        self.matrix = matrix
    
    def as_quat(self):
        return Quaternion.from_matrix(self.matrix)
    
    def to_list(self):
        return np.reshape(np.transpose(self.matrix), 9)
    
    def __str__(self):
        vals = ", ".join([f"{x:.05f}" for x in self.to_list()])
        return f"<Rotation {vals}>"


class Vector:
    def __init__(self, x, y, z):
        if isinstance(x, np.ndarray):
            x, y, z = map(lambda val: val[0], (x, y, z))
        # Directly correct axis
        self.x = x
        self.y = y
        self.z = z
    
    def to_list(self):
        return [self.x, self.y, self.z]
    
    def __str__(self):
        return f"<Vector {self.x:.03f} {self.y:.03f} {self.z:.03f}>"


class CameraIntrinsics:
    def __init__(self, width=1920, height=1080, focalLength=26.5, sensorWidth=36, sensorHeight=20.25):
        self.width = width
        self.height = height
        self.focalLength = focalLength
        self.sensorWidth = sensorWidth
        self.sensorHeight = sensorHeight
    
    def toDict(self):
        return {
            "intrinsicId": str(id(self)),
            "width": str(self.width),
            "height": str(self.height),
            "sensorWidth": str(self.sensorWidth),
            "sensorHeight": str(self.sensorHeight),
            "serialNumber": "",
            "type": "pinhole",
            "initializationMode": "unknown",
            "initialFocalLength": "-1",
            "focalLength": str(float(self.focalLength)),
            "pixelRatio": "1",
            "pixelRatioLocked": "true",
            "offsetLocked": "false",
            "scaleLocked": "false",
            "principalPoint": ["0", "0"],
            "distortionLocked": "false",
            "distortionInitializationMode": "none",
            "distortionParams": ["0", "0", "0"],
            "undistortionOffset": ["0", "0"],
            "undistortionParams": "",
            "distortionType": "radialk3",
            "undistortionType": "none",
            "locked": "false"
        }
    
    def __str__(self):
        return f"<Intrinsic {str(id(self))} {self.width}x{self.height} (fl={self.focalLength})>"


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
        center = T[:3,3] * np.array([1, -1, -1])

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
        self.poses[frame_id] = (Rotation(rotate), Vector(*center), Vector(*translate))
    
    def to_format(self):
        poses = []
        for poseId, pose in self.poses.items():
            rotation, center, _ = pose
            poseDict = {
                "poseId": str(poseId),
                "pose": {
                    "transform": {
                        "rotation": [str(x) for x in rotation.to_list()],
                        "center": [str(x) for x in center.to_list()]
                    },
                    "locked": "false",
                    "rotationOnly": "false",
                    "removable": "true"
                }
            }
            poses.append(poseDict)
        return poses
    
    def getViews(self, intrinsic):
        views = []
        inds = np.argsort(np.array(list(self.poses.keys())))
        for frameIndex, poseId in enumerate(inds):
            viewDict = {
                "viewId": str(poseId),
                "poseId": str(poseId),
                "frameId": str(frameIndex),
                "intrinsicId": str(id(intrinsic)),
                "path": f"dummy_frame_{frameIndex:06d}.jpg",
                "width": str(intrinsic.width),
                "height": str(intrinsic.height),
                "metadata": {}
            }
            views.append(viewDict)
        return views


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
        alembicPath = "/mvgRoot/mvgCameras"
    
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
    
    # Get intrinsic
    intrinsicsArgs = {
        "width": args.width,
        "height": args.height,
        "sensorWidth": args.sensorWidth,
        "sensorHeight": args.sensorHeight,
        "focalLength": args.focalLength
    }
    intrinsic = CameraIntrinsics(**intrinsicsArgs)
    
    # Export to file
    outputFile = os.path.join(args.result_dir, "sfmData.json")
    sfm_data = {
        "version": ["1","2","12"],
        "views": cameraPoses.getViews(intrinsic),
        "poses": cameraPoses.to_format(),
        "intrinsics": [intrinsic.toDict()]
    }
    with open(outputFile, 'w') as f:
        json.dump(sfm_data, f, indent=4)
    

if __name__ == "__main__":
    """
    gsPrepareCamera --result_dir output
    Then either :
        --sfmData sfmDataFolder
    or :
        --alembicFile alembicFile --alembicPath alembicPath
    """
    parser = argparse.ArgumentParser()
    # General params
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
    # Intrinsics
    parser.add_argument("--width", type=int, default=1920, required=False, help="Camera width")
    parser.add_argument("--height", type=int, default=1080, required=False, help="Camera height")
    parser.add_argument("--sensorWidth", type=float, default=36, required=False, help="Sensor width")
    parser.add_argument("--sensorHeight", type=float, default=20.25, required=False, help="Sensor height")
    parser.add_argument("--focalLength", type=float, default=26.5, required=False, help="Focal length")
    
    args = parser.parse_args()
    
    main(args)
