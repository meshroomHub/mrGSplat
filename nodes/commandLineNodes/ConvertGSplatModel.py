
import os
from pathlib import Path

from meshroom.core import desc

exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'convertGSplatModel.py')
rez_env = ["python-3.11", "pytorch", "numpy", "plyfile"]


class ConvertGSplatModel(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''

    commandLine = 'rez env {rezEnvNameValue} -- python '+exe_path+' {inputValue} {formatValue} {outputValue}'

    inputs = [
        desc.File(
            name="input",
            label="Input Model",
            description="Gaussian splats (.ckpt) to render.",
            value="",
        ),
        
        desc.ChoiceParam(
            name='format',
            label='Format',
            description='''Output format''',
            value='.ply',
            values=['.ply'],
            exclusive=True,
        ),
        
        desc.File(
            name="rezEnvName",
            label="Rez package name",
            description="Name (with path if necessary) of the rez package into which the computation should be executed.",
            value=" ".join(rez_env),
            invalidate=False,
            advanced=True,
            exposed=False,
        ),
    ]
    
    outputs = [
        desc.File(
            name='output',
            label='Output Model',
            description='Output model',
            value="{nodeCacheFolder}/gsplat_model{formatValue}"
        )
    ]
