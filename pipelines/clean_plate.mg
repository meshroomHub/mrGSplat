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
            "FilterMasks": "1.0",
            "GaussianSplattingOptim": "1.0",
            "GaussianSplattingRender": "1.0",
            "ImageCompo": "1.0",
            "ImageMatching": "2.0",
            "ImageMatchingMultiSfM": "1.0",
            "ImageProcessing": "3.3",
            "ImageSegmentationPrompt": "0.1",
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
                -4,
                1023
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 15,
                "split": 1
            },
            "uid": "2963cbaa8b8484d4cf72a2a89a2a66bf6a666d53",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageProcessing_1.outSfMData}",
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
                -481,
                1180
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 15,
                "split": 1
            },
            "uid": "5334c61d23e067374aefcfd36b405412ffa26cdd",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "viewpoints": [
                    {
                        "viewId": 278206827,
                        "poseId": 278206827,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254022.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254022.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254022.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254022.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254022.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.297\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"2.06299\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254022\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:50:22\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 316335160,
                        "poseId": 316335160,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254033.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254033.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254033.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254033.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254033.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.27\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254033\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:09\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 330497476,
                        "poseId": 330497476,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254030.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254030.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254030.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254030.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254030.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.275\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254030\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:06\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 535192670,
                        "poseId": 535192670,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254028.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254028.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254028.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254028.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254028.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.277\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254028\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:04\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 535888438,
                        "poseId": 535888438,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254032.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254032.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254032.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254032.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254032.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.272\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254032\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:08\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 614124647,
                        "poseId": 614124647,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254026.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254026.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254026.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254026.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254026.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.282\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99499\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254026\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:02\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 917496925,
                        "poseId": 917496925,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254024.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254024.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254024.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254024.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254024.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.289\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"2.016\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254024\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:00\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 1143621803,
                        "poseId": 1143621803,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254020.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254020.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254020.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254020.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254020.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.302\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"2.07\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254020\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:50:20\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 1176722805,
                        "poseId": 1176722805,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254031.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254031.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254031.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254031.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254031.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.272\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254031\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:07\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 1504772603,
                        "poseId": 1504772603,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254027.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254027.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254027.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254027.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254027.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.28\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.992\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254027\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:03\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 1817117833,
                        "poseId": 1817117833,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254025.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254025.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254025.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254025.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254025.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.287\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"2.005\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254025\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:01\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 1843601845,
                        "poseId": 1843601845,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254034.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254034.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254034.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254034.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254034.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.27\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254034\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:10\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 1992858180,
                        "poseId": 1992858180,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254023.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254023.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254023.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254023.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254023.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.292\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"2.03998\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254023\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:50:23\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 2128904490,
                        "poseId": 2128904490,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254021.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254021.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254021.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254021.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254021.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.299\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"2.06698\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254021\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:50:21\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    },
                    {
                        "viewId": 2129544910,
                        "poseId": 2129544910,
                        "path": "/s/prods/mvg/_source_global/footage/anna/sequences/VFX_035_0040/3424x2202/VFX_035_0040.1254029.exr",
                        "intrinsicId": 3486608314,
                        "rigId": -1,
                        "subPoseId": -1,
                        "metadata": "{\"AliceVision:SensorWidth\": \"28.250000\", \"Copyright\": \"ANNA M\", \"DateTime\": \"2018-02-12 14:07:16\", \"Exif:ImageHistory\": \"oiiotool ./VFX_035_0040.1254029.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254029.exr\", \"ExposureTime\": \"0.02\", \"FNumber\": \"4\", \"ImageDescription\": \"Location:;Operator:;UserInfo1:;UserInfo2:\", \"PixelAspectRatio\": \"1\", \"Software\": \"OpenImageIO 1.8.7 : oiiotool ./VFX_035_0040.1254029.exr --eraseattrib recorderSerialNumber -o ./VFX_035_0040.1254029.exr\", \"adoptedNeutral\": \"0.3127, 0.329\", \"cameraFirmwareVersion\": \"24449\", \"cameraIdentifier\": \"ARRI-ARRI_ALEXA_Mini-SN_R0BX\", \"cameraLabel\": \"B\", \"cameraMake\": \"ARRI\", \"cameraModel\": \"ARRI ALEXA Mini\", \"cameraSerialNumber\": \"20429\", \"captureRate\": \"24000/1000\", \"chromaticities\": \"0.684, 0.313, 0.221, 0.848, 0.0861, -0.102, 0.3127, 0.329\", \"com\": {\"arri\": {\"camera\": {\"AmcVersion\": \"0\", \"ArriUuid\": \"6C474293-DBA2-4553-8DDB-F7CF377903FA\", \"BayerColorOrder\": \"BGGR\", \"ColorGamma\": \"LOG-C\", \"ColorVersion\": \"5\", \"Dst\": \"0\", \"ExrMapVersion\": \"1\", \"FrmLn1AName\": \"AspectRatio:2.39:1_Scaling:97\", \"FrmLnFilename1\": \"MINI_2-39_3-4K_OG_50_CROSS\", \"HardwareVersion\": \"-1\", \"ImageOrient\": \"No flip\", \"LdsEncFocusMax\": \"65535\", \"LdsEncFocusMin\": \"65535\", \"LdsEncFocusRaw\": \"0\", \"LdsEncIrisMax\": \"65535\", \"LdsEncIrisMin\": \"65535\", \"LdsEncIrisRaw\": \"0\", \"LdsEncZoomMax\": \"65535\", \"LdsEncZoomMin\": \"65535\", \"LdsEncZoomRaw\": \"0\", \"LdsLagType\": \"CONSTANT\", \"LdsLagValue\": \"1\", \"LensLinearIris\": \"4.277\", \"LensType\": \"Leica SUM 21 56\", \"LookCdlMode\": \"CDL LogC\", \"LookCdlOffset\": \"0, 0, 0\", \"LookCdlPower\": \"1, 1, 1\", \"LookCdlSlope\": \"1, 1, 1\", \"LookFileName\": \"ARRI 709\", \"LookLiveGrading\": \"Unchanged\", \"LookLutMode\": \"3D Look LUT\", \"LookSaturation\": \"1\", \"Nr\": {\"Applied\": \"0\", \"Strength\": \"2.5\"}, \"Roll\": \"0.6\", \"Sharpness\": \"100\", \"SmpteUuid\": \"060A2B340101010501010D43130000006C474293DBA245538DDBF7CF377903FA\", \"SupVersion\": \"5.01.07\", \"Tilt\": \"7.1\", \"TimeBase\": \"24\", \"UnitPref\": \"Imperial\", \"Variframe\": \"0\", \"WbFactor\": \"1.27531, 1, 1.85844\", \"WbTintCc\": \"0\"}}}, \"compression\": \"zips\", \"creator\": \"THIERRY ARBOGAST\", \"focalLength\": \"21\", \"focus\": \"1.99098\", \"framesPerSecond\": \"24/1\", \"imageCounter\": \"1254029\", \"imageRotation\": \"0\", \"interim\": {\"camera\": {\"shutterAngle\": \"172.8\", \"wbKelvin\": \"3700\"}, \"clip\": {\"cameraClipName\": \"B168C023_180212_R0BX\", \"cinematographer\": \"THIERRY ARBOGAST\", \"company\": \"EUROPACORP\", \"director\": \"LUC BESSON\", \"production\": \"ANNA M\"}}, \"isoSpeed\": \"800\", \"lensModel\": \"Leica SUM 21 56\", \"lensSerialNumber\": \"56\", \"oiio:ColorSpace\": \"Linear\", \"oiio:subimages\": \"1\", \"originalImageFlag\": \"1\", \"reelName\": \"B168R0BX\", \"screenWindowCenter\": \"0, 0\", \"screenWindowWidth\": \"1\", \"smpte:TimeCode\": \"14:30:51:05\", \"timecodeRate\": \"24\", \"uk\": {\"ltd\": {\"filmlight\": {\"Clip\": \"VFX_035_0040\", \"Company\": \"EUROPACORP\", \"DRT\": \"ARRI Photometric v2\", \"DRTNoInverse\": \"0\", \"Director\": \"LUC BESSON\", \"InputColourSpace\": \"ARRI: LogC / Wide Gamut\", \"Production\": \"ANNA M\", \"Tape\": \"B168C023_180212_R0BX\", \"ViewingColourSpace\": \"ARRI: Linear / Wide Gamut\", \"WorkingColourSpace\": \"ARRI: LogC / Wide Gamut\"}}}, \"utcOffset\": \"0\"}"
                    }
                ],
                "intrinsics": [
                    {
                        "intrinsicId": 3486608314,
                        "initialFocalLength": 21.000000000000004,
                        "focalLength": 21.000000000000004,
                        "pixelRatio": 1.0,
                        "pixelRatioLocked": true,
                        "scaleLocked": false,
                        "offsetLocked": false,
                        "distortionLocked": false,
                        "type": "pinhole",
                        "distortionType": "radialk3",
                        "width": 3424,
                        "height": 2202,
                        "sensorWidth": 28.25,
                        "sensorHeight": 18.16778621495327,
                        "serialNumber": "2042956",
                        "principalPoint": {
                            "x": 0.0,
                            "y": 0.0
                        },
                        "initializationMode": "estimated",
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
                482,
                1470
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 30,
                "split": 1
            },
            "uid": "7e15c7697c8b448d55022fe32e6e948036ebe53f",
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
                201,
                1157
            ],
            "parallelization": {
                "blockSize": 40,
                "size": 15,
                "split": 1
            },
            "uid": "895be8edab857b0301f7a7d4d641fb4dac2b2cda",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ApplyCalibration_3.output}",
                "masksFolder": "{ImageSegmentationPrompt_1.output}",
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
                640,
                1014
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 15,
                "split": 1
            },
            "uid": "8d1e6cb6dd03ec3fedb3681ee4c8f131b939cf77",
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
                1201,
                1024
            ],
            "parallelization": {
                "blockSize": 20,
                "size": 30,
                "split": 2
            },
            "uid": "785d6917f9a8a75b00237d60c407a84826874902",
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
        "FilterMasks_1": {
            "nodeType": "FilterMasks",
            "position": [
                1393,
                1626
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "6a14ad3f73d71ae2268466fff9ed45b2c3943f38",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "maskFolder": "{FilterMasks_6.outputFolder}",
                "inputSfM": "{FilterMasks_6.inputSfM}",
                "filterType": "blur",
                "keepFilename": true,
                "extension": "{FilterMasks_6.extension}",
                "kernel_size": 3,
                "kernel_shape": "rect",
                "iterations": 1,
                "use_of": false,
                "smoothing_strength": 0.05,
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "Blur",
                "color": "#C16162"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.jpg"
            }
        },
        "FilterMasks_2": {
            "nodeType": "FilterMasks",
            "position": [
                393,
                1272
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "321e8a1e9eb2688c0f189d8abab606adc1a9a1b7",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "maskFolder": "{FilterMasks_3.outputFolder}",
                "inputSfM": "{FilterMasks_3.inputSfM}",
                "filterType": "temporal_filtering",
                "keepFilename": true,
                "extension": "{FilterMasks_3.extension}",
                "kernel_size": 3,
                "kernel_shape": "rect",
                "iterations": 1,
                "use_of": false,
                "smoothing_strength": 0.05,
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "Unflicker",
                "color": "#C16162"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.jpg"
            }
        },
        "FilterMasks_3": {
            "nodeType": "FilterMasks",
            "position": [
                197,
                1272
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "f9a399273d1c91494f95f3a9469b3dd43ca2705d",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "maskFolder": "{ImageSegmentationPrompt_1.output}",
                "inputSfM": "{ImageSegmentationPrompt_1.input}",
                "filterType": "erosion",
                "keepFilename": true,
                "extension": "jpg",
                "kernel_size": 3,
                "kernel_shape": "rect",
                "iterations": 1,
                "use_of": false,
                "smoothing_strength": 0.05,
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "Dilate",
                "color": "#C16162"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.jpg"
            }
        },
        "FilterMasks_4": {
            "nodeType": "FilterMasks",
            "position": [
                590,
                1273
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "5f4c028a4c58f9db32b075f34e84eb8f16cd1b82",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "maskFolder": "{FilterMasks_2.outputFolder}",
                "inputSfM": "{FilterMasks_2.inputSfM}",
                "filterType": "dilation",
                "keepFilename": true,
                "extension": "{FilterMasks_2.extension}",
                "kernel_size": 3,
                "kernel_shape": "rect",
                "iterations": 1,
                "use_of": false,
                "smoothing_strength": 0.05,
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "Erode",
                "color": "#C16162"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.jpg"
            }
        },
        "FilterMasks_6": {
            "nodeType": "FilterMasks",
            "position": [
                1193,
                1622
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "e8ec0a8b27b7ad09986a861aac3ecf7af94bc3a5",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "maskFolder": "{PrepareFolderForGS_1.maskFolder}",
                "inputSfM": "{FilterMasks_4.inputSfM}",
                "filterType": "erosion",
                "keepFilename": true,
                "extension": "jpg",
                "kernel_size": 3,
                "kernel_shape": "rect",
                "iterations": 1,
                "use_of": false,
                "smoothing_strength": 0.05,
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "Dilate",
                "color": "#C16162"
            },
            "outputs": {
                "outputFolder": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.jpg"
            }
        },
        "GaussianSplattingOptim_1": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                1311.0,
                1445.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "15edb831482fa0a17b63dedae0fb091cfdb065b3",
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
                "use_masks": true,
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
                1108,
                1510
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "e705d4fabbf71d5910296bdcc0e41c8ccf3fbce3",
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
                "use_masks": true,
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
                "model": "{nodeCacheFolder}/ckpts/ckpt_2999_rank0.pt"
            }
        },
        "GaussianSplattingRender_1": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                1513.0,
                1441.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "6f029e489f1d95424b038b87a4032df367d6a9c3",
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
        "ImageCompo_2": {
            "nodeType": "ImageCompo",
            "position": [
                1746,
                1468
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "a01374a069dc94af3ea3e1026f4bb15d7754eea5",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "folderA": "{PrepareFolderForGS_1.outputImageFolder}",
                "folderB": "{GaussianSplattingRender_1.render_folder}",
                "folderMask": "{FilterMasks_1.outputFolder}",
                "rename": true
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "combinedImageFolder": "{nodeCacheFolder}",
                "frames": "{nodeCacheFolder}/*.jpg"
            }
        },
        "ImageMatchingMultiSfM_4": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                1016,
                1016
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 30,
                "split": 1
            },
            "uid": "f8b2293568a1ae718599d22a1299f39f9022e11c",
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
                439,
                1014
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 15,
                "split": 1
            },
            "uid": "58876e90e5dcbe7ceae5521ad2a4a55539e592d1",
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
        "ImageProcessing_1": {
            "nodeType": "ImageProcessing",
            "position": [
                -252,
                1154
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 15,
                "split": 1
            },
            "uid": "bc1b3aa8c90393ab43ef3acaa24393adf6c1b814",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{CameraInit_5.output}",
                "inputFolders": [],
                "metadataFolders": [],
                "extension": "jpg",
                "reconstructedViewsOnly": false,
                "keepImageFilename": false,
                "reorient": false,
                "fixNonFinite": false,
                "exposureCompensation": false,
                "rawAutoBright": false,
                "rawExposureAdjust": 0.0,
                "lensCorrection": {
                    "lensCorrectionEnabled": false,
                    "geometry": false,
                    "vignetting": false,
                    "chromaticAberration": false
                },
                "scaleFactor": 1.0,
                "maxWidth": 0,
                "maxHeight": 0,
                "contrast": 1.0,
                "medianFilter": 0,
                "fillHoles": false,
                "sharpenFilter": {
                    "sharpenFilterEnabled": false,
                    "width": 3,
                    "contrast": 1.0,
                    "threshold": 0.0
                },
                "bilateralFilter": {
                    "bilateralFilterEnabled": false,
                    "bilateralFilterDistance": 0,
                    "bilateralFilterSigmaSpace": 0.0,
                    "bilateralFilterSigmaColor": 0.0
                },
                "claheFilter": {
                    "claheEnabled": false,
                    "claheClipLimit": 4.0,
                    "claheTileGridSize": 8
                },
                "noiseFilter": {
                    "noiseEnabled": false,
                    "noiseMethod": "uniform",
                    "noiseA": 0.0,
                    "noiseB": 1.0,
                    "noiseMono": true
                },
                "nlmFilter": {
                    "nlmFilterEnabled": false,
                    "nlmFilterH": 5.0,
                    "nlmFilterHColor": 10.0,
                    "nlmFilterTemplateWindowSize": 7,
                    "nlmFilterSearchWindowSize": 21
                },
                "parFilter": {
                    "parEnabled": false,
                    "parRowDecimation": false
                },
                "outputFormat": "rgba",
                "inputColorSpace": "AUTO",
                "outputColorSpace": "AUTO",
                "workingColorSpace": "Linear",
                "rawColorInterpretation": "DCPLinearProcessing",
                "applyDcpMetadata": false,
                "colorProfileDatabase": "${ALICEVISION_COLOR_PROFILE_DB}",
                "errorOnMissingColorProfile": true,
                "useDCPColorMatrixOnly": true,
                "doWBAfterDemosaicing": false,
                "demosaicingAlgo": "AHD",
                "highlightMode": 0,
                "correlatedColorTemperature": -1.0,
                "lensCorrectionProfileInfo": "${ALICEVISION_LENS_PROFILE_INFO}",
                "lensCorrectionProfileSearchIgnoreCameraModel": true,
                "storageDataType": "float",
                "exrCompressionMethod": "auto",
                "exrCompressionLevel": 0,
                "jpegCompress": true,
                "jpegQuality": 90,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "",
                "color": ""
            },
            "outputs": {
                "outSfMData": "{nodeCacheFolder}/cameraInit.sfm",
                "output": "{nodeCacheFolder}",
                "outputImages": "{nodeCacheFolder}/<VIEW_ID>.jpg"
            }
        },
        "ImageSegmentationPrompt_1": {
            "nodeType": "ImageSegmentationPrompt",
            "position": [
                4,
                1252
            ],
            "parallelization": {
                "blockSize": 50,
                "size": 15,
                "split": 1
            },
            "uid": "131998e4c89fecd32b055bf3f89b86e66289d752",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "input": "{ImageProcessing_1.outSfMData}",
                "recognitionModelPath": "/s/apps/packages/mikrosVfx/multiview/imagePrompt_nnModels/1.0/models/ram_plus_swin_large_14m.pth",
                "detectionModelPath": "/s/apps/packages/mikrosVfx/multiview/imagePrompt_nnModels/1.0/models/groundingdino_swint_ogc.pth",
                "detectionConfigPath": "/s/apps/packages/mikrosVfx/multiview/imagePrompt_nnModels/1.0/models/GroundingDINO_SwinT_OGC.py",
                "segmentationModelPath": "/s/apps/packages/mikrosVfx/multiview/imagePrompt_nnModels/1.0/models/sam_vit_h_4b8939.pth",
                "prompt": "woman",
                "synonyms": "",
                "forceDetection": true,
                "thresholdDetection": 0.3,
                "bboxMargin": 0,
                "maskInvert": true,
                "useGpu": true,
                "keepFilename": true,
                "extension": "jpg",
                "outputBboxImage": true,
                "verboseLevel": "info"
            },
            "internalInputs": {
                "invalidation": "",
                "comment": "",
                "label": "Segmentation3",
                "color": "#C16162"
            },
            "outputs": {
                "output": "{nodeCacheFolder}",
                "masks": "{nodeCacheFolder}/<FILESTEM>.jpg",
                "bboxes": "{nodeCacheFolder}/<FILESTEM>_bboxes.jpg"
            }
        },
        "KeyframeSelection_3": {
            "nodeType": "KeyframeSelection",
            "position": [
                202,
                1017
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 15,
                "split": 1
            },
            "uid": "db66dabef9cc930427aea46d3de5570af0645301",
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
                663,
                1464
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 30,
                "split": 1
            },
            "uid": "be31b26a2703124cac6a47b04ff436e9e167fab2",
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
                879,
                1437
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "87817fd5b0fc3a4c641306ea8783fa75a96526d8",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "colmapFolder": "{Meshroom2ColmapSfmConvertions_3.output}",
                "maskFolder": "{FilterMasks_4.outputFolder}",
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
                883.0,
                1319.0
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 1,
                "split": 1
            },
            "uid": "d6b9250d408f9ef7975bc3f6673855d63e9f2644",
            "internalFolder": "{cache}/{nodeType}/{uid}",
            "inputs": {
                "colmapFolder": "{Meshroom2ColmapSfmConvertions_3.output}",
                "maskFolder": "{FilterMasks_4.outputFolder}",
                "scale": [
                    "2",
                    "4",
                    "8",
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
        "StructureFromMotion_6": {
            "nodeType": "StructureFromMotion",
            "position": [
                839,
                1014
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 15,
                "split": 1
            },
            "uid": "4610a3cfa9f74201343027ff96dcde39f686a462",
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
                1385,
                1028
            ],
            "parallelization": {
                "blockSize": 0,
                "size": 30,
                "split": 1
            },
            "uid": "99900d1a823f2b24dbc32cf7fb1ab302b4ebe1b9",
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