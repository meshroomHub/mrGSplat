# -*- coding: utf-8 -*-

from common import apply_float_colormap, GSplatRenderTabState, CameraState
from common import createProgressBar

import argparse
import math
import os
import time

import torch
import torch.nn.functional as F

from gsplatInterface.avImage import AvImage

from gsplat.distributed import cli
from gsplat.rendering import rasterization

from datasets.sfm.sceneManager import PoseParser
# from cameraPosesParser import CameraParser


def get_cameras_from_sfm(sfmFile, data_factor):
    cameras = []
    
    psr = PoseParser(
        sfmFile=sfmFile,
        factor=int(data_factor),
        normalize=True
    )
    
    # Find a default intrinsic
    valid_intrinsics = [el for el in psr.camera_ids if el is not None]
    default_cam_id = None
    if len(valid_intrinsics) > 0:
        # Take the intrinsic of the first pose that has a valid view
        default_cam_id = valid_intrinsics[0]
    else:
        # Take the first intrinsic we have
        default_cam_id = list(psr.Ks_dict.keys())[0]
    
    # Build list of cameras
    for pose_id, img_name, camId, c2w in zip(psr.pose_ids, psr.image_names, psr.camera_ids, psr.camtoworlds):
        if camId is None:
            camId = default_cam_id
        K = psr.Ks_dict[camId].copy()
        imsize = psr.imsize_dict[camId]
        cam = CameraState(
            c2w=c2w,
            K=K
        )
        cameras.append((pose_id, cam, img_name, imsize))
    
    return cameras


def main(local_rank: int, world_rank, world_size: int, args):
    torch.manual_seed(42)
    device = torch.device("cuda", local_rank)
    
    means, quats, scales, opacities, sh0, shN = [], [], [], [], [], []
    for ckpt_path in args.ckpt:
        ckpt = torch.load(ckpt_path, map_location=device, weights_only=True)["splats"]
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
    sh_degree = int(math.sqrt(colors.shape[-2]) - 1)
    
    print("Number of Gaussians:", len(means))

    @torch.no_grad()
    def viewer_render_fn(camera_state: CameraState, render_tab_state: GSplatRenderTabState):
        width = render_tab_state.render_width
        height = render_tab_state.render_height
 
        c2w = camera_state.c2w
        K = camera_state.get_K((width, height))
        c2w = torch.from_numpy(c2w).float().to(device)
        K = torch.from_numpy(K).float().to(device)
        viewmat = c2w.inverse()

        RENDER_MODE_MAP = {
            "rgb": "RGB",
            "depth(accumulated)": "D",
            "depth(expected)": "ED",
            "alpha": "RGB",
        }

        render_colors, render_alphas, info = rasterization(
            means,  # [N, 3]
            quats,  # [N, 4]
            scales,  # [N, 3]
            opacities,  # [N]
            colors,  # [N, S, 3]
            viewmat[None],  # [1, 4, 4]
            K[None],  # [1, 3, 3]
            width,
            height,
            sh_degree=(
                min(render_tab_state.max_sh_degree, sh_degree)
                if sh_degree is not None
                else None
            ),
            near_plane=render_tab_state.near_plane,
            far_plane=render_tab_state.far_plane,
            radius_clip=render_tab_state.radius_clip,
            eps2d=render_tab_state.eps2d,
            backgrounds=torch.tensor([render_tab_state.backgrounds], device=device)
            / 255.0,
            render_mode=RENDER_MODE_MAP[render_tab_state.render_mode],
            rasterize_mode=render_tab_state.rasterize_mode,
            camera_model=render_tab_state.camera_model,
            packed=False
        )
        render_tab_state.total_gs_count = len(means)
        render_tab_state.rendered_gs_count = (info["radii"] > 0).all(-1).sum().item()

        if render_tab_state.render_mode == "rgb":
            # colors represented with sh are not guranteed to be in [0, 1]
            render_colors = render_colors[0, ..., 0:3].clamp(0, 1)
            renders = render_colors.cpu().numpy()
        elif render_tab_state.render_mode in ["depth(accumulated)", "depth(expected)"]:
            # normalize depth to [0, 1]
            depth = render_colors[0, ..., 0:1]
            if render_tab_state.normalize_nearfar:
                near_plane = render_tab_state.near_plane
                far_plane = render_tab_state.far_plane
            else:
                near_plane = depth.min()
                far_plane = depth.max()
            depth_norm = (depth - near_plane) / (far_plane - near_plane + 1e-10)
            depth_norm = torch.clip(depth_norm, 0, 1)
            if render_tab_state.inverse:
                depth_norm = 1 - depth_norm
            renders = (
                apply_float_colormap(depth_norm, render_tab_state.colormap)
                .cpu()
                .numpy()
            )
        elif render_tab_state.render_mode == "alpha":
            alpha = render_alphas[0, ..., 0:1]
            renders = (
                apply_float_colormap(alpha, render_tab_state.colormap).cpu().numpy()
            )
        return renders
    
    cameras = get_cameras_from_sfm(args.cameras, args.data_factor)
    render_tab_state = GSplatRenderTabState()
    
    total_render_time = 0.
    min_render_time, max_render_time = None, 0.
    for pose_id, camera, imgName, imgSize in createProgressBar(cameras, desc="Rendering images..."):
        print(f"Rendering {imgName} (pose_id={pose_id})")
        # Set RenderTabState (if we render with different render settings... which should never happen)
        W, H = imgSize
        render_tab_state.render_width  = W
        render_tab_state.render_height = H
        # Render image
        t0 = time.time()
        render = viewer_render_fn(camera, render_tab_state)
        render_time = time.time() - t0
        total_render_time += render_time
        if min_render_time == None or render_time < min_render_time: min_render_time = render_time
        if render_time > max_render_time: max_render_time = render_time
        # Convert and export image
        if imgName is None:
            imgName = f"pose_{pose_id:06d}.jpg"
        imgBasename = os.path.splitext(imgName)[0]  # Remove extension
        outputFormat = args.output_format
        if not outputFormat or outputFormat == "auto":
            outputFormat = os.path.splitext(imgName)[1]
        im_path = os.path.join(args.output_dir, f"{imgBasename}{outputFormat}")
        img = AvImage.from_numpy(render)
        img.write(im_path, colorspace=args.output_colorspace)
    print("="*10 + " RENDER STAT " + "="*10)
    print(f"* Render of {len(cameras)} images took {total_render_time:.02f}s.")
    print(f"* Average of {total_render_time/len(cameras):.02f}s. per frame, or {int(len(cameras)/total_render_time)} fps")
    print(f"* Min : {min_render_time:.02f}s., Max : {max_render_time:.02f}s.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--model", dest="ckpt", type=str, nargs="+", default=None, help="path to the .pt file"
    )
    parser.add_argument(
        "-c", "--cameras", type=str, help="SFM file containing cameras (poses)"
    )
    parser.add_argument(
        "-df", "--data_factor", type=int, default=1, help="Data factor"
    )
    parser.add_argument(
        "--output_dir", type=str, default="results/", help="where to dump outputs"
    )
    parser.add_argument(
        "--output_format", type=str, help="Output format"
    )
    parser.add_argument(
        "--output_colorspace", type=str, help="Output colorspace (you can use AUTO, SRGB, ...)"
    )
    
    args = parser.parse_args()
    
    output_dir = os.path.join(args.output_dir, "renders")
    if os.path.exists(output_dir):
        os.rmdir(output_dir)
    os.makedirs(output_dir)
    args.output_dir = output_dir
    
    cli(main, args, verbose=True)
