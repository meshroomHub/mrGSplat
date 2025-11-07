{
    "header": {
        "releaseVersion": "2026.1.0+develop",
        "fileVersion": "2.0",
        "nodesVersions": {
            "CameraInit": "12.0",
            "ExportImages": "1.1",
            "FeatureExtraction": "1.3",
            "FeatureMatching": "2.0",
            "GaussianSplattingOptim": "1.0",
            "GaussianSplattingRender": "1.0",
            "ImageMatching": "2.0",
            "IntrinsicsTransforming": "1.1",
            "RelativePoseEstimating": "3.1",
            "SfMBootStrapping": "4.1",
            "SfMColorizing": "1.0",
            "SfMExpanding": "2.3",
            "SfMTransform": "3.2",
            "TracksBuilding": "1.0"
        },
        "template": true
    },
    "graph": {
        "CameraInit_1": {
            "nodeType": "CameraInit",
            "position": [
                0,
                0
            ],
            "inputs": {}
        },
        "ExportImages_1": {
            "nodeType": "ExportImages",
            "position": [
                2208.5,
                -10.0
            ],
            "inputs": {
                "input": "{IntrinsicsTransforming_1.input}",
                "target": "{IntrinsicsTransforming_1.output}",
                "maskExtension": "exr"
            }
        },
        "FeatureExtraction_1": {
            "nodeType": "FeatureExtraction",
            "position": [
                200,
                0
            ],
            "inputs": {
                "input": "{CameraInit_1.output}"
            }
        },
        "FeatureMatching_1": {
            "nodeType": "FeatureMatching",
            "position": [
                600,
                0
            ],
            "inputs": {
                "input": "{ImageMatching_1.input}",
                "featuresFolders": "{ImageMatching_1.featuresFolders}",
                "imagePairsList": "{ImageMatching_1.output}",
                "describerTypes": "{FeatureExtraction_1.describerTypes}"
            }
        },
        "GaussianSplattingOptim_1": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                2404,
                -14
            ],
            "inputs": {
                "sfm_file": "{ExportImages_1.outputSfMData}",
                "image_alpha": true,
                "max_steps": 10000
            }
        },
        "GaussianSplattingRender_1": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                2602,
                -14
            ],
            "inputs": {
                "cameras": "{GaussianSplattingOptim_1.sfm_file}",
                "model": "{GaussianSplattingOptim_1.model}"
            }
        },
        "ImageMatching_1": {
            "nodeType": "ImageMatching",
            "position": [
                400,
                0
            ],
            "inputs": {
                "input": "{FeatureExtraction_1.input}",
                "featuresFolders": [
                    "{FeatureExtraction_1.output}"
                ]
            }
        },
        "IntrinsicsTransforming_1": {
            "nodeType": "IntrinsicsTransforming",
            "position": [
                2007.5,
                -10.0
            ],
            "inputs": {
                "input": "{SfMColorizing_2.output}"
            }
        },
        "RelativePoseEstimating_1": {
            "nodeType": "RelativePoseEstimating",
            "position": [
                1000,
                0
            ],
            "inputs": {
                "input": "{TracksBuilding_1.input}",
                "tracksFilename": "{TracksBuilding_1.output}",
                "minInliers": 100,
                "imagePairsList": "{FeatureMatching_1.imagePairsList}"
            }
        },
        "SfMBootStrapping_1": {
            "nodeType": "SfMBootStrapping",
            "position": [
                1200,
                0
            ],
            "inputs": {
                "input": "{RelativePoseEstimating_1.input}",
                "tracksFilename": "{RelativePoseEstimating_1.tracksFilename}",
                "pairs": "{RelativePoseEstimating_1.output}"
            }
        },
        "SfMColorizing_2": {
            "nodeType": "SfMColorizing",
            "position": [
                1800,
                0
            ],
            "inputs": {
                "input": "{SfMTransform_1.output}"
            }
        },
        "SfMExpanding_1": {
            "nodeType": "SfMExpanding",
            "position": [
                1400,
                0
            ],
            "inputs": {
                "input": "{SfMBootStrapping_1.output}",
                "tracksFilename": "{SfMBootStrapping_1.tracksFilename}",
                "meshFilename": "{SfMBootStrapping_1.meshFilename}"
            }
        },
        "SfMTransform_1": {
            "nodeType": "SfMTransform",
            "position": [
                1600,
                0
            ],
            "inputs": {
                "input": "{SfMExpanding_1.output}"
            }
        },
        "TracksBuilding_1": {
            "nodeType": "TracksBuilding",
            "position": [
                800,
                0
            ],
            "inputs": {
                "input": "{FeatureMatching_1.input}",
                "featuresFolders": "{FeatureMatching_1.featuresFolders}",
                "matchesFolders": [
                    "{FeatureMatching_1.output}"
                ],
                "describerTypes": "{FeatureMatching_1.describerTypes}"
            }
        }
    }
}