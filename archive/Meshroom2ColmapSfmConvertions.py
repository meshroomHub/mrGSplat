__version__ = "2.0"
from meshroom.core import desc


class Meshroom2ColmapSfmConvertions(desc.CommandLineNode):
    commandLine = 'aliceVision_exportColmap -i {inputValue} -o {outputValue} '
    size = desc.DynamicNodeSize('input')

    category = 'Gsplat'
    documentation = ''' '''

    inputs = [
        desc.File(
            name='input',
            label='Input',
            description='SfMData file.',
            value='',
            group=""
        ),

        desc.ChoiceParam(
            name='verboseLevel',
            label='Verbose Level',
            description='Verbosity level (fatal, error, warning, info, debug, trace).',
            value='info',
            values=['fatal', 'error', 'warning', 'info', 'debug', 'trace'],
            exclusive=True,
        ),
    ]

    outputs = [
        desc.File(
            name='output',
            label='Output Folder',
            description='Path to the output SfM Data file.',
            value="{nodeCacheFolder}",
        )
    ]


    def processChunk(self, chunk):
        import json, os
        # get image info
        sfm_data = json.load(open(chunk.node.input.value))
        views = sfm_data["views"]
        images_path = [v["path"] for v in views]
        image_sizes = [[int(v["width"]), int(v["height"])] for v in views]
        images_base_folder = set([os.path.dirname(p) for p in images_path ])
        if len(images_base_folder) > 1:
            raise RuntimeError("Images from different folders not supported yet")
        images_basename = [os.path.basename(p) for p in images_path ]
        images_output_folder = os.path.join(chunk.node.output.value, "images")
        new_images_path = [os.path.join( images_output_folder, basename) for basename in images_basename]

        #run the cl
        desc.CommandLineNode.processChunk(self, chunk)
        
        #create image folder from sfm (need to be done after the cl, otherwise bugs...)
        os.makedirs(images_output_folder, exist_ok=True)
     
        print("Exporting images")
        for i, (img_path, new_img_path) in enumerate(zip(images_path, new_images_path)):
            os.symlink(img_path, new_img_path)

        # #moves from sparse/0 to sparse
        # shutil.copytree(os.path.join(chunk.node.output.value, 'sparse', '0'), 
        #                 os.path.join(chunk.node.output.value, 'sparse2'))
        # shutil.rmtree(os.path.join(chunk.node.output.value, 'sparse', '0'))
        # os.rename(os.path.join(chunk.node.output.value, 'sparse2'), os.path.join(chunk.node.output.value, 'sparse'))
        # #os.rmdir(os.path.join(chunk.node.output.value,'dense'))
