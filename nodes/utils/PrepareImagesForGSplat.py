
__version__ = "1.0"

import os
from pathlib import Path

from meshroom.core import desc
from pyalicevision import sfmData, sfmDataIO

SCALES = ['1', '2', '4', '8', '16', '32', '64']
VALID_IMG_EXT = (".exr", ".jpg", ".JPG", ".png", ".PNG")


class ViewsRange:
    """
    ViewsRange splits a range in several chunks. We use this here in order to make sure that we
    will export all images, and we try to deal with an equivalent number of images per chunk
    """
    def __init__(self, nb_views, chunkRange):
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
    
    def get_block_id(self, index):
        for chunkId, chunk in enumerate(self.chunks):
            if index in chunk:
                return chunkId
        return None
    
    def isViewInRange(self, index):
        return self.get_block_id(index) == self.iteration
    
    def get_current_block_info(self):
        chunk = self.chunks[self.iteration]
        return f"Block [{self.iteration+1}/{self.nbBlocks}] -> Process views {chunk[0]} to {chunk[-1]}"
            

class PrepareImagesForGSplat(desc.Node):

    category = 'Gsplat'
    documentation = ''''''
    
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
            description="If you use masks we need to match masks with images in the input SFM. " \
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
        """
        image_<scale>
        mask_<scale>
        in output folder
        """
        import OpenImageIO as oiio
        from pyalicevision.system import ConsoleProgressDisplay

        chunk.logManager.start(chunk.node.verboseLevel.value)
        
        class Image:
            # TODO : replace with pyalicevision.image
            def __init__(self, path):
                self.path = path
                self.buf = None
                self.open()
            
            def open(self):
                self.buf = oiio.ImageBuf(self.path)
            
            def resize(self, factor):
                spec = self.buf.spec()
                W = int(spec.width / factor)
                H = int(spec.height / factor)
                resized = oiio.ImageBuf(oiio.ImageSpec(W, H, spec.nchannels, spec.format))
                oiio.ImageBufAlgo.resize(resized, self.buf)
                self.buf = resized
            
            def write(self, output):
                self.buf.write(output)
        
        # Load SFM
        sfmPath = chunk.node.sfmData.value
        sfmContent = sfmData.SfMData()
        if not sfmDataIO.load(sfmContent, sfmPath, sfmDataIO.ALL):
            raise SystemError(f"Could not load sfm file {sfmPath}")
        
        viewrange = ViewsRange(len(sfmContent.getViews()), chunk.range)
        chunk.logger.info(viewrange.get_current_block_info())
        
        # Load reference SFM
        refSfmPath = chunk.node.referenceSfm.value
        # frame_id_to_name = {}
        view_id_to_name = {}  # { viewId: img_name (without ext) }
        if refSfmPath and os.path.exists(refSfmPath):
            refSfmContent = sfmData.SfMData()
            if not sfmDataIO.load(refSfmContent, refSfmPath, sfmDataIO.ALL):
                raise SystemError(f"Could not load sfm file {refSfmPath}")
            # Build frame_id_to_name
            for view in refSfmContent.getViews().itervalues():
                img_path = view.getImageInfo().getImagePath()
                img_name = os.path.splitext(os.path.basename(img_path))[0]
                # frame_id = view.getFrameId()
                # frame_id_to_name[int(frame_id)] = img_name
                view_id = view.getViewId()
                view_id_to_name[int(view_id)] = img_name
        
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
                    image = Image(image_path)
                    image.resize(float(scale))
                    image.write(output_path)
                progress += 1
            return mapping
        
        # Undistort images
        # TODO

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
