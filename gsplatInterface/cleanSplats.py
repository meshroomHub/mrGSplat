# -*- coding: utf-8 -*-

import argparse
import math

import trimesh
import numpy as np
import torch
import torch.nn.functional as F

from gsplat.distributed import cli


def open_gaussian(args, local_rank):
    # Load ckpt
    # device = torch.device("cuda", local_rank)
    # ckpt = torch.load(args.ckpt, map_location=device, weights_only=True)["splats"]
    checkpoint_data = torch.load(args.ckpt, map_location="cpu", weights_only=True)
    # Extract weight arrays    
    means = checkpoint_data['splats']["means"]
    quats = F.normalize(checkpoint_data['splats']["quats"], p=2, dim=-1)
    scales = torch.exp(checkpoint_data['splats']["scales"])
    opacities = torch.sigmoid(checkpoint_data['splats']["opacities"])
    sh0 = checkpoint_data['splats']["sh0"]
    shN = checkpoint_data['splats']["shN"]
    # Stack
    means = torch.cat(means, dim=0)
    quats = torch.cat(quats, dim=0)
    scales = torch.cat(scales, dim=0)
    opacities = torch.cat(opacities, dim=0)
    sh0 = torch.cat(sh0, dim=0)
    shN = torch.cat(shN, dim=0)
    colors = torch.cat([sh0, shN], dim=-2)
    
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


def _main(modelPath, outputObjPath):
    gaussians = open_gaussian(modelPath)
    xyz, rots, scales, opacities = gaussians
    meshes = []
    for i, (c, r, s, o) in enumerate(zip(xyz, rots, scales, opacities)):
        unit_sphere = trimesh.creation.icosphere(subdivisions=1)
        transform = trimesh.transformations.compose_matrix(translate=c,angles=r,scale=s)
        unit_sphere.apply_transform(transform)
        meshes.append(unit_sphere)
    preview_mesh = trimesh.util.concatenate(meshes)
    preview_mesh.export(outputObjPath)


def main(local_rank: int, world_rank, world_size: int, args):
    device = torch.device("cuda", local_rank)
    means, quats, scales, opacities, sh0, shN = [], [], [], [], [], []
    ckpt = torch.load(args.ckpt, map_location=device, weights_only=True)["splats"]
    means.append(ckpt["means"])
    quats.append(F.normalize(ckpt["quats"], p=2, dim=-1))
    scales.append(torch.exp(ckpt["scales"]))
    opacities.append(torch.sigmoid(ckpt["opacities"]))
    sh0.append(ckpt["sh0"])
    shN.append(ckpt["shN"])
    means = torch.cat(means, dim=0)
    quats = torch.cat(quats, dim=0)
    scales = torch.cat(scales, dim=0)
    opacities = torch.cat(opacities, dim=0)
    sh0 = torch.cat(sh0, dim=0)
    shN = torch.cat(shN, dim=0)
    colors = torch.cat([sh0, shN], dim=-2)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    
    parser.add_argument(
        "--ckpt", type=str, required=True, help="path to the .pt file"
    )
    parser.add_argument(
        "--mesh", type=str, required=True, help="Mesh"
    )
    parser.add_argument(
        "--outputModel", type=str, required=True, help="Cleaned model"
    )
    parser.add_argument(
        "--metadata_folder", type=str, help="Metadata folder"
    )

    args = parser.parse_args()
    
    cli(main, args, verbose=True)
