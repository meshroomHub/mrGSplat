# -*- coding: utf-8 -*-

from typing import Tuple
from .types import NDArray3x3
from .utils import pose3ToNp, poseDictToNp

import math

import numpy as np
from scipy.optimize import root

from pyalicevision import sfmData
from pyalicevision.camera import IntrinsicBase

IntrinsicsBaseType = (sfmData.IntrinsicBase, IntrinsicBase)


class SfmIntrinsic:
    KEYS = ["type", "focalLength", "width", "height", "sensorWidth", "sensorHeight", "principalPoint"]
    
    def __init__(self, intrinsicId: int, intrinsicDict: dict):
        self.intrinsicId = int(intrinsicId)
        assert all([key in intrinsicDict.keys() for key in self.KEYS]), f"missing keys in dict : {intrinsicDict}"
        self.__intrinsic = intrinsicDict
    
    @classmethod
    def from_pyalicevision(cls, intrinsic: Tuple[int, IntrinsicBase]):
        # Assert we have the correct type
        typeErrMsg = f"Expected type Tuple[int, IntrinsicBase], found {type(intrinsic)} : {intrinsic}"
        assert isinstance(intrinsic, tuple), typeErrMsg
        typeErrMsg = f"Expected type Tuple[int, IntrinsicBase], found {type(intrinsic)}(size={len(intrinsic)}): {intrinsic}"
        assert len(intrinsic)==2, typeErrMsg
        intrinsicId, intrinsic = intrinsic
        typeErrMsg = f"Expected type Tuple[int, IntrinsicBase], element 2 has type {type(intrinsic)}: {intrinsic}"
        assert isinstance(intrinsic, IntrinsicsBaseType), typeErrMsg
        # Get intrinsic infos
        hfov = intrinsic.getHorizontalFov()
        sensorWidth = intrinsic.sensorWidth()
        fx = (sensorWidth)/(2.0*math.tan(hfov/2.0))
        # vfov = intrinsic.getVerticalFov()
        # sensorHeight = intrinsic.sensorHeight()
        # fy = (sensorHeight)/(2.0*math.tan(vfov/2.0))
        # TODO : "sensorWidth", "sensorHeight", "principalPoint"
        raise NotImplementedError("Missing keys : sensorWidth, sensorHeight, principalPoint")
        intrinsicDict = {
            "type": intrinsic.getTypeStr(),
            "focalLength": fx,
            "width": intrinsic.w(),
            "height": intrinsic.h()
        }
        return cls(intrinsicId, intrinsicDict)

    def __repr__(self):
        return f"<Intrinsic[{self.type}] {self.intrinsicId}>"

    @property
    def type(self):
        return self.__intrinsic.get("type")
    
    @property
    def isPinhole(self):
        return self.__intrinsic.get("type") == "pinhole"
    
    @property
    def H(self):
        return float(self.__intrinsic.get("height"))
    
    @property
    def W(self):
        return float(self.__intrinsic.get("width"))
    
    @property
    def focal_length(self):
        return float(self.__intrinsic.get("focalLength"))
    
    @property
    def sensorWidth(self):
        return float(self.__intrinsic.get("sensorWidth"))
    
    @property
    def sensorHeight(self):
        return float(self.__intrinsic.get("sensorHeight"))
    
    @property
    def principalPoint(self):
        return list(map(float, self.__intrinsic.get("principalPoint")))
    
    @property
    def fx(self):
        # return self.focal_length
        return max(self.W, self.H) * self.focal_length / self.sensorWidth
    
    @property
    def fy(self):
        # return self.focal_length
        return max(self.W, self.H) * self.focal_length / self.sensorWidth
    
    @property
    def cx(self):
        # return self.W / 2.0
        return float(self.W) / 2.0 + self.principalPoint[0]
    
    @property
    def cy(self):
        # return self.H / 2.0
        return float(self.H) / 2.0 + self.principalPoint[1]
    
    def get_K(self) -> NDArray3x3:
        """
        Get intrinsics camera
        """
        fx = self.fx
        fy = self.fy
        s = 0.
        cx = self.cx
        cy = self.cy
        K = np.array(
            [
                [fx , s  , cx ],
                [0.0, fy , cy ],
                [0.0, 0.0, 1.0],
            ]
        )
        return K

    def get_K_inv(self) -> NDArray3x3:
        """
        Get inverse intrinsics camera
        """
        fx = self.fx
        fy = self.fy
        cx = self.cx
        cy = self.cy
        inv_K = np.array(
            [
                [1./fx , 0    , -cx/fx ],
                [0     , 1./fy, -cy/fy ],
                [0     , 0    , 1      ],
            ]
        )
        return inv_K


class SfmExtrinsic:
    def __init__(self, transform: dict):
        self.R = transform.get("rotation")
        self.T = transform.get("translation")
        self.C = transform.get("center")
        
    @classmethod
    def from_camerapose(cls, pose):
        transform = pose3ToNp(pose.getTransform())
        return cls(transform)
    
    @classmethod
    def from_dict(cls, poseDict: dict):
        transform = poseDictToNp(poseDict)
        return cls(transform)
