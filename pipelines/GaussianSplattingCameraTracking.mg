{
    "header": {
        "releaseVersion": "2025.1.0",
        "fileVersion": "2.0",
        "nodesVersions": {
            "ApplyCalibration": "1.0",
            "CameraInit": "12.0",
            "ConvertSfMFormat": "2.0",
            "ExportImages": "1.0",
            "FeatureExtraction": "1.3",
            "FeatureMatching": "2.0",
            "FilterMasks": "1.0",
            "GaussianSplattingOptim": "1.0",
            "GaussianSplattingRender": "1.0",
            "ImageDetectionPrompt": "0.1",
            "ImageMatching": "2.0",
            "ImageMatchingMultiSfM": "1.0",
            "ImageSegmentationBox": "0.2",
            "IntrinsicsTransforming": "1.0",
            "KeyframeSelection": "5.0",
            "PrepareImagesForGSplat": "1.0",
            "RelativePoseEstimating": "3.0",
            "SfMBootStrapping": "4.1",
            "SfMColorizing": "1.0",
            "SfMExpanding": "2.1",
            "SfMTransfer": "2.1",
            "SfMTransform": "3.1",
            "TracksBuilding": "1.0",
            "TracksMerging": "3.0"
        }
    },
    "graph": {
        "ApplyCalibration_2": {
            "nodeType": "ApplyCalibration",
            "position": [
                456,
                2335
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "8210e9931d6fa343350d8a48cbff4d3d470b5ddc",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{CameraInit_1.output}",
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
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                151,
                2536
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "59614963ab66dcbdd672ffc787b91949031774a4",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "viewpoints": [],
                "intrinsics": [],
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
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{nodeCacheFolder}/cameraInit.sfm"
            }
        },
        "ConvertSfMFormat_8": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                4173.75,
                2506.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "1ec1f0a7e3709509dbc9ffde07becf24f690cd72",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMTransfer_2.output}",
                "fileExt": "json",
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
        "ExportImages_3": {
            "nodeType": "ExportImages",
            "position": [
                3759.5,
                2450.0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "6e70b9330606e99617a8846cc747f13f4c3ab559",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{IntrinsicsTransforming_2.input}",
                "target": "{IntrinsicsTransforming_2.output}",
                "outputFileType": "exr",
                "evCorrection": false,
                "namingMode": "viewid",
                "masksFolders": [],
                "maskExtension": "png",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "undistorted": "{nodeCacheFolder}/<VIEW_ID>.{outputFileTypeValue}",
                "outputSfMData": "{nodeCacheFolder}/sfm.abc"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                896,
                2534
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "0f2ae7957a005baae032e0bfbba048f98c06caf6",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ApplyCalibration_2.output}",
                "masksFolder": "{ImageSegmentationBox_1.output}",
                "maskExtension": "exr",
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
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                1096,
                2334
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "467983e5ccd97da374d1dc4637af23c3da580891",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}",
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
        "FeatureMatching_7": {
            "nodeType": "FeatureMatching",
            "position": [
                2296,
                2694
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "4f9b795d7be7c266171fba52cabc595c02ec13e1",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatching_5.input}",
                "featuresFolders": "{ImageMatching_5.featuresFolders}",
                "imagePairsList": "{ImageMatching_5.output}",
                "describerTypes": [
                    "dspsift"
                ],
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
                "label": "FeatureMatchingAllFrames",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "FeatureMatching_8": {
            "nodeType": "FeatureMatching",
            "position": [
                2296,
                2534
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "7a18b3d11d7dfd3e19f1cf06015530b68ff8f8ab",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatchingMultiSfM_3.outputCombinedSfM}",
                "featuresFolders": "{ImageMatchingMultiSfM_3.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_3.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}",
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
        "FilterMasks_2": {
            "nodeType": "FilterMasks",
            "position": [
                4053,
                2750
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "7939092ed35d8db879b60bf9c25a63ef553689bb",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "maskFolder": "{ImageSegmentationBox_1.output}",
                "inputSfM": "{ImageSegmentationBox_1.input}",
                "filterType": "erosion",
                "keepFilename": true,
                "extension": "exr",
                "kernel_size": 10,
                "kernel_shape": "rect",
                "iterations": 5,
                "use_of": false,
                "smoothing_strength": 0.05,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#B61518"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.exr"
            }
        },
        "GaussianSplattingOptim_3": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                4648.5,
                2665.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "c17e8f02e75003db21aa755b46496335fedbd055",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat aliceVision",
                "sfm": "{PrepareImagesForGSplat_1.outputSfmFile}",
                "mesh": "",
                "dataFactor": 2,
                "masksFolder": "{PrepareImagesForGSplat_1.outputMasksFolder}",
                "metadataFolder": "",
                "resumeCheckpoint": "",
                "n_steps": 5000,
                "custom_ckpts": false,
                "save_steps": [],
                "pose_opt": false
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#E35C03"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "model": "{nodeCacheFolder}/ckpts/ckpt_4999_rank0.pt",
                "optimizedPoses": "{nodeCacheFolder}/ckpts/poses4999.sfm"
            }
        },
        "GaussianSplattingOptim_7": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                4863.0,
                2471.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "11bde61f086ce94c656d3c33c4a64ef07e924522",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat aliceVision",
                "sfm": "{PrepareImagesForGSplat_2.outputSfmFile}",
                "mesh": "",
                "dataFactor": 1,
                "masksFolder": "{PrepareImagesForGSplat_2.outputMasksFolder}",
                "metadataFolder": "",
                "resumeCheckpoint": "{GaussianSplattingOptim_3.model}",
                "n_steps": 15000,
                "custom_ckpts": false,
                "save_steps": [],
                "pose_opt": false
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#E35C03"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "model": "{nodeCacheFolder}/ckpts/ckpt_14999_rank0.pt",
                "optimizedPoses": "{nodeCacheFolder}/ckpts/poses14999.sfm"
            }
        },
        "GaussianSplattingRender_8": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                5084.0,
                2478.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "de0a880575675985c52d25b1ae1c5ed6195a8eac",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat aliceVision",
                "cameras": "{GaussianSplattingOptim_7.sfm}",
                "model": "{GaussianSplattingOptim_7.model}",
                "resolutionFactor": 1,
                "outputFormat": ".jpg",
                "outputColorspace": "AUTO"
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
        "ImageDetectionPrompt_2": {
            "nodeType": "ImageDetectionPrompt",
            "position": [
                431.0,
                2821.0
            ],
            "parallelization": {
                "blockSize": 50,
                "size": 0,
                "split": 0
            },
            "uid": "4b36539cd7890052605eb1c3ad338fd37798e685",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{CameraInit_1.output}",
                "recognitionModelPath": "${RDS_RECOGNITION_MODEL_PATH}",
                "detectionModelPath": "${RDS_DETECTION_MODEL_PATH}",
                "detectionConfigPath": "${RDS_DETECTION_CONFIG_PATH}",
                "prompt": "person",
                "synonyms": "man\nwoman\nboy\ngirl\nhuman\npeople",
                "forceDetection": false,
                "thresholdDetection": 0.2,
                "bboxMargin": 0,
                "useGpu": true,
                "outputBboxImage": false,
                "keepFilename": false,
                "extension": "jpg",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#B61518"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "bboxes": "{nodeCacheFolder}/<VIEW_ID>.jpg"
            }
        },
        "ImageMatchingMultiSfM_3": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                2096,
                2534
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "7fa61be1fe1fd157f0b9de396a2303e9f41d53dc",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{KeyframeSelection_2.outputSfMDataFrames}",
                "inputB": "{SfMExpanding_1.output}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
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
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                896,
                2334
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "8b0ae558694e4978726c759f70b839417d4e50d9",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{KeyframeSelection_2.outputSfMDataKeyframes}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
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
        "ImageMatching_5": {
            "nodeType": "ImageMatching",
            "position": [
                2096,
                2694
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "8f0f127876a04b725ba437057ec15f7eb680cb09",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ApplyCalibration_2.output}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ],
                "method": "Sequential",
                "tree": "${ALICEVISION_VOCTREE}",
                "weights": "",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 40,
                "nbNeighbors": 20,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/imageMatches.txt"
            }
        },
        "ImageSegmentationBox_1": {
            "nodeType": "ImageSegmentationBox",
            "position": [
                631.0,
                2821.0
            ],
            "parallelization": {
                "blockSize": 50,
                "size": 0,
                "split": 0
            },
            "uid": "bbe75dbe83c207b707fb3e19bda9c4ecced49b8d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageDetectionPrompt_2.input}",
                "bboxFolder": "{ImageDetectionPrompt_2.output}",
                "nukeTracker": "",
                "segmentationModelPath": "${RDS_SEGMENTATION_MODEL_PATH}",
                "maskInvert": true,
                "useGpu": true,
                "keepFilename": true,
                "extension": "exr",
                "outputBboxImage": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#B61518"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.exr",
                "bboxes": "{nodeCacheFolder}/bboxes_<FILESTEM>.jpg"
            }
        },
        "IntrinsicsTransforming_2": {
            "nodeType": "IntrinsicsTransforming",
            "position": [
                3546.5,
                2548.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "67e774e871f0e6f1db3edf839c769720d0535055",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMColorizing_3.output}",
                "inputTracks": "",
                "type": "pinhole",
                "fakeFov": 90.0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmData.abc",
                "outputTracks": "{nodeCacheFolder}/tracksFile.json"
            }
        },
        "KeyframeSelection_2": {
            "nodeType": "KeyframeSelection",
            "position": [
                663,
                2221
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "209772be4c687d4239db6db429fc0b211ce7a17f",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "inputPaths": [
                    "{ApplyCalibration_2.output}"
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
        "PrepareImagesForGSplat_1": {
            "nodeType": "PrepareImagesForGSplat",
            "position": [
                4432.5,
                2658.0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "2e75681acba9379d5b1bfcb00952278b84f0f12d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "sfmData": "{ConvertSfMFormat_8.output}",
                "maskFolder": "{FilterMasks_2.outputFolder}",
                "referenceSfm": "{FilterMasks_2.inputSfM}",
                "scale": "2",
                "colorspaces": {
                    "inputColorspace": "AUTO",
                    "outputColorspace": "AUTO"
                },
                "forceExtension": "keep",
                "verboseLevel": "info",
                "forcePinhole": true
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#3D6953"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputSfmFile": "{nodeCacheFolder}/sfm.json",
                "outputImages": "{nodeCacheFolder}/images/*",
                "outputImageFolder": "{nodeCacheFolder}/images",
                "outputMasks": "{nodeCacheFolder}/masks/*",
                "outputMasksFolder": "{nodeCacheFolder}/masks"
            }
        },
        "PrepareImagesForGSplat_2": {
            "nodeType": "PrepareImagesForGSplat",
            "position": [
                4433.0,
                2483.0
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "306ac5399fb012cc683a1eef5531ea48aa64f53c",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "sfmData": "{ConvertSfMFormat_8.output}",
                "maskFolder": "{FilterMasks_2.outputFolder}",
                "referenceSfm": "{FilterMasks_2.inputSfM}",
                "scale": "1",
                "colorspaces": {
                    "inputColorspace": "AUTO",
                    "outputColorspace": "AUTO"
                },
                "forceExtension": "keep",
                "verboseLevel": "info",
                "forcePinhole": true
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#3D6953"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputSfmFile": "{nodeCacheFolder}/sfm.json",
                "outputImages": "{nodeCacheFolder}/images/*",
                "outputImageFolder": "{nodeCacheFolder}/images",
                "outputMasks": "{nodeCacheFolder}/masks/*",
                "outputMasksFolder": "{nodeCacheFolder}/masks"
            }
        },
        "RelativePoseEstimating_1": {
            "nodeType": "RelativePoseEstimating",
            "position": [
                1496,
                2334
            ],
            "parallelization": {
                "blockSize": 25,
                "size": 0,
                "split": 0
            },
            "uid": "5644b17f9aef566286d053637f496c0d27275960",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{TracksBuilding_1.input}",
                "tracksFilename": "{TracksBuilding_1.output}",
                "enforcePureRotation": false,
                "countIterations": 50000,
                "minInliers": 100,
                "imagePairsList": "{FeatureMatching_1.imagePairsList}",
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
        "SfMBootStrapping_1": {
            "nodeType": "SfMBootStrapping",
            "position": [
                1696,
                2334
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "44a1784bff7173d89a0d047af261c31331db85f8",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{RelativePoseEstimating_1.input}",
                "tracksFilename": "{RelativePoseEstimating_1.tracksFilename}",
                "meshFilename": "",
                "pairs": "{RelativePoseEstimating_1.output}",
                "minAngleSoftInitialPair": 5.0,
                "minAngleHardInitialPair": 1.0,
                "maxAngleInitialPair": 40.0,
                "initialPairA": "",
                "initialPairB": "",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/bootstrap.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "SfMColorizing_3": {
            "nodeType": "SfMColorizing",
            "position": [
                3297.5,
                2536.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "6b26dbcd819499081b2361400d94107031d0d2f4",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMTransform_1.output}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmData.abc"
            }
        },
        "SfMExpanding_1": {
            "nodeType": "SfMExpanding",
            "position": [
                1896,
                2334
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "338f61e9544356dd79c15aab7f4518c2ead0e6d0",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMBootStrapping_1.output}",
                "tracksFilename": "{SfMBootStrapping_1.tracksFilename}",
                "meshFilename": "{SfMBootStrapping_1.meshFilename}",
                "localizerEstimatorMaxIterations": 50000,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 30,
                "maxImagesPerGroup": 30,
                "bundleAdjustmentMaxOutliers": 50,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "maxReprojectionError": 4.0,
                "maxTriangulationError": 8.0,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "Estimate cameras parameters for the keyframes.",
                "label": "SfMExpandingKeys",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmExpanded.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "SfMExpanding_5": {
            "nodeType": "SfMExpanding",
            "position": [
                2896,
                2534
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "a7008324de2820fcf8c0d28fdee695eccb250143",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{TracksBuilding_5.input}",
                "tracksFilename": "{TracksMerging_3.output}",
                "meshFilename": "{SfMExpanding_1.meshFilename}",
                "localizerEstimatorMaxIterations": 50000,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 0,
                "maxImagesPerGroup": 0,
                "bundleAdjustmentMaxOutliers": 5000000,
                "minNumberOfObservationsForTriangulation": 3,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "maxReprojectionError": 4.0,
                "maxTriangulationError": 8.0,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "Estimate cameras parameters for the complete camera tracking sequence.",
                "label": "SfMExpandingAll",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmExpanded.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "SfMTransfer_2": {
            "nodeType": "SfMTransfer",
            "position": [
                3985.75,
                2502.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "ba8353e14999250f84ecc023cf72eb66754e5b88",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ExportImages_3.outputSfMData}",
                "reference": "{IntrinsicsTransforming_2.output}",
                "method": "from_viewid",
                "fileMatchingPattern": ".*\\/(.*?)\\.\\w{3}",
                "metadataMatchingList": [],
                "transferPoses": true,
                "transferIntrinsics": true,
                "transferLandmarks": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfm.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "SfMTransform_1": {
            "nodeType": "SfMTransform",
            "position": [
                3096.5,
                2535.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "9ba6fd3a8000fa0b494bf11e88c264e1c70d2c06",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMExpanding_5.output}",
                "method": "auto",
                "lineUp": "",
                "tracksFile": "",
                "objectFile": "",
                "transformation": "",
                "manualTransform": {
                    "manualTranslation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "manualRotation": {
                        "x": 0.0,
                        "y": 0.0,
                        "z": 0.0
                    },
                    "manualScale": 1.0
                },
                "landmarksDescriberTypes": [
                    "sift",
                    "dspsift",
                    "akaze"
                ],
                "scale": 1.0,
                "markers": [],
                "applyScale": true,
                "applyRotation": true,
                "applyTranslation": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmExpanded.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "TracksBuilding_1": {
            "nodeType": "TracksBuilding",
            "position": [
                1296,
                2334
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "53c2f1dd67b54a6565d146017e4037f0a78104e5",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}",
                "minInputTrackLength": 2,
                "useOnlyMatchesFromInputFolder": false,
                "filterTrackForks": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/tracksFile.json"
            }
        },
        "TracksBuilding_5": {
            "nodeType": "TracksBuilding",
            "position": [
                2496,
                2534
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "ea908a1cdff5fbf721900edd8bdcacca9493b814",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_8.input}",
                "featuresFolders": "{FeatureMatching_8.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_7.output}",
                    "{FeatureMatching_8.output}"
                ],
                "describerTypes": "{FeatureMatching_8.describerTypes}",
                "minInputTrackLength": 5,
                "useOnlyMatchesFromInputFolder": false,
                "filterTrackForks": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/tracksFile.json"
            }
        },
        "TracksMerging_3": {
            "nodeType": "TracksMerging",
            "position": [
                2696,
                2534
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "80947b79b3178b404a702f9dc98ed6fd8bf3571a",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "inputs": [
                    "{TracksBuilding_5.output}",
                    "{SfMExpanding_1.tracksFilename}"
                ],
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#80766f"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/tracks.json"
            }
        }
    }
}