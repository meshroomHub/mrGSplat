# -*- coding: utf-8 -*-

import dataclasses

from typing import Annotated, Literal, Optional, Tuple
import numpy as np
import numpy.typing as npt
import torch
from torch import Tensor
import matplotlib as mpl

from pyalicevision.system import ConsoleProgressDisplay



# Define types for ndarray of specific shape
# Could use np.generic instead of np.float32
NDArray4x4 = Annotated[npt.NDArray[np.dtype[np.float32]], Literal[4, 4]]
NDArray3x3 = Annotated[npt.NDArray[np.dtype[np.float32]], Literal[4, 4]]

Colormaps = Literal["turbo", "viridis", "magma", "inferno", "cividis", "gray"]


def apply_float_colormap(image: Annotated[Tensor, "*bs 1"], colormap: Colormaps = "viridis") -> Annotated[Tensor, "*bs rgb=3"]:
    """Copied from nerfstudio/utils/colormaps.py
    Convert single channel to a color image.

    Args:
        image: Single channel image.
        colormap: Colormap for image.

    Returns:
        Tensor: Colored image with colors in [0, 1]
    """

    image = torch.nan_to_num(image, 0)
    if colormap == "gray":
        return image.repeat(1, 1, 3)
    image_long = (image * 255).long()
    image_long_min = torch.min(image_long)
    image_long_max = torch.max(image_long)
    assert image_long_min >= 0, f"the min value is {image_long_min}"
    assert image_long_max <= 255, f"the max value is {image_long_max}"
    return torch.tensor(mpl.colormaps[colormap].colors, device=image.device)[
        image_long[..., 0]
    ]



@dataclasses.dataclass
class RenderTabState:
    """Useful GUI handles exposed by the render tab."""
    num_train_rays_per_sec: Optional[float] = None
    num_view_rays_per_sec: float = 100000.0
    preview_render: bool = False
    preview_fov: float = 0.0
    preview_time: float = 0.0
    preview_aspect: float = 1.0
    viewer_res: int = 2048
    render_width: int = 1280
    render_height: int = 960


class GSplatRenderTabState(RenderTabState):
    # non-controlable parameters
    total_gs_count: int = 0
    rendered_gs_count: int = 0

    # controlable parameters
    max_sh_degree: int = 5
    near_plane: float = 1e-2
    far_plane: float = 1e2
    radius_clip: float = 0.0
    eps2d: float = 0.3
    backgrounds: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    render_mode: Literal[
        "rgb", "depth(accumulated)", "depth(expected)", "alpha"
    ] = "rgb"
    normalize_nearfar: bool = False
    inverse: bool = False
    colormap: Literal[
        "turbo", "viridis", "magma", "inferno", "cividis", "gray"
    ] = "turbo"
    rasterize_mode: Literal["classic", "antialiased"] = "classic"
    camera_model: Literal["pinhole", "ortho", "fisheye"] = "pinhole"


# @dataclasses.dataclass
# class CameraState(object):
#     fov: float
#     aspect: float
#     c2w: NDArray4x4

#     def get_K(self, img_wh: Tuple[int, int]) -> NDArray3x3:
#         W, H = img_wh
#         focal_length = H / 2.0 / np.tan(self.fov / 2.0)
#         K = np.array(
#             [
#                 [focal_length, 0.0, W / 2.0],
#                 [0.0, focal_length, H / 2.0],
#                 [0.0, 0.0, 1.0],
#             ]
#         )
#         return K

@dataclasses.dataclass
class CameraState(object):
    c2w: NDArray4x4
    K: NDArray3x3
    
    @staticmethod
    def build_K(fov, img_wh: Tuple[int, int]) -> NDArray3x3:
        W, H = img_wh
        focal_length = H / 2.0 / np.tan(fov / 2.0)
        K = np.array(
            [
                [focal_length, 0.0, W / 2.0],
                [0.0, focal_length, H / 2.0],
                [0.0, 0.0, 1.0],
            ]
        )
        return K
    
    @classmethod
    def build(cls, fov, c2w, img_wh):
        return cls(
            c2w=c2w,
            K=cls.get_K(fov, img_wh)
        )

    def get_K(self, img_wh: Tuple[int, int]) -> NDArray3x3:
        return self.K


class ProgressBar:
    def __init__(self, items, desc=""):
        self.items = items
        self.__progress = ConsoleProgressDisplay(self.length, desc + "\n")
    
    @property
    def length(self):
        return len(self.items)
    
    def __iter__(self):
        return self
    
    def __next__(self):
        count = self.__progress.count()
        self.__progress += 1
        if count < self.length:
            return self.items[count]
        raise StopIteration
    
    @staticmethod
    def set_description(message):
        # No real solution with boost progress_display so just print is doing the job
        print(message)

def createProgressBar(items, desc=""):
    return iter(ProgressBar(items, desc))

def createProgressBarRange(maxValue, desc=""):
    return iter(ProgressBar(range(maxValue), desc))
