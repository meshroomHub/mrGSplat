__version__ = "1.0"

from meshroom.core import desc


class GaussianSplattingOptim(desc.CommandLineNode):
    
    commandLine = "gaussianSplattingOptim {allParams}"

    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE

    category = 'Gsplat'
    documentation = '''
This node creates and optimizes a gaussian splatting model based on sfm data and images.
'''

    def buildCommandLine(self, chunk):

        node = chunk.node

        # Always 1 because the scale is updated in the intrinsics by the exportImages 
        cmdLine = self.commandLine
        saveEpochs = str(node.max_epochs.value)
        if node.custom_ckpts.value:
            saveEpochs = " ".join([str(e.value) for e in node.save_epochs.value])

        cmdLine += f" --save_epochs {saveEpochs}"
                
        if node.image_alpha.value:
            cmdLine += f" --image_alpha"
        
        # Update nodeDesc.commandLine
        node.nodeDesc.commandLine = cmdLine
        
        return super().buildCommandLine(chunk)

    inputs = [
        desc.File(
            name="sfm_file",
            label="sfmData",
            description="SfMData with the views, poses and intrinsics to use.",
            value="",
            group="allParams"
        ),
        desc.BoolParam(
            name="image_alpha",
            label="Images have alpha channel",
            description="Set to True if images has an alpha channel.",
            value=False,
            group=""
        ),
        
        desc.File(
            name="resume_ckpt",
            label="resumeFromModel",
            description="Resume from Model",
            value="",
            group="allParams"
        ),
        desc.IntParam(
            name="max_epochs",
            label="Number of Epochs",
            description="The number of epochs performed by the optimization.\n"
                        "60 for quick debug, 600 for good quality.",
            value=600,
            group="allParams"
        ),
        desc.BoolParam(
            name="custom_ckpts",
            label="Use custom checkpoints",
            description="Set to True to provide custom checkpoints; default behavior is to save the model once, at the end of the optimization.",
            value=False,
            group=""
        ),
        desc.ListAttribute(
            desc.IntParam(
                name="save_epoch",
                label="Saving epoch",
                description="Epoch at which the model will be saved as checkpoint.",
                value=600,
            ),
            name="save_epochs",
            label="Saving epochs",
            description="All the epochs at which the model will be saved as a check point.",
            group=""
        )
    ]

    outputs = [
        desc.File(
            name="result_dir",
            label="Output",
            description="Output folder.",
            value="{nodeCacheFolder}",
            group="allParams"
        ),
        desc.File(
            name="model",
            label="Model",
            description="Optimized gaussian splatting model",
            value = lambda attr: "{nodeCacheFolder}" + f"/ckpts/ckpt_{attr.node.max_epochs.value-1}_rank0.pt",
            group=""
        )
    ]
