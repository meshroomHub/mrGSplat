# -*- coding: utf-8 -*-

from typing import Annotated, Literal
import numpy as np
import numpy.typing as npt


# Define types for ndarray of specific shape
# Could use np.generic instead of np.float32
NDArray4x4 = Annotated[npt.NDArray[np.dtype[np.float32]], Literal[4, 4]]
NDArray3x3 = Annotated[npt.NDArray[np.dtype[np.float32]], Literal[4, 4]]
