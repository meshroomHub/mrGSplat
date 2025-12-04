# -*- coding: utf-8 -*-

from common import (
    CameraState, 
    RenderTabState, GSplatRenderTabState, 
    apply_float_colormap, 
    createProgressBar, createProgressBarRange
)

import json
import math
import os
import time
from collections import defaultdict
from dataclasses import dataclass, field
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Union

import imageio
import numpy as np
import torch
import torch.nn.functional as F
import yaml
from datasets.sfm import Dataset, Parser
from datasets.traj import (
    generate_ellipse_path_z,
    generate_interpolated_path,
    generate_spiral_path,
)
from fused_ssim import fused_ssim
from torch import Tensor
from torch.nn.parallel import DistributedDataParallel as DDP
from torch.utils.tensorboard import SummaryWriter
from torchmetrics.image import PeakSignalNoiseRatio, StructuralSimilarityIndexMeasure
from torchmetrics.image.lpip import LearnedPerceptualImagePatchSimilarity
from typing import Literal, assert_never
from utils import AppearanceOptModule, CameraOptModule, knn, rgb_to_sh, set_random_seed

from gsplat import export_splats
from gsplat.distributed import cli
from gsplat.optimizers import SelectiveAdam
from gsplat.rendering import rasterization
from gsplat.strategy import DefaultStrategy, MCMCStrategy


@dataclass
class Config:
    # Path to the .pt files. If provide, it will skip training and run evaluation only.
    ckpt: Optional[List[str]] = None
    # Path to the .pt files to load and resume training
    resume_ckpt: Optional[str] = ""

    # Path to the dataset
    sfm_file: str = "sfm.json"
    image_alpha: bool = False
    metadata_folder: str = ""
    
    # Directory to save results
    result_dir: str = "results/garden"
    # Random crop size for training  (experimental)
    patch_size: Optional[int] = None
    # A global scaler that applies to the scene size related parameters
    global_scale: float = 1.0

    # Camera model
    camera_model: Literal["pinhole", "ortho", "fisheye"] = "pinhole"

    # Batch size for training. Learning rates are scaled automatically
    batch_size: int = 1

    # Number of training steps
    max_epochs: int = 600
    
    # Steps to save the model
    save_epochs: List[int] = field(
        default_factory=lambda: [150, 600],
        metadata=dict(nargs="*")
    )
    
    # Degree of spherical harmonics
    sh_degree: int = 3
    # Turn on another SH degree every this steps
    sh_degree_interval: int = 1000
    # Initial opacity of GS
    init_opa: float = 0.1
    # Initial scale of GS
    init_scale: float = 1.0
    # Weight for SSIM loss
    ssim_lambda: float = 0.2

    # Near plane clipping distance
    near_plane: float = 0.01
    # Far plane clipping distance
    far_plane: float = 1e10

    # Strategy for GS densification
    strategy: Union[DefaultStrategy, MCMCStrategy] = field(
        default_factory=DefaultStrategy,
        metadata=dict(type=str)
    )
    # Use packed mode for rasterization, this leads to less memory usage but slightly slower.
    packed: bool = False
    # Use sparse gradients for optimization. (experimental)
    sparse_grad: bool = False 
    # Use visible adam from Taming 3DGS. (experimental)
    visible_adam: bool = False
    # Anti-aliasing in rasterization. Might slightly hurt quantitative metrics.
    antialiased: bool = False

    # Use random background for training to discourage transparency
    random_bkgd: bool = False

    # LR for 3D point positions
    means_lr: float = 1.6e-4
    # LR for Gaussian scale factors
    scales_lr: float = 5e-3
    # LR for alpha blending weights
    opacities_lr: float = 5e-2
    # LR for orientation (quaternions)
    quats_lr: float = 1e-3
    # LR for SH band 0 (brightness)
    sh0_lr: float = 2.5e-3
    # LR for higher-order SH (detail)
    shN_lr: float = 2.5e-3 / 20

    # Opacity regularization
    opacity_reg: float = 0.0
    # Scale regularization
    scale_reg: float = 0.0

    # Enable camera optimization.
    pose_opt: bool = False
    # Learning rate for camera optimization
    pose_opt_lr: float = 1e-5
    # Regularization for camera optimization as weight decay
    pose_opt_reg: float = 1e-6

    # Enable appearance optimization. (experimental)
    app_opt: bool = False
    # Appearance embedding dimension
    app_embed_dim: int = 16
    # Learning rate for appearance optimization
    app_opt_lr: float = 1e-3
    # Regularization for appearance optimization as weight decay
    app_opt_reg: float = 1e-6

    # Enable bilateral grid. (experimental)
    use_bilateral_grid: bool = False
    
    # Whether use fused-bilateral grid
    use_fused_bilagrid: bool = False
    # Shape of the bilateral grid (X, Y, W)
    bilateral_grid_shape: Tuple[int, int, int] = (16, 16, 8)

    # Enable depth loss. (experimental)
    depth_loss: bool = False
    # Weight for depth loss
    depth_lambda: float = 1e-2

    # tile size 
    tile_size: int = 16

    # 3DGUT (uncented transform + eval 3D)
    with_ut: bool = False
    with_eval3d: bool = False
    
    #Strategy default
    prune_opa: float = 0.005
    grow_grad2d: float = 0.0002
    grow_scale3d: float = 0.01
    grow_scale2d: float = 0.05
    prune_scale3d: float = 0.1
    prune_scale2d: float = 0.15
    refine_scale2d_stop_iter: int = 0
    refine_start_iter: int = 500
    refine_stop_iter: int = 15_000
    reset_every: int = 3000
    refine_every: int = 100
    pause_refine_after_reset: int = 0
    absgrad: bool = False
    revised_opacity: bool = False

    #Strategy mcmc
    cap_max: int = 1_000_000
    noise_lr: float = 5e5
    min_opacity: float = 0.005


def create_splats_with_optimizers(
    parser: Parser,
    init_opacity: float = 0.1,
    init_scale: float = 1.0,
    means_lr: float = 1.6e-4,
    scales_lr: float = 5e-3,
    opacities_lr: float = 5e-2,
    quats_lr: float = 1e-3,
    sh0_lr: float = 2.5e-3,
    shN_lr: float = 2.5e-3 / 20,
    scene_scale: float = 1.0,
    sh_degree: int = 3,
    sparse_grad: bool = False,
    visible_adam: bool = False,
    batch_size: int = 1,
    feature_dim: Optional[int] = None,
    device: str = "cuda",
    world_rank: int = 0,
    world_size: int = 1,
) -> Tuple[torch.nn.ParameterDict, Dict[str, torch.optim.Optimizer]]:

    #initialize from sfm
    points = torch.from_numpy(parser.points).float()
    rgbs = torch.from_numpy(parser.points_rgb / 255.0).float()

    # Initialize the GS size to be the average dist of the 3 nearest neighbors
    dist2_avg = (knn(points, 4)[:, 1:] ** 2).mean(dim=-1)  # [N,]
    dist_avg = torch.sqrt(dist2_avg)
    scales = torch.log(dist_avg * init_scale).unsqueeze(-1).repeat(1, 3)  # [N, 3]

    # Distribute the GSs to different ranks (also works for single rank)
    points = points[world_rank::world_size]
    rgbs = rgbs[world_rank::world_size]
    scales = scales[world_rank::world_size]

    N = points.shape[0]
    quats = torch.rand((N, 4))  # [N, 4]
    opacities = torch.logit(torch.full((N,), init_opacity))  # [N,]

    params = [
        # name, value, lr
        ("means", torch.nn.Parameter(points), means_lr * scene_scale),
        ("scales", torch.nn.Parameter(scales), scales_lr),
        ("quats", torch.nn.Parameter(quats), quats_lr),
        ("opacities", torch.nn.Parameter(opacities), opacities_lr),
    ]

    if feature_dim is None:
        # color is SH coefficients.
        colors = torch.zeros((N, (sh_degree + 1) ** 2, 3))  # [N, K, 3]
        colors[:, 0, :] = rgb_to_sh(rgbs)
        params.append(("sh0", torch.nn.Parameter(colors[:, :1, :]), sh0_lr))
        params.append(("shN", torch.nn.Parameter(colors[:, 1:, :]), shN_lr))
    else:
        # features will be used for appearance and view-dependent shading
        features = torch.rand(N, feature_dim)  # [N, feature_dim]
        params.append(("features", torch.nn.Parameter(features), sh0_lr))
        colors = torch.logit(rgbs)  # [N, 3]
        params.append(("colors", torch.nn.Parameter(colors), sh0_lr))

    splats = torch.nn.ParameterDict({n: v for n, v, _ in params}).to(device)
    # Scale learning rate based on batch size, reference:
    # https://www.cs.princeton.edu/~smalladi/blog/2024/01/22/SDEs-ScalingRules/
    # Note that this would not make the training exactly equivalent, see
    # https://arxiv.org/pdf/2402.18824v1
    BS = batch_size * world_size
    optimizer_class = None
    if sparse_grad:
        optimizer_class = torch.optim.SparseAdam
    elif visible_adam:
        optimizer_class = SelectiveAdam
    else:
        optimizer_class = torch.optim.Adam
    optimizers = {
        name: optimizer_class(
            [{"params": splats[name], "lr": lr * math.sqrt(BS), "name": name}],
            eps=1e-15 / math.sqrt(BS),
            # TODO: check betas logic when BS is larger than 10 betas[0] will be zero.
            betas=(1 - BS * (1 - 0.9), 1 - BS * (1 - 0.999)),
        )
        for name, _, lr in params
    }
    return splats, optimizers


class Runner:
    """Engine for training and testing."""

    def __init__(
        self, local_rank: int, world_rank, world_size: int, cfg: Config
    ) -> None:
        set_random_seed(42 + local_rank)

        self.cfg = cfg
        self.world_rank = world_rank
        self.local_rank = local_rank
        self.world_size = world_size
        self.device = f"cuda:{local_rank}"

        # Where to dump results.
        os.makedirs(cfg.result_dir, exist_ok=True)

        # Setup output directories.
        self.ckpt_dir = f"{cfg.result_dir}/ckpts"
        os.makedirs(self.ckpt_dir, exist_ok=True)

        # Load data: Training data should contain initial points and colors.
        self.parser = Parser(
            sfmFile=cfg.sfm_file,
            normalize=False,
            metadataFolder=cfg.metadata_folder,
            image_alpha=cfg.image_alpha,
        )

        self.trainset = Dataset(
            self.parser,
            patch_size=cfg.patch_size,
            load_depths=cfg.depth_loss,
        )

        self.scene_scale = self.parser.scene_scale * 1.1 * cfg.global_scale

        print("Scene scale:", self.scene_scale)

        # Model
        feature_dim = 32 if cfg.app_opt else None
        self.splats, self.optimizers = create_splats_with_optimizers(
            self.parser,
            init_opacity=cfg.init_opa,
            init_scale=cfg.init_scale,
            means_lr=cfg.means_lr,
            scales_lr=cfg.scales_lr,
            opacities_lr=cfg.opacities_lr,
            quats_lr=cfg.quats_lr,
            sh0_lr=cfg.sh0_lr,
            shN_lr=cfg.shN_lr,
            scene_scale=self.scene_scale,
            sh_degree=cfg.sh_degree,
            sparse_grad=cfg.sparse_grad,
            visible_adam=cfg.visible_adam,
            batch_size=cfg.batch_size,
            feature_dim=feature_dim,
            device=self.device,
            world_rank=world_rank,
            world_size=world_size,
        )
        print("Model initialized. Number of GS:", len(self.splats["means"]))

        # Densification Strategy
        
        self.cfg.strategy.check_sanity(self.splats, self.optimizers)

        if isinstance(self.cfg.strategy, DefaultStrategy):
            self.cfg.strategy.prune_opa = self.cfg.prune_opa
            self.cfg.strategy.grow_grad2d = self.cfg.grow_grad2d
            self.cfg.strategy.grow_scale3d = self.cfg.grow_scale3d
            self.cfg.strategy.grow_scale2d = self.cfg.grow_scale2d
            self.cfg.strategy.prune_scale3d = self.cfg.prune_scale3d
            self.cfg.strategy.prune_scale2d = self.cfg.prune_scale2d
            self.cfg.strategy.refine_scale2d_stop_iter = self.cfg.refine_scale2d_stop_iter
            self.cfg.strategy.refine_start_iter = self.cfg.refine_start_iter
            self.cfg.strategy.refine_stop_iter = self.cfg.refine_stop_iter
            self.cfg.strategy.reset_every = self.cfg.reset_every
            self.cfg.strategy.refine_every = self.cfg.refine_every
            self.cfg.strategy.pause_refine_after_reset = self.cfg.pause_refine_after_reset
            self.cfg.strategy.absgrad = self.cfg.absgrad
            self.cfg.strategy.revised_opacity = self.cfg.revised_opacity
            self.strategy_state = self.cfg.strategy.initialize_state(
                scene_scale=self.scene_scale
            )
        elif isinstance(self.cfg.strategy, MCMCStrategy):
            self.cfg.strategy.cap_max = self.cfg.cap_max
            self.cfg.strategy.noise_lr = self.cfg.noise_lr
            self.cfg.strategy.refine_start_iter = self.cfg.refine_start_iter 
            self.cfg.strategy.refine_stop_iter = self.cfg.refine_stop_iter 
            self.cfg.strategy.refine_every = self.cfg.refine_every 
            self.cfg.strategy.min_opacity = self.cfg.min_opacity 
            self.cfg.strategy.verbose = True 
            self.strategy_state = self.cfg.strategy.initialize_state()
        else:
            assert_never(self.cfg.strategy)


        self.pose_optimizers = []
        if cfg.pose_opt:
            self.pose_adjust = CameraOptModule(len(self.trainset)).to(self.device)
            self.pose_adjust.zero_init()
            self.pose_optimizers = [
                torch.optim.Adam(
                    self.pose_adjust.parameters(),
                    lr=cfg.pose_opt_lr * math.sqrt(cfg.batch_size),
                    weight_decay=cfg.pose_opt_reg,
                )
            ]
            if world_size > 1:
                self.pose_adjust = DDP(self.pose_adjust)

        

        self.app_optimizers = []
        if cfg.app_opt:
            assert feature_dim is not None
            self.app_module = AppearanceOptModule(
                len(self.trainset), feature_dim, cfg.app_embed_dim, cfg.sh_degree
            ).to(self.device)
            # initialize the last layer to be zero so that the initial output is zero.
            torch.nn.init.zeros_(self.app_module.color_head[-1].weight)
            torch.nn.init.zeros_(self.app_module.color_head[-1].bias)
            self.app_optimizers = [
                torch.optim.Adam(
                    self.app_module.embeds.parameters(),
                    lr=cfg.app_opt_lr * math.sqrt(cfg.batch_size) * 10.0,
                    weight_decay=cfg.app_opt_reg,
                ),
                torch.optim.Adam(
                    self.app_module.color_head.parameters(),
                    lr=cfg.app_opt_lr * math.sqrt(cfg.batch_size),
                ),
            ]
            if world_size > 1:
                self.app_module = DDP(self.app_module)

        self.bil_grid_optimizers = []
        if cfg.use_bilateral_grid:
            self.bil_grids = BilateralGrid(
                len(self.trainset),
                grid_X=cfg.bilateral_grid_shape[0],
                grid_Y=cfg.bilateral_grid_shape[1],
                grid_W=cfg.bilateral_grid_shape[2],
            ).to(self.device)
            self.bil_grid_optimizers = [
                torch.optim.Adam(
                    self.bil_grids.parameters(),
                    lr=2e-3 * math.sqrt(cfg.batch_size),
                    eps=1e-15,
                ),
            ]

        # Losses & Metrics.
        self.ssim = StructuralSimilarityIndexMeasure(data_range=1.0).to(self.device)
        self.psnr = PeakSignalNoiseRatio(data_range=1.0).to(self.device)

    def rasterize_splats(
        self,
        camtoworlds: Tensor,
        Ks: Tensor,
        width: int,
        height: int,
        rasterize_mode: Optional[Literal["classic", "antialiased"]] = None,
        camera_model: Optional[Literal["pinhole", "ortho", "fisheye"]] = None,
        **kwargs,
    ) -> Tuple[Tensor, Tensor, Dict]:
        means = self.splats["means"]  # [N, 3]
        # quats = F.normalize(self.splats["quats"], dim=-1)  # [N, 4]
        # rasterization does normalization internally
        quats = self.splats["quats"]  # [N, 4]
        scales = torch.exp(self.splats["scales"])  # [N, 3]
        opacities = torch.sigmoid(self.splats["opacities"])  # [N,]

        image_ids = kwargs.pop("image_ids", None)
        if self.cfg.app_opt:
            colors = self.app_module(
                features=self.splats["features"],
                embed_ids=image_ids,
                dirs=means[None, :, :] - camtoworlds[:, None, :3, 3],
                sh_degree=kwargs.pop("sh_degree", self.cfg.sh_degree),
            )
            colors = colors + self.splats["colors"]
            colors = torch.sigmoid(colors)
        else:
            colors = torch.cat([self.splats["sh0"], self.splats["shN"]], 1)  # [N, K, 3]

        if rasterize_mode is None:
            rasterize_mode = "antialiased" if self.cfg.antialiased else "classic"
        if camera_model is None:
            camera_model = self.cfg.camera_model
        render_colors, render_alphas, info = rasterization(
            means=means,
            quats=quats,
            scales=scales,
            opacities=opacities,
            colors=colors,
            viewmats=torch.linalg.inv(camtoworlds),  # [C, 4, 4]
            Ks=Ks,  # [C, 3, 3]
            width=width,
            height=height,
            packed=self.cfg.packed,
            absgrad=(
                self.cfg.strategy.absgrad
                if isinstance(self.cfg.strategy, DefaultStrategy)
                else False
            ),
            sparse_grad=self.cfg.sparse_grad,
            rasterize_mode=rasterize_mode,
            distributed=self.world_size > 1,
            camera_model=self.cfg.camera_model,
            with_ut=self.cfg.with_ut,
            with_eval3d=self.cfg.with_eval3d,
            tile_size=self.cfg.tile_size,
            **kwargs,
        )

        return render_colors, render_alphas, info

    def train(self):

        cfg = self.cfg
        device = self.device
        world_rank = self.world_rank
        world_size = self.world_size

        #Compute effective steps
        max_steps = cfg.max_epochs * len(self.trainset)

        schedulers = [
            # means has a learning rate schedule, that end at 0.01 of the initial value
            torch.optim.lr_scheduler.ExponentialLR(
                self.optimizers["means"], gamma=0.01 ** (1.0 / max_steps)
            ),
        ]

        if cfg.pose_opt:
            # pose optimization has a learning rate schedule
            schedulers.append(
                torch.optim.lr_scheduler.ExponentialLR(
                    self.pose_optimizers[0], gamma=0.01 ** (1.0 / max_steps)
                )
            )

        if cfg.use_bilateral_grid:
            # bilateral grid has a learning rate schedule. Linear warmup for 1000 steps.
            schedulers.append(
                torch.optim.lr_scheduler.ChainedScheduler(
                    [
                        torch.optim.lr_scheduler.LinearLR(
                            self.bil_grid_optimizers[0],
                            start_factor=0.01,
                            total_iters=1000,
                        ),
                        torch.optim.lr_scheduler.ExponentialLR(
                            self.bil_grid_optimizers[0], gamma=0.01 ** (1.0 / max_steps)
                        ),
                    ]
                )
            )

        trainloader = torch.utils.data.DataLoader(
            self.trainset,
            batch_size=cfg.batch_size,
            shuffle=True,
            num_workers=4,
            persistent_workers=True,
            pin_memory=True,
        )
        

        # Training loop.
        dsize = len(self.trainset)
        global_tic = time.time()
        pbar = createProgressBar(range(0, cfg.max_epochs))
        for epoch in pbar:
            
            trainloader_iter = iter(trainloader)

            for substep in range(0, dsize):
                
                step = epoch * dsize + substep
                data = next(trainloader_iter)

                #Load data sample
                camtoworlds = camtoworlds_gt = data["camtoworld"].to(device)  # [1, 4, 4]
                Ks = data["K"].to(device)  # [1, 3, 3]
                pixels = data["image"].to(device)  # [1, H, W, 3] -> already float
                num_train_rays_per_step = (
                    pixels.shape[0] * pixels.shape[1] * pixels.shape[2]
                )
                image_ids = data["image_id"].to(device)
                masks = data["mask"].to(device) if "mask" in data else None  # [1, H, W]
                
                if cfg.depth_loss:
                    points = data["points"].to(device)  # [1, M, 2]
                    depths_gt = data["depths"].to(device)  # [1, M]

                height, width = pixels.shape[1:3]


                if cfg.pose_opt:
                    camtoworlds = self.pose_adjust(camtoworlds, image_ids)

                # sh schedule
                sh_degree_to_use = min(step // cfg.sh_degree_interval, cfg.sh_degree)

                # forward
                renders, alphas, info = self.rasterize_splats(
                    camtoworlds=camtoworlds,
                    Ks=Ks,
                    width=width,
                    height=height,
                    sh_degree=sh_degree_to_use,
                    near_plane=cfg.near_plane,
                    far_plane=cfg.far_plane,
                    image_ids=image_ids,
                    render_mode="RGB+ED" if cfg.depth_loss else "RGB",
                )

                if renders.shape[-1] == 4:
                    colors, depths = renders[..., 0:3], renders[..., 3:4]
                else:
                    colors, depths = renders, None

                if cfg.use_bilateral_grid:
                    grid_y, grid_x = torch.meshgrid(
                        (torch.arange(height, device=self.device) + 0.5) / height,
                        (torch.arange(width, device=self.device) + 0.5) / width,
                        indexing="ij",
                    )
                    grid_xy = torch.stack([grid_x, grid_y], dim=-1).unsqueeze(0)
                    colors = slice(
                        self.bil_grids,
                        grid_xy.expand(colors.shape[0], -1, -1, -1),
                        colors,
                        image_ids.unsqueeze(-1),
                    )["rgb"]

                if cfg.random_bkgd:
                    bkgd = torch.rand(1, 3, device=device)
                    colors = colors + bkgd * (1.0 - alphas)

                self.cfg.strategy.step_pre_backward(
                    params=self.splats,
                    optimizers=self.optimizers,
                    state=self.strategy_state,
                    step=step,
                    info=info,
                )

                if masks is not None:
                    colors[~masks] = 0
                    pixels[~masks] = 0


                # loss
                l1loss = F.l1_loss(colors, pixels)
                ssimloss = 1.0 - fused_ssim(
                    colors.permute(0, 3, 1, 2), pixels.permute(0, 3, 1, 2), padding="valid"
                )
                loss = l1loss * (1.0 - cfg.ssim_lambda) + ssimloss * cfg.ssim_lambda

                if cfg.depth_loss:
                    # query depths from depth map
                    points = torch.stack(
                        [
                            points[:, :, 0] / (width - 1) * 2 - 1,
                            points[:, :, 1] / (height - 1) * 2 - 1,
                        ],
                        dim=-1,
                    )  # normalize to [-1, 1]
                    grid = points.unsqueeze(2)  # [1, M, 1, 2]
                    depths = F.grid_sample(
                        depths.permute(0, 3, 1, 2), grid, align_corners=True
                    )  # [1, 1, M, 1]
                    depths = depths.squeeze(3).squeeze(1)  # [1, M]
                    # calculate loss in disparity space
                    disp = torch.where(depths > 0.0, 1.0 / depths, torch.zeros_like(depths))
                    disp_gt = 1.0 / depths_gt  # [1, M]
                    depthloss = F.l1_loss(disp, disp_gt) * self.scene_scale
                    loss += depthloss * cfg.depth_lambda

                if cfg.use_bilateral_grid:
                    tvloss = 10 * total_variation_loss(self.bil_grids.grids)
                    loss += tvloss

                # regularizations
                if cfg.opacity_reg > 0.0:
                    loss += cfg.opacity_reg * torch.sigmoid(self.splats["opacities"]).mean()
                if cfg.scale_reg > 0.0:
                    loss += cfg.scale_reg * torch.exp(self.splats["scales"]).mean()

                loss.backward()

                desc = f"loss={loss.item():.3f}| " f"sh degree={sh_degree_to_use}| "
                if cfg.depth_loss:
                    desc += f"depth loss={depthloss.item():.6f}| "
           
                pbar.set_description(desc)
                    

                # Turn Gradients into Sparse Tensor before running optimizer
                if cfg.sparse_grad:
                    assert cfg.packed, "Sparse gradients only work with packed mode."
                    gaussian_ids = info["gaussian_ids"]
                    for k in self.splats.keys():
                        grad = self.splats[k].grad
                        if grad is None or grad.is_sparse:
                            continue
                        self.splats[k].grad = torch.sparse_coo_tensor(
                            indices=gaussian_ids[None],  # [1, nnz]
                            values=grad[gaussian_ids],  # [nnz, ...]
                            size=self.splats[k].size(),  # [N, ...]
                            is_coalesced=len(Ks) == 1,
                        )

                if cfg.visible_adam:
                    gaussian_cnt = self.splats.means.shape[0]
                    if cfg.packed:
                        visibility_mask = torch.zeros_like(
                            self.splats["opacities"], dtype=bool
                        )
                        visibility_mask.scatter_(0, info["gaussian_ids"], 1)
                    else:
                        visibility_mask = (info["radii"] > 0).all(-1).any(0)

                # optimize
                for optimizer in self.optimizers.values():
                    if cfg.visible_adam:
                        optimizer.step(visibility_mask)
                    else:
                        optimizer.step()
                    optimizer.zero_grad(set_to_none=True)
                for optimizer in self.pose_optimizers:
                    optimizer.step()
                    optimizer.zero_grad(set_to_none=True)
                for optimizer in self.app_optimizers:
                    optimizer.step()
                    optimizer.zero_grad(set_to_none=True)
                for optimizer in self.bil_grid_optimizers:
                    optimizer.step()
                    optimizer.zero_grad(set_to_none=True)
                for scheduler in schedulers:
                    scheduler.step()

                # Run post-backward steps after backward and optimizer
                if isinstance(self.cfg.strategy, DefaultStrategy):
                    self.cfg.strategy.step_post_backward(
                        params=self.splats,
                        optimizers=self.optimizers,
                        state=self.strategy_state,
                        step=step,
                        info=info,
                        packed=cfg.packed,
                    )
                    print("Number of GS:", len(self.splats["means"]))
                elif isinstance(self.cfg.strategy, MCMCStrategy):
                    self.cfg.strategy.step_post_backward(
                        params=self.splats,
                        optimizers=self.optimizers,
                        state=self.strategy_state,
                        step=step,
                        info=info,
                        lr=schedulers[0].get_last_lr()[0],
                    )
                else:
                    assert_never(self.cfg.strategy)
            
            if epoch in [i - 1 for i in cfg.save_epochs] or epoch == cfg.max_epochs - 1:

                path = f"{self.ckpt_dir}/ckpt_{epoch}_rank{self.world_rank}.pt"
                data = {"step": step, "splats": self.splats.state_dict()}
                
                if cfg.pose_opt:
                    if world_size > 1:
                        data["pose_adjust"] = self.pose_adjust.module.state_dict()
                    else:
                        data["pose_adjust"] = self.pose_adjust.state_dict()
                if cfg.app_opt:
                    if world_size > 1:
                        data["app_module"] = self.app_module.module.state_dict()
                    else:
                        data["app_module"] = self.app_module.state_dict()
                
                torch.save(data, path)


def main(local_rank: int, world_rank, world_size: int, cfg: Config):
    
    #Create object for computation
    runner = Runner(local_rank, world_rank, world_size, cfg)

    #if a checkpoint was passed, will load the gaussians from there
    if cfg.resume_ckpt != "":
        print("Loading from checkpoint")
        ckpt = torch.load(cfg.resume_ckpt, map_location=runner.device, weights_only=True)
        for k in runner.splats.keys():
            runner.splats[k].data = torch.cat([ckpt["splats"][k]])

    #Launch training
    runner.train()


if __name__ == "__main__":
    
    import sys
    from argparse_dataclass import ArgumentParser

    # Config objects we can choose between.
    # Each is a tuple of (CLI description, config object).
    configs = {
        "default": (
            "Gaussian splatting training using densification heuristics from the original paper.",
            Config(
                strategy=DefaultStrategy(verbose=True),
            ),
        ),
        "mcmc": (
            "Gaussian splatting training using densification from the paper '3D Gaussian Splatting as Markov Chain Monte Carlo'.",
            Config(
                init_opa=0.5,
                init_scale=0.1,
                opacity_reg=0.01,
                scale_reg=0.01,
                strategy=MCMCStrategy(verbose=True),
            ),
        ),
    }

    parser = ArgumentParser(configs, prebuilt=True)
    cfg = parser.parse_args(sys.argv[1:])

    if cfg.sparse_grad:
        cfg.visible_adam = False

    # Import BilateralGrid and related functions based on configuration
    if cfg.use_bilateral_grid or cfg.use_fused_bilagrid:
        if cfg.use_fused_bilagrid:
            cfg.use_bilateral_grid = True
            from fused_bilagrid import (
                BilateralGrid,
                color_correct,
                slice,
                total_variation_loss,
            )
        else:
            cfg.use_bilateral_grid = True
            from lib_bilagrid import (
                BilateralGrid,
                color_correct,
                slice,
                total_variation_loss,
            )


    if cfg.with_ut:
        assert cfg.with_eval3d, "Training with UT requires setting `with_eval3d` flag."

    cli(main, cfg, verbose=True)
