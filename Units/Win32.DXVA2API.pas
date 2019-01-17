unit Win32.DXVA2API;

// Checked and Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner
{$IFDEF FPC}
{$mode delphi}
{$ENDIF}



interface

uses
    Windows, Classes, SysUtils, ActiveX, Direct3D9;

const
    DXVA2_DLL = 'Dxva2.dll';

const
    DXVA2_ModeMPEG2_MoComp: TGUID = '{e6a9f44b-61b0-4563-9ea4-63d2a3c6fe66}';
    DXVA2_ModeMPEG2_IDCT: TGUID = '{bf22ad00-03ea-4690-8077-473346209b7e}';
    DXVA2_ModeMPEG2_VLD: TGUID = '{ee27417f-5e28-4e65-beea-1d26b508adc9}';
    DXVA2_ModeMPEG1_VLD: TGUID = '{6f3ec719-3735-42cc-8063-65cc3cb36616}';
    DXVA2_ModeMPEG2and1_VLD: TGUID = '{86695f12-340e-4f04-9fd3-9253dd327460}';
    DXVA2_ModeH264_A: TGUID = '{1b81be64-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_MoComp_NoFGT: TGUID = '{1b81be64-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_B: TGUID = '{1b81be65-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_MoComp_FGT: TGUID = '{1b81be65-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_C: TGUID = '{1b81be66-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_IDCT_NoFGT: TGUID = '{1b81be66-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_D: TGUID = '{1b81be67-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_IDCT_FGT: TGUID = '{1b81be67-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_E: TGUID = '{1b81be68-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_VLD_NoFGT: TGUID = '{1b81be68-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_F: TGUID = '{1b81be69-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_VLD_FGT: TGUID = '{1b81be69-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeH264_VLD_WithFMOASO_NoFGT: TGUID = '{d5f04ff9-3418-45d8-9561-32a76aae2ddd}';
    DXVA2_ModeH264_VLD_Stereo_Progressive_NoFGT: TGUID = '{d79be8da-0cf1-4c81-b82a-69a4e236f43d}';
    DXVA2_ModeH264_VLD_Stereo_NoFGT: TGUID = '{f9aaccbb-c2b6-4cfc-8779-5707b1760552}';
    DXVA2_ModeH264_VLD_Multiview_NoFGT: TGUID = '{705b9d82-76cf-49d6-b7e6-ac8872db013c}';
    DXVA2_ModeWMV8_A: TGUID = '{1b81be80-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV8_PostProc: TGUID = '{1b81be80-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV8_B: TGUID = '{1b81be81-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV8_MoComp: TGUID = '{1b81be81-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV9_A: TGUID = '{1b81be90-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV9_PostProc: TGUID = '{1b81be90-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV9_B: TGUID = '{1b81be91-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV9_MoComp: TGUID = '{1b81be91-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV9_C: TGUID = '{1b81be94-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeWMV9_IDCT: TGUID = '{1b81be94-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_A: TGUID = '{1b81beA0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_PostProc: TGUID = '{1b81beA0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_B: TGUID = '{1b81beA1-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_MoComp: TGUID = '{1b81beA1-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_C: TGUID = '{1b81beA2-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_IDCT: TGUID = '{1b81beA2-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_D: TGUID = '{1b81beA3-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_VLD: TGUID = '{1b81beA3-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_ModeVC1_D2010: TGUID = '{1b81beA4-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_NoEncrypt: TGUID = '{1b81beD0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA2_VideoProcProgressiveDevice: TGUID = '{5a54a0c9-c7ec-4bd9-8ede-f3c75dc4393b}';
    DXVA2_VideoProcBobDevice: TGUID = '{335aa36e-7884-43a4-9c91-7f87faf3e37e}';
    DXVA2_VideoProcSoftwareDevice: TGUID = '{4553d47f-ee7e-4e3f-9475-dbf1376c4810}';
    DXVA2_ModeMPEG4pt2_VLD_Simple: TGUID = '{efd64d74-c9e8-41d7-a5e9-e9b0e39fa319}';
    DXVA2_ModeMPEG4pt2_VLD_AdvSimple_NoGMC: TGUID = '{ed418a9f-010d-4eda-9ae3-9a65358d8d2e}';
    DXVA2_ModeMPEG4pt2_VLD_AdvSimple_GMC: TGUID = '{ab998b5b-4258-44a9-9feb-94e597a6baae}';
    DXVA2_ModeHEVC_VLD_Main: TGUID = '{5b11d51b-2f4c-4452-bcc3-09f2a1160cc0}';
    DXVA2_ModeHEVC_VLD_Main10: TGUID = '{107af0e0-ef1a-4d19-aba8-67a163073d13}';

    DXVA2_ModeVP9_VLD_Profile0: TGUID = '{463707f8-a1d0-4585-876d-83aa6d60b89e}';
    DXVA2_ModeVP9_VLD_10bit_Profile2: TGUID = '{a4c749ef-6ecf-48aa-8448-50a7a1165ff7}';
    DXVA2_ModeVP8_VLD: TGUID = '{90b899ea-3a62-4705-88b3-8df04b2744e7}';

const
    IID_IDirect3DDeviceManager9: TGUID = '{a0cade0f-06d5-4cf4-a1c7-f3cdd725aa75}';
    IID_IDirectXVideoAccelerationService: TGUID = '{fc51a550-d5e7-11d9-af55-00054e43ff02}';
    IID_IDirectXVideoDecoderService: TGUID = '{fc51a551-d5e7-11d9-af55-00054e43ff02}';
    IID_IDirectXVideoProcessorService: TGUID = '{fc51a552-d5e7-11d9-af55-00054e43ff02}';
    IID_IDirectXVideoDecoder: TGUID = '{f2b0810a-fd00-43c9-918c-df94e2d8ef7d}';
    IID_IDirectXVideoProcessor: TGUID = '{8c3a39f0-916e-4690-804f-4c8001355d25}';
    IID_IDirectXVideoMemoryConfiguration: TGUID = '{b7f916dd-db3b-49c1-84d7-e45ef99ec726}';

const
    DXVA2_E_NOT_INITIALIZED = HRESULT($80041000);
    DXVA2_E_NEW_VIDEO_DEVICE = HRESULT($80041001);
    DXVA2_E_VIDEO_DEVICE_LOCKED = HRESULT($80041002);
    DXVA2_E_NOT_AVAILABLE = HRESULT($80041003);

const
    MAX_DEINTERLACE_SURFACES = 32;
    MAX_SUBSTREAMS = 15;


    DXVA2_DeinterlaceTech_Unknown = 0;
    DXVA2_DeinterlaceTech_BOBLineReplicate = $1;
    DXVA2_DeinterlaceTech_BOBVerticalStretch = $2;
    DXVA2_DeinterlaceTech_BOBVerticalStretch4Tap = $4;
    DXVA2_DeinterlaceTech_MedianFiltering = $8;
    DXVA2_DeinterlaceTech_EdgeFiltering = $10;
    DXVA2_DeinterlaceTech_FieldAdaptive = $20;
    DXVA2_DeinterlaceTech_PixelAdaptive = $40;
    DXVA2_DeinterlaceTech_MotionVectorSteered = $80;
    DXVA2_DeinterlaceTech_InverseTelecine = $100;
    DXVA2_DeinterlaceTech_Mask = $1ff;

    DXVA2_NoiseFilterLumaLevel = 1;
    DXVA2_NoiseFilterLumaThreshold = 2;
    DXVA2_NoiseFilterLumaRadius = 3;
    DXVA2_NoiseFilterChromaLevel = 4;
    DXVA2_NoiseFilterChromaThreshold = 5;
    DXVA2_NoiseFilterChromaRadius = 6;
    DXVA2_DetailFilterLumaLevel = 7;
    DXVA2_DetailFilterLumaThreshold = 8;
    DXVA2_DetailFilterLumaRadius = 9;
    DXVA2_DetailFilterChromaLevel = 10;
    DXVA2_DetailFilterChromaThreshold = 11;
    DXVA2_DetailFilterChromaRadius = 12;

    DXVA2_NoiseFilterTech_Unsupported = 0;
    DXVA2_NoiseFilterTech_Unknown = $1;
    DXVA2_NoiseFilterTech_Median = $2;
    DXVA2_NoiseFilterTech_Temporal = $4;
    DXVA2_NoiseFilterTech_BlockNoise = $8;
    DXVA2_NoiseFilterTech_MosquitoNoise = $10;
    DXVA2_NoiseFilterTech_Mask = $1f;

    DXVA2_DetailFilterTech_Unsupported = 0;
    DXVA2_DetailFilterTech_Unknown = $1;
    DXVA2_DetailFilterTech_Edge = $2;
    DXVA2_DetailFilterTech_Sharpening = $4;
    DXVA2_DetailFilterTech_Mask = $7;

    DXVA2_ProcAmp_None = 0;
    DXVA2_ProcAmp_Brightness = $1;
    DXVA2_ProcAmp_Contrast = $2;
    DXVA2_ProcAmp_Hue = $4;
    DXVA2_ProcAmp_Saturation = $8;
    DXVA2_ProcAmp_Mask = $f;

    DXVA2_VideoProcess_None = 0;
    DXVA2_VideoProcess_YUV2RGB = $1;
    DXVA2_VideoProcess_StretchX = $2;
    DXVA2_VideoProcess_StretchY = $4;
    DXVA2_VideoProcess_AlphaBlend = $8;
    DXVA2_VideoProcess_SubRects = $10;
    DXVA2_VideoProcess_SubStreams = $20;
    DXVA2_VideoProcess_SubStreamsExtended = $40;
    DXVA2_VideoProcess_YUV2RGBExtended = $80;
    DXVA2_VideoProcess_AlphaBlendExtended = $100;
    DXVA2_VideoProcess_Constriction = $200;
    DXVA2_VideoProcess_NoiseFilter = $400;
    DXVA2_VideoProcess_DetailFilter = $800;
    DXVA2_VideoProcess_PlanarAlpha = $1000;
    DXVA2_VideoProcess_LinearScaling = $2000;
    DXVA2_VideoProcess_GammaCompensated = $4000;
    DXVA2_VideoProcess_MaintainsOriginalFieldData = $8000;
    DXVA2_VideoProcess_Mask = $ffff;

    DXVA2_VPDev_HardwareDevice = $1;
    DXVA2_VPDev_EmulatedDXVA1 = $2;
    DXVA2_VPDev_SoftwareDevice = $4;
    DXVA2_VPDev_Mask = $7;

    DXVA2_SampleData_RFF = $1;
    DXVA2_SampleData_TFF = $2;
    DXVA2_SampleData_RFF_TFF_Present = $4;
    DXVA2_SampleData_Mask = $ffff;

    DXVA2_DestData_RFF = $1;
    DXVA2_DestData_TFF = $2;
    DXVA2_DestData_RFF_TFF_Present = $4;
    DXVA2_DestData_Mask = $ffff;

    DXVA2_PictureParametersBufferType = 0;
    DXVA2_MacroBlockControlBufferType = 1;
    DXVA2_ResidualDifferenceBufferType = 2;
    DXVA2_DeblockingControlBufferType = 3;
    DXVA2_InverseQuantizationMatrixBufferType = 4;
    DXVA2_SliceControlBufferType = 5;
    DXVA2_BitStreamDateBufferType = 6;
    DXVA2_MotionVectorBuffer = 7;
    DXVA2_FilmGrainBuffer = 8;

    DXVA2_VideoDecoderRenderTarget = 0;
    DXVA2_VideoProcessorRenderTarget = 1;
    DXVA2_VideoSoftwareRenderTarget = 2;


    // DXVA2_DECODE_GET_DRIVER_HANDLE is an extension function that allows the
    // driver to return a handle for the DXVA2 decode device that can be used to
    // associate it with a IDirect3DCryptoSession9 interface.  When this function
    // is used:
    //     pPrivateInputData = NULL
    //     pPrivateInputDataSize = 0
    //     pPrivateOutputData = HANDLE*
    //     pPrivateOutputDataSize = sizeof(HANDLE)
    DXVA2_DECODE_GET_DRIVER_HANDLE = $725;

    // DXVA2_DECODE_SPECIFY_ENCRYPTED_BLOCKS is an extension function that that allows
    // the decoder to specify which portions of the compressed buffers are encrypted.
    // If this fucntion is not used to specify this information, it is assumed that
    // the entire buffer is encrypted.
    //     pPrivateInputData = D3DENCRYPTED_BLOCK_INFO*;
    //     PrivateInputDataSize = sizeof(D3DENCRYPTED_BLOCK_INFO);
    //     pPrivateOutputData = NULL;
    //     PrivateOutputDataSize = 0;
    DXVA2_DECODE_SPECIFY_ENCRYPTED_BLOCKS = $724;


type
    //   The following declarations within the 'if 0' block are dummy typedefs used to make
    //   the evr.idl file build. The actual definitions are contained in d3d9.h

    {    IDirect3DDevice9 = DWORD;   }
    PIDirect3DDevice9 = ^IDirect3DDevice9;

    {    IDirect3DSurface9 = DWORD;    }
    PIDirect3DSurface9 = ^IDirect3DSurface9;

    TD3DFORMAT = DWORD;
    PD3DFORMAT = ^TD3DFORMAT;

    TD3DPOOL = DWORD;
    PD3DPOOL = ^TD3DPOOL;


    {$IFDEF FPC}
    TDXVA2_ExtendedFormat = bitpacked record
        case integer of
            0: (
                SampleFormat: 0..255;
                VideoChromaSubsampling: 0..15;
                NominalRange: 0..7;
                VideoTransferMatrix: 0..7;
                VideoLighting: 0..15;
                VideoPrimaries: 0..31;
                VideoTransferFunction: 0..31;
            );
            1: (Value: UINT);
    end;
    {$ELSE}
    TDXVA2_ExtendedFormat = record
        Value: UINT;
    end;
    {$ENDIF}



    TDXVA2_SampleFormat = (
        DXVA2_SampleFormatMask = $ff,
        DXVA2_SampleUnknown = 0,
        DXVA2_SampleProgressiveFrame = 2,
        DXVA2_SampleFieldInterleavedEvenFirst = 3,
        DXVA2_SampleFieldInterleavedOddFirst = 4,
        DXVA2_SampleFieldSingleEven = 5,
        DXVA2_SampleFieldSingleOdd = 6,
        DXVA2_SampleSubStream = 7
        );

    TDXVA2_VideoChromaSubSampling = (
        DXVA2_VideoChromaSubsamplingMask = $f,
        DXVA2_VideoChromaSubsampling_Unknown = 0,
        DXVA2_VideoChromaSubsampling_ProgressiveChroma = $8,
        DXVA2_VideoChromaSubsampling_Horizontally_Cosited = $4,
        DXVA2_VideoChromaSubsampling_Vertically_Cosited = $2,
        DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = $1,
        DXVA2_VideoChromaSubsampling_MPEG2 = Ord(DXVA2_VideoChromaSubsampling_Horizontally_Cosited) or Ord(
        DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes),
        DXVA2_VideoChromaSubsampling_MPEG1 = DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes,
        DXVA2_VideoChromaSubsampling_DV_PAL = Ord(DXVA2_VideoChromaSubsampling_Horizontally_Cosited) or Ord(
        DXVA2_VideoChromaSubsampling_Vertically_Cosited),
        DXVA2_VideoChromaSubsampling_Cosited = Ord(DXVA2_VideoChromaSubsampling_Horizontally_Cosited) or Ord(
        DXVA2_VideoChromaSubsampling_Vertically_Cosited) or Ord(DXVA2_VideoChromaSubsampling_Vertically_AlignedChromaPlanes)
        );

    TDXVA2_NominalRange = (
        DXVA2_NominalRangeMask = $7,
        DXVA2_NominalRange_Unknown = 0,
        DXVA2_NominalRange_Normal = 1,
        DXVA2_NominalRange_Wide = 2,
        DXVA2_NominalRange_0_255 = 1,
        DXVA2_NominalRange_16_235 = 2,
        DXVA2_NominalRange_48_208 = 3
        );

    TDXVA2_VideoTransferMatrix = (
        DXVA2_VideoTransferMatrixMask = $7,
        DXVA2_VideoTransferMatrix_Unknown = 0,
        DXVA2_VideoTransferMatrix_BT709 = 1,
        DXVA2_VideoTransferMatrix_BT601 = 2,
        DXVA2_VideoTransferMatrix_SMPTE240M = 3
        );

    TDXVA2_VideoLighting = (
        DXVA2_VideoLightingMask = $f,
        DXVA2_VideoLighting_Unknown = 0,
        DXVA2_VideoLighting_bright = 1,
        DXVA2_VideoLighting_office = 2,
        DXVA2_VideoLighting_dim = 3,
        DXVA2_VideoLighting_dark = 4
        );

    TDXVA2_VideoPrimaries = (
        DXVA2_VideoPrimariesMask = $1f,
        DXVA2_VideoPrimaries_Unknown = 0,
        DXVA2_VideoPrimaries_reserved = 1,
        DXVA2_VideoPrimaries_BT709 = 2,
        DXVA2_VideoPrimaries_BT470_2_SysM = 3,
        DXVA2_VideoPrimaries_BT470_2_SysBG = 4,
        DXVA2_VideoPrimaries_SMPTE170M = 5,
        DXVA2_VideoPrimaries_SMPTE240M = 6,
        DXVA2_VideoPrimaries_EBU3213 = 7,
        DXVA2_VideoPrimaries_SMPTE_C = 8
        );

    TDXVA2_VideoTransferFunction = (
        DXVA2_VideoTransFuncMask = $1f,
        DXVA2_VideoTransFunc_Unknown = 0,
        DXVA2_VideoTransFunc_10 = 1,
        DXVA2_VideoTransFunc_18 = 2,
        DXVA2_VideoTransFunc_20 = 3,
        DXVA2_VideoTransFunc_22 = 4,
        DXVA2_VideoTransFunc_709 = 5,
        DXVA2_VideoTransFunc_240M = 6,
        DXVA2_VideoTransFunc_sRGB = 7,
        DXVA2_VideoTransFunc_28 = 8,
        // Deprecated labels - please use the ones in the DXVA2_VideoTransferFunction enum.
        DXVA2_VideoTransFunc_22_709 = DXVA2_VideoTransFunc_709,
        DXVA2_VideoTransFunc_22_240M = DXVA2_VideoTransFunc_240M,
        DXVA2_VideoTransFunc_22_8bit_sRGB = DXVA2_VideoTransFunc_sRGB);


    TDXVA2_Frequency = record
        Numerator: UINT;
        Denominator: UINT;
    end;

    TDXVA2_VideoDesc = record
        SampleWidth: UINT;
        SampleHeight: UINT;
        SampleFormat: TDXVA2_ExtendedFormat;
        Format: TD3DFORMAT;
        InputSampleFreq: TDXVA2_Frequency;
        OutputFrameFreq: TDXVA2_Frequency;
        UABProtectionLevel: UINT;
        Reserved: UINT;
    end;


    TDXVA2_VideoProcessorCaps = record
        DeviceCaps: UINT;
        InputPool: TD3DPOOL;
        NumForwardRefSamples: UINT;
        NumBackwardRefSamples: UINT;
        Reserved: UINT;
        DeinterlaceTechnology: UINT;
        ProcAmpControlCaps: UINT;
        VideoProcessorOperations: UINT;
        NoiseFilterTechnology: UINT;
        DetailFilterTechnology: UINT;
    end;

    TDXVA2_Fixed32 = record
        case integer of
            0: (Fraction: USHORT;
                Value: SHORT
            );
            1: (ll: longint);
    end;

    PDXVA2_Fixed32 = ^TDXVA2_Fixed32;

    TDXVA2_AYUVSample8 = record
        Cr: UCHAR;
        Cb: UCHAR;
        Y: UCHAR;
        Alpha: UCHAR;
    end;

    TDXVA2_AYUVSample16 = record
        Cr: USHORT;
        Cb: USHORT;
        Y: USHORT;
        Alpha: USHORT;
    end;

    TREFERENCE_TIME = LONGLONG;


    TDXVA2_VideoSample = record
        Start: TREFERENCE_TIME;
        Ende: TREFERENCE_TIME;
        SampleFormat: TDXVA2_ExtendedFormat;
        SrcSurface: IDirect3DSurface9;
        SrcRect: TRECT;
        DstRect: TRECT;
        Pal: array [0.. 15] of TDXVA2_AYUVSample8;
        PlanarAlpha: TDXVA2_Fixed32;
        SampleData: DWORD;
    end;

    PDXVA2_VideoSample = ^TDXVA2_VideoSample;


    TDXVA2_ValueRange = record
        MinValue: TDXVA2_Fixed32;
        MaxValue: TDXVA2_Fixed32;
        DefaultValue: TDXVA2_Fixed32;
        StepSize: TDXVA2_Fixed32;
    end;

    TDXVA2_ProcAmpValues = record
        Brightness: TDXVA2_Fixed32;
        Contrast: TDXVA2_Fixed32;
        Hue: TDXVA2_Fixed32;
        Saturation: TDXVA2_Fixed32;
    end;

    TDXVA2_FilterValues = record
        Level: TDXVA2_Fixed32;
        Threshold: TDXVA2_Fixed32;
        Radius: TDXVA2_Fixed32;
    end;

    TDXVA2_VideoProcessBltParams = record
        TargetFrame: TREFERENCE_TIME;
        TargetRect: TRECT;
        ConstrictionSize: TSIZE;
        StreamingFlags: UINT;
        BackgroundColor: TDXVA2_AYUVSample16;
        DestFormat: TDXVA2_ExtendedFormat;
        ProcAmpValues: TDXVA2_ProcAmpValues;
        Alpha: TDXVA2_Fixed32;
        NoiseFilterLuma: TDXVA2_FilterValues;
        NoiseFilterChroma: TDXVA2_FilterValues;
        DetailFilterLuma: TDXVA2_FilterValues;
        DetailFilterChroma: TDXVA2_FilterValues;
        DestData: DWORD;
    end;

    TDXVA2_ConfigPictureDecode = record
        guidConfigBitstreamEncryption: TGUID;
        guidConfigMBcontrolEncryption: TGUID;
        guidConfigResidDiffEncryption: TGUID;
        ConfigBitstreamRaw: UINT;
        ConfigMBcontrolRasterOrder: UINT;
        ConfigResidDiffHost: UINT;
        ConfigSpatialResid8: UINT;
        ConfigResid8Subtraction: UINT;
        ConfigSpatialHost8or9Clipping: UINT;
        ConfigSpatialResidInterleaved: UINT;
        ConfigIntraResidUnsigned: UINT;
        ConfigResidDiffAccelerator: UINT;
        ConfigHostInverseScan: UINT;
        ConfigSpecificIDCT: UINT;
        Config4GroupedCoefs: UINT;
        ConfigMinRenderTargetBuffCount: USHORT;
        ConfigDecoderSpecific: USHORT;
    end;

    PDXVA2_ConfigPictureDecode = ^TDXVA2_ConfigPictureDecode;

    TDXVA2_DecodeBufferDesc = record
        CompressedBufferType: DWORD;
        BufferIndex: UINT;
        DataOffset: UINT;
        DataSize: UINT;
        FirstMBaddress: UINT;
        NumMBsInBuffer: UINT;
        Width: UINT;
        Height: UINT;
        Stride: UINT;
        ReservedBits: UINT;
        pvPVPState: Pointer;
    end;

    PDXVA2_DecodeBufferDesc = ^TDXVA2_DecodeBufferDesc;

    // The value in pvPVPState depends on the type of crypo used.  For
    // D3DCRYPTOTYPE_AES128_CTR, pvPState points to the following structure:

    TDXVA2_AES_CTR_IV = record
        IV: UINT64;
        Count: UINT64;
    end;

    TDXVA2_DecodeExtensionData = record
        _Function: UINT;
        pPrivateInputData: Pointer;
        PrivateInputDataSize: UINT;
        pPrivateOutputData: Pointer;
        PrivateOutputDataSize: UINT;
    end;

    PDXVA2_DecodeExtensionData = ^TDXVA2_DecodeExtensionData;

    TDXVA2_DecodeExecuteParams = record
        NumCompBuffers: UINT;
        pCompressedBuffers: PDXVA2_DecodeBufferDesc;
        pExtensionData: PDXVA2_DecodeExtensionData;
    end;


    IDirect3DDeviceManager9 = interface(IUnknown)
        ['{a0cade0f-06d5-4cf4-a1c7-f3cdd725aa75}']
        function ResetDevice(pDevice: IDirect3DDevice9; resetToken: UINT): HResult; stdcall;
        function OpenDeviceHandle(out phDevice: THANDLE): HResult; stdcall;
        function CloseDeviceHandle(hDevice: THANDLE): HResult; stdcall;
        function TestDevice(hDevice: THANDLE): HResult; stdcall;
        function LockDevice(hDevice: THANDLE; out ppDevice: IDirect3DDevice9; fBlock: boolean): HResult; stdcall;
        function UnlockDevice(hDevice: THANDLE; fSaveState: boolean): HResult; stdcall;
        function GetVideoService(hDevice: THANDLE; const riid: TGUID; out ppService): HResult; stdcall;
    end;


    IDirectXVideoAccelerationService = interface(IUnknown)
        ['{fc51a550-d5e7-11d9-af55-00054e43ff02}']
        function CreateSurface(Width: UINT; Height: UINT; BackBuffers: UINT; Format: TD3DFORMAT; Pool: TD3DPOOL;
            Usage: DWORD; DxvaType: DWORD; out ppSurface: IDirect3DSurface9; pSharedHandle: PHANDLE): HResult; stdcall;
    end;

    IDirectXVideoDecoder = interface;
    IDirectXVideoProcessor = interface;

    IDirectXVideoDecoderService = interface(IDirectXVideoAccelerationService)
        ['{fc51a551-d5e7-11d9-af55-00054e43ff02}']
        function GetDecoderDeviceGuids(out pCount: UINT; out pGuids {arraysize pCount}: PGUID): HResult; stdcall;
        function GetDecoderRenderTargets(const Guid: TGUID; out pCount: UINT; out pFormats {arraysize pCount}: PD3DFORMAT): HResult; stdcall;
        function GetDecoderConfigurations(const Guid: TGUID; const pVideoDesc: TDXVA2_VideoDesc; pReserved: Pointer;
            out pCount: UINT; out ppConfigs{arraysize pCount}: PDXVA2_ConfigPictureDecode): HResult; stdcall;
        function CreateVideoDecoder(const Guid: TGUID; const pVideoDesc: TDXVA2_VideoDesc; const pConfig: TDXVA2_ConfigPictureDecode;
            ppDecoderRenderTargets{arraysize NumRenderTargets}: PIDirect3DSurface9; NumRenderTargets: UINT; out ppDecode: IDirectXVideoDecoder): HResult; stdcall;
    end;


    IDirectXVideoProcessorService = interface(IDirectXVideoAccelerationService)
        ['{fc51a552-d5e7-11d9-af55-00054e43ff02}']
        function RegisterVideoProcessorSoftwareDevice(pCallbacks: pointer): HResult; stdcall;
        function GetVideoProcessorDeviceGuids(const pVideoDesc: TDXVA2_VideoDesc; out pCount: UINT; out pGuids{arraysize pCount}: PGUID): HResult; stdcall;
        function GetVideoProcessorRenderTargets(const VideoProcDeviceGuid: TGUID; const pVideoDesc: TDXVA2_VideoDesc;
            out pCount: UINT; out pFormats{arraysize pCount}: PD3DFORMAT): HResult; stdcall;
        function GetVideoProcessorSubStreamFormats(const VideoProcDeviceGuid: TGUID; const pVideoDesc: TDXVA2_VideoDesc;
            RenderTargetFormat: TD3DFORMAT; out pCount: UINT; out pFormats: PD3DFORMAT): HResult; stdcall;
        function GetVideoProcessorCaps(const VideoProcDeviceGuid: TGUID; const pVideoDesc: TDXVA2_VideoDesc;
            RenderTargetFormat: TD3DFORMAT; out pCaps: TDXVA2_VideoProcessorCaps): HResult; stdcall;
        function GetProcAmpRange(const VideoProcDeviceGuid: TGUID; const pVideoDesc: TDXVA2_VideoDesc;
            RenderTargetFormat: TD3DFORMAT; ProcAmpCap: UINT; out pRange: TDXVA2_ValueRange): HResult; stdcall;
        function GetFilterPropertyRange(const VideoProcDeviceGuid: TGUID; const pVideoDesc: TDXVA2_VideoDesc;
            RenderTargetFormat: TD3DFORMAT; FilterSetting: UINT; out pRange: TDXVA2_ValueRange): HResult; stdcall;
        function CreateVideoProcessor(const VideoProcDeviceGuid: TGUID; const pVideoDesc: TDXVA2_VideoDesc;
            RenderTargetFormat: TD3DFORMAT; MaxNumSubStreams: UINT; out ppVidProcess: IDirectXVideoProcessor): HResult; stdcall;
    end;


    IDirectXVideoDecoder = interface(IUnknown)
        ['{f2b0810a-fd00-43c9-918c-df94e2d8ef7d}']
        function GetVideoDecoderService(out ppService: IDirectXVideoDecoderService): HResult; stdcall;
        function GetCreationParameters(out pDeviceGuid: TGUID; out pVideoDesc: TDXVA2_VideoDesc;
            out pConfig: TDXVA2_ConfigPictureDecode; out pDecoderRenderTargets{arraysize pNumSurfaces}: PIDirect3DSurface9;
            out pNumSurfaces: UINT): HResult; stdcall;
        function GetBuffer(BufferType: UINT; out ppBuffer:pointer; out pBufferSize: UINT): HResult; stdcall;
        function ReleaseBuffer(BufferType: UINT): HResult; stdcall;
        function BeginFrame(pRenderTarget: IDirect3DSurface9; pvPVPData: Pointer): HResult; stdcall;
        function EndFrame(var pHandleComplete: THANDLE): HResult; stdcall;
        function Execute(const pExecuteParams: TDXVA2_DecodeExecuteParams): HResult; stdcall;
    end;


    IDirectXVideoProcessor = interface(IUnknown)
        ['{8c3a39f0-916e-4690-804f-4c8001355d25}']
        function GetVideoProcessorService(out ppService: IDirectXVideoProcessorService): HResult; stdcall;
        function GetCreationParameters(out pDeviceGuid: TGUID; out pVideoDesc: TDXVA2_VideoDesc;
            out pRenderTargetFormat: TD3DFORMAT; out pMaxNumSubStreams: UINT): HResult; stdcall;
        function GetVideoProcessorCaps(out pCaps: TDXVA2_VideoProcessorCaps): HResult; stdcall;
        function GetProcAmpRange(ProcAmpCap: UINT; out pRange: TDXVA2_ValueRange): HResult; stdcall;
        function GetFilterPropertyRange(FilterSetting: UINT; out pRange: TDXVA2_ValueRange): HResult; stdcall;
        function VideoProcessBlt(pRenderTarget: IDirect3DSurface9; const pBltParams: TDXVA2_VideoProcessBltParams;
            const pSamples{arraysize NumSamples}: PDXVA2_VideoSample; NumSamples: UINT; var pHandleComplete: THANDLE): HResult; stdcall;
    end;


    TDXVA2_SurfaceType = (
        DXVA2_SurfaceType_DecoderRenderTarget = 0,
        DXVA2_SurfaceType_ProcessorRenderTarget = 1,
        DXVA2_SurfaceType_D3DRenderTargetTexture = 2
        );


    IDirectXVideoMemoryConfiguration = interface(IUnknown)
        ['{b7f916dd-db3b-49c1-84d7-e45ef99ec726}']
        function GetAvailableSurfaceTypeByIndex(dwTypeIndex: DWORD; out pdwType: TDXVA2_SurfaceType): HResult; stdcall;
        function SetSurfaceType(dwType: TDXVA2_SurfaceType): HResult; stdcall;
    end;


function DXVA2CreateDirect3DDeviceManager9(out pResetToken: UINT; out ppDeviceManager: IDirect3DDeviceManager9): HResult;
    stdcall; external DXVA2_DLL;

function DXVA2CreateVideoService(pDD: IDirect3DDevice9; const riid: TGUID; out ppService): HResult;
    stdcall; external DXVA2_DLL;


function DXVA2FloatToFixed(const _float: single): TDXVA2_Fixed32; inline;
function DXVA2FixedToFloat(const _fixed: TDXVA2_Fixed32): single; inline;
function DXVA2_Fixed32TransparentAlpha(): TDXVA2_Fixed32; inline;
function DXVA2_Fixed32OpaqueAlpha(): TDXVA2_Fixed32; inline;

implementation



function DXVA2FloatToFixed(const _float: single): TDXVA2_Fixed32; inline;
var
    lTemp: longint;
begin
    lTemp := Trunc(_float * $10000);
    Result.Fraction := LOWORD(lTemp);
    Result.Value := HIWORD(lTemp);
end;



function DXVA2FixedToFloat(const _fixed: TDXVA2_Fixed32): single; inline;
begin
    Result := (_fixed.Value) + (_fixed.Fraction / $10000);
end;



function DXVA2_Fixed32TransparentAlpha(): TDXVA2_Fixed32; inline;
begin
    Result.Fraction := 0;
    Result.Value := 0;
end;



function DXVA2_Fixed32OpaqueAlpha(): TDXVA2_Fixed32; inline;
begin
    Result.Fraction := 0;
    Result.Value := 1;
end;

end.






























































































































































































































