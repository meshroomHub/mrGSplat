
import os
from pathlib import Path

from meshroom.core import desc

exe_path = os.path.join(os.path.dirname(__file__), '../../scripts', 'convertGSplatModel.py')

DOC = """# ConvertGSplatModel

Converts a GSplat model to a model that can be used outside of Meshroom.
The PLY format can be used with GSOPs in Houdini
"""


class ConvertGSplatModel(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = DOC

    commandLine = 'python '+exe_path+' {inputValue} {formatValue} {outputValue}'

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
        )
    ]
    
    outputs = [
        desc.File(
            name='output',
            label='Output Model',
            description='Output model',
            value="{nodeCacheFolder}/gsplat_model{formatValue}"
        )
    ]
