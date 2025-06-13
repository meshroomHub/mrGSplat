
__version__ = "3.0"

import os

from meshroom.core import desc

SCALES = ['1', '2', '4', '8', '16', '32', '64']

class PrepareFolderForGS(desc.Node):

    category = 'Gsplat'
    documentation = ''''''

    inputs = [
        desc.File(
            name='colmapFolder',
            label='colmapFolder',
            description='',
            value='',
        ),

        desc.File(
            name="maskFolder",
            label="Mask Folder",
            description="maskFolder",
            value="",
        ),

        desc.ChoiceParam(
            name='scale',
            label='scale',
            description=''' ''',
            value=['1', '2', '4', '8'],
            values=SCALES,
            exclusive=False,
        ),

        desc.ChoiceParam(
            name='selectedScale',
            label='selectedScale',
            description=''' ''',
            value='1',
            values=SCALES,
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
        )

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
            name='outputImageFolder',
            label='outputImageFolder',
            description='outputImageFolder',
            value=os.path.join("{nodeCacheFolder}", "images"),
            group='',
        )
    ]

    def processChunk(self, chunk):
        """
        image_<scale>
        mask_<scale>
        in output folder
        """
        import numpy as np
        from shutil import copytree, rmtree
        import cv2
        from PIL import Image

        def open_image(i):
            return np.asarray(Image.open(i))
        
        def save_image(p,i):
            Image.fromarray(i).save(p)
      
        chunk.logManager.start(chunk.node.verboseLevel.value)
       
        #copy colmap folder
        copytree(chunk.node.colmapFolder.value, chunk.node.outputFolder.value, dirs_exist_ok=True)
        rmtree(os.path.join(chunk.node.outputFolder.value, 'images'))
        

        if chunk.node.forcePinhole.value:
            camera_file_path = os.path.join(chunk.node.outputFolder.value, "sparse", "cameras.txt")
            if not os.path.exists(camera_file_path):
                camera_file_path = os.path.join(chunk.node.outputFolder.value, "sparse", "0", "cameras.txt")
            with open(camera_file_path, "r") as camera_file:
                lines = camera_file.readlines()
            with open(camera_file_path, "w") as camera_file:
                for l in lines:
                    l = l.replace("FULL_OPENCV", "PINHOLE")
                    l = " ".join(l.split(" ")[0:8])
                    camera_file.write(l)
        #resize images and images
        def save_downsampled(inputfolder, name):
            chunk.logger.info("Loading...")
            image_files = [f 
                    for f in os.listdir(inputfolder) if f.endswith(".exr") or f.endswith(".jpg")]
            images = []
            for image_file in image_files:
                image_file=os.path.join(inputfolder,image_file)
                if not os.path.exists(image_file):
                    chunk.logger.info("Issue with "+image_file+", skipping")
                images.append(open_image(image_file)/255.0)
            #for each scale, save in mask_<scale>
            for scale in chunk.node.scale.value:
                dirname = name+"_"+scale
                if os.path.exists(dirname):
                    chunk.logger.warning("Folder "+dirname+" already computed, skipping")
                    continue
                chunk.logger.info("Resizing at "+scale)
                images_resized = [cv2.resize(m, (0,0), fx=1/float(scale), fy=1/float(scale)) for m in images]
                chunk.logger.info("Saving images")
                #if int(scale)!=int(chunk.node.selectedScale.value) else name
                os.makedirs(os.path.join(chunk.node.outputFolder.value, dirname), exist_ok=True)
                for image_file, image in zip(image_files, images_resized):
                    save_image(os.path.join(chunk.node.outputFolder.value, dirname, image_file[:-4]+".jpg"),(255*image).astype(np.uint8))
            #create symlink for used scale
            os.symlink(os.path.join(chunk.node.outputFolder.value, 
                                    name+"_"+chunk.node.selectedScale.value),
                       os.path.join(chunk.node.outputFolder.value, name))
            
        if chunk.node.maskFolder.value != "":
            save_downsampled(chunk.node.maskFolder.value, "masks")
        save_downsampled(os.path.join(chunk.node.colmapFolder.value, "images"), "images")
        chunk.logManager.end()

