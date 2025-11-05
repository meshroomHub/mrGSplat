import argparse
import os
import json

import numpy as np
from numpy import linalg as LA
from scipy.spatial.transform import Rotation as R


class TransformationMatrix:
    def __init__(self, rotation, center):
        mat = np.array(rotation).reshape(3,3)
        self.rotation = self.rotMatToQuat(mat)
        self.center = np.array(center)
    
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
    
    def add_noise(self, translationNoise, rotationNoise):
        noise = np.random.rand(2, 4)
        self.center   *= translationNoise * noise[0,:3]
        self.rotation *= rotationNoise    * noise[1]
    
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
        poses[int(pose["poseId"])] = TransformationMatrix(rotation, center)
    return poses


def get_diff(a, b):
    """
    We use the norm to quantify the difference
    """
    diffByPose = {}
    for poseId in a.keys():
        poseA = a[poseId]
        poseB = b[poseId]
        transDiff = LA.norm(poseB.center - poseA.center)
        rotDiff   = LA.norm(poseB.rotation - poseA.rotation)
        diffByPose[poseId] = {
            "translate": transDiff,
            "rotation": rotDiff
        }
    accumulatedTransDiff = sum([x["translate"] for x in diffByPose.values()]) / len(diffByPose)
    accumulatedRotDiff   = sum([x["rotation"]  for x in diffByPose.values()]) / len(diffByPose)
    return {
        "poses_diff": diffByPose,
        "accumulated_translate_diff": accumulatedTransDiff,
        "accumulated_rotation_diff": accumulatedRotDiff
    }


def print_diff(diff, previousDiff=None):
    for poseId in diff["poses_diff"].keys():
        poseDiff = diff["poses_diff"][poseId]
        tPoseDiff = poseDiff['translate']
        rPoseDiff = poseDiff['rotation']
        poseTxt = f"difference is translate={poseDiff['translate']:10.4f}, rotate={poseDiff['rotation']:10.4f}"
        if previousDiff and str(poseId) in previousDiff["poses_diff"]:
            if str(poseId) not in previousDiff["poses_diff"]:
                poseTxt += " (no previous diff for this pose)"
            else:
                p_poseDiff = previousDiff["poses_diff"][str(poseId)]
                p_tPoseDiff = p_poseDiff['translate']
                p_rPoseDiff = p_poseDiff['rotation']
                poseTxt = f"difference is translate=[{tPoseDiff:10.4f}/{p_tPoseDiff:10.4f}]"
                poseTxt += f", rotate=[{rPoseDiff:10.4f}]/{p_rPoseDiff:10.4f}"
                if ((tPoseDiff-p_tPoseDiff)+(rPoseDiff-p_rPoseDiff))/2.0 > 0:
                    poseTxt += " -> new poses are closer"
                else:
                    poseTxt += " -> new poses are not closer"
        print(f"- Pose {poseId:10d} : " + poseTxt)
    print(f"")
    print(f"Summary :")
    accTransTxt = f"{diff['accumulated_translate_diff']:10.4f}"
    accRotTxt   = f"{diff['accumulated_rotation_diff']:10.4f}"
    if previousDiff:
        accTransTxt += f" (was {previousDiff['accumulated_translate_diff']:10.4f} previously)"
        accRotTxt   += f" (was {previousDiff['accumulated_rotation_diff' ]:10.4f} previously)"
    print(f"- Accumulated translate diff : {accTransTxt}")
    print(f"- Accumulated rotation diff  : {accRotTxt}")


def export_diff(diff, diffFile):
    print(f"Export diff to {diffFile}")
    with open(diffFile, 'w') as f:
        json.dump(diff, f, indent=4)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("inputSfmPath", type=str, help="Input SFM")
    parser.add_argument("referenceSfmPath", type=str, help="SFM refernece")
    parser.add_argument("outputDiffFile", type=str, help="Output difference file")
    parser.add_argument("--previousDiff", type=str, required=False, help="Previous difference file to compare with (if we got closer or not)")
    args = parser.parse_args()
    
    inputPoses = load_poses(args.inputSfmPath)
    refPoses   = load_poses(args.referenceSfmPath)
    diff = get_diff(inputPoses, refPoses)
    previousDiff = None
    if args.previousDiff:
        with open(args.previousDiff, "r") as f:
            previousDiff = json.load(f)
    print_diff(diff, previousDiff)
    export_diff(diff, args.outputDiffFile)
