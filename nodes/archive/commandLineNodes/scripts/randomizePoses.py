import argparse
import json

import numpy as np
from scipy.spatial.transform import Rotation as R


class TransformationMatrix:
    def __init__(self, rotation, center):
        mat = np.array(rotation).reshape(3,3)
        self.rotation = self.rotMatToQuat(mat)
        self.center = center
    
    @staticmethod
    def rotMatToQuat(mat):
        r = R.from_matrix(mat)
        quat = r.as_quat()
        return quat
    
    @staticmethod
    def quatToRotMat(quat):
        r = R.from_quat(quat)
        mat = r.as_matrix()
        return mat
    
    def add_noise(self, poseId, translationNoise, rotationNoise):
        noise = 2*np.random.uniform(size=7)-1
        self.center   += (translationNoise * noise[:3])
        self.rotation += (rotationNoise    * noise[3:])
    
    def as_dict(self):
        transform = {
            "rotation": [str(x) for x in self.quatToRotMat(self.rotation).reshape(9)],
            "center": [str(x) for x in self.center]
        }
        return transform


def load_poses(inputSfmPath):
    with open(inputSfmPath, "r") as f:
        content = json.load(f)
    poses = {}
    for pose in content["poses"]:
        transform = pose["pose"]["transform"]
        rotation = [float(x) for x in transform["rotation"]]
        center = [float(x) for x in transform["center"]]
        poses[pose["poseId"]] = TransformationMatrix(rotation, center)
    return poses


def apply_noise(poses, translationNoise, rotationNoise):
    for poseId, mat in poses.items():
        mat.add_noise(poseId, translationNoise, rotationNoise)


def update_sfm_poses(inputSfmPath, poses):
    with open(inputSfmPath, "r") as f:
        content = json.load(f)
    for pose in content["poses"]:
        poseId = pose["poseId"]
        # Update transform
        pose["pose"]["transform"] = poses[poseId].as_dict()
    return content


def export_sfm(sfm_data, outputSfmPath):
    with open(outputSfmPath, 'w') as f:
        json.dump(sfm_data, f, indent=4)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("inputSfmPath", type=str, help="Input SFM")
    parser.add_argument("translationNoise", type=float, help="Noise amplitude applied to the translation")
    parser.add_argument("rotationNoise", type=float, help="Noise amplitude applied to the rotation")
    parser.add_argument("outputSfmPath", type=str, help="Output SFM")
    args = parser.parse_args()
    
    poses = load_poses(args.inputSfmPath)
    apply_noise(poses, args.translationNoise, args.rotationNoise)
    sfm_data = update_sfm_poses(args.inputSfmPath, poses)
    export_sfm(sfm_data, args.outputSfmPath)
