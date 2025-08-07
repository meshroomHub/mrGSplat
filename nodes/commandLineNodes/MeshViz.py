
import os

from meshroom.core import desc

exe_path = os.path.join(os.path.dirname(__file__), 'scripts', 'meshviz.py')
rez_env = ["pytorch", "numpy", "trimesh"]


class MeshViz(desc.CommandLineNode):

    category = 'Gsplat'
    documentation = ''''''

    commandLine = 'rez env {rezEnvNameValue} -- python '+exe_path+' {modelValue} {meshPreviewValue} {samplingValue}'

    inputs = [
        desc.File(
            name="model",
            label="Model",
            description="Gaussian splats (.ckpt) to render.",
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
            value=" ".join(rez_env),
            invalidate=False,
            group="",
            advanced=True,
            exposed=False,
        ),
    ]

    outputs = [
        desc.File(
            name='meshPreview',
            label='meshPreview',
            description='meshPreview',
            value=os.path.join('{nodeCacheFolder}', "preview_mesh.obj"),
            group="",
        )
    ]
