
__version__ = "1.0"

import os

from meshroom.core import desc


exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'exportPoses.py')
rez_env = ["numpy", "pytorch", "scipy", "aliceVision"]


DOC = """# ExportPoses (Experimental)

Update the input sfmData with poses from a GSplat model.
It can be used when we want to use GSplat to optimize camera poses
"""


class ExportPoses(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = DOC

    commandLine = 'rez env {rezEnvNameValue} -- python ' + exe_path + ' {modelValue} {inputSfmDataValue} {nodeCacheFolder}'

    inputs = [
        desc.File(
            name='model',
            label='Model',
            description='',
            value='',
        ),
        
        desc.File(
            name='inputSfmData',
            label='Camera Poses',
            description='SFM file with poses and views used for the training',
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
            name='outputFile',
            label='outputFile',
            description='outputFile',
            value=os.path.join("{nodeCacheFolder}","poses.npy"),
            group='',
        ),
        
        desc.File(
            name='sfmData',
            label='sfmData',
            description='sfmData',
            value=os.path.join("{nodeCacheFolder}","sfm.json"),
            group='',
        )
    ]
