__version__ = "1.0"

from meshroom.core import desc


DOC = """# InitializeSplats (Experimental)

This node will initialize splats to make sure the model is initialized with correct colors.
"""


class InitializeSplats(desc.CommandLineNode):
    
    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE

    category = 'Gsplat'
    documentation = DOC
    
    # commandLine = 'rez env {rezEnvNameValue} -- gaussianSplattingInit --sfm {sfmValue} --resultDirectory {cache}/{nodeType}/{uid}'
    commandLine = 'rez env {rezEnvNameValue} -- gaussianSplattingInit --sfm {sfmValue} --resultDirectory {nodeCacheFolder}'

    def buildCommandLine(self, chunk):
        cmdLine = super(InitializeSplats, self).buildCommandLine(chunk) # ou juste super().buildCommandLine(chunk)
        node = chunk.node
        if node.masksFolder.value:
            cmdLine = cmdLine + " --masksFolder " + node.masksFolder.value
        if node.metadataFolder.value:
            cmdLine = cmdLine + " --metadataFolder " + node.metadataFolder.value
        return cmdLine

    inputs = [
        desc.File(
            name="rezEnvName",
            label="Rez package name",
            description="Name (with path if necessary) of the rez package into which the computation should be executed.",
            value="gsplat-develop",
            invalidate=False,
            advanced=True,
            exposed=False,
        ),
        
        desc.File(
            name="sfm",
            label="sfmData",
            description="SfMData with the views, poses and intrinsics to use.",
            value="",
        ),
        
        desc.File(
            name="masksFolder",
            label="masksFolder",
            description="Masks folder.",
            value="",
        ),
        
        desc.File(
            name="metadataFolder",
            label="metadataFolder",
            description="Folder that can contain metadata files for gsplat.",
            value="",
        )
    ]

    outputs = [
        desc.File(
            name="output",
            label="Output",
            description="Output folder.",
            value="{nodeCacheFolder}",
        ),
        
        desc.File(
            name="sfmData",
            label="SfmData",
            description="Updated SFM data",
            value="{nodeCacheFolder}/sfm.json", 
        ),
        
        desc.File(
            name="model",
            label="Model",
            description="Initialized gaussian splatting model",
            value="{nodeCacheFolder}/ckpts/ckpt_0_rank0.pt", 
        ),
    ]
