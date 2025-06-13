# mrGSplat
Collection of nodes to run gsplat in meshroom.
Relies on the rez package gsplat-develop, containing an install and a modify version of nerfstudio's gsplat https://github.com/nerfstudio-project/gsplat

Utilisation: rez env meshroom-develop gsplatNodes-develop

# Optim nodes
Gsplat is split in optim and render nodes.
Use "GaussianSplattingOptim" to train the model for the target resolution.
Use "GaussianSplattingRender" to render frame. The sfm does't have to be the same as the input, only the poses matters.
It is adviced to train the GS, first at a lower scale, then higher, to save on optim time.

# Util nodes

## Data preparation
Gsplat support colmap'format, use the export nodes "Meshroom2Colmap" and "PrepareFolderForGS" to convert a meshroom sfm (including landmarks) to colmap format, for the given target image resolution.
You can also include masks.

## Image compo
Node used to simply comp two set of images using masks
