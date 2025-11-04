# -*- coding: utf-8 -*-

import numpy as np
from numpy.linalg import inv as invert
from scipy.spatial.transform import Rotation as R


# HACK : need these two import statements for using pose3ToNp
from pyalicevision import sfmData
from pyalicevision import geometry as geo


# No need here because the sfm file was created with CV convention
CONVERT_FROM_CG_TO_CV = False


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


def pose3ToNp(p):
    return {
        "rotation": p.rotation(),
        "translation": p.translation(),
        "center": p.center(),
    }


def poseDictToNp(p: dict):
    transform = p.get("pose", {}).get("transform", {})
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
    
    # convert from computer graphics convention (opengl-like) to computer vision
    if CONVERT_FROM_CG_TO_CV:
        M = np.identity(4)
        M[1][1] = -1.0
        M[2][2] = -1.0
        T2 = invert(np.matmul(np.matmul(M, T), M))
    else:
        T2 = invert(T)
    
    rotate = np.zeros((3, 3))
    translate = np.zeros((3, 1))
    for row_i in range(3):
        # Rotation
        for col_i in range(3):
            rotate[row_i][col_i] = T2[row_i][col_i]
        # Translation
        translate[row_i] = T2[row_i][3]
    
    # r = R.from_matrix(rotate)
    # qx, qy, qz, qw = r.as_quat()
    
    return {
        "rotation": rotate,
        "translation": translate,
        "center": center
    }
