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

    commandLine = 'gaussianSplattingRender {allParams}'

    gpu = desc.Level.INTENSIVE
    cpu = desc.Level.NORMAL
    ram = desc.Level.INTENSIVE

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
            group="allParams"
        ),
        desc.File(
            name="model",
            label="Model",
            description="Gaussian splats (.ckpt) to render.",
            value="",
            group="allParams"
        ),
        desc.ChoiceParam(
            name='output_format',
            label='Output format',
            description='''auto will try to find the extension from views in the sfm (cameras) input''',
            value='auto',
            values=['auto', '.jpg', '.png', '.exr'],
            exclusive=True,
            group="allParams"
        ),
        desc.ChoiceParam(
            name='output_colorspace',
            label='Output colorspace',
            description='''''',
            value='AUTO',
            values=COLOR_SPACES,
            exclusive=True,
            group="allParams"
        ),
    ]

    outputs = [
        desc.File(
            name="output_dir",
            label="Output",
            description="Output folder.",
            value="{nodeCacheFolder}",
            group="allParams"
        ),
        desc.File(
            name="frames",
            label="Frames",
            description="Frames rendered using gaussian splatting.",
            semantic="image", # use "image" for <VIEW_ID> logic
            # semantic="sequence", # use "sequence" for *.jpg logic
            value="{nodeCacheFolder}/renders/<VIEW_ID>.exr",  # _<FILESTEM>
            group="",
        ),
        desc.File(
            name="render_folder",
            label="Render Folder",
            description="Output folder.",
            value="{nodeCacheFolder}/renders",
            group="",
        ),
    ]
