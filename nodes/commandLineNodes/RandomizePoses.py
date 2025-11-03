
__version__ = "1.0"

import os

from meshroom.core import desc


exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'randomizePoses.py')
rez_env = ["numpy", "scipy"]


DOC = """# RandomizePoses (Experimental)

Randomize poses from an input SFM file by adding noise in translation and rotation.
Used to test the pose optimization offered by GSplat.
"""


class RandomizePoses(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = DOC

    commandLine = 'rez env {rezEnvNameValue} -- python ' + exe_path + ' {inputSfmDataValue} {translationValue} {rotationValue} {outputSfmDataValue}'

    inputs = [
        desc.File(
            name='inputSfmData',
            label='Camera Poses',
            description='SFM file with poses and views used for the training',
            value='',
        ),
        
        desc.FloatParam(
            name="translation",
            label="Translation noise",
            description="",
            value=0.1,
        ),
        
        desc.FloatParam(
            name="rotation",
            label="Rotation noise",
            description="",
            value=0.1,
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
            name='outputSfmData',
            label='outputSfmData',
            description='outputSfmData',
            value=os.path.join("{nodeCacheFolder}","sfm.json"),
            group='',
        ),
    ]
