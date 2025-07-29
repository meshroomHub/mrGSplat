__version__ = "1.0"

from meshroom.core import desc
import os.path

currentDir = os.path.dirname(os.path.abspath(__file__))

class GaussianSplattingOptim(desc.CommandLineNode):
    
    commandLine = 'rez env {rezEnvNameValue} -- gaussianSplattingOptim --sfm {sfmValue} --resultDirectory {cache}/{nodeType}/{uid} --data_factor {dataFactorValue} --maxSteps {n_stepsValue} --evalSteps'

    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE

    category = 'Gsplat'
    documentation = '''
    This node creates and optimizes a gaussian splatting model based on sfm data and images.
    '''

    def buildCommandLine(self, chunk):
        cmdLine = super(GaussianSplattingOptim, self).buildCommandLine(chunk) # ou juste super().buildCommandLine(chunk)
        node = chunk.node
        if node.masksFolder.value:
            cmdLine = cmdLine + " --masksFolder " + node.masksFolder.value
        if node.metadataFolder.value:
            cmdLine = cmdLine + " --metadataFolder " + node.metadataFolder.value
        if node.pose_opt.value:
            cmdLine = cmdLine + " --poseOpt"
        if node.resumeCheckpoint.value:
            cmdLine = cmdLine + " --resumeCkpt " + node.resumeCheckpoint.value
        saveSteps = "{}".format(
            str(node.n_steps.value) if not node.custom_ckpts.value else " ".join([str(e.value) for e in node.save_steps.value])
        )
        cmdLine = cmdLine + f" --saveSteps \"{saveSteps}\""
        return cmdLine

    inputs = [
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
            name="sfm",
            label="sfmData",
            description="SfMData with the views, poses and intrinsics to use.",
            value="",
            group="",
        ),
        desc.IntParam(
            name="dataFactor",
            label="Scale factor",
            description="",
            value=1,
            group="",
        ),
        desc.File(
            name="masksFolder",
            label="masksFolder",
            description="Masks folder.",
            value="",
            group="",
        ),
        desc.File(
            name="metadataFolder",
            label="metadataFolder",
            description="Folder that can contain metadata files for gsplat.",
            value="",
            group="",
        ),
        desc.File(
            name="resumeCheckpoint",
            label="resumeFromModel",
            description="resumeFromModel",
            value="",
            group="",
            
        ),
        desc.IntParam(
            name="n_steps",
            label="Number of Steps",
            description="The number of steps performed by the optimization. (1 step per image)\n"
                        "For 50 images: 3000 for quick debug, 30000 for good quality.",
            value=30000,
            group="",
        ),
        desc.BoolParam(
            name="custom_ckpts",
            label="Use custom checkpoints",
            description="Set to True to provide custom checkpoints; default behavior is to save the model once, at the end of the optimization.",
            value=False,
            group="",
        ),
        desc.ListAttribute(
            desc.IntParam(
                name="save_step",
                label="Saving step",
                description="Step at which the model will be saved as checkpoint.",
                value=30000,
                group="",
            ),
            name="save_steps",
            label="Saving steps",
            description="All the steps at which the model will be saved as a check point.",
            group="",
            # TODO add enabled = 
        ),
        desc.BoolParam(
            name="pose_opt",
            label="Optim Poses",
            description="Whether to optimise the poses or not.",
            value=False,
            group="",
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
            name="model",
            label="Model",
            description="Optimized gaussian splatting model",
            value = lambda attr: "{nodeCacheFolder}" + f"/ckpts/ckpt_{attr.node.n_steps.value-1}_rank0.pt",
            group="",
        ),
    ]
