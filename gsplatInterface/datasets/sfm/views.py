# -*- coding: utf-8 -*-

import os
from typing import Tuple

from gsplatInterface.avImage import AvImage
from pyalicevision.sfmData import View


class SfmView:
    KEYS = ["intrinsicId", "poseId", "frameId", "path", "width", "height"]
    
    def __init__(self, viewId: int, viewDict: dict):
        self.viewId = int(viewId)
        assert all([key in viewDict.keys() for key in self.KEYS]), f"missing keys in dict : {viewDict}"
        self.__view = viewDict
        self.__image = None
    
    @classmethod
    def from_pyalicevision(cls, view: Tuple[int, View]):
        # Assert we have the correct type
        typeErrMsg = f"Expected type Tuple[int, View], found {type(view)} : {view}"
        assert isinstance(view, tuple), typeErrMsg
        typeErrMsg = f"Expected type Tuple[int, View], found {type(view)}(size={len(view)}): {view}"
        assert len(view)==2, typeErrMsg
        viewId, view = view
        typeErrMsg = f"Expected type Tuple[int, View], element 2 has type {type(view)}: {view}"
        assert isinstance(view, View), typeErrMsg
        # Get view infos
        imageInfo = view.getImageInfo()
        meta = {}  # TODO : read from image, seems difficult from the API -> use pyalicevision.image.readImageMetadata
        viewDict = {
            "intrinsicId": view.getIntrinsicId(),
            "poseId": view.getPoseId(),
            "frameId": view.getFrameId(),
            "path": imageInfo.getImagePath(),
            "width": imageInfo.getWidth(),
            "height": imageInfo.getHeight(),
            "metadata": meta
        }
        return cls(viewId, viewDict)
    
    def __repr__(self):
        return f"<View {self.viewId}>"
    
    @property
    def imageInfo(self):
        return self.__view
    
    @property
    def imagePath(self):
        return self.__view.get("path")
    
    @property
    def imageName(self):
        return os.path.basename(self.__view.get("path"))
    
    @property
    def intrinsicId(self):
        return int(self.__view.get("intrinsicId"))
    
    @property
    def poseId(self):
        return int(self.__view.get("poseId"))
    
    @property
    def frameId(self):
        return int(self.__view.get("frameId"))
    
    @property
    def W(self):
        return float(self.__view.get("width"))
    
    @property
    def H(self):
        return float(self.__view.get("height"))
    
    @property
    def colorSpace(self):
        meta = self.__view.get("metadata", {})
        colorspace = meta.get("oiio:ColorSpace", None)
        return colorspace
    
    def close_image(self):
        del self.__image.pixels  # Is it necessary to free memory ?
        self.__image = None
    
    def open_image(self):
        if self.__image is None:
            self.__image = AvImage(self.imagePath, open=True)
        return self.__image.pixels
