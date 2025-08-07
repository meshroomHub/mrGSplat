{
    "header": {
        "releaseVersion": "2025.1.0-develop",
        "fileVersion": "2.0",
        "nodesVersions": {
            "ApplyCalibration": "1.0",
            "CameraInit": "12.0",
            "ConvertSfMFormat": "2.0",
            "ExportImages": "1.0",
            "ExtractPosesFromSfm": "1.0",
            "FeatureExtraction": "1.3",
            "FeatureMatching": "2.0",
            "GaussianSplattingOptim": "1.0",
            "GaussianSplattingRender": "1.0",
            "ImageMatching": "2.0",
            "ImageMatchingMultiSfM": "1.0",
            "IntrinsicsTransforming": "1.0",
            "KeyframeSelection": "5.0",
            "PrepareImagesForGSplat": "1.0",
            "RelativePoseEstimating": "3.0",
            "SfMBootStrapping": "4.0",
            "SfMColorizing": "1.0",
            "SfMExpanding": "2.0",
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
                359.0,
                757.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "8210e9931d6fa343350d8a48cbff4d3d470b5ddc",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{CameraInit_2.output}",
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
        "CameraInit_2": {
            "nodeType": "CameraInit",
            "position": [
                145.0,
                757.5
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
                "label": "InitShot",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/cameraInit.sfm"
            }
        },
        "CameraInit_4": {
            "nodeType": "CameraInit",
            "position": [
                77.0,
                242.5
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
                "label": "InitPhotogrammetry",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/cameraInit.sfm"
            }
        },
        "ConvertSfMFormat_8": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                3039.0,
                304.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "087ea163fcdb3050f0ff42690ef1dde934b073d8",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMTransfer_1.output}",
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
        "ExportImages_2": {
            "nodeType": "ExportImages",
            "position": [
                2570.5,
                200.5
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "1dfda1b2fe841f33c4b5cac1c429bc8b3951228c",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{IntrinsicsTransforming_2.input}",
                "target": "{IntrinsicsTransforming_2.output}",
                "outputFileType": "exr",
                "evCorrection": false,
                "namingMode": "viewid",
                "masksFolders": [],
                "maskExtension": "exr",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "undistorted": "{nodeCacheFolder}/<VIEW_ID>.{outputFileTypeValue}",
                "outputSfMData": "{nodeCacheFolder}/sfm.abc"
            }
        },
        "ExtractPosesFromSfm_1": {
            "nodeType": "ExtractPosesFromSfm",
            "position": [
                4273,
                804
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "fad913b03bcac074009f92a08a2000d4868addc2",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "sfmData": "{SfMExpanding_6.outputViewsAndPoses}",
                "referenceSfmData": "{ApplyCalibration_2.output}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputSfmFile": "{nodeCacheFolder}/sfm.json"
            }
        },
        "FeatureExtraction_3": {
            "nodeType": "FeatureExtraction",
            "position": [
                598.0,
                858.5
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "0b182a5cb95ddd25db25fe260ab52f43e47e0f07",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ApplyCalibration_2.output}",
                "masksFolder": "",
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
        "FeatureExtraction_4": {
            "nodeType": "FeatureExtraction",
            "position": [
                277.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "69336c00f762b7c56a716fa98d19af38e4fc4673",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{CameraInit_4.output}",
                "masksFolder": "",
                "maskExtension": "png",
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
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "FeatureMatching_10": {
            "nodeType": "FeatureMatching",
            "position": [
                2293.0,
                566.5
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "6cd85c609892be17341648f3809b35cec7f1e0a3",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatchingMultiSfM_4.outputCombinedSfM}",
                "featuresFolders": "{ImageMatchingMultiSfM_4.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_4.output}",
                "describerTypes": "{FeatureExtraction_3.describerTypes}",
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
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "FeatureMatching_6": {
            "nodeType": "FeatureMatching",
            "position": [
                1172.0,
                731.5
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "cd997454d131aa0e8c96313720cecb4affadf2a4",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatching_4.input}",
                "featuresFolders": "{ImageMatching_4.featuresFolders}",
                "imagePairsList": "{ImageMatching_4.output}",
                "describerTypes": "{FeatureExtraction_3.describerTypes}",
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
                3426.0,
                1068.5
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "3df5d05f2c27dce26c175416d7d4505b22d51f2c",
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
                3426.0,
                913.5
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "b396a50e62b2b4a7b7e2b47b9d85aba740946290",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatchingMultiSfM_3.outputCombinedSfM}",
                "featuresFolders": "{ImageMatchingMultiSfM_3.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_3.output}",
                "describerTypes": "{FeatureExtraction_3.describerTypes}",
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
        "FeatureMatching_9": {
            "nodeType": "FeatureMatching",
            "position": [
                677.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 0,
                "split": 0
            },
            "uid": "e9c56d201b27b36a647e5609dcc03c66f7b07891",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageMatching_6.input}",
                "featuresFolders": "{ImageMatching_6.featuresFolders}",
                "imagePairsList": "{ImageMatching_6.output}",
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
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "GaussianSplattingOptim_4": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                4276.0,
                381.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "8a01c14687560f186446fbad2ce2eb05c2fa6dd5",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat==sonoleta aliceVision==sonoleta",
                "sfm": "{PrepareImagesForGSplat_2.outputSfmFile}",
                "mesh": "",
                "dataFactor": 1,
                "masksFolder": "",
                "metadataFolder": "",
                "resumeCheckpoint": "",
                "n_steps": 6000,
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
                "model": "{nodeCacheFolder}/ckpts/ckpt_5999_rank0.pt",
                "optimizedPoses": "{nodeCacheFolder}/ckpts/poses5999.sfm"
            }
        },
        "GaussianSplattingRender_5": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                4535.0,
                602.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "f4a1e08acd01fc36135da13f00f6ff46796da4fb",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "rezEnvName": "gsplat==sonoleta aliceVision==sonoleta",
                "cameras": "{ExtractPosesFromSfm_1.outputSfmFile}",
                "model": "{GaussianSplattingOptim_4.model}",
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
        "ImageMatchingMultiSfM_3": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                3223.0,
                895.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "268040578f604005c44d67396584ae042a7e2dce",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{KeyframeSelection_2.outputSfMDataFrames}",
                "inputB": "{SfMExpanding_5.output}",
                "featuresFolders": "{TracksBuilding_5.featuresFolders}",
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
        "ImageMatchingMultiSfM_4": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                2097.0,
                574.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "8305abc020df06c961bef357103dbb08e6eb159d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{KeyframeSelection_2.outputSfMDataKeyframes}",
                "inputB": "{SfMColorizing_6.output}",
                "featuresFolders": [
                    "{FeatureExtraction_4.output}",
                    "{FeatureExtraction_3.output}"
                ],
                "method": "Exhaustive",
                "tree": "${ALICEVISION_VOCTREE}",
                "weights": "",
                "matchingMode": "a/b",
                "minNbImages": 200,
                "maxDescriptors": 500,
                "nbMatches": 40,
                "nbNeighbors": 5,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/imageMatches.txt",
                "outputCombinedSfM": "{nodeCacheFolder}/combineSfM.sfm"
            }
        },
        "ImageMatching_4": {
            "nodeType": "ImageMatching",
            "position": [
                906.0,
                753.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "81d11f32878ba634ae31ecd420825726060dd515",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{KeyframeSelection_2.outputSfMDataKeyframes}",
                "featuresFolders": [
                    "{FeatureExtraction_3.output}"
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
                3226.0,
                1068.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "0dec801435135c1289198de3a3afef13556bf960",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ApplyCalibration_2.output}",
                "featuresFolders": [
                    "{FeatureExtraction_3.output}"
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
        "ImageMatching_6": {
            "nodeType": "ImageMatching",
            "position": [
                477.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "a6b23f4a5caec2174ff9db1e13f287dad55bca7f",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureExtraction_4.input}",
                "featuresFolders": [
                    "{FeatureExtraction_4.output}"
                ],
                "method": "SequentialAndVocabularyTree",
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
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/imageMatches.txt"
            }
        },
        "IntrinsicsTransforming_2": {
            "nodeType": "IntrinsicsTransforming",
            "position": [
                2288.5,
                211.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "8a2464d2500f029933d48ca746f1491b17781933",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMColorizing_6.output}",
                "inputTracks": "",
                "type": "pinhole",
                "fakeFov": 90.0,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmData.abc",
                "outputTracks": "{nodeCacheFolder}/tracksFile.json"
            }
        },
        "KeyframeSelection_2": {
            "nodeType": "KeyframeSelection",
            "position": [
                605.0,
                549.5
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
        "PrepareImagesForGSplat_2": {
            "nodeType": "PrepareImagesForGSplat",
            "position": [
                3993.0,
                247.5
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 0,
                "split": 0
            },
            "uid": "820f73dcaef5fb7bae257b1e5745416c4b1f84cf",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "sfmData": "{ConvertSfMFormat_8.output}",
                "maskFolder": "",
                "referenceSfm": "",
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
                "label": "Scale_1",
                "color": "#3D6953"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "outputSfmFile": "{nodeCacheFolder}/sfm.json",
                "outputImageFolder": "{nodeCacheFolder}/images",
                "outputMasksFolder": "{nodeCacheFolder}/masks"
            }
        },
        "RelativePoseEstimating_2": {
            "nodeType": "RelativePoseEstimating",
            "position": [
                1077.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 25,
                "size": 0,
                "split": 0
            },
            "uid": "0e1d8f42f5aff0bd2e6364c291265248ec854d6a",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{TracksBuilding_4.input}",
                "tracksFilename": "{TracksBuilding_4.output}",
                "enforcePureRotation": false,
                "countIterations": 1024,
                "minInliers": 100,
                "imagePairsList": "{FeatureMatching_9.imagePairsList}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}"
            }
        },
        "SfMBootStrapping_2": {
            "nodeType": "SfMBootStrapping",
            "position": [
                1277.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "50c136d8f77441aabfa7a9620dcb78822ca3bf0b",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{RelativePoseEstimating_2.input}",
                "tracksFilename": "{RelativePoseEstimating_2.tracksFilename}",
                "meshFilename": "",
                "pairs": "{RelativePoseEstimating_2.output}",
                "minAngleInitialPair": 5.0,
                "maxAngleInitialPair": 40.0,
                "initialPairA": "",
                "initialPairB": "",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/bootstrap.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "SfMColorizing_6": {
            "nodeType": "SfMColorizing",
            "position": [
                1860.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "559b663588db62d6a085096ddd103b8b3b35f4ac",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMTransform_2.output}",
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmData.abc"
            }
        },
        "SfMExpanding_4": {
            "nodeType": "SfMExpanding",
            "position": [
                1477.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "99a6bba0cd53e524431155d83eabdfc855a563aa",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMBootStrapping_2.output}",
                "tracksFilename": "{SfMBootStrapping_2.tracksFilename}",
                "meshFilename": "{SfMBootStrapping_2.meshFilename}",
                "localizerEstimatorMaxIterations": 50000,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": false,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 30,
                "maxImagesPerGroup": 30,
                "bundleAdjustmentMaxOutliers": 50,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 3.0,
                "minAngleForLandmark": 2.0,
                "maxReprojectionError": 4.0,
                "lockAllIntrinsics": false,
                "minNbCamerasToRefinePrincipalPoint": 3,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "SfMExpandingPhotog",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmExpanded.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "SfMExpanding_5": {
            "nodeType": "SfMExpanding",
            "position": [
                2961.0,
                707.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "c51826e96c9ef39ae09a790b99884af16d60d033",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{TracksBuilding_5.input}",
                "tracksFilename": "{TracksMerging_4.output}",
                "meshFilename": "",
                "localizerEstimatorMaxIterations": 50000,
                "localizerEstimatorError": 0.0,
                "lockScenePreviouslyReconstructed": true,
                "useLocalBA": true,
                "localBAGraphDistance": 1,
                "nbFirstUnstableCameras": 30,
                "maxImagesPerGroup": 30,
                "bundleAdjustmentMaxOutliers": 50,
                "minNumberOfObservationsForTriangulation": 2,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "maxReprojectionError": 4.0,
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
        "SfMExpanding_6": {
            "nodeType": "SfMExpanding",
            "position": [
                4020.0,
                896.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "32537532b68015bbfc27f86a63d451ff7c0b836b",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{TracksBuilding_6.input}",
                "tracksFilename": "{TracksMerging_3.output}",
                "meshFilename": "",
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
        "SfMTransfer_1": {
            "nodeType": "SfMTransfer",
            "position": [
                2798.0,
                297.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "fcf742eaaf932099c6a7d2be84aba88c0688c6b3",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ExportImages_2.outputSfMData}",
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
        "SfMTransform_2": {
            "nodeType": "SfMTransform",
            "position": [
                1674.0,
                241.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "002d205b2c75d34f7d0683d50e321999626570df",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{SfMExpanding_4.output}",
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
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/sfmExpanded.abc",
                "outputViewsAndPoses": "{nodeCacheFolder}/cameras.sfm"
            }
        },
        "TracksBuilding_4": {
            "nodeType": "TracksBuilding",
            "position": [
                877.0,
                242.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "67daa9c4603bfdeda2f2b6f1c3c40966a48efe6f",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_9.input}",
                "featuresFolders": "{FeatureMatching_9.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_9.output}"
                ],
                "describerTypes": "{FeatureMatching_9.describerTypes}",
                "minInputTrackLength": 2,
                "useOnlyMatchesFromInputFolder": false,
                "filterTrackForks": false,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#384a55"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/tracksFile.json"
            }
        },
        "TracksBuilding_5": {
            "nodeType": "TracksBuilding",
            "position": [
                2566.0,
                759.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "adbb3ea510542f79108f69c9834cf11db39228aa",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_10.input}",
                "featuresFolders": "{FeatureMatching_10.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_6.output}",
                    "{FeatureMatching_10.output}"
                ],
                "describerTypes": "{FeatureMatching_10.describerTypes}",
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
        "TracksBuilding_6": {
            "nodeType": "TracksBuilding",
            "position": [
                3626.0,
                913.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 0,
                "split": 1
            },
            "uid": "7517fa105bc783116faa4e9c70fc3dcd6c69ef86",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{FeatureMatching_8.input}",
                "featuresFolders": "{FeatureMatching_8.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_8.output}",
                    "{FeatureMatching_7.output}"
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
                3822.0,
                852.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "d0bea3620949c24945bec94d90f80c2cc24102a3",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "inputs": [
                    "{TracksBuilding_6.output}",
                    "{SfMExpanding_5.tracksFilename}"
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
        },
        "TracksMerging_4": {
            "nodeType": "TracksMerging",
            "position": [
                2764.0,
                732.5
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "ef858b90fd2bee53ea974fa7d5e90a8e2eb67eca",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "inputs": [
                    "{TracksBuilding_5.output}",
                    "{TracksBuilding_4.output}"
                ],
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": "#575963"
            },
            "outputs": {
                "output": "{nodeCacheFolder}/tracks.json"
            }
        }
    }
}