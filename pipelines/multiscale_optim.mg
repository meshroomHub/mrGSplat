{
    "header": {
        "releaseVersion": "2025.1.0-develop",
        "fileVersion": "2.0",
        "nodesVersions": {
            "ApplyCalibration": "1.0",
            "CameraInit": "12.0",
            "ConvertSfMFormat": "2.0",
            "FeatureExtraction": "1.3",
            "FeatureMatching": "2.0",
            "GaussianSplattingOptim": "1.0",
            "GaussianSplattingRender": "1.0",
            "ImageMatching": "2.0",
            "ImageMatchingMultiSfM": "1.0",
            "KeyframeSelection": "5.0",
            "Meshroom2ColmapSfmConvertions": "2.0",
            "PrepareFolderForGS": "3.0",
            "StructureFromMotion": "3.3"
        }
    },
    "graph": {
        "ApplyCalibration_3": {
            "nodeType": "ApplyCalibration",
            "position": [
                -296,
                988
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uid": "10a8135f66d72b1568df95bc0f7f506774572f24",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{CameraInit_5.output}",
                "calibration": "",
                "useJson": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmData.sfm"
            }
        },
        "CameraInit_5": {
            "nodeType": "CameraInit",
            "position": [
                -512,
                1124
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uid": "b1ddcd106986d8b15cdcb4ecab9b974c077fd8e1",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 7554437,
                        "poseId": 7554437,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000004.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 77937651,
                        "poseId": 77937651,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000013.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 246686527,
                        "poseId": 246686527,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000003.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 328990241,
                        "poseId": 328990241,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000000.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 335902456,
                        "poseId": 335902456,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000001.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 435457966,
                        "poseId": 435457966,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000005.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 475560383,
                        "poseId": 475560383,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000008.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 538779264,
                        "poseId": 538779264,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000014.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 623335754,
                        "poseId": 623335754,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000002.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1102296173,
                        "poseId": 1102296173,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000007.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1398374336,
                        "poseId": 1398374336,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000012.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1416335166,
                        "poseId": 1416335166,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000009.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1566310525,
                        "poseId": 1566310525,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000010.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 1655582873,
                        "poseId": 1655582873,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000011.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2030917626,
                        "poseId": 2030917626,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000006.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    },
                    {
                        "viewId": 2054207917,
                        "poseId": 2054207917,
                        "path": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images/00000015.jpg",
                        "intrinsicId": 434888469,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"jpeg:subsampling\": \"4:2:0\", \"oiio:ColorSpace\": \"sRGB\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 434888469,
                        "initialFocalLength": -1.0,
                        "focalLength": 43.45584412271571,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "scaleLocked": false,
                        "offsetLocked": false,
                        "distortionLocked": false,
                        "type": "pinhole",
                        "distortionType": "none",
                        "width": 768,
                        "height": 576,
                        "sensorWidth": 36.0,
                        "sensorHeight": 27.0,
                        "serialNumber": "/s/prods/mvg/_source_global/users/hogm/datasets/blendedMVSNEt/debug_set/5aa0f9d7a9efce63548c69a1/blended_images",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "unknown",
                        "distortionInitializationMode": "none",
                        "distortionParams": [
                            0.0,
                            0.0,
                            0.0
                        ],
                        "undistortionOffset": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "undistortionParams": [],
                        "locked": false
                    }
                ],
                "sensorDatabase": "${ALICEVISION_SENSOR_DB}",
                "lensCorrectionProfileInfo": "${ALICEVISION_LENS_PROFILE_INFO}",
                "lensCorrectionProfileSearchIgnoreCameraModel": true,
                "defaultFieldOfView": 45.0,
                "groupCameraFallback": "folder",
                "rawColorInterpretation": "DCPLinearProcessing",
                "colorProfileDatabase": "${ALICEVISION_COLOR_PROFILE_DB}",
                "errorOnMissingColorProfile": true,
                "viewIdMethod": "metadata",
                "viewIdRegex": ".*?(\\d+)",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "InitShot",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/cameraInit.sfm"
            }
        },
        "ConvertSfMFormat_7": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                1268,
                996
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 32,
                "split": 1
            },
            "uid": "c0fb54933d52e6f6c3222790a9dd22d4091da46d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{StructureFromMotion_7.output}",
                "fileExt": "sfm",
                "describerTypes": [
                    "dspsift"
                ],
                "imageWhiteList": [],
                "views": true,
                "intrinsics": true,
                "extrinsics": true,
                "structure": true,
                "observations": true,
                "surveys": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfm.{fileExtValue}"
            }
        },
        "FeatureExtraction_4": {
            "nodeType": "FeatureExtraction",
            "position": [
                -91,
                1122
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 16,
                "split": 1
            },
            "uid": "8e8b1389b6886d7235b6850eac50555f716f7516",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ApplyCalibration_3.output}",
                "masksFolder": "",
                "maskExtension": "jpg",
                "maskInvert": false,
                "describerTypes": [
                    "dspsift"
                ],
                "describerPreset": "normal",
                "maxNbFeatures": 0,
                "describerQuality": "normal",
                "contrastFiltering": "GridSort",
                "relativePeakThreshold": 0.01,
                "gridFiltering": true,
                "workingColorSpace": "sRGB",
                "forceCpuExtraction": true,
                "maxThreads": 0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "FeatureMatching_7": {
            "nodeType": "FeatureMatching",
            "position": [
                348,
                979
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 16,
                "split": 1
            },
            "uid": "4a44ded9c13dde416bb73d87b9ef623aa2f3b83d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatching_5.input}",
                "featuresFolders": "{ImageMatching_5.featuresFolders}",
                "imagePairsList": "{ImageMatching_5.output}",
                "describerTypes": "{FeatureExtraction_4.describerTypes}",
                "photometricMatchingMethod": "ANN_L2",
                "geometricEstimator": "acransac",
                "geometricFilterType": "fundamental_matrix",
                "distanceRatio": 0.8,
                "maxIteration": 50000,
                "geometricError": 0.0,
                "knownPosesGeometricErrorMax": 5.0,
                "minRequired2DMotion": -1.0,
                "maxMatches": 0,
                "savePutativeMatches": false,
                "crossMatching": false,
                "guidedMatching": false,
                "matchFromKnownCameraPoses": false,
                "exportDebugFiles": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "FeatureMatchingKeyframes",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "FeatureMatching_9": {
            "nodeType": "FeatureMatching",
            "position": [
                909,
                989
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 32,
                "split": 2
            },
            "uid": "2fbcf680fcd65e1d5524cf127b997fbaa833e9a5",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatchingMultiSfM_4.outputCombinedSfM}",
                "featuresFolders": "{StructureFromMotion_6.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_4.output}",
                "describerTypes": "{StructureFromMotion_6.describerTypes}",
                "photometricMatchingMethod": "ANN_L2",
                "geometricEstimator": "acransac",
                "geometricFilterType": "fundamental_matrix",
                "distanceRatio": 0.8,
                "maxIteration": 50000,
                "geometricError": 0.0,
                "knownPosesGeometricErrorMax": 5.0,
                "minRequired2DMotion": -1.0,
                "maxMatches": 0,
                "savePutativeMatches": false,
                "crossMatching": false,
                "guidedMatching": false,
                "matchFromKnownCameraPoses": false,
                "exportDebugFiles": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "FeatureMatchingFramesToKeyframes",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "GaussianSplattingOptim_1": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                2006.0,
                922.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "99986e598ff39cf0dc2d182546bd4eeca848ea84",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat-develop",
                "sfm": "{PrepareFolderForGS_2.outputFolder}",
                "resumeCheckpoint": "{GaussianSplattingOptim_3.model}",
                "n_steps": 300,
                "dataFactor": 1,
                "custom_ckpts": false,
                "save_steps": [
                    3000
                ],
                "use_masks": false,
                "pose_opt": false
            },
            "internalInputs": {
                "invalidation": "new env C",
                "comment": "",
                "label": "",
                "color": "#2CB9CC"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "model": "{nodeCacheFolder}/ckpts/ckpt_299_rank0.pt"
            }
        },
        "GaussianSplattingOptim_3": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                1826,
                1030
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "5aff3799c6478d4a06035232ae99206bff76369d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat-develop",
                "sfm": "{PrepareFolderForGS_1.outputFolder}",
                "resumeCheckpoint": "",
                "n_steps": 3000,
                "dataFactor": 8,
                "custom_ckpts": false,
                "save_steps": [
                    3000
                ],
                "use_masks": false,
                "pose_opt": true
            },
            "internalInputs": {
                "invalidation": "new env C",
                "comment": "",
                "label": "",
                "color": "#2CB9CC"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "model": "{nodeCacheFolder}/ckpts/ckpt_2999_rank0.pt"
            }
        },
        "GaussianSplattingRender_1": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                2214.0,
                918.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "39fe79949470147261fef1ca41600d3f282fc223",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat-maskSupport",
                "cameras": "{GaussianSplattingOptim_1.sfm}",
                "model": "{GaussianSplattingOptim_1.model}",
                "resolutionFactor": 1
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#2CB9CC"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "frames": "{nodeCacheFolder}/renders/*.jpg",
                "render_folder": "{nodeCacheFolder}/renders"
            }
        },
        "GaussianSplattingRender_4": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                2022,
                1037
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "3ccf68b3525af4e72a7f6e76010b6c8df73a49aa",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "{GaussianSplattingOptim_3.rezEnvName}",
                "cameras": "{GaussianSplattingOptim_3.sfm}",
                "model": "{GaussianSplattingOptim_3.model}",
                "resolutionFactor": 1
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#2CB9CC"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "frames": "{nodeCacheFolder}/renders/*.jpg",
                "render_folder": "{nodeCacheFolder}/renders"
            }
        },
        "ImageMatchingMultiSfM_4": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                724,
                981
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 32,
                "split": 1
            },
            "uid": "862aa09a9022c525fa81a55c8dc3772f775b0661",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{StructureFromMotion_6.output}",
                "inputB": "{KeyframeSelection_3.outputSfMDataFrames}",
                "featuresFolders": "{StructureFromMotion_6.featuresFolders}",
                "method": "VocabularyTree",
                "tree": "${ALICEVISION_VOCTREE}",
                "weights": "",
                "matchingMode": "a/b",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 20,
                "nbNeighbors": 5,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/imageMatches.txt",
                "outputCombinedSfM": "{nodeCacheFolder}/combineSfM.sfm"
            }
        },
        "ImageMatching_5": {
            "nodeType": "ImageMatching",
            "position": [
                147,
                979
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uid": "5721a63ef3a860de5a6b3bd44da7a714a94eee4c",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{KeyframeSelection_3.outputSfMDataKeyframes}",
                "featuresFolders": [
                    "{FeatureExtraction_4.output}"
                ],
                "method": "Exhaustive",
                "tree": "${ALICEVISION_VOCTREE}",
                "weights": "",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 40,
                "nbNeighbors": 5,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "ImageMatchingKeyframes",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/imageMatches.txt"
            }
        },
        "KeyframeSelection_3": {
            "nodeType": "KeyframeSelection",
            "position": [
                -90,
                982
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uid": "e9de430153aa30b8ffe9f16ea7eba4f3fd4f7f1e",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "inputPaths": [
                    "{ApplyCalibration_3.output}"
                ],
                "brands": [],
                "models": [],
                "mmFocals": [],
                "sensorDbPath": "${ALICEVISION_SENSOR_DB}",
                "maskPaths": [],
                "selectionMethod": {
                    "useSmartSelection": true,
                    "regularSelection": {
                        "minFrameStep": 12,
                        "maxFrameStep": 0,
                        "maxNbOutFrames": 0
                    },
                    "smartSelection": {
                        "pxDisplacement": 10.0,
                        "minNbOutFrames": 40,
                        "maxNbOutFrames": 2000,
                        "rescaledWidthSharpness": 720,
                        "rescaledWidthFlow": 720,
                        "sharpnessWindowSize": 200,
                        "flowCellSize": 90,
                        "minBlockSize": 10
                    }
                },
                "renameKeyframes": false,
                "outputExtension": "none",
                "storageDataType": "float",
                "debugOptions": {
                    "debugScores": {
                        "exportScores": false,
                        "csvFilename": "scores.csv",
                        "exportSelectedFrames": false
                    },
                    "opticalFlowVisualisation": {
                        "exportFlowVisualisation": false,
                        "flowVisualisationOnly": false
                    },
                    "skipSharpnessComputation": false,
                    "skipSelection": false
                },
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputSfMDataKeyframes": "{nodeCacheFolder}/keyframes.sfm",
                "outputSfMDataFrames": "{nodeCacheFolder}/frames.sfm"
            }
        },
        "Meshroom2ColmapSfmConvertions_3": {
            "nodeType": "Meshroom2ColmapSfmConvertions",
            "position": [
                1451,
                990
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 32,
                "split": 1
            },
            "uid": "0c25f48b17c0b995507a3a7e710fda9111f59966",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ConvertSfMFormat_7.output}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "PrepareFolderForGS_1": {
            "nodeType": "PrepareFolderForGS",
            "position": [
                1636,
                1041
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "3a3c93e67bc7d85eb61683539b458ca10d651af1",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "colmapFolder": "{Meshroom2ColmapSfmConvertions_3.output}",
                "maskFolder": "",
                "scale": [
                    "2",
                    "4",
                    "8",
                    "1"
                ],
                "selectedScale": "8",
                "verboseLevel": "info",
                "forcePinhole": true
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#E35C03"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputImageFolder": "{nodeCacheFolder}/images"
            }
        },
        "PrepareFolderForGS_2": {
            "nodeType": "PrepareFolderForGS",
            "position": [
                1818.0,
                912.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "72056bcf40d97b0523069eeeeb16df99c7377f13",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "colmapFolder": "{PrepareFolderForGS_1.colmapFolder}",
                "maskFolder": "",
                "scale": [
                    "1"
                ],
                "selectedScale": "1",
                "verboseLevel": "info",
                "forcePinhole": true
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#E35C03"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputImageFolder": "{nodeCacheFolder}/images"
            }
        },
        "RomaWarp_1": {
            "nodeType": "RomaWarp",
            "position": [
                -287,
                1170
            ],
            "inputs": {
                "inputSfMData": "{CameraInit_5.output}"
            },
            "version": "2.0"
        },
        "StructureFromMotion_6": {
            "nodeType": "StructureFromMotion",
            "position": [
                542,
                977
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 16,
                "split": 1
            },
            "uid": "619650dac8ba40f3bd7f155a3d23fe6f6d181789",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_7.input}",
                "featuresFolders": "{FeatureMatching_7.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_7.output}"
                ],
                "describerTypes": "{FeatureMatching_7.describerTypes}",
                "localizerEstimator": "acransac",
                "observationConstraint": "Scale",
                "localizerEstimatorMaxIterations": 50000,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": true,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 30,
                "maxImagesPerGroup": 30,
                "bundleAdjustmentMaxOutliers": 50,
                "maxNumberOfMatches": 0,
                "minNumberOfMatches": 0,
                "minInputTrackLength": 2,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "maxReprojectionError": 4.0,
                "minAngleInitialPair": 5.0,
                "maxAngleInitialPair": 40.0,
                "useOnlyMatchesFromInputFolder": false,
                "useRigConstraint": true,
                "rigMinNbCamerasForCalibration": 20,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "filterTrackForks": true,
                "computeStructureColor": true,
                "useAutoTransform": false,
                "initialPairA": "",
                "initialPairB": "",
                "interFileExtension": ".abc",
                "logIntermediateSteps": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "Solve all keyframes first.",
                "label": "StructureFromMotionKeyframes",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfm.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm",
                "extraInfoFolder": "{nodeCacheFolder}"
            }
        },
        "StructureFromMotion_7": {
            "nodeType": "StructureFromMotion",
            "position": [
                1093,
                993
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 32,
                "split": 1
            },
            "uid": "ae26f17847969963895aa1903a8e4c59da05589f",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_9.input}",
                "featuresFolders": "{FeatureMatching_9.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_9.output}"
                ],
                "describerTypes": "{FeatureMatching_9.describerTypes}",
                "localizerEstimator": "acransac",
                "observationConstraint": "Scale",
                "localizerEstimatorMaxIterations": 50000,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 0,
                "maxImagesPerGroup": 0,
                "bundleAdjustmentMaxOutliers": -1,
                "maxNumberOfMatches": 0,
                "minNumberOfMatches": 0,
                "minInputTrackLength": 5,
                "minNumberOfObservationsForTriangulation": 3,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "maxReprojectionError": 4.0,
                "minAngleInitialPair": 5.0,
                "maxAngleInitialPair": 40.0,
                "useOnlyMatchesFromInputFolder": false,
                "useRigConstraint": true,
                "rigMinNbCamerasForCalibration": 20,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "filterTrackForks": true,
                "computeStructureColor": true,
                "useAutoTransform": false,
                "initialPairA": "",
                "initialPairB": "",
                "interFileExtension": ".abc",
                "logIntermediateSteps": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "Estimate cameras parameters for the complete camera tracking sequence.",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfm.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm",
                "extraInfoFolder": "{nodeCacheFolder}"
            }
        }
    }
}