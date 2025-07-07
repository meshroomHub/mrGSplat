import sys

import torch
import numpy as np

import trimesh

def open_gaussian(file):
    checkpoint_data = torch.load(file, map_location='cpu')
    xyz = checkpoint_data["splats"]["means"]
    opacities = checkpoint_data["splats"]["opacities"]
    scales = checkpoint_data["splats"]["scales"]
    rots = checkpoint_data["splats"]["quats"]
    rots = quaternions_to_euler_angles(rots)
    scales=np.exp(scales)
    return xyz.numpy(), rots, scales, opacities.numpy()

def quaternions_to_euler_angles(quaternions):
    num_quaternions = quaternions.shape[0]
    euler_angles = np.zeros((num_quaternions, 3))
    for i, q in enumerate(quaternions):
        w, x, y, z = q[0], q[1], q[2], q[3]
        sinr_cosp = 2 * (w * x + y * z)
        cosr_cosp = 1 - 2 * (x * x + y * y)
        roll = np.arctan2(sinr_cosp, cosr_cosp)
        sinp = 2 * (w * y - z * x)
        if np.abs(sinp) >= 1:
            pitch = np.copysign(np.pi / 2, sinp) 
        else:
            pitch = np.arcsin(sinp)
        siny_cosp = 2 * (w * z + x * y)
        cosy_cosp = 1 - 2 * (y * y + z * z)
        yaw = np.arctan2(siny_cosp, cosy_cosp)

        euler_angles[i] = [roll, pitch, yaw]
        
    return euler_angles

gaussians = open_gaussian(sys.argv[1])

xyz, rots, scales, opacities=gaussians

meshes = []
STEP = 30
for i, (c, r, s, o) in enumerate(zip(*gaussians)):
    if not (i%STEP==0):
        continue
    unit_sphere = trimesh.creation.icosphere(subdivisions=1)
    transform = trimesh.transformations.compose_matrix(translate=c,angles=r,scale=s)
    unit_sphere.apply_transform(transform)
    meshes.append(unit_sphere)
preview_mesh = trimesh.util.concatenate(meshes)
preview_mesh.export(sys.argv[2])
