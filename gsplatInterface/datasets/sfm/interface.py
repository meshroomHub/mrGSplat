# -*- coding: utf-8 -*-

import os
from pathlib import Path

from .camera import SfmIntrinsic, SfmExtrinsic
from .views import SfmView

from pyalicevision import sfmData
from pyalicevision import sfmDataIO

import numpy as np
from numpy.linalg import inv as invert
import json


FORCE_JSON_TYPE = True


class SfmPose:
    def __init__(self, poseId: int, poseDict: dict):
        self.__poseId = int(poseId)
        if "extrinsic" in poseDict.keys():
            self._extrinsic = poseDict.get("extrinsic")
        else:
            self._extrinsic = SfmExtrinsic.from_dict(poseDict)
    
    @classmethod
    def from_pyalicevision(cls, poseId: int, pose: sfmData.CameraPose):
        # Assert we have the correct type
        assert isinstance(pose, sfmData.CameraPose)
        # Get view infos
        extrinsic = SfmExtrinsic.from_camerapose(pose)
        poseDict = {
            "extrinsic": extrinsic
        }
        return cls(poseId, poseDict)
    
    def __repr__(self):
        return f"<Pose {self.__poseId}>"
    
    def get_w2c(self):
        bottom = np.array([0, 0, 0, 1]).reshape(1, 4)
        rot = self.R
        trans = self.T.reshape(3, 1)
        mat = np.concatenate([np.concatenate([rot, trans], 1), bottom], axis=0)
        return mat
    
    @property
    def extrinsic(self):
        return self._extrinsic
    
    @property
    def T(self):
        return self.extrinsic.T
    
    @property
    def R(self):
        return self.extrinsic.R
    
    @property
    def C(self):
        return self.extrinsic.C


class SfmObservation:
    """
    Dummy class for the observation position (position in the image)
    I'm not using it in GSplat but we never know so I'm still creating a class
    to make sure if we need more infos we can add them here easily
    """
    def __init__(self, landmarkId, **observationDict):
        self.landmarkId = landmarkId
        self.observationId = int(observationDict["observationId"])
    
    def __repr__(self):
        return f"<Observation of view={self.observationId} on landmark={self.landmarkId}>"


class SfmLandmark:
    def __init__(self, landmarkId: int, position: np.ndarray, color: np.ndarray, observations: dict):
        self.landmarkId = int(landmarkId)
        # Landmark point coordinates
        self.position = position
        self.x, self.y, self.z = self.position
        self.color = color  # RGB (0 to 255)
        self.observations =  observations
    
    @classmethod
    def from_pyalicevision(cls, landmarkId: int, landmark: sfmData.Landmark):
        # Assert we have the correct type
        assert isinstance(landmark, sfmData.Landmark)
        # Get view infos
        position = np.array(landmark.X, dtype=np.float32)
        color = np.array(landmark.rgb, dtype=np.int16)
        observations = {}
        # TODO : this part doesn't work, missing bindings to Observation 
        #        (getObservations return Swig object so we don't have access to coodinates)
        # for obs in landmark.getObservations().itervalues():
        #     print(obs.getCoordinates())
        return cls(landmarkId, position, color, observations)
    
    @classmethod
    def from_dict(cls, landmarkDict: dict):
        landmarkId = int(landmarkDict.pop("landmarkId"))
        position = np.array(landmarkDict["X"], dtype=np.float32)
        color = np.array(landmarkDict["color"], dtype=np.int16)
        observations = {}
        for obs in landmarkDict["observations"]:
            obsId = int(obs["observationId"])
            observations[obsId] = SfmObservation(landmarkId, **obs)
        return cls(landmarkId, position, color, observations)
    
    def __repr__(self):
        return f"<Landmark {self.landmarkId}>"


class SfmJsonFile:
    def __init__(self, path: Path):
        print(f"Read SfmJsonFile {path}")
        self.__path = path
        self.__content = {}
        with open(path, "r") as fo:
            self.__content = json.load(fo)
    
    def __repr__(self):
        return f"<SfmJsonFile {self.__path}>"
    
    def getIntrinsics(self):
        intrinsics = []
        for intrinsicDict in self.__content.get("intrinsics", []):
            intrinsicId = intrinsicDict.pop("intrinsicId")
            intrinsics.append(SfmIntrinsic(intrinsicId, intrinsicDict))
        return intrinsics
    
    def getViews(self):
        views = []
        for viewDict in self.__content.get("views", []):
            viewId = viewDict.pop("viewId")
            views.append(SfmView(viewId, viewDict))
        return views
    
    def getPoses(self):
        poses = {}
        for poseDict in self.__content.get("poses", []):
            poseId = int(poseDict.pop("poseId"))
            poses[poseId] = SfmPose(poseId, poseDict)
        return poses
    
    def getLandmarks(self):
        landmarks = []
        for landmark in self.__content.get("structure", []):
            landmarks.append(SfmLandmark.from_dict(landmark))
        return landmarks


class SfmFile:
    def __init__(self, path: Path):
        print(f"Read SfmFile {path}")
        self.__path = path
        self.__content = sfmData.SfMData()
        if not sfmDataIO.load(self.__content, str(path), sfmDataIO.ALL):
            raise SystemError(f"Could not load sfm file {path}")
    
    def __repr__(self):
        return f"<SfmFile {self.__path}>"
    
    def getIntrinsics(self):
        intrinsics = []
        for item in self.__content.getIntrinsics().iteritems():
            intrinsics.append(SfmIntrinsic.from_pyalicevision(item))
        return intrinsics
    
    def getViews(self):
        views = []
        # TODO : use getValidViews ?
        # self._views = self.__content.getValidViews()
        for item in self.__content.getViews().iteritems():
            views.append(SfmView.from_pyalicevision(item))
        return views
    
    def getPoses(self):
        poses = {}
        for key, value in self.__content.getPoses().iteritems():
            poses[key] = SfmPose.from_pyalicevision(key, value)
        return poses
    
    def getLandmarks(self):
        landmarks = []
        for landmarkId, landmark in self.__content.getLandmarks().iteritems():
            landmarks.append(SfmLandmark.from_pyalicevision(landmarkId, landmark))
        return landmarks


class SfmReader:
    def __init__(self, inputSfmPath: Path):
        self.__originalSfmFile = inputSfmPath  # In case we convert it to JSON
        self.sfmFile = inputSfmPath
        self.dataAV = None
        self.viewFiles = None
        self.load()
    
    @staticmethod
    def convert_to_json(filepath: Path):
        print(f"Convert SFM {filepath} to JSON")
        # TODO : temp file
        ouput_json = os.path.join(filepath.parent, "save_sfm.json")
        dataAV = sfmData.SfMData()
        if sfmDataIO.load(dataAV, str(filepath), sfmDataIO.ALL):
            if sfmDataIO.save(dataAV, ouput_json, sfmDataIO.ALL):
                return ouput_json
            else:
                raise SystemError(f"Could not save SFM file to {ouput_json}")
        else:
            raise ValueError(f"Could not read SFM file {filepath}")
    
    def load(self):
        if self.sfmFile.suffix == ".json":
            self.dataAV = SfmJsonFile(self.sfmFile)
        elif FORCE_JSON_TYPE:
            self.sfmFile = self.convert_to_json(self.sfmFile)
            self.dataAV = SfmJsonFile(self.sfmFile)
        else:
            self.dataAV = SfmFile(self.sfmFile)
    
    @property
    def intrinsics(self):
        if getattr(self, "_intrinsics", None) is None:
            self._intrinsics = self.dataAV.getIntrinsics()
        return self._intrinsics
    
    @intrinsics.setter
    def intrinsics(self, value):
        if value is None:
            self._intrinsics = None
            return
        if not isinstance(value, list):
            value = [value]
        for item in value:
            if not isinstance(item, SfmIntrinsic):
                raise TypeError(f"Element {item} cannot be converted to an intrinsic")
        self._intrinsics = value
    
    @property
    def views(self):
        if getattr(self, "_views", None) is None:
            self._views = self.dataAV.getViews()
        return self._views
    
    @views.setter
    def views(self, value):
        if value is None:
            self._views = None
            return
        if not isinstance(value, list):
            value = [value]
        for item in value:
            if not isinstance(item, SfmView):
                raise TypeError(f"Element {item} cannot be converted to a view")
        self._views = value
    
    @property
    def poses(self):
        if getattr(self, "_poses", None) is None:
            self._poses = self.dataAV.getPoses()
        return self._poses
    
    @poses.setter
    def poses(self, value):
        if value is None:
            self._poses = None
            return
        if not isinstance(value, dict):
            raise TypeError(f"Pose {value} should be a dictionnary")
        for _, item in value.items():
            if not isinstance(item, SfmPose):
                raise TypeError(f"Element {item} cannot be converted to a pose")
        self._poses = value
    
    @property
    def landmarks(self):
        if getattr(self, "_landmarks", None) is None:
            self._landmarks = self.dataAV.getLandmarks()
        return self._landmarks
    
    @landmarks.setter
    def landmarks(self, value):
        if value is None:
            self._landmarks = None
            return
        if not isinstance(value, dict):
            raise TypeError(f"Pose {value} should be a dictionnary")
        for _, item in value.items():
            if not isinstance(item, SfmLandmark):
                raise TypeError(f"Element {item} cannot be converted to a landmark")
        self._landmarks = value
