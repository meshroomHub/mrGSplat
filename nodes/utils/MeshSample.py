
import os
import re

from meshroom.core import desc

exe_path_obj = os.path.join(os.path.dirname(__file__), 'scripts', 'meshSampleObj.py')
required_pkg_obj = ["numpy", "trimesh"]
exe_path_abc = os.path.join(os.path.dirname(__file__), 'scripts', 'meshSampleAbc.py')
required_pkg_abc = ["numpy", "cask", "python-2.7"]


class MeshSample(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''

    def buildCommandLine(self, chunk):
        node = chunk.node
        meshFile = node.meshFile.value
        # Build rez env rezEnvName -- python exe_path
        rezEnv = node.rezEnvName.value.split(" ")
        packages = [re.split("-|==", x)[0] for x in rezEnv if x]
        if os.path.splitext(meshFile)[1] == ".abc":
            for missing_pkg in [x for x in required_pkg_abc if re.split("-|==", x)[0] not in packages]:
                rezEnv.append(missing_pkg)
            exe_path = exe_path_abc
        else:
            for missing_pkg in [x for x in required_pkg_obj if re.split("-|==", x)[0] not in packages]:
                rezEnv.append(missing_pkg)
            exe_path = exe_path_obj
        cmdLine = f"rez env {' '.join([x for x in rezEnv if x])} -- python {exe_path}"
        # Build remaining args
        cmdLine += f" {node.meshFile.value} {node.sampling.value} {node.inputSfMData.value} {node.outputSfmData.value}"
        return cmdLine

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
