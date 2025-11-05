import argparse
import torch
import numpy as np
from plyfile import PlyData,PlyElement


class Gaussian:
    paramSet1 = ["nx","ny","nz","f_dc_0","f_dc_1","f_dc_2"]
    paramSet2 = ["opacity","scale_0","scale_1","scale_2","rot_0","rot_1","rot_2","rot_3"]
    
    # ['f_dc_0', 'f_dc_1', 'f_dc_2', 'f_rest_0', 'f_rest_1', 'f_rest_2', 'f_rest_3', 'f_rest_4', 'f_rest_5', 'f_rest_6', 'f_rest_7', 'f_rest_8', 'f_rest_9', 'f_rest_10', 'f_rest_11', 'f_rest_12', 'f_rest_13', 'f_rest_14', 'opacity', 'scale_0', 'scale_1', 'scale_2', 'rot_0', 'rot_1', 'rot_2', 'rot_3']
    
    def __init__(self, xyz, rot, scale, opacity, sh0, shN):
        x, y, z = xyz
        self.P = [x, y, z]
        self.rot = rot
        self.scale = scale
        self.opacity = opacity
        self.sh0 = sh0
        self.shN = shN
    
    def getAttribute(self, attributeName):
        if attributeName.startswith("f_dc_"):
            index = int(attributeName.replace("f_dc_", ""))
            return self.sh0[index]
        elif attributeName.startswith("f_rest_"):
            index = int(attributeName.replace("f_rest_", ""))
            return self.shN[index]
            
        return self.attributes.get(attributeName)
    
    @property
    def dtype(self):
        return self.P.dtype

    @property
    def shMax(self):
        shMax = 0
        attribute = f"f_rest_{shMax}"
        while 1 :
            try :
                self.getAttribute(attribute)
                shMax += 1
                attribute = f"f_rest_{shMax}"
            except :
                break
        if shMax > 71 :
            return 72
        elif shMax > 44 :
            return 45
        elif shMax > 23 :
            return 24
        elif shMax > 8 :
            return 9
        else :
            return 0


class Splats:
    def __init__(self, splats):
        self.splats = splats

    def construct_list_of_attributes(self):
        l = ['x', 'y', 'z', 'nx', 'ny', 'nz']
        # All channels except the 3 DC
        for i in range(self.splats["sh0"].shape[1]*self.splats["sh0"].shape[2]):
            l.append('f_dc_{}'.format(i))
        for i in range(self.splats["shN"].shape[1]*self.splats["shN"].shape[2]):
            l.append('f_rest_{}'.format(i))
        l.append('opacity')
        for i in range(self.splats["scales"].shape[1]):
            l.append('scale_{}'.format(i))
        for i in range(self.splats["quats"].shape[1]):
            l.append('rot_{}'.format(i))
        return l
    
    def export_to_ply(self, outputFile):
        xyz = self.splats["means"].detach().cpu().numpy()
        normals = np.zeros_like(xyz)
        f_dc =   self.splats["sh0"].detach().transpose(1, 2).flatten(start_dim=1).contiguous().cpu().numpy()
        f_rest = self.splats["shN"].detach().transpose(1, 2).flatten(start_dim=1).contiguous().cpu().numpy()
        opacities = self.splats["opacities"].detach().unsqueeze(-1).cpu().numpy()
        scale =  self.splats["scales"].detach().cpu().numpy()
        rotation = self.splats["quats"].detach().cpu().numpy()
        dtype_full = [(attribute, 'f4') for attribute in self.construct_list_of_attributes()]
        elements = np.empty(xyz.shape[0], dtype=dtype_full)
        attributes = np.concatenate((xyz, normals, f_dc, f_rest, opacities, scale, rotation), axis=1)
        elements[:] = list(map(tuple, attributes))
        el = PlyElement.describe(elements, 'vertex')
        PlyData([el]).write(outputFile)


def open_gaussians(path) -> Splats:
    checkpoint_data = torch.load(path, map_location='cpu')
    splats = checkpoint_data["splats"]
    return Splats(splats)


def main(modelPath, _format, outputPath):
    splats = open_gaussians(modelPath)
    if _format == ".ply":
        splats.export_to_ply(outputPath)
    else:
        raise NotImplementedError(f"Format {_format} is not implemented yet")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=str, help="Input model")
    parser.add_argument("format", type=str, help="Output format")
    parser.add_argument("output", type=str, help="Output model")
    args = parser.parse_args()
    main(args.input, args.format, args.output)
