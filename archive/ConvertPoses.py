__version__ = "1.0"

from meshroom.core import desc
from meshroom.core.utils import VERBOSE_LEVEL

import os

class ConvertPoses(desc.Node):
    category = 'Gsplat'
    documentation = ''''''

    inputs = [
        desc.File(
            name="npy",
            label="npy",
            description="Poses npy",
            value="",
        ),
       desc.File(
            name='inputSfm',
            label='inputSfm',
            description='sfm',
            value="",
            group='',
        )
    ]

    outputs = [
        desc.File(
            name='sfm',
            label='sfm',
            description='sfm',
            value=os.path.join("{nodeCacheFolder}","sfm.sfm"),
            group='',
        )
    ]

    def processChunk(self, chunk):
        import numpy as np
        
        import pyalicevision as av
        try:
            
            # assumes same order
            poses=np.load(chunk.node.desc.npy.value)
            data = av.sfmData.SfMData()
            print("Load")
            ret = av.sfmDataIO.load(data, chunk.node.desc.inputSfm.value, av.sfmDataIO.VIEWS)
            print(data.getViews())
            #views = sorted(data.getViews(),key=data.)
            for pose, view in zip(poses, data.getViews()):
                view.s
            print("e")

        finally:
            chunk.logManager.end()
