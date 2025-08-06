
__version__ = "3.0"

import os

from meshroom.core import desc


class ExportPoses(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''

    commandLine = 'rez env {rezEnvNameValue} -- python -c "import numpy as np; import torch; np.save(\'{outputFileValue}\',torch.load(\'{modelValue}\', map_location=\'cpu\')[\'pose_adjust\'])" '

    inputs = [
        desc.File(
            name='model',
            label='Model',
            description='',
            value='',
        ),
        desc.File(
            name="rezEnvName",
            label="Rez package name",
            description="Name (with path if necessary) of the rez package into which the computation should be executed.",
            value="gsplat-develop",
            invalidate=False,
            group="",
            advanced=True,
            exposed=False,
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
            name='outputFile',
            label='outputFile',
            description='outputFile',
            value=os.path.join("{nodeCacheFolder}","poses.npy"),
            group='',
        )
    ]


