
__version__ = "1.0"

import os
from pathlib import Path
from typing import Union, Optional

from meshroom.core import desc

from pyalicevision import sfmData, sfmDataIO
from pyalicevision import image as avimg
from pyalicevision.system import ConsoleProgressDisplay


DOC = """# PrepareImagesForGSplat

This node prepares a sfmData fiel so that it will work in GSplat.
It allows resizing images and masks, changing colorspaces, changing image formats...
"""


SCALES = ['1', '2', '4', '8', '16', '32', '64']
# Simply used to know which file are going to be considered as images when we list files from a folder
VALID_IMG_EXT = (".exr", ".jpg", ".JPG", ".png", ".PNG")


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
    def get_colorspace(cls, colorspace: Union[str, int]) -> int:
        """ Utility function to get colorspace from a string
        """
        if isinstance(colorspace, str):
            return cls.COLOR_SPACES.get(colorspace, cls.COLOR_SPACES["AUTO"])
        return colorspace
    
    @classmethod
    def get_default_colorspace(cls, path: str, img_shape: int):
        """ Get default colorspace depending on image extension
        """
        ext = os.path.splitext(path)[1]
        if img_shape < 3:
            # Non-RGB images (greyscale, ...) -> no conversion to do
            return cls.get_colorspace("NO_CONVERSION")
        if ext.lower() == ".exr":
            return cls.get_colorspace("LINEAR")
        if ext.lower() == ".jpg":
            return cls.get_colorspace("SRGB")
        # TODO : other files types
        else:
            return cls.get_colorspace("NO_CONVERSION")
    
    def __init__(self, path: str, mode: Optional[str] = "rgb", colorspace: Optional[Union[str, int]] = None):
        self.mode = mode
        self.path = str(path)
        self.buf = None
        self.open(colorspace)
    
    def open(self, colorspace: Optional[Union[str, int]] = None):
        im_shape = 3
        if self.mode == "greyscale":
            im_shape = 1
        self.buf = self.open_RGB_image(self.path, im_shape=im_shape, colorspace=colorspace)
    
    @classmethod
    def open_RGB_image(cls, p: str, im_shape: int, colorspace: Optional[Union[str, int]] = None):
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
        avimg.readImage(p, av_image, avOptRead)
        return av_image
    
    @property
    def pixels(self):
        """ Get image as a numpy array
        """
        return self.buf.getNumpyArray()
    
    def resize(self, factor: float):
        """ resize image
        :param factor: Downsampling factor 
        """
        import cv2
        import numpy as np
        # New size
        W = int(self.buf.width() / float(factor))
        H = int(self.buf.height()/ float(factor))
        img = self.pixels
        res = cv2.resize(img, dsize=(W, H), interpolation=cv2.INTER_AREA)  # Best for downscaling
        if len(res.shape) == 2:
            res = np.reshape(res, (*res.shape, 1))
        self.buf.fromNumpyArray(res)
    
    def write(self, output: str, colorspace: Optional[Union[str, int]] = None):
        """ Write image
        """
        if colorspace is None:
            # colorspace = self.get_default_colorspace(output, img_shape=self.buf.channels())
            colorspace = self.get_colorspace("AUTO")
        else:
            colorspace = self.get_colorspace(colorspace)
        optWrite = avimg.ImageWriteOptions()
        optWrite.toColorSpace(colorspace)
        oiio_params = avimg.oiioParams(1, 1, "zips")
        avimg.writeImage(output, self.buf, optWrite, oiio_params.get())


class ViewsRange:
    """
    ViewsRange splits a range in several chunks. We use this here in order to make sure that we
    will export all images, and we try to deal with an equivalent number of images per chunk
    """
    
    def __init__(self, nb_views: int, chunkRange: desc.Range):
        self.nb_views = nb_views
        self.iteration = chunkRange.iteration
        self.nbBlocks = chunkRange.nbBlocks
        def chunkize(l, n):
            bs = len(l)//n + (1 if len(l)%n else 0)
            s = [[] for _ in range(n)]
            for i, e in enumerate(l):
                s[i//bs].append(e)
            return s
        viewIndex = list(range(nb_views))
        self.chunks = chunkize(viewIndex, self.nbBlocks)
    
    def get_block_id(self, index: int) -> int:
        """ For a specific view get the chunk that will treat the view
        """
        for chunkId, chunk in enumerate(self.chunks):
            if index in chunk:
                return chunkId
        return None
    
    def isViewInRange(self, index: int) -> bool:
        """ Check if the current chunk needs to process a specific view 
        """
        return self.get_block_id(index) == self.iteration
    
    def get_current_block_info(self) -> str:
        """ Utility function to show some infos on the current chunk
        """
        chunk = self.chunks[self.iteration]
        return f"Block [{self.iteration+1}/{self.nbBlocks}] -> Process views {chunk[0]} to {chunk[-1]}"
            

class PrepareImagesForGSplat(desc.Node):

    category = 'Gsplat'
    documentation = DOC
    
    # size = ViewNodeSize("sfmData")
    size = desc.DynamicNodeSize("sfmData")
    parallelization = desc.Parallelization(blockSize=40)

    inputs = [
        desc.File(
            name='sfmData',
            label='sfmData',
            description='',
            value='',
        ),

        desc.File(
            name="maskFolder",
            label="Mask Folder",
            description="maskFolder",
            value="",
        ),
        desc.File(
            name="referenceSfm",
            label="Reference",
            description="If you use masks we need to matColorspacesh masks with images in the input SFM. " \
                "If you plug the reference we can extract the frame ID corresponding to the mask images",
            value="",
        ),

        desc.ChoiceParam(
            name='scale',
            label='scale',
            description='''Downsampling factor''',
            value='1',
            values=SCALES,
            exclusive=True,
        ),
        
        desc.GroupAttribute(
            name="colorspaces",
            label="Colorspaces",
            description="",
            groupDesc=[
                desc.ChoiceParam(
                    name='inputColorspace',
                    label='Input Colorspace',
                    description='''By default AUTO will be LINEAR for exr files and SRGB for jpg''',
                    value='AUTO',
                    values=list(AvImage.COLOR_SPACES.keys()),
                    exclusive=True,
                ),
                desc.ChoiceParam(
                    name='outputColorspace',
                    label='Output Colorspace',
                    description='''''',
                    value='AUTO',
                    values=list(AvImage.COLOR_SPACES.keys()),
                    exclusive=True,
                ),
            ],
        ),

        desc.ChoiceParam(
            name='forceExtension',
            label='Change extension',
            description='''''',
            value='keep',
            values=['keep', '.jpg', '.png', '.exr'],
            exclusive=True,
        ),
        
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),

        desc.BoolParam(
            name="forcePinhole",
            label="forcePinhole",
            description="forcePinhole",
            value=True,
        ),
    ]

    outputs = [
        desc.File(
            name='outputFolder',
            label='outputFolder',
            description='outputFolder',
            value="{nodeCacheFolder}",
            group='',
        ),
        desc.File(
            name='outputSfmFile',
            label='outputSfmFile',
            description='Output SFM file',
            value=os.path.join("{nodeCacheFolder}", "sfm.json"),
            group='',
            semantic="image"
        ),
        desc.File(
            name='outputImageFolder',
            label='outputImageFolder',
            description='Output images folder',
            value=os.path.join("{nodeCacheFolder}", "images"),
            group='',
            semantic="image"
        ),
        desc.File(
            name='outputMasksFolder',
            label='outputMasksFolder',
            description='Output masks folder',
            value=os.path.join("{nodeCacheFolder}", "masks"),
            group='',
            semantic="image"
        )
    ]

    def processChunk(self, chunk):
        chunk.logManager.start(chunk.node.verboseLevel.value)
        
        # Load SFM
        sfmPath = chunk.node.sfmData.value
        sfmContent = sfmData.SfMData()
        if not sfmDataIO.load(sfmContent, sfmPath, sfmDataIO.ALL):
            raise SystemError(f"Could not load sfm file {sfmPath}")
        
        viewrange = ViewsRange(len(sfmContent.getViews()), chunk.range)
        chunk.logger.info(viewrange.get_current_block_info())
        
        # Get colorspaces
        inputColorspace  = chunk.node.colorspaces.inputColorspace.value
        if inputColorspace  == "AUTO": inputColorspace  = None
        outputColorspace = chunk.node.colorspaces.outputColorspace.value
        if outputColorspace == "AUTO": outputColorspace = None
        
        # Load reference SFM
        refSfmPath = chunk.node.referenceSfm.value
        view_id_to_name = {}  # -> { viewId: img_name (without ext) }
        if refSfmPath and os.path.exists(refSfmPath):
            refSfmContent = sfmData.SfMData()
            if not sfmDataIO.load(refSfmContent, refSfmPath, sfmDataIO.ALL):
                raise SystemError(f"Could not load sfm file {refSfmPath}")
            for view in refSfmContent.getViews().itervalues():
                img_path = view.getImageInfo().getImagePath()
                img_name = os.path.splitext(os.path.basename(img_path))[0]
                # frame_id = view.getFrameId()
                view_id = view.getViewId()
                view_id_to_name[int(view_id)] = img_name
        elif chunk.node.maskFolder.value != "":
            raise ValueError("When using masks you also need a reference to be able to map the images to the " \
                "masks ! You can use the input of ImageSegmentationPrompt or the sfmData of FilterMask nodes")
        
        def get_image_name(image_path: Path, image_name_to_view_id: dict = None):
            """
            image_name_to_view_id -> { image_stem : viewId }
            """
            stem = image_path.stem
            if image_name_to_view_id:
                viewId = image_name_to_view_id[stem]
                stem = view_id_to_name.get(viewId, stem)
            suffix = image_path.suffix
            if chunk.node.forceExtension.value != "keep":
                suffix = chunk.node.forceExtension.value
            return stem + suffix
        
        #resize images and images
        def save_downsampled(name, image_paths=None, inputfolder=None, image_name_to_view_id=None):
            """ Save downsampled images
            """
            # List images
            assert (image_paths or inputfolder), f"Missing either a list of images or a folder to grab images from"
            if not image_paths:
                image_paths = [os.path.join(inputfolder, f) for f in os.listdir(inputfolder) if f.endswith(VALID_IMG_EXT)]
            chunk.logger.info(f"Found {len(image_paths)} to process")
            # Create output folder
            scale = int(chunk.node.scale.value)
            chunk.logger.info(f"Resizing at {scale}")
            output_folder_name = name if scale == 1 else f"{name}_{scale}"
            output_folder_path = os.path.join(chunk.node.outputFolder.value, output_folder_name)
            os.makedirs(output_folder_path, exist_ok=True)
            # Symlink the output folder to the downsampling folder (e.g. create images->images_4)
            if scale != 1:
                linkPath = os.path.join(chunk.node.outputFolder.value, name)
                if os.path.exists(linkPath):
                    os.unlink(linkPath)
                os.symlink(output_folder_path, os.path.join(chunk.node.outputFolder.value, name))
            # Downsample images
            mapping = {}
            chunk.logger.info(f"Saving images to {output_folder_path}")
            progress = ConsoleProgressDisplay(len(image_paths), f"Saving images : {name} (scale={scale})\n")
            for k, image_path in enumerate(image_paths):
                print(f"Process image {os.path.basename(image_path)}")  # Works better with ProgressDisplay than using logger
                if not os.path.exists(image_path):
                    chunk.logger.warning(f"Issue with {image_path}, skipping")
                output_basename = get_image_name(Path(image_path), image_name_to_view_id)
                output_path = os.path.join(output_folder_path, output_basename)
                mapping[image_path] = output_path
                if viewrange.isViewInRange(k):
                    mode = "greyscale" if name == "masks" else "rgb"
                    image = AvImage(image_path, mode=mode, colorspace=inputColorspace)
                    if scale != 1:
                        image.resize(float(scale))
                    image.write(output_path, colorspace=outputColorspace)
                progress += 1
            return mapping
        
        # Undistort images
        # TODO : for now processed by IntrinsicsTransforming / ExportImages

        # Process images
        views = sfmContent.getViews()
        image_path_to_view_id = {v.getImageInfo().getImagePath(): int(v.getViewId()) for v in views.itervalues()}
        image_files = list(image_path_to_view_id.keys())
        image_name_to_view_id = {Path(im_path).stem: v for im_path, v in image_path_to_view_id.items()}
        if len(image_name_to_view_id) == 0:
            image_name_to_view_id = None
        chunk.logger.info("Process images...")
        mapping = save_downsampled("images", image_paths=image_files, image_name_to_view_id=image_name_to_view_id)
        
        # Process masks
        if chunk.node.maskFolder.value != "":
            chunk.logger.info("Process masks...")
            mask_folder = chunk.node.maskFolder.value
            if not os.path.isdir(chunk.node.maskFolder.value):
                mask_folder = os.path.dirname(chunk.node.maskFolder.value)
            image_name_to_view_id = {Path(v.getImageInfo().getImagePath()).stem: int(v.getViewId()) for v in refSfmContent.getViews().itervalues()}
            if len(image_name_to_view_id) == 0:
                image_name_to_view_id = None
            save_downsampled("masks", inputfolder=mask_folder, image_name_to_view_id=image_name_to_view_id)
        
        # Update sfm with images
        if chunk.range.start == 0:
            chunk.logger.info(f"Update SFM data...")
            for view in views.itervalues():
                imageInfo = view.getImageInfo()
                imageInfo.setImagePath(mapping[imageInfo.getImagePath()])
            # Save sfm
            chunk.logger.info(f"Save SFM data")
            sfmDataIO.save(sfmContent, chunk.node.outputSfmFile.value, sfmDataIO.ALL)

        chunk.logManager.end()
