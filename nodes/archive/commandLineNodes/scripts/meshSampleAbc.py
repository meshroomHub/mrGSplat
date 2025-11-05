# -*- coding: utf-8 -*-

import os
import argparse
import numpy as np
import json
import cask


def getPoints(archive):
    """ Retrieve points and colors from the alembic archive
    
    .. note::
       V3fArray, C3fArray are found on imath
    
    :param archive: Alembic archive
    :type archive: cask.Archive
    :return: arrays of points and arrays of colors
    :rtype: Tuple[V3fArray, C3fArray]
    """
    path = "/mvgRoot/mvgCloud/mvgPointCloud"
    ptc = archive.top.children[path]
    ptcShape = ptc.children.values()[0]
    ptcShapeGeom = ptcShape.properties[".geom"]
    # Get P array
    PProperty = ptcShapeGeom.properties["P"]
    PArray = PProperty.values[0]
    # Get color array
    colorProperty = ptcShapeGeom.properties[".arbGeomParams/color"]
    colorArray = colorProperty.values[0]
    return PArray, colorArray


def samplePoints(archive, nb_samples):
    """ Sample points and return list of points and associated colors
    
    :param archive: Alembic archive
    :type archive: cask.Archive
    :param nb_samples: number of samples to keep
    :type nb_samples: int
    :return: Sampled points and colors
    :rtype: Tuple[np.ndarray, np.ndarray]
    """
    print("** Sampling")
    # Extract arrays
    p_array, c_array = getPoints(archive)
    # Sample points
    selectedPoints = np.random.choice(range(len(p_array)), nb_samples, replace=False)
    return (
        np.array([list(p_array[idx]) for idx in selectedPoints]),  
        np.array([list(c_array[idx]) for idx in selectedPoints])
    )


def updateSfm(inputSfMPath, samples):
    """ Get a sfm file with new landmarks
    
    :param inputSfMPath: input sfm path
    :type inputSfMPath: str 
    :param samples: points and colors for the landmarks
    :type samples: Tuple[np.ndarray, np.ndarray]
    :return: Sfm content with sampled landmarks
    :rtype: dict
    """
    print("** Updating SFM data")
    with open(inputSfMPath, "r") as f:
        sfm_data = json.load(f)
    structure = []
    views_id = [v["viewId"] for v in sfm_data["views"]]
    for vi, (sample_p, sample_c) in enumerate(zip(*samples)):  
        landmark = {}
        landmark["landmarkId"] = str(vi)
        landmark["descType"] = "unknown" 
        landmark["color"] = [str(int(x)) for x in sample_c*255]
        x, y, z = sample_p
        landmark["X"] = [str(x), str(-y), str(-z)]  # Because CV I suppose we need to invert y and z
        landmark["observations"] = []
        #create dummy obs in all views 
        for oi, i in enumerate(views_id):
            obs =  {"observationId": str(i),
                    "featureId": str(oi),
                    "x": [0,0]}
            landmark["observations"].append(obs)
            break  # Don't think we need them actually so let's just keep one
        structure.append(landmark)
    sfm_data["structure"] = structure
    return sfm_data


def exportSfm(sfm_data, outputSfmPath):
    """ Export the sfm file
    
    :param sfm_data: content of the sfm data
    :type sfm_data: dict
    :param outputSfmPath: path to the output SFM file
    :type outputSfmPath: str
    """
    # Save the generated SFM data to JSON file
    print("** Writting sfm file")
    with open(outputSfmPath, 'w') as f:
        json.dump(sfm_data, f, indent=4)


def main(args):
    alembicFile = args.meshFile
    if not os.path.exists(alembicFile):
        raise ValueError("Could not find alembic file " + alembicFile)
    # Open alembic archive
    print("** Loading mesh")
    archive = cask.Archive(alembicFile)
    # Sample points
    samples = samplePoints(archive, args.sampling)
    # Get sfm with landmarks
    sfm_data = updateSfm(args.inputSfMData, samples)
    # Export sfm
    exportSfm(sfm_data, args.outputSfmData)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    # meshFile sampling inputSfMData outputSfmData
    parser.add_argument(
        "meshFile", type=str, help="Input mesh file"
    )
    parser.add_argument(
        "sampling", type=int, help="Sampling level (how many points we want to keep)"
    )
    parser.add_argument(
        "inputSfMData", type=str, help="Input SFM file"
    )
    parser.add_argument(
        "outputSfmData", type=str, help="Output SFM file"
    )
    args = parser.parse_args()
    main(args)
