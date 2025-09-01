
__version__ = "1.0"

from meshroom.core import desc
import os

exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'importAlembicCamera.py')
rez_env = ["python-3.7", "scipy", "numpy", "cask"]


class ImportAlembicCamera(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''
    
    commandLine = 'rez env {rezEnvNameValue} -- python ' + exe_path
    
    def buildCommandLine(self, chunk):
        cmdLine = super(ImportAlembicCamera, self).buildCommandLine(chunk) # ou juste super().buildCommandLine(chunk)
        node = chunk.node
        if node.sfmData.value:
            cmdLine = cmdLine + " --sfmData " + node.sfmData.value
        else:
            cmdLine = cmdLine + " --alembicFile " + node.alembicFile.value
            cmdLine = cmdLine + " --alembicPath " + node.cameraPath.value
        cmdLine = cmdLine + " --result_dir " + node.output.value
        # Default cam
        defaultCam = node.defaultCameraAttributes
        if defaultCam.width.value:
            cmdLine = cmdLine + " --width " + str(defaultCam.width.value)
        if defaultCam.height.value:
            cmdLine = cmdLine + " --height " + str(defaultCam.height.value)
        if defaultCam.sensorWidth.value:
            cmdLine = cmdLine + " --sensorWidth " + str(defaultCam.sensorWidth.value)
        if defaultCam.sensorHeight.value:
            cmdLine = cmdLine + " --sensorHeight " + str(defaultCam.sensorHeight.value)
        if defaultCam.focal.value:
            cmdLine = cmdLine + " --focalLength " + str(defaultCam.focal.value)
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
            name="cameraPath",
            label="Alembic path",
            description="Path to the camera in the alembic file",
            value="",
        ),
        
        desc.GroupAttribute(
            name="defaultCameraAttributes",
            label="Default Camera",
            description="Intrinsics to use.",
            groupDesc=[
                desc.IntParam(
                    name="width",
                    label="W",
                    description="",
                    value=1920,
                ),
                desc.IntParam(
                    name="height",
                    label="H",
                    description="",
                    value=1080,
                ),
                desc.FloatParam(
                    name="sensorWidth",
                    label="Sensor Width",
                    description="",
                    value=36.0,
                ),
                desc.FloatParam(
                    name="sensorHeight",
                    label="Sensor Height",
                    description="",
                    value=20.25,
                ),
                desc.FloatParam(
                    name="focal",
                    label="focal length",
                    description="",
                    value=26.5,
                ),
            ],
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
            name="output",
            label="Output",
            description="Output folder.",
            value="{nodeCacheFolder}",
        ),
        
        desc.File(
            name="cameraPoses",
            label="Camera Poses",
            description="SFM containing poses.",
            value="{nodeCacheFolder}/sfmData.json",
        )
    ]
