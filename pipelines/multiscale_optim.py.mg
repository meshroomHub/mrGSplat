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
        },
        "template": true
    },
    "graph": {
        "ApplyCalibration_3": {
            "nodeType": "ApplyCalibration",
            "position": [
                -296,
                988
            ],
            "inputs": {
                "input": "{CameraInit_5.output}"
            },
            "internalInputs": {
                "color": "#575963"
            }
        },
        "CameraInit_5": {
            "nodeType": "CameraInit",
            "position": [
                -512,
                1124
            ],
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
                ]
            },
            "internalInputs": {
                "label": "InitShot",
                "color": "#575963"
            }
        },
        "ConvertSfMFormat_7": {
            "nodeType": "ConvertSfMFormat",
            "position": [
                1268,
                996
            ],
            "inputs": {
                "input": "{StructureFromMotion_7.output}",
                "fileExt": "sfm"
            }
        },
        "FeatureExtraction_4": {
            "nodeType": "FeatureExtraction",
            "position": [
                -91,
                1122
            ],
            "inputs": {
                "input": "{ApplyCalibration_3.output}",
                "maskExtension": "jpg"
            },
            "internalInputs": {
                "color": "#575963"
            }
        },
        "FeatureMatching_7": {
            "nodeType": "FeatureMatching",
            "position": [
                348,
                979
            ],
            "inputs": {
                "input": "{ImageMatching_5.input}",
                "featuresFolders": "{ImageMatching_5.featuresFolders}",
                "imagePairsList": "{ImageMatching_5.output}",
                "describerTypes": "{FeatureExtraction_4.describerTypes}"
            },
            "internalInputs": {
                "label": "FeatureMatchingKeyframes",
                "color": "#575963"
            }
        },
        "FeatureMatching_9": {
            "nodeType": "FeatureMatching",
            "position": [
                909,
                989
            ],
            "inputs": {
                "input": "{ImageMatchingMultiSfM_4.outputCombinedSfM}",
                "featuresFolders": "{StructureFromMotion_6.featuresFolders}",
                "imagePairsList": "{ImageMatchingMultiSfM_4.output}",
                "describerTypes": "{StructureFromMotion_6.describerTypes}"
            },
            "internalInputs": {
                "label": "FeatureMatchingFramesToKeyframes",
                "color": "#80766f"
            }
        },
        "GaussianSplattingOptim_1": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                2006.0,
                922.0
            ],
            "inputs": {
                "sfm": "{PrepareFolderForGS_2.outputFolder}",
                "resumeCheckpoint": "{GaussianSplattingOptim_3.model}",
                "n_steps": 300,
                "dataFactor": 1,
                "save_steps": [
                    3000
                ],
                "use_masks": false
            },
            "internalInputs": {
                "invalidation": "new env C",
                "color": "#2CB9CC"
            }
        },
        "GaussianSplattingOptim_3": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                1826,
                1037
            ],
            "inputs": {
                "sfm": "{PrepareFolderForGS_1.outputFolder}",
                "n_steps": 3000,
                "dataFactor": 8,
                "save_steps": [
                    3000
                ],
                "use_masks": false,
                "pose_opt": true
            },
            "internalInputs": {
                "invalidation": "new env C",
                "color": "#2CB9CC"
            }
        },
        "GaussianSplattingRender_1": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                2207.0,
                913.0
            ],
            "inputs": {
                "cameras": "{GaussianSplattingOptim_1.sfm}",
                "model": "{GaussianSplattingOptim_1.model}"
            },
            "internalInputs": {
                "color": "#2CB9CC"
            }
        },
        "GaussianSplattingRender_4": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                2015,
                1040
            ],
            "inputs": {
                "rezEnvName": "{GaussianSplattingOptim_3.rezEnvName}",
                "cameras": "{GaussianSplattingOptim_3.sfm}",
                "model": "{GaussianSplattingOptim_3.model}"
            },
            "internalInputs": {
                "color": "#2CB9CC"
            }
        },
        "ImageMatchingMultiSfM_4": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                724,
                981
            ],
            "inputs": {
                "input": "{StructureFromMotion_6.output}",
                "inputB": "{KeyframeSelection_3.outputSfMDataFrames}",
                "featuresFolders": "{StructureFromMotion_6.featuresFolders}",
                "method": "VocabularyTree",
                "matchingMode": "a/b",
                "nbMatches": 20
            },
            "internalInputs": {
                "color": "#80766f"
            }
        },
        "ImageMatching_5": {
            "nodeType": "ImageMatching",
            "position": [
                147,
                979
            ],
            "inputs": {
                "input": "{KeyframeSelection_3.outputSfMDataKeyframes}",
                "featuresFolders": [
                    "{FeatureExtraction_4.output}"
                ],
                "method": "Exhaustive"
            },
            "internalInputs": {
                "label": "ImageMatchingKeyframes",
                "color": "#575963"
            }
        },
        "KeyframeSelection_3": {
            "nodeType": "KeyframeSelection",
            "position": [
                -90,
                982
            ],
            "inputs": {
                "inputPaths": [
                    "{ApplyCalibration_3.output}"
                ]
            },
            "internalInputs": {
                "color": "#575963"
            }
        },
        "Meshroom2ColmapSfmConvertions_3": {
            "nodeType": "Meshroom2ColmapSfmConvertions",
            "position": [
                1451,
                990
            ],
            "inputs": {
                "input": "{ConvertSfMFormat_7.output}"
            }
        },
        "PrepareFolderForGS_1": {
            "nodeType": "PrepareFolderForGS",
            "position": [
                1636,
                1041
            ],
            "inputs": {
                "colmapFolder": "{Meshroom2ColmapSfmConvertions_3.output}",
                "scale": [
                    "2",
                    "4",
                    "8",
                    "1"
                ],
                "selectedScale": "8"
            },
            "internalInputs": {
                "color": "#E35C03"
            }
        },
        "PrepareFolderForGS_2": {
            "nodeType": "PrepareFolderForGS",
            "position": [
                1639.0,
                933.0
            ],
            "inputs": {
                "colmapFolder": "{PrepareFolderForGS_1.colmapFolder}",
                "scale": [
                    "1"
                ]
            },
            "internalInputs": {
                "color": "#E35C03"
            }
        },
        "RomaWarp_1": {
            "nodeType": "RomaWarp",
            "position": [
                -265,
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
                547,
                979
            ],
            "inputs": {
                "input": "{FeatureMatching_7.input}",
                "featuresFolders": "{FeatureMatching_7.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_7.output}"
                ],
                "describerTypes": "{FeatureMatching_7.describerTypes}",
                "lockScenePreviouslyReconstructed": true,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "filterTrackForks": true,
                "useAutoTransform": false
            },
            "internalInputs": {
                "comment": "Solve all keyframes first.",
                "label": "StructureFromMotionKeyframes",
                "color": "#575963"
            }
        },
        "StructureFromMotion_7": {
            "nodeType": "StructureFromMotion",
            "position": [
                1093,
                993
            ],
            "inputs": {
                "input": "{FeatureMatching_9.input}",
                "featuresFolders": "{FeatureMatching_9.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_9.output}"
                ],
                "describerTypes": "{FeatureMatching_9.describerTypes}",
                "nbFirstUnstableCameras": 0,
                "maxImagesPerGroup": 0,
                "bundleAdjustmentMaxOutliers": -1,
                "minInputTrackLength": 5,
                "minNumberOfObservationsForTriangulation": 3,
                "minAngleForTriangulation": 1.0,
                "minAngleForLandmark": 0.5,
                "filterTrackForks": true,
                "useAutoTransform": false
            },
            "internalInputs": {
                "comment": "Estimate cameras parameters for the complete camera tracking sequence.",
                "color": "#80766f"
            }
        }
    }
}