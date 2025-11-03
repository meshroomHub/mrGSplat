
__version__ = "1.0"

import os

from meshroom.core import desc


exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'sfmPoseDistance.py')
rez_env = ["numpy", "scipy"]


DOC = """# SfmPoseDistance

Check distance from poses of a sfm and a reference sfm file. 
Use to test the pose optimization offered by GSplat : we add noise with RandomizePoses 
to a SFM where we know the poses are correctly estimated, then we optimize 
the poses with GSplat and check if we got closer
"""


class SfmPoseDistance(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''
    documentation = DOC

    commandLine = 'rez env {rezEnvNameValue} -- python ' + exe_path + ' {inputSfmValue} {referenceSfmValue} {diffFileValue}'

    def buildCommandLine(self, chunk):
        cmdLine = super(SfmPoseDistance, self).buildCommandLine(chunk)
        node = chunk.node
        if node.previousDiff.value:
            cmdLine = cmdLine + " --previousDiff " + node.previousDiff.value
        return cmdLine

    inputs = [
        desc.File(
            name='inputSfm',
            label='Input SFM',
            description='',
            value='',
        ),
        
        desc.File(
            name='referenceSfm',
            label='Reference',
            description='',
            value='',
        ),
        
        desc.File(
            name='previousDiff',
            label='Previous distance',
            description='Previous diff file to check whether we got closer or not',
            value='',
        ),
        
        desc.File(
            name="rezEnvName",
            label="Rez package name",
            description="Name (with path if necessary) of the rez package into which the computation should be executed.",
            value=" ".join(rez_env),
            invalidate=False,
            group="",
            advanced=True,
            exposed=False,
        ),
    ]

    outputs = [
        desc.File(
            name='diffFile',
            label='Distance',
            description='Distance to reference data',
            value=os.path.join("{nodeCacheFolder}/diff.json"),
            group='',
        ),
    ]
