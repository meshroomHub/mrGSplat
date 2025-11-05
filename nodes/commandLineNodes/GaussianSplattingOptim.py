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
        cmdLine = self.commandLine + f" --data_factor 1"
        saveSteps = str(node.max_steps.value)
        if node.custom_ckpts.value:
            saveSteps = " ".join([str(e.value) for e in node.save_steps.value])
        cmdLine += f" --save_steps {saveSteps}"
        # cmdLine += f" --eval_steps {node.max_steps.value}"
        cmdLine += f" --eval_steps"
        if node.pose_opt.value:
            cmdLine += f" --pose_opt"
        if node.image_alpha.value:
            cmdLine += f" --image_alpha"
        print("\n" + cmdLine + "\n")
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
        # Masks are in alpha -> use exportImages
        # desc.File(
        #     name="masksFolder",
        #     label="masksFolder",
        #     description="Masks folder.",
        #     value="",
        #     group="allParams"
        # ),
        # Disabled metadata for now
        # desc.File(
        #     name="metadataFolder",
        #     label="metadataFolder",
        #     description="Folder that can contain metadata files for gsplat.",
        #     value="",
        # ),
        desc.File(
            name="resume_ckpt",
            label="resumeFromModel",
            description="resumeFromModel",
            value="",
            group="allParams"
        ),
        desc.IntParam(
            name="max_steps",
            label="Number of Steps",
            description="The number of steps performed by the optimization. (1 step per image)\n"
                        "For 50 images: 3000 for quick debug, 30000 for good quality.",
            value=30000,
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
                name="save_steps",
                label="Saving step",
                description="Step at which the model will be saved as checkpoint.",
                value=30000,
            ),
            name="save_steps",
            label="Saving steps",
            description="All the steps at which the model will be saved as a check point.",
            group=""
        ),
        desc.BoolParam(
            name="pose_opt",
            label="Optim Poses",
            description="Whether to optimise the poses or not.",
            value=False,
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
            value = lambda attr: "{nodeCacheFolder}" + f"/ckpts/ckpt_{attr.node.max_steps.value-1}_rank0.pt",
            group=""
        ),
        desc.File(
            name="optimizedPoses",
            label="Poses",
            description="Optimized poses",
            value = lambda attr: "{nodeCacheFolder}" + f"/ckpts/poses{attr.node.max_steps.value-1}.sfm",
            group=""
        ),
    ]
