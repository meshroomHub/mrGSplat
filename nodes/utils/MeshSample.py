
import os

from meshroom.core import desc

exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'meshSample.py')

class MeshSample(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''

    commandLine = 'rez env {rezEnvNameValue} -- python '+exe_path+' {meshFileValue} {samplingValue} {inputSfMDataValue} {outputSfmDataValue}'

    inputs = [
        desc.File(
            name="meshFile",
            label="meshFile",
            description="",
            value="",
            group="",
        ),
        desc.IntParam(
            name="sampling",
            label="Sampling",
            description="Step to sample the gaussians",
            value=3,
            group="",
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
        desc.File(
            name='inputSfMData',
            label='inputSfMData',
            description='SfMData file.',
            value=''
        ),
    ]

    outputs = [
        desc.File(
            name='outputSfmData',
            label='outputSfmData',
            description='outputSfmData',
            value=os.path.join('{nodeCacheFolder}', "sfm.sfm"),
            group="",
        )
    ]
