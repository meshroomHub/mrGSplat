
__version__ = "1.0"

from meshroom.core import desc
import os

exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'prepareAlembicCamera.py ')


class PrepareAlembicCamera(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''
    
    commandLine = f"rez env python-3.7 cask numpy scipy -- python {exe_path}"
    
    def buildCommandLine(self, chunk):
        cmdLine = super(PrepareAlembicCamera, self).buildCommandLine(chunk) # ou juste super().buildCommandLine(chunk)
        node = chunk.node
        if node.sfmData.value:
            cmdLine = cmdLine + " --sfmData " + node.sfmData.value
        else:
            cmdLine = cmdLine + " --alembicFile " + node.alembicFile.value
            cmdLine = cmdLine + " --alembicPath " + node.alembicPath.value
        cmdLine = cmdLine + " --result_dir " + node.output.value
        return cmdLine

    inputs = [
        desc.File(
            name='sfmData',
            label='sfmData',
            description='',
            value='',
        ),

        desc.File(
            name="alembicFile",
            label="Alembic file",
            description="Alembic file",
            value="",
        ),
        
        desc.File(
            name="alembicPath",
            label="Alembic path",
            description="Path to the camera in the alembic file",
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
            name="cameraPoses",
            label="Camera Poses",
            description="Camera Poses file.",
            value="{nodeCacheFolder}/cameraPoses.txt",
        )
    ]
