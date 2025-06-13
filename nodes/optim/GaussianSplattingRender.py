__version__ = "1.0"

from meshroom.core import desc
import os.path

currentDir = os.path.dirname(os.path.abspath(__file__))

class GaussianSplattingRender(desc.CommandLineNode):

    commandLine = 'rez env {rezEnvNameValue} -- gaussianSplattingOptim default --ckpt {modelValue} --data_factor {resolutionFactorValue} --test_every 1 --data_dir {camerasValue} --result_dir {cache}/{nodeType}/{uid} --disable_viewer'

    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE
    
    # size = desc.DynamicNodeSize('cameras')
    # parallelization = desc.Parallelization(blockSize=40)
    # commandLineRange = '--rangeStart {rangeStart} --rangeSize {rangeBlockSize}'

    category = 'Gsplat'
    documentation = '''
    This node computes the rasterization of a given gaussian splatting model from given viewpoints.
'''

    inputs = [
        desc.File(
            name="rezEnvName",
            label="Rez package name",
            description="Name (with path if necessary) of the rez package into which the computation should be executed.",
            value="gsplat-maskSupport",
            invalidate=False,
            group="",
            advanced=True,
            exposed=False,
        ),
        desc.File(
            name="cameras",
            label="Cameras",
            description="SfMData with the views, poses and intrinsics to use (in JSON format).",
            value="",
        ),
        desc.File(
            name="model",
            label="Model",
            description="Gaussian splats (.ckpt) to render.",
            value="",
            group="",
        ),
        desc.IntParam(
            name="resolutionFactor",
            label="Subsampling factor",
            description="How low in the resolution pyramid should the rendering be done. Ex: a value of 4 -> 16x less pixels",
            value=1,
            group="",
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
            name="frames",
            label="Frames",
            description="Frames rendered using gaussian splatting.",
            semantic="sequence", #"image", # use "image" when <FILESTEM> logic, and "sequence" when *.jpg logic
            # semantic="sequence",
            value=os.path.join("{nodeCacheFolder}",'renders', '*.jpg'), #/renders/<VIEW_ID>_<FILESTEM>.JPG',
            group="",
        ),
        desc.File(
            name="render_folder",
            label="Render Folder",
            description="Output folder.",
            value=os.path.join("{nodeCacheFolder}", 'renders'),
            semantic="sequence"
        ),

    ]
