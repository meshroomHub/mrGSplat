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
        },
        "template": true
    },
    "graph": {
        "ApplyCalibration_3": {
            "nodeType": "ApplyCalibration",
            "position": [
                -4,
                1023
            ],
            "inputs": {
                "input": "{ImageProcessing_1.outSfMData}"
            },
            "internalInputs": {
                "color": "#575963"
            }
        },
        "CameraInit_5": {
            "nodeType": "CameraInit",
            "position": [
                -481,
                1180
            ],
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
                482,
                1470
            ],
            "inputs": {
                "input": "{StructureFromMotion_7.output}",
                "fileExt": "sfm"
            }
        },
        "FeatureExtraction_4": {
            "nodeType": "FeatureExtraction",
            "position": [
                201,
                1157
            ],
            "inputs": {
                "input": "{ApplyCalibration_3.output}",
                "masksFolder": "{ImageSegmentationPrompt_1.output}",
                "maskExtension": "jpg"
            },
            "internalInputs": {
                "color": "#575963"
            }
        },
        "FeatureMatching_7": {
            "nodeType": "FeatureMatching",
            "position": [
                640,
                1014
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
                1201,
                1024
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
        "FilterMasks_1": {
            "nodeType": "FilterMasks",
            "position": [
                1393,
                1626
            ],
            "inputs": {
                "maskFolder": "{FilterMasks_6.outputFolder}",
                "inputSfM": "{FilterMasks_6.inputSfM}",
                "filterType": "blur",
                "extension": "{FilterMasks_6.extension}",
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "label": "Blur",
                "color": "#C16162"
            }
        },
        "FilterMasks_2": {
            "nodeType": "FilterMasks",
            "position": [
                393,
                1272
            ],
            "inputs": {
                "maskFolder": "{FilterMasks_3.outputFolder}",
                "inputSfM": "{FilterMasks_3.inputSfM}",
                "extension": "{FilterMasks_3.extension}",
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "label": "Unflicker",
                "color": "#C16162"
            }
        },
        "FilterMasks_3": {
            "nodeType": "FilterMasks",
            "position": [
                197,
                1272
            ],
            "inputs": {
                "maskFolder": "{ImageSegmentationPrompt_1.output}",
                "inputSfM": "{ImageSegmentationPrompt_1.input}",
                "filterType": "erosion",
                "extension": "jpg",
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "label": "Dilate",
                "color": "#C16162"
            }
        },
        "FilterMasks_4": {
            "nodeType": "FilterMasks",
            "position": [
                590,
                1273
            ],
            "inputs": {
                "maskFolder": "{FilterMasks_2.outputFolder}",
                "inputSfM": "{FilterMasks_2.inputSfM}",
                "filterType": "dilation",
                "extension": "{FilterMasks_2.extension}",
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "label": "Erode",
                "color": "#C16162"
            }
        },
        "FilterMasks_6": {
            "nodeType": "FilterMasks",
            "position": [
                1193,
                1622
            ],
            "inputs": {
                "maskFolder": "{PrepareFolderForGS_1.maskFolder}",
                "inputSfM": "{FilterMasks_4.inputSfM}",
                "filterType": "erosion",
                "extension": "jpg",
                "verboseLevel": "debug"
            },
            "internalInputs": {
                "label": "Dilate",
                "color": "#C16162"
            }
        },
        "GaussianSplattingOptim_1": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                1311.0,
                1445.0
            ],
            "inputs": {
                "sfm": "{PrepareFolderForGS_2.outputFolder}",
                "resumeCheckpoint": "{GaussianSplattingOptim_3.model}",
                "n_steps": 300,
                "dataFactor": 1,
                "save_steps": [
                    3000
                ]
            },
            "internalInputs": {
                "invalidation": "new env C",
                "color": "#2CB9CC"
            }
        },
        "GaussianSplattingOptim_3": {
            "nodeType": "GaussianSplattingOptim",
            "position": [
                1122,
                1448
            ],
            "inputs": {
                "sfm": "{PrepareFolderForGS_1.outputFolder}",
                "n_steps": 3000,
                "dataFactor": 8,
                "save_steps": [
                    3000
                ]
            },
            "internalInputs": {
                "invalidation": "new env C",
                "color": "#2CB9CC"
            }
        },
        "GaussianSplattingRender_1": {
            "nodeType": "GaussianSplattingRender",
            "position": [
                1513.0,
                1441.0
            ],
            "inputs": {
                "cameras": "{GaussianSplattingOptim_1.sfm}",
                "model": "{GaussianSplattingOptim_1.model}"
            },
            "internalInputs": {
                "color": "#2CB9CC"
            }
        },
        "ImageCompo_2": {
            "nodeType": "ImageCompo",
            "position": [
                1698,
                1436
            ],
            "inputs": {
                "folderA": "{PrepareFolderForGS_1.outputImageFolder}",
                "folderB": "{GaussianSplattingRender_1.render_folder}",
                "folderMask": "{FilterMasks_1.outputFolder}"
            }
        },
        "ImageMatchingMultiSfM_4": {
            "nodeType": "ImageMatchingMultiSfM",
            "position": [
                1016,
                1016
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
                439,
                1014
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
        "ImageProcessing_1": {
            "nodeType": "ImageProcessing",
            "position": [
                -252,
                1154
            ],
            "inputs": {
                "input": "{CameraInit_5.output}",
                "extension": "jpg"
            }
        },
        "ImageSegmentationPrompt_1": {
            "nodeType": "ImageSegmentationPrompt",
            "position": [
                4,
                1252
            ],
            "inputs": {
                "input": "{ImageProcessing_1.outSfMData}",
                "prompt": "woman",
                "synonyms": "",
                "forceDetection": true,
                "thresholdDetection": 0.3,
                "maskInvert": true,
                "keepFilename": true,
                "extension": "jpg",
                "outputBboxImage": true
            },
            "internalInputs": {
                "label": "Segmentation3",
                "color": "#C16162"
            }
        },
        "KeyframeSelection_3": {
            "nodeType": "KeyframeSelection",
            "position": [
                202,
                1017
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
                663,
                1464
            ],
            "inputs": {
                "input": "{ConvertSfMFormat_7.output}"
            }
        },
        "PrepareFolderForGS_1": {
            "nodeType": "PrepareFolderForGS",
            "position": [
                879,
                1437
            ],
            "inputs": {
                "colmapFolder": "{Meshroom2ColmapSfmConvertions_3.output}",
                "maskFolder": "{FilterMasks_4.outputFolder}",
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
                883.0,
                1319.0
            ],
            "inputs": {
                "colmapFolder": "{Meshroom2ColmapSfmConvertions_3.output}",
                "maskFolder": "{FilterMasks_4.outputFolder}",
                "scale": [
                    "2",
                    "4",
                    "8",
                    "1"
                ]
            },
            "internalInputs": {
                "color": "#E35C03"
            }
        },
        "StructureFromMotion_6": {
            "nodeType": "StructureFromMotion",
            "position": [
                839,
                1014
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
                1385,
                1028
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