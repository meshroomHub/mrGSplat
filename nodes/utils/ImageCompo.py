__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL
import os

class ImageCompo(desc.Node):
    #size = desc.DynamicNodeSize('inputFiles')

    category = 'Gsplat'
    documentation = '''
This node allows to perform basic alpha compositing.
'''

    inputs = [
        desc.File(
            name="folderA",
            label="Folder A",
            description="Foreground images folder.",
            value="",
        ),
        desc.File(
            name="folderB",
            label="Folder B",
            description="Background images folder.",
            value="",
        ),
        desc.File(
            name="folderMask",
            label="Alpha masks folder",
            description="The alpha masks used to combine the images.",
            value="",
        ),
        desc.BoolParam(
            name="rename",
            label="rename",
            description="Renames the images",
            value=True,
        )
    ]

    outputs = [
        desc.File(
            name="combinedImageFolder",
            label="Combined images folder",
            description="The output images are mixes between input images.",
            value="{nodeCacheFolder}",
        ),
        desc.File(
            name="frames",
            label="Frames",
            description="Frames rendered using gaussian splatting.",
            semantic="sequence",
            # semantic="sequence",
            value=os.path.join("{nodeCacheFolder}", '*.jpg'),
            group="",
        ),
    ]

    def processChunk(self, chunk):
        try:
            import OpenImageIO as oiio
            import os
            import cv2

            im1_names = sorted([e for e in os.listdir(chunk.node.folderA.value) if len(e)>=5 and e[-4:]==".jpg"])
            im2_names = sorted([e for e in os.listdir(chunk.node.folderB.value) if len(e)>=5 and e[-4:]==".jpg"])
            masks_names = sorted([e for e in os.listdir(chunk.node.folderMask.value) if len(e)>=5 and e[-4:]==".jpg"])

            assert len(im1_names)==len(im2_names), f"Number of images is different in two folders: {len(im1_names)} VS {len(im2_names)}"
            assert len(im1_names)==len(masks_names), f"Number of images is different from number of masks: {len(im1_names)} VS {len(masks_names)}"
            
            for i, (a,b) in enumerate(zip(im1_names, im2_names)):
                im1_buff = oiio.ImageBuf(os.path.join(chunk.node.folderA.value, a))
                im2_buff = oiio.ImageBuf(os.path.join(chunk.node.folderB.value, b))
                
                c = [e for e in masks_names if a in e or e in a]
                assert len(c)==1, f"error, len(c)={len(c)}"
                c = c[0]

                mask_buff = oiio.ImageBuf(os.path.join(chunk.node.folderMask.value, c))

                im1 = im1_buff.get_pixels()
                im2 = im2_buff.get_pixels()
                mask = mask_buff.get_pixels()

                # resize
                H = max(max(mask.shape[0], im1.shape[0]), im2.shape[0])
                W = max(max(mask.shape[1], im1.shape[1]), im2.shape[1])

                if mask.shape[0] != H or mask.shape[1] != W:
                    chunk.logger.warning("Resizing mask")
                    mask=cv2.resize(mask, (W,H))
                    
                if im1.shape[0] != H or im1.shape[1] != W:
                    chunk.logger.warning("Resizing im1")
                    im1=cv2.resize(im1,  (W,H))
                   
                if im2.shape[0] != H or im2.shape[1] != W:
                    chunk.logger.warning("Resizing im2")
                    im2=cv2.resize(im2,  (W,H))

                res = im2*(1-mask) + im1*mask

                if chunk.node.rename.value:
                    filename = os.path.join(chunk.node.combinedImageFolder.value, "%05d.jpg"%i)
                else:
                    filename = os.path.join(chunk.node.combinedImageFolder.value, a)
                out = oiio.ImageOutput.create(filename)
                spec = oiio.ImageSpec(res.shape[1], res.shape[0], res.shape[2], oiio.UINT8)
                out.open(filename, spec)
                out.write_image(res)
                out.close()

        finally:
            chunk.logManager.end()
