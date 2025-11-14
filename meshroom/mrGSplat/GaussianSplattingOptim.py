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

        cmdLine = "gaussianSplattingOptim"
        cmdLine += f" {node.strategy.value} "
        cmdLine += "{allParams}"

        saveEpochs = str(node.max_epochs.value)
        if node.custom_ckpts.value:
            saveEpochs = " ".join([str(e.value) for e in node.save_epochs.value])

        cmdLine += f" --save_epochs {saveEpochs}"

        if node.patchSize.value > 0:
            cmdLine += f" --patch_size {node.patchSize.value}"
                
        if node.image_alpha.value:
            cmdLine += f" --image_alpha"

        if node.sparseGradient.value:
            cmdLine += " --sparse_grad --packed"
        
        if node.visibleAdam.value:
            cmdLine += " --visible_adam"

        if node.randomBkgd.value:
            cmdLine += " --random_bkgd"

        if node.poseOpt.value:
            cmdLine += " --pose_opt"
        
        # if node.appOpt.value:
        #     cmdLine += " --app_opt"

        if node.useBilateralGrid.value:
            cmdLine += " --use_bilateral_grid"
        
        if node.useFusedBilagrid.value:
            cmdLine += " --use_fused_bilagrid"
        
        if node.useDepthLoss.value:
            cmdLine += " --depth_loss"
        
        if node.use3DGut.value:
            cmdLine += " --with_ut --with_eval3d"

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
            group=None
        ),
        desc.File(
            name="resume_ckpt",
            label="Resume From Model",
            description="Resume from Model",
            value="",
            group="allParams"
        ),
        desc.ChoiceParam(
            name='strategy',
            label='Densification Strategy',
            description='''Densification Strategy to use (Default or Mcmc)''',
            value='default',
            values=['default', 'mcmc'],
            exclusive=True,
            group=None
        ),
        desc.IntParam(
            name="max_epochs",
            label="Number Of Epochs",
            description="The number of epochs performed by the optimization.\n"
                        "60 for quick debug, 600 for good quality.",
            value=600,
            group="allParams"
        ),
        desc.IntParam(
            name="patchSize",
            label="Patch Size",
            description="Size of randomly cropped patches\n"
                        "Use a value of 0 to disable random crop.",
            value=0,
            group=None,
        ),
        desc.IntParam(
            name="sh_degree",
            label="Degrees Of Spherical Harmonics",
            description="How many degrees are we using to describe texture in a splat.",
            value=3,
            range=[0, 6, 1],
            group="allParams"
        ),
        desc.IntParam(
            name="sh_degree_interval",
            label="Steps For Spherical Harmonics",
            description="One degree is activate at a time.\n"
            "We start with 0 degree and activate a new harmonic degree each sh_degree_interval steps.",
            value=1000,
            range=[100, 100000, 100],
            group="allParams"
        ),
        desc.FloatParam(
            name="init_opa",
            label="Initial Opacity",
            description="A gaussian splat is initialized with an opacity between 0 and 1",
            value=0.1,
            range=[0.0, 1.0, 0.1],
            group="allParams"
        ),
        desc.FloatParam(
            name="init_scale",
            label="Initial Scale",
            description="A gaussian splat is initialized with a scale",
            value=1.0,
            range=[0.0, 1.0, 0.1],
            group="allParams"
        ),
        desc.FloatParam(
            name="ssim_lambda",
            label="Weight SSIM",
            description="Weight of the SSIM loss in the total loss",
            value=0.2,
            group="allParams"
        ),
        desc.FloatParam(
            name="near_plane",
            label="Rendering Near Plane",
            description="Near plane used for rendering frustum",
            value=0.01,
            group="allParams"
        ),
        desc.FloatParam(
            name="far_plane",
            label="Rendering Far Plane",
            description="Far plane used for rendering frustum",
            value=1e10,
            group="allParams"
        ),
        desc.FloatParam(
            name="means_lr",
            label="Gaussian Centers LR",
            description="Gaussian Centers Learning Rate",
            value=1.6e-4,
            group="allParams"
        ),
        desc.FloatParam(
            name="scales_lr",
            label="Gaussian Scales LR",
            description="Gaussian Scales Learning Rate",
            value=5e-3,
            group="allParams"
        ),
        desc.FloatParam(
            name="opacities_lr",
            label="Gaussian Opacities LR",
            description="Gaussian Opacities Learning Rate",
            value=5e-2,
            group="allParams"
        ),
        desc.FloatParam(
            name="quats_lr",
            label="Gaussian Orientation LR",
            description="Gaussian Orientation Learning Rate",
            value=1e-3,
            group="allParams"
        ),
        desc.FloatParam(
            name="sh0_lr",
            label="Gaussian Brightness LR",
            description="Gaussian Brightness Learning Rate (Spherical harmonics 1st degree)",
            value=2.5e-3,
            group="allParams"
        ),
        desc.FloatParam(
            name="shN_lr",
            label="Gaussian SH LR",
            description="Gaussian Spherical harmonics Learning Rate",
            value=2.5e-3 / 20,
            group="allParams"
        ),
        desc.BoolParam(
            name="sparseGradient",
            label="Use Sparse Gradients",
            description="Use sparse gradients for optimization.",
            value=False,
            group=None
        ),
        desc.BoolParam(
            name="visibleAdam",
            label="Use Visible Adam",
            description="Use visible adam from Taming 3DGS.",
            value=False,
            group=None
        ),
        desc.BoolParam(
            name="randomBkgd",
            label="Use Random Background",
            description="Use random background for training to discourage transparency.",
            value=False,
            group=None
        ),
        desc.BoolParam(
            name="poseOpt",
            label="Use Pose Optimization",
            description="Use pose optimization.",
            value=False,
            group=None
        ),
        desc.FloatParam(
            name="pose_opt_lr",
            label="Pose optimization LR",
            description="Pose Optimization Learning Rate",
            value=1e-5,
            group="allParams",
            enabled=lambda node: node.poseOpt.value
        ),
        desc.FloatParam(
            name="pose_opt_reg",
            label="Pose optimization regularization",
            description="Regularization for camera optimization as weight decay",
            value=1e-6,
            group="allParams",
            enabled=lambda node: node.poseOpt.value
        ),
        # Rendering doesn't work for the moment with that ?
        # desc.BoolParam(
        #     name="appOpt",
        #     label="Use Appearance Optimization",
        #     description="Use appearance optimization.",
        #     value=False,
        #     group=None
        # ),
        # desc.FloatParam(
        #     name="app_opt_lr",
        #     label="Appearance optimization LR",
        #     description="Appearance Optimization Learning Rate",
        #     value=1e-3,
        #     group="allParams",
        #     enabled=lambda node: node.appOpt.value
        # ),
        # desc.FloatParam(
        #     name="app_opt_reg",
        #     label="Appearance optimization regularization",
        #     description="Regularization for Appearance optimization as weight decay",
        #     value=1e-6,
        #     group="allParams",
        #     enabled=lambda node: node.appOpt.value
        # ),
        desc.BoolParam(
            name="useBilateralGrid",
            label="Use Bilateral Grid",
            description="Use Bilateral Grid.",
            value=False,
            group=None
        ),
        desc.BoolParam(
            name="useFusedBilagrid",
            label="Use Fused Bilateral Grid",
            description="Use Fused Bilateral Grid.",
            value=False,
            group=None
        ),
        desc.BoolParam(
            name="useDepthLoss",
            label="Use Depth Loss",
            description="Use Depth Loss in optimization.",
            value=False,
            group=None
        ),
        desc.FloatParam(
            name="depth_lambda",
            label="Depth weight",
            description="depth weight in optimization",
            value=1e-2,
            group="allParams",
            enabled=lambda node: node.useDepthLoss.value
        ),
        desc.BoolParam(
            name="use3DGut",
            label="Use 3DGut Method",
            description="Use 3DGut method.",
            value=False,
            group=None
        ),
        desc.BoolParam(
            name="custom_ckpts",
            label="Use custom checkpoints",
            description="Set to True to provide custom checkpoints; default behavior is to save the model once, at the end of the optimization.",
            value=False,
            group=None
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
            group=None,
            enabled=lambda node: node.custom_ckpts.value
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
