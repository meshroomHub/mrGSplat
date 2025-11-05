# -*- coding: utf-8 -*-

import os
from typing import Tuple, Union

import cv2
import numpy as np

from pyalicevision import image as avimg


class AvImage:
    """
    Format-agnostic class to manage images, resize them, handle colorspace conversions
    """
    
    COLOR_SPACES = {
        "AUTO": avimg.EImageColorSpace_AUTO,
        "LINEAR": avimg.EImageColorSpace_LINEAR,
        "SRGB": avimg.EImageColorSpace_SRGB,
        "ACES2065_1": avimg.EImageColorSpace_ACES2065_1,
        "ACEScg": avimg.EImageColorSpace_ACEScg,
        "REC709": avimg.EImageColorSpace_REC709,
        "Linear_ARRI_Wide_Gamut_3": avimg.EImageColorSpace_Linear_ARRI_Wide_Gamut_3,
        "ARRI_LogC3_EI800": avimg.EImageColorSpace_ARRI_LogC3_EI800,
        "Linear_ARRI_Wide_Gamut_4": avimg.EImageColorSpace_Linear_ARRI_Wide_Gamut_4,
        "ARRI_LogC4": avimg.EImageColorSpace_ARRI_LogC4,
        "Linear_BMD_WideGamut_Gen5": avimg.EImageColorSpace_Linear_BMD_WideGamut_Gen5,
        "BMDFilm_WideGamut_Gen5": avimg.EImageColorSpace_BMDFilm_WideGamut_Gen5,
        "CanonLog2_CinemaGamut_D55": avimg.EImageColorSpace_CanonLog2_CinemaGamut_D55,
        "CanonLog3_CinemaGamut_D55": avimg.EImageColorSpace_CanonLog3_CinemaGamut_D55,
        "Linear_CinemaGamut_D55": avimg.EImageColorSpace_Linear_CinemaGamut_D55,
        "Linear_V_Gamut": avimg.EImageColorSpace_Linear_V_Gamut,
        "V_Log_V_Gamut": avimg.EImageColorSpace_V_Log_V_Gamut,
        "Linear_REDWideGamutRGB": avimg.EImageColorSpace_Linear_REDWideGamutRGB,
        "Log3G10_REDWideGamutRGB": avimg.EImageColorSpace_Log3G10_REDWideGamutRGB,
        "Linear_Venice_S_Gamut3_Cine": avimg.EImageColorSpace_Linear_Venice_S_Gamut3_Cine,
        "S_Log3_Venice_S_Gamut3_Cine": avimg.EImageColorSpace_S_Log3_Venice_S_Gamut3_Cine,
        "LAB": avimg.EImageColorSpace_LAB,
        "XYZ": avimg.EImageColorSpace_XYZ,
        "NO_CONVERSION": avimg.EImageColorSpace_NO_CONVERSION,
    }
    
    @classmethod
    def get_colorspace(cls, colorspace):
        if isinstance(colorspace, str):
            return cls.COLOR_SPACES.get(colorspace, cls.COLOR_SPACES["AUTO"])
        return colorspace
    
    @classmethod
    def get_default_colorspace(cls, path, img_shape=None):
        ext = os.path.splitext(path)[1]
        if img_shape < 3:
            # Non-RGB images (greyscale, ...) -> no conversion to do
            return cls.get_colorspace("NO_CONVERSION")
        if ext.lower() == ".exr":
            return cls.get_colorspace("LINEAR")
        if ext.lower() == ".jpg":
            return cls.get_colorspace("SRGB")
        # TODO : other files
        else:
            return cls.get_colorspace("NO_CONVERSION")
    
    def __init__(self, path, greyscale=False, open=False, colorspace=None):
        self.mode = "greyscale" if greyscale else "rgb" 
        self.nb_channels = 1 if greyscale else 3
        self.path = str(path)
        self.buf = None
        if open:
            self.open(colorspace)
    
    @classmethod
    def from_numpy(cls, array):
        # Find image shape
        im_shape = 3
        if len(array.shape) == 2:
            im_shape = 1
        elif len(array.shape) == 3:
            im_shape = array.shape[2]
        else:
            raise ValueError("Array shape {array.shape} is not valid")
        av_image = cls(None, greyscale=(im_shape==1), open=False)
        if im_shape == 1:
            av_image.buf = avimg.Image_float()
        elif im_shape == 3:
            av_image.buf = avimg.Image_RGBfColor()
        else:
            av_image.buf = avimg.Image_RGBAfColor()
        av_image.buf.fromNumpyArray(array)
        return av_image
    
    def open(self, colorspace=None): 
        im_shape = 3
        if self.mode == "greyscale":
            im_shape = 1
        self.buf = self.open_RGB_image(self.path, im_shape=im_shape, colorspace=colorspace)
    
    @classmethod
    def open_RGB_image(cls, p, im_shape=3, colorspace=None):
        if colorspace is None:
            colorspace = cls.get_default_colorspace(p, img_shape=im_shape)
        else:
            colorspace = cls.get_colorspace(colorspace)
        if im_shape == 1:
            av_image = avimg.Image_float()
        elif im_shape == 3:
            av_image = avimg.Image_RGBfColor()
        else:
            av_image = avimg.Image_RGBAfColor()
        # Read image
        avOptRead = avimg.ImageReadOptions(colorspace)
        try:
            avimg.readImage(p, av_image, avOptRead)
        except Exception as err:
            # raise ValueError(f"[open_RGB_image] Read image {p} ({im_shape}/{colorspace} -> {str(av_image.__class__)})\n{err}")
            raise ValueError(f"[open_RGB_image] Read image {p} ({im_shape}/{colorspace})\n{err}")
        return av_image
    
    @property
    def pixels(self):
        return self.buf.getNumpyArray()
    
    def resize(self, factor):
        # New size
        W = int(self.buf.width() / float(factor))
        H = int(self.buf.height()/ float(factor))
        img = self.pixels
        res = cv2.resize(img, dsize=(W, H), interpolation=cv2.INTER_AREA)  # Best for downscaling
        if len(res.shape) == 2:
            res = np.reshape(res, (*res.shape, 1))
        self.buf.fromNumpyArray(res)
    
    def write(self, output, colorspace=None):
        if colorspace is None:
            # colorspace = self.get_default_colorspace(output, img_shape=self.buf.channels())
            colorspace = self.get_colorspace("AUTO")
        else:
            colorspace = self.get_colorspace(colorspace)
        optWrite = avimg.ImageWriteOptions()
        optWrite.toColorSpace(colorspace)
        oiio_params = avimg.oiioParams(1, 1, "zips")
        avimg.writeImage(output, self.buf, optWrite, oiio_params.get())
