
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
            semantic="image"
        )
    ]

    def processChunk(self, chunk):
        """
        image_<scale>
        mask_<scale>
        in output folder
        """
        import numpy as np
        from shutil import copytree
        import cv2
        from PIL import Image

        def open_image(i):
            return np.asarray(Image.open(i))
        
        def save_image(p,i):
            Image.fromarray(i).save(p)
      
        chunk.logManager.start(chunk.node.verboseLevel.value)
       
        #copy colmap folder
        copytree(os.path.join(chunk.node.colmapFolder.value,"dense"), os.path.join(chunk.node.outputFolder.value,"dense"),dirs_exist_ok=True)
        copytree(os.path.join(chunk.node.colmapFolder.value,"sparse"), os.path.join(chunk.node.outputFolder.value,"sparse"), dirs_exist_ok=True)
      

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
            chunk.logger.info("Looking for images")
            image_files = [f 
                    for f in os.listdir(inputfolder) if f.endswith(".exr") or f.endswith(".jpg") or f.endswith(".JPG") ]
            chunk.logger.info(image_files)
            scale=chunk.node.scale.value
            folder_name = name if scale == 1 else name+"_"+str(scale)
            os.makedirs(os.path.join(chunk.node.outputFolder.value, folder_name), exist_ok=True)
            os.symlink(folder_name, os.path.join(chunk.node.outputFolder.value, name))
            for image_file in image_files:
                chunk.logger.info(image_file)
                image_file=os.path.join(inputfolder,image_file)
                if not os.path.exists(image_file):
                    chunk.logger.info("Issue with "+image_file+", skipping")
                image = open_image(image_file)/255.0
            
                chunk.logger.info("Resizing at "+scale)
                images_resized = cv2.resize(image, (0,0), fx=1/float(scale), fy=1/float(scale))
                
                chunk.logger.info("Saving image")
                
                im_path=os.path.join(chunk.node.outputFolder.value, folder_name, os.path.basename(image_file))
                chunk.logger.info(im_path)
                save_image(im_path,(255*images_resized).astype(np.uint8))
   
                
        if chunk.node.maskFolder.value != "":
            save_downsampled(chunk.node.maskFolder.value, "masks")
        save_downsampled(os.path.join(chunk.node.colmapFolder.value, "images"), "images")
        chunk.logManager.end()

