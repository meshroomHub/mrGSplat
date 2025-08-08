
__version__ = "1.0"

import os

from meshroom.core import desc
from pyalicevision import sfmData, sfmDataIO


DOC = """Allow to extract poses that are coming from a sfm file.
In some cases, for example when we use a ImageMatchingMultiSfm node, we have
poses from multiple intrinsics on the same file.
This node allows to extract the poses that match intrinsics found on on a second sfm
"""
            

class ExtractPosesFromSfm(desc.Node):

    category = 'Gsplat'
    documentation = DOC
    
    size = desc.DynamicNodeSize("sfmData")

    inputs = [
        desc.File(
            name='sfmData',
            label='sfmData',
            description='',
            value='',
        ),
        desc.File(
            name='referenceSfmData',
            label='Reference',
            description='',
            value='',
        ),
        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='''verbosity level (fatal, error, warning, info, debug, trace).''',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
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
    ]

    def processChunk(self, chunk):
        chunk.logManager.start(chunk.node.verboseLevel.value)
        # chunk.logger.info("")
        
        # Load SFM
        sfmPath = chunk.node.sfmData.value
        sfmContent = sfmData.SfMData()
        if not sfmDataIO.load(sfmContent, sfmPath, sfmDataIO.ALL):
            raise SystemError(f"Could not load sfm file {sfmPath}")
        
        # Load reference
        refSfmPath = chunk.node.referenceSfmData.value
        refSfmContent = sfmData.SfMData()
        if not sfmDataIO.load(refSfmContent, refSfmPath, sfmDataIO.ALL):
            raise SystemError(f"Could not load sfm file {refSfmPath}")
        intrinsicsToKeep = list(refSfmContent.getIntrinsics().iterkeys())
        
        # Get elements to remove
        poseIdsToRemove = []
        viewIdsToRemove = []
        intrinsicIdsToRemove = []
        for viewId, view in sfmContent.getViews().iteritems():
            intrinsicId = view.getIntrinsicId()
            if intrinsicId not in intrinsicsToKeep:
                poseIdsToRemove.append(view.getPoseId())
                viewIdsToRemove.append(viewId)
        for intrinsicId in sfmContent.getIntrinsics().iterkeys():
            if intrinsicId not in intrinsicsToKeep:
                intrinsicIdsToRemove.append(intrinsicId)
        # Erase poses
        print(f"Erase {len(poseIdsToRemove)} poses : \n{poseIdsToRemove}")
        # sfmContent.getPoses().erase(poseIdsToRemove)
        for poseId in poseIdsToRemove:
            sfmContent.erasePose(poseId)
        # Erase views
        print(f"Erase {len(viewIdsToRemove)} views : \n{viewIdsToRemove}")
        for viewId in viewIdsToRemove:
            sfmContent.getViews().erase(viewId)
        # Erase intrinsics
        print(f"Erase {len(intrinsicIdsToRemove)} intrinsics : \n{intrinsicIdsToRemove}")
        for intrinsicId in intrinsicIdsToRemove:
            sfmContent.getIntrinsics().erase(intrinsicId)
        
        # Save sfm
        chunk.logger.info(f"Save SFM data")
        sfmDataIO.save(sfmContent, chunk.node.outputSfmFile.value, sfmDataIO.VIEWS|sfmDataIO.EXTRINSICS|sfmDataIO.INTRINSICS)

        chunk.logManager.end()
