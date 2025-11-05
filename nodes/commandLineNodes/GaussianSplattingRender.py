__version__ = "1.0"

from meshroom.core import desc
import os.path

COLOR_SPACES = [
    "AUTO", "LINEAR", "SRGB", "ACES2065_1", "ACEScg", "REC709", "Linear_ARRI_Wide_Gamut_3", 
    "ARRI_LogC3_EI800", "Linear_ARRI_Wide_Gamut_4", "ARRI_LogC4", "Linear_BMD_WideGamut_Gen5", 
    "BMDFilm_WideGamut_Gen5", "CanonLog2_CinemaGamut_D55", "CanonLog3_CinemaGamut_D55", 
    "Linear_CinemaGamut_D55", "Linear_V_Gamut", "V_Log_V_Gamut", "Linear_REDWideGamutRGB", 
    "Log3G10_REDWideGamutRGB", "Linear_Venice_S_Gamut3_Cine", "S_Log3_Venice_S_Gamut3_Cine", 
    "LAB", "XYZ", "NO_CONVERSION"
]

class GaussianSplattingRender(desc.CommandLineNode):

    commandLine = 'gaussianSplattingRender --model {modelValue} --cameras {camerasValue} --data_factor {resolutionFactorValue} --output {nodeCacheFolder} --outputFormat {outputFormatValue} --outputColorspace {outputColorspaceValue}'
    
    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE
    
    # TODO : split in multiple process -> probably useless because rendering is fast, what takes time is rez env and loading model
    # size = desc.DynamicNodeSize('cameras')
    # parallelization = desc.Parallelization(blockSize=40)
    # commandLineRange = '--rangeStart {rangeStart} --rangeSize {rangeBlockSize}'

    category = 'Gsplat'
    documentation = '''
This node computes the rasterization of a given gaussian splatting model from given viewpoints.
'''
    
    inputs = [
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
        desc.ChoiceParam(
            name='outputFormat',
            label='Output format',
            description='''auto will try to find the extension from views in the sfm (cameras) input''',
            value='auto',
            values=['auto', '.jpg', '.png', '.exr'],
            exclusive=True,
        ),
        desc.ChoiceParam(
            name='outputColorspace',
            label='Output colorspace',
            description='''''',
            value='AUTO',
            values=COLOR_SPACES,
            exclusive=True,
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
