# mrGSplat

Collection of nodes to run gsplat in meshroom.
Relies on the rez package gsplat, containing an install and a version of nerfstudio's gsplat https://github.com/nerfstudio-project/gsplat

Utilisation: rez env meshroom-develop mrGSplat-version

This also give you access to templates to run the optimisation/render, and the clean plate pipeline.

## Nodes

### PrepareImagesForGSPlat

This node will prepare images by downscaling images and converting the codec/colorspace
- *scale* is the downscaling factor
- *mask folder* can be used to input masks. 
- In this case *reference* is a SFM file used to link masks images to their intrinsics ID so that we know what mask corresponds to what image in the dataset

### GaussianSplattingOptim

This node is used to train the model
- *scale* needs to be the same as the scale from PrepareImagesForGSplat
- *number of steps* is the number of iterations
- *resume from model* is an input from a model output of a previous `GaussianSplattingOptim`. It is mainly used to create checkpoints. If you set the scale correctly you can mix trained models from different scales with this (so for example you can first train with downscaled images, and later train refine by training on full size)

### GaussianSplattingRender

This node is used to render a model. It uses a model and poses from a SFM file.

### ConvertGSplatModel

This node will convert the model to different format.
For now it supports ".ply" which corresponds to what [GSOPs](https://github.com/cgnomads/GSOPs) uses to render splats

### ImageCompo

When you use masks to remove moving objects you may want to composite back on the image. This node is here for that.
You can composite back what was removed using the mask input, and a background (usually the gsplat render) and the foreground (the original image).


## Additional Nodes

### ImportAlembicCamera

This node can be used to import an alembic camera and create a SFM file that can be used to render.
You can additionally override the camera intrinsics parameters.

### MeshViz

This will take a model, sample N points (e.g. keep N splats) and export them as `.obj`, so that they can be displayed in Meshroom's 3D viewer

### ExtractPosesFromSfm

This is a node that can be used to extract poses when there are multiple intrinsics that were mixed.
It's probably only doing things that SfMTransfer does.


## Experimental / WIP Nodes

These node address future optimizations that we wanted to try.

### MeshSample

First an idea was that instead of taking the result from the SfM to initialize splats, we could take the result from the Meshing step.
The logic behind is that SfM will spawn a lot of points in the air and by using Meshing we would avoid a lot of "fake" points.
The MeshSample node was here to test this because we could sample points on the mesh, export them as a SfM file and then use this as the Optim input.
However for now this doesn't really solve the issue, and I think for 2 reasons :
- first the result is better when the splats are initialized with the correct color, and this is not the case here
- then it sample uniformly on the mesh, while by using the SfM we get more points where SfM found more landmarks. Usually we get better results with SfM and I think this is the main reason.

### InitializeSplats

This was an attempt of improving MeshSample

### CleanSplats

The second improvement we thought about was to clean splats that were too far away from the mesh, but after the optimization.
This is not helping the optim itself but it's here to remove "floating" splats.
So this node is supposed to check the minimum distance between each splats and the mesh, and to remove those whe are too far.

### RandomizePoses, ExportPoses, SfmPoseDistance

The next thing we wanted to test was the post optimization through gaussian splatting.
These nodes are used to :
- *RandomizePoses* will add random noise to each pose (translation, rotation)
- Then in *GaussianSplattingOptim* you can check the pose optimization checkbox
- *ExportPoses* will export optimized poses as a Sfm file
- Finally *SfmPoseDistance* compute the difference between the original SfM and the optimized poses. It will check if the pose optimization step helped improving the poses.

Unfortunately for now I didn"t find that the pose optimization really worked. We can clearly see that gsplat is modifying the poses but the result is not closer to the original sfm that the randomized poses.
