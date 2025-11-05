__version__ = "1.0"

from meshroom.core import desc


DOC = """# CleanSplats (Experimental and WIP, not working yet)

This node will try to clean some splats that are too far away from a reference mesh
"""


class CleanSplats(desc.CommandLineNode):
    
    category = 'Gsplat'
    documentation = DOC
    
    commandLine = 'gaussianSplattingClean --model {modelValue} --mesh {meshValue} --metadata {metadataFolderValue} --outputModel {cleanedModelValue}'

    inputs = [
        desc.File(
            name="model",
            label="Model",
            description="Gaussian splats (.ckpt) to render.",
            value="",
        ),
        
        desc.File(
            name="mesh",
            label="mesh",
            description="",
            value="",
        ),
        
        desc.File(
            name="metadataFolder",
            label="metadataFolder",
            description="Folder that can contain metadata files for gsplat.",
            value="",
        ),
    ]

    outputs = [
        desc.File(
            name="output",
            label="Output",
            description="Output folder.",
            value="{nodeCacheFolder}",
        ),
        
        desc.File(
            name="cleanedModel",
            label="Cleaned model",
            description="Gaussian splatting model cleaned",
            value = "{nodeCacheFolder}/ckpts/ckpt_rank0.pt",
        ),
    ]
