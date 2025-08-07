
import os
import sys
import json

import numpy as np
import torch


def create_pose(poseId, rotMat, transVec):
    return {
        "poseId": str(poseId),
        "pose": {
            "transform": {
                "rotation": [str(x) for x in rotMat],
                "center": [str(x) for x in transVec]
            },
            "locked": "false",
            "rotationOnly": "false",
            "removable": "true"
        }
    }


def create_sfm(model):
    print(model)
    raise sys.exit(0)
    poses = []
    sfm_data = {
        "version": ["1", "2", "12"],
        "poses": poses
    }
    return sfm_data


def main(modelPath, outputPoseFile, outputSfmFile):
    # Load model
    model = torch.load(modelPath, map_location='cpu')['pose_adjust']
    # Save poses
    np.save(outputPoseFile, model)
    # Create sfm
    sfm_data = create_sfm(model)
    with open(outputSfmFile, 'w') as f:
        json.dump(sfm_data, f, indent=4)
    

if __name__ == "__main__":
    model = sys.argv[1]
    outputFolder = sys.argv[2]
    outputPoseFile = os.path.join(outputFolder, "poses.npy")
    outputSfmFile = os.path.join(outputFolder, "sfm.json")
    main(model, outputPoseFile, outputSfmFile)
