(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:   dxva9typ.h
 *  Content:    Direct3D include file
 *
 ****************************************************************************)

unit CMC.DXVA9Typ;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, ActiveX;

const
    DXVAp_ModeMPEG2_A: TGUID = '{1b81be0A-a0c7-11d3-b984-00c04f2e73c5}';
    DXVAp_ModeMPEG2_C: TGUID = '{1b81be0C-a0c7-11d3-b984-00c04f2e73c5}';
    DXVAp_NoEncrypt: TGUID = '{1b81beD0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVAp_DeinterlaceBobDevice: TGUID = '{335aa36e-7884-43a4-9c91-7f87faf3e37e}';
    DXVA_DeinterlaceBobDevice: TGUID = '{335aa36e-7884-43a4-9c91-7f87faf3e37e}';
    DXVAp_DeinterlaceContainerDevice: TGUID = '{0e85cb93-3046-4ff0-aecc-d58cb5f035fd}';
    DXVA_DeinterlaceContainerDevice: TGUID = '{0e85cb93-3046-4ff0-aecc-d58cb5f035fd}';
    DXVA_ProcAmpControlDevice: TGUID = '{9f200913-2ffd-4056-9f1e-e1b508f22dcf}';
    DXVA_COPPDevice: TGUID = '{d2457add-8999-45ed-8a8a-d1aa047ba4d5}';
    DXVA_COPPSetProtectionLevel: TGUID = '{9bb9327c-4eb5-4727-9f00-b42b0919c0da}';
    DXVA_COPPSetSignaling: TGUID = '{09a631a5-d684-4c60-8e4d-d3bb0f0be3ee}';
    // Status GUID and enumerations
    DXVA_COPPQueryConnectorType: TGUID = '{81d0bfd5-6afe-48c2-99c0-95a08f97c5da}';
    DXVA_COPPQueryProtectionType: TGUID = '{38f2a801-9a6c-48bb-9107-b6696e6f1797}';
    DXVA_COPPQueryLocalProtectionLevel: TGUID = '{b2075857-3eda-4d5d-88db-748f8c1a0549}';
    DXVA_COPPQueryGlobalProtectionLevel: TGUID = '{1957210a-7766-452a-b99a-d27aed54f03a}';
    DXVA_COPPQueryDisplayData: TGUID = '{d7bf1ba3-ad13-4f8e-af98-0dcb3ca204cc}';
    DXVA_COPPQueryHDCPKeyData: TGUID = '{0db59d74-a992-492e-a0bd-c23fda564e00}';
    DXVA_COPPQueryBusData: TGUID = '{c6f4d673-6174-4184-8e35-f6db5200bcba}';
    DXVA_COPPQuerySignaling: TGUID = '{6629a591-3b79-4cf3-924a-11e8e7811671}';


const
    DXVA_QUERYORREPLYFUNCFLAG_DECODER_PROBE_QUERY = $FFFFF1;
    DXVA_QUERYORREPLYFUNCFLAG_DECODER_LOCK_QUERY = $FFFFF5;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_OK_COPY = $FFFFF8;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_OK_PLUS = $FFFFF9;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_LOCK_OK_COPY = $FFFFFC;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_FALSE_PLUS = $FFFFFB;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_LOCK_FALSE_PLUS = $FFFFFF;

    DXVA_PICTURE_DECODE_BUFFER = 1;
    DXVA_MACROBLOCK_CONTROL_BUFFER = 2;
    DXVA_RESIDUAL_DIFFERENCE_BUFFER = 3;
    DXVA_DEBLOCKING_CONTROL_BUFFER = 4;
    DXVA_INVERSE_QUANTIZATION_MATRIX_BUFFER = 5;
    DXVA_SLICE_CONTROL_BUFFER = 6;
    DXVA_BITSTREAM_DATA_BUFFER = 7;
    DXVA_AYUV_BUFFER = 8;
    DXVA_IA44_SURFACE_BUFFER = 9;
    DXVA_DPXD_SURFACE_BUFFER = 10;
    DXVA_HIGHLIGHT_BUFFER = 11;
    DXVA_DCCMD_SURFACE_BUFFER = 12;
    DXVA_ALPHA_BLEND_COMBINATION_BUFFER = 13;
    DXVA_PICTURE_RESAMPLE_BUFFER = 14;
    DXVA_READ_BACK_BUFFER = 15;

    MAX_DEINTERLACE_SURFACES = 32;
    DXVA_DeinterlaceBltFnCode = $01;

    DXVA_ExtColorData_ShiftBase = 8;

    DXVA_DeinterlaceBltExFnCode = $02;
    // lpInput => DXVA_DeinterlaceBltEx*
    // lpOuput => NULL { not currently used }

    MAX_DEINTERLACE_DEVICE_GUIDS = 32;

    DXVA_DeinterlaceQueryAvailableModesFnCode = $01;
    // lpInput => DXVA_VideoDesc*
    // lpOuput => DXVA_DeinterlaceQueryAvailableModes*

    DXVA_DeinterlaceQueryModeCapsFnCode = $02;
    // lpInput => DXVA_DeinterlaceQueryModeCaps*
    // lpOuput => DXVA_DeinterlaceCaps*


    DXVA_ProcAmpControlQueryCapsFnCode = $03;
    // lpInput => DXVA_VideoDesc*
    // lpOuput => DXVA_ProcAmpControlCaps*


    DXVA_ProcAmpControlQueryRangeFnCode = $04;
    // lpInput => DXVA_ProcAmpControlQueryRange*
    // lpOuput => DXVA_VideoPropertyRange*

    DXVA_ProcAmpControlBltFnCode = $01;
    // lpInput => DXVA_ProcAmpControlBlt*
    // lpOuput => NULL { not currently used }


    // -------------------------------------------------------------------------
    // COPPGetCertificateLength
    // -------------------------------------------------------------------------
    DXVA_COPPGetCertificateLengthFnCode = $01;
    // lpInput => NULL
    // lpOuput => DWORD*

    // -------------------------------------------------------------------------
    // COPPKeyExchange
    // -------------------------------------------------------------------------
    DXVA_COPPKeyExchangeFnCode = $02;
    // lpInputData => NULL
    // lpOuputData => GUID*

    DXVA_COPPSequenceStartFnCode = $03;
    // lpInputData => DXVA_COPPSignature*
    // lpOuputData => NULL


    DXVA_COPPCommandFnCode = $04;
    // lpInputData => DXVA_COPPCommand*
    // lpOuputData => NULL

    DXVA_COPPQueryStatusFnCode = $05;
    // lpInputData => DXVA_COPPStatusInput*
    // lpOuputData => DXVA_COPPStatusOutput*


    COPP_NoProtectionLevelAvailable = -1;
    COPP_DefaultProtectionLevel = 0;


    // Bit flags of possible protection types.  Note that it is possible to apply
    // different protection settings to a single connector.


    COPP_ProtectionType_Unknown = $80000000;
    COPP_ProtectionType_None = $00000000;
    COPP_ProtectionType_HDCP = $00000001;
    COPP_ProtectionType_ACP = $00000002;
    COPP_ProtectionType_CGMSA = $00000004;
    COPP_ProtectionType_Mask = $80000007;
    COPP_ProtectionType_Reserved = $7FFFFFF8;


    COPP_ImageAspectRatio_EN300294_Mask = $00000007;

const
    D3DPOOL_DEFAULT = 0;
    D3DPOOL_MANAGED = 1;
    D3DPOOL_SYSTEMMEM = 2;
    D3DPOOL_SCRATCH = 3;
    D3DPOOL_LOCALVIDMEM = 4;
    D3DPOOL_NONLOCALVIDMEM = 5;
    D3DPOOL_FORCE_DWORD = $7fffffff;


type

    // -------------------------------------------------------------------------

    // The definitions that follow describe the DirectX Video Acceleration
    // decoding interface.
    // This interface is accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------


    { AYUV sample for 16-entry YUV palette or graphic surface }

    TDXVA_AYUVsample2 = record
        bCrValue: byte;
        bCbValue: byte;
        bY_Value: byte;
        bSampleAlpha8: byte;
    end;
    PDXVA_AYUVsample2 = ^TDXVA_AYUVsample2;


{$Z1}
{$A1}
    //pragma pack(push, BeforeDXVApacking, 1)

    TDXVA_BufferDescription = packed record
        dwTypeIndex: DWORD;
        dwBufferIndex: DWORD;
        dwDataOffset: DWORD;
        dwDataSize: DWORD;
        dwFirstMBaddress: DWORD;
        dwNumMBsInBuffer: DWORD;
        dwWidth: DWORD;
        dwHeight: DWORD;
        dwStride: DWORD;
        dwReservedBits: DWORD;
    end;
    PDXVA_BufferDescription = ^TDXVA_BufferDescription;

    TDXVA_ConfigQueryOrReplyFunc = dword;

    PDXVA_ConfigQueryOrReplyFunc = ^TDXVA_ConfigQueryOrReplyFunc;


    TDXVA_ConfigPictureDecode = packed record

        // Operation Indicated
        dwFunction: TDXVA_ConfigQueryOrReplyFunc;

        // Alignment
        dwReservedBits: array [0..2] of DWORD;

        // Encryption GUIDs
        guidConfigBitstreamEncryption: TGUID;
        guidConfigMBcontrolEncryption: TGUID;
        guidConfigResidDiffEncryption: TGUID;

        // Bitstream Processing Indicator
        bConfigBitstreamRaw: byte;

        // Macroblock Control Config
        bConfigMBcontrolRasterOrder: byte;

        // Host Resid Diff Config
        bConfigResidDiffHost: byte;
        bConfigSpatialResid8: byte;
        bConfigResid8Subtraction: byte;
        bConfigSpatialHost8or9Clipping: byte;
        bConfigSpatialResidInterleaved: byte;
        bConfigIntraResidUnsigned: byte;

        // Accelerator Resid Diff Config
        bConfigResidDiffAccelerator: byte;
        bConfigHostInverseScan: byte;
        bConfigSpecificIDCT: byte;
        bConfig4GroupedCoefs: byte;
    end;
    PDXVA_ConfigPictureDecode = ^TDXVA_ConfigPictureDecode;

    TDXVA_PictureParameters = packed record

        wDecodedPictureIndex: word;
        wDeblockedPictureIndex: word;

        wForwardRefPictureIndex: word;
        wBackwardRefPictureIndex: word;

        wPicWidthInMBminus1: word;
        wPicHeightInMBminus1: word;

        bMacroblockWidthMinus1: byte;
        bMacroblockHeightMinus1: byte;

        bBlockWidthMinus1: byte;
        bBlockHeightMinus1: byte;

        bBPPminus1: byte;

        bPicStructure: byte;
        bSecondField: byte;
        bPicIntra: byte;
        bPicBackwardPrediction: byte;

        bBidirectionalAveragingMode: byte;
        bMVprecisionAndChromaRelation: byte;
        bChromaFormat: byte;

        bPicScanFixed: byte;
        bPicScanMethod: byte;
        bPicReadbackRequests: byte;

        bRcontrol: byte;
        bPicSpatialResid8: byte;
        bPicOverflowBlocks: byte;
        bPicExtrapolation: byte;

        bPicDeblocked: byte;
        bPicDeblockConfined: byte;
        bPic4MVallowed: byte;
        bPicOBMC: byte;
        bPicBinPB: byte;
        bMV_RPS: byte;

        bReservedBits: byte;

        wBitstreamFcodes: word;
        wBitstreamPCEelements: word;
        bBitstreamConcealmentNeed: byte;
        bBitstreamConcealmentMethod: byte;

    end;
    PDXVA_PictureParameters = ^TDXVA_PictureParameters;


{$Z4}
{$A4}
    //pragma pack(pop, BeforeDXVApacking)

    IDirect3DDevice9 = DWORD;
    PIDirect3DDevice9 = ^IDirect3DDevice9;

    IDirect3DSurface9 = DWORD;
    PIDirect3DSurface9 = ^IDirect3DSurface9;

    TD3DFORMAT = DWORD;
    PD3DFORMAT = ^TD3DFORMAT;

    TD3DPOOL = DWORD;
    PD3DPOOL = ^TD3DPOOL;


    // -------------------------------------------------------------------------
    // Decoding data types used with RenderMoComp
    // -------------------------------------------------------------------------


    TDXVAUncompDataInfo = record
        UncompWidth: DWORD;    { Width of uncompressed data }
        UncompHeight: DWORD;   { Height of uncompressed data }
        UncompFormat: TD3DFORMAT;   { Format of uncompressed data }
    end;

    TDXVACompBufferInfo = record
        NumCompBuffers: DWORD;     { Number of buffers reqd for compressed data }
        WidthToCreate: DWORD;      { Width of surface to create }
        HeightToCreate: DWORD;     { Height of surface to create }
        BytesToAllocate: DWORD;    { Total number of bytes used by each surface }
        Usage: DWORD;              { Usage used to create the compressed buffer }
        Pool: TD3DPOOL;               { Pool where the compressed buffer belongs }
        Format: TD3DFORMAT;             { Format used to create the compressed buffer }
    end;

    TDXVABufferInfo = record
        pCompSurface: pointer;   { Pointer to buffer containing compressed data }
        DataOffset: DWORD;     { Offset of relevant data from the beginning of buffer }
        DataSize: DWORD;       { Size of relevant data }
    end;


    // -------------------------------------------------------------------------

    // D3DFORMAT describes a pixel memory layout, DXVA sample format contains
    // additional information that describes how the pixels should be interpreted.

    // DXVA Extended color data - occupies the SampleFormat DWORD
    // data fields.
    // -------------------------------------------------------------------------


    TDXVA_SampleFormat = (
        DXVA_SampleFormatMask = $FF,   // 8 bits used for DXVA Sample format
        DXVA_SampleUnknown = 0,
        DXVA_SamplePreviousFrame = 1,
        DXVA_SampleProgressiveFrame = 2,
        DXVA_SampleFieldInterleavedEvenFirst = 3,
        DXVA_SampleFieldInterleavedOddFirst = 4,
        DXVA_SampleFieldSingleEven = 5,
        DXVA_SampleFieldSingleOdd = 6,
        DXVA_SampleSubStream = 7);


    TDXVA_VideoTransferFunction = (
        DXVA_VideoTransFuncShift = (DXVA_ExtColorData_ShiftBase + 19),
        DXVA_VideoTransFuncMask = ((($FFFFFFFF shl 5) xor $FFFFFFFF) shl Ord(DXVA_VideoTransFuncShift)),
        // DXVAColorMask(5, DXVA_VideoTransFuncShift),
        DXVA_VideoTransFunc_Unknown = 0,
        DXVA_VideoTransFunc_10 = 1,
        DXVA_VideoTransFunc_18 = 2,
        DXVA_VideoTransFunc_20 = 3,
        DXVA_VideoTransFunc_22 = 4,
        DXVA_VideoTransFunc_22_709 = 5,
        DXVA_VideoTransFunc_22_240M = 6,
        DXVA_VideoTransFunc_22_8bit_sRGB = 7,
        DXVA_VideoTransFunc_28 = 8);

    TDXVA_VideoPrimaries = (
        DXVA_VideoPrimariesShift = (DXVA_ExtColorData_ShiftBase + 14),
        DXVA_VideoPrimariesMask = ((($FFFFFFFF shl 5) xor $FFFFFFFF) shl Ord(DXVA_VideoPrimariesShift)),
        // DXVAColorMask(5, DXVA_VideoPrimariesShift),

        DXVA_VideoPrimaries_Unknown = 0,
        DXVA_VideoPrimaries_reserved = 1,
        DXVA_VideoPrimaries_BT709 = 2,
        DXVA_VideoPrimaries_BT470_2_SysM = 3,
        DXVA_VideoPrimaries_BT470_2_SysBG = 4,
        DXVA_VideoPrimaries_SMPTE170M = 5,
        DXVA_VideoPrimaries_SMPTE240M = 6,
        DXVA_VideoPrimaries_EBU3213 = 7,
        DXVA_VideoPrimaries_SMPTE_C = 8);

    TDXVA_VideoLighting = (
        DXVA_VideoLightingShift = (DXVA_ExtColorData_ShiftBase + 10),
        DXVA_VideoLightingMask = ((($FFFFFFFF shl 4) xor $FFFFFFFF) shl Ord(DXVA_VideoLightingShift)), // DXVAColorMask(4, DXVA_VideoLightingShift),
        DXVA_VideoLighting_Unknown = 0,
        DXVA_VideoLighting_bright = 1,
        DXVA_VideoLighting_office = 2,
        DXVA_VideoLighting_dim = 3,
        DXVA_VideoLighting_dark = 4);


    TDXVA_VideoTransferMatrix = (
        DXVA_VideoTransferMatrixShift = (DXVA_ExtColorData_ShiftBase + 7),
        DXVA_VideoTransferMatrixMask = ((($FFFFFFFF shl 3) xor $FFFFFFFF) shl Ord(DXVA_VideoTransferMatrixShift)),
        // DXVAColorMask(3, DXVA_VideoTransferMatrixShift),

        DXVA_VideoTransferMatrix_Unknown = 0,
        DXVA_VideoTransferMatrix_BT709 = 1,
        DXVA_VideoTransferMatrix_BT601 = 2,
        DXVA_VideoTransferMatrix_SMPTE240M = 3);

    TDXVA_NominalRange = (
        DXVA_NominalRangeShift = (DXVA_ExtColorData_ShiftBase + 4),
        DXVA_NominalRangeMask = ((($FFFFFFFF shl 3) xor $FFFFFFFF) shl Ord(DXVA_NominalRangeShift)), // DXVAColorMask(3, DXVA_NominalRangeShift),

        DXVA_NominalRange_Unknown = 0,
        DXVA_NominalRange_Normal = 1,
        DXVA_NominalRange_Wide = 2,

        DXVA_NominalRange_0_255 = 1,
        DXVA_NominalRange_16_235 = 2,
        DXVA_NominalRange_48_208 = 3);

    TDXVA_VideoChromaSubsampling = (
        DXVA_VideoChromaSubsamplingShift = (DXVA_ExtColorData_ShiftBase + 0),
        DXVA_VideoChromaSubsamplingMask = ((($FFFFFFFF shl 4) xor $FFFFFFFF) shl Ord(DXVA_VideoChromaSubsamplingShift)),
        // DXVAColorMask(4, DXVA_VideoChromaSubsamplingShift),

        DXVA_VideoChromaSubsampling_Unknown = 0,
        DXVA_VideoChromaSubsampling_ProgressiveChroma = $8,
        DXVA_VideoChromaSubsampling_Horizontally_Cosited = $4,
        DXVA_VideoChromaSubsampling_Vertically_Cosited = $2,
        DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = $1,
        // 4:2:0 variations
        DXVA_VideoChromaSubsampling_MPEG2 = Ord(DXVA_VideoChromaSubsampling_Horizontally_Cosited) or
        Ord(DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes),

        DXVA_VideoChromaSubsampling_MPEG1 = DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes,

        DXVA_VideoChromaSubsampling_DV_PAL = Ord(DXVA_VideoChromaSubsampling_Horizontally_Cosited) or
        Ord(DXVA_VideoChromaSubsampling_Vertically_Cosited),
        // 4:4:4, 4:2:2, 4:1:1
        DXVA_VideoChromaSubsampling_Cosited = Ord(DXVA_VideoChromaSubsampling_Horizontally_Cosited) or
        Ord(DXVA_VideoChromaSubsampling_Vertically_Cosited) or Ord(DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes)
        );

{$IFDEF FPC}
    TDXVA_ExtendedFormat = bitpacked record
        SampleFormat: 0..255;           // See DXVA_SampleFormat
        VideoChromaSubsampling: 0..15; // See DXVA_VideoChromaSubSampling
        NominalRange: 0..7;           // See DXVA_NominalRange
        VideoTransferMatrix: 0..7;    // See DXVA_VideoTransferMatrix
        VideoLighting: 0..15;          // See DXVA_VideoLighting
        VideoPrimaries: 0..31;         // See DXVA_VideoPrimaries
        VideoTransferFunction: 0..31;  // See DXVA_VideoTransferFunction
    end;

{$ELSE}
    TDXVA_ExtendedFormat = record
        Value: UINT;
    end;
{$ENDIF}


    // -------------------------------------------------------------------------

    // The definitions that follow describe the video de-interlace interface
    // between the VMR and the graphics device driver.  This interface is not
    // accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------


    TREFERENCE_TIME = LONGLONG;


    // -------------------------------------------------------------------------
    // data structures shared by User mode and Kernel mode.
    // -------------------------------------------------------------------------


    TDXVA_Frequency = record
        Numerator: DWORD;
        Denominator: DWORD;
    end;

    TDXVA_VideoDesc = record
        Size: DWORD;
        SampleWidth: DWORD;
        SampleHeight: DWORD;
        SampleFormat: DWORD; // also contains extend color data
        d3dFormat: TD3DFORMAT;
        InputSampleFreq: TDXVA_Frequency;
        OutputFrameFreq: TDXVA_Frequency;
    end;
    PDXVA_VideoDesc = ^TDXVA_VideoDesc;

    TDXVA_VideoProcessCaps = (
        DXVA_VideoProcess_None = $0000,
        DXVA_VideoProcess_YUV2RGB = $0001,
        DXVA_VideoProcess_StretchX = $0002,
        DXVA_VideoProcess_StretchY = $0004,
        DXVA_VideoProcess_AlphaBlend = $0008,
        DXVA_VideoProcess_SubRects = $0010,
        DXVA_VideoProcess_SubStreams = $0020,
        DXVA_VideoProcess_SubStreamsExtended = $0040,
        DXVA_VideoProcess_YUV2RGBExtended = $0080,
        DXVA_VideoProcess_AlphaBlendExtended = $0100);

    TDXVA_DeinterlaceTech = (

        // the algorithm is unknown or proprietary
        DXVA_DeinterlaceTech_Unknown = $0000,

        // the algorithm creates the missing lines by repeating
        // the line either above or below it - this method will look very jaggy and
        // isn't recommended
        DXVA_DeinterlaceTech_BOBLineReplicate = $0001,

        // The algorithm creates the missing lines by vertically stretching each
        // video field by a factor of two by averaging two lines
        DXVA_DeinterlaceTech_BOBVerticalStretch = $0002,

        // or using a [-1, 9, 9, -1]/16 filter across four lines.
        DXVA_DeinterlaceTech_BOBVerticalStretch4Tap = $0100,

        // the pixels in the missing line are recreated by a median filtering operation
        DXVA_DeinterlaceTech_MedianFiltering = $0004,

        // the pixels in the missing line are recreated by an edge filter.
        // In this process, spatial directional filters are applied to determine
        // the orientation of edges in the picture content, and missing
        // pixels are created by filtering along (rather than across) the
        // detected edges.
        DXVA_DeinterlaceTech_EdgeFiltering = $0010,

        // the pixels in the missing line are recreated by switching on a field by
        // field basis between using either spatial or temporal interpolation
        // depending on the amount of motion.
        DXVA_DeinterlaceTech_FieldAdaptive = $0020,

        // the pixels in the missing line are recreated by switching on a pixel by pixel
        // basis between using either spatial or temporal interpolation depending on
        // the amount of motion..
        DXVA_DeinterlaceTech_PixelAdaptive = $0040,

        // Motion Vector Steering  identifies objects within a sequence of video
        // fields.  The missing pixels are recreated after first aligning the
        // movement axes of the individual objects in the scene to make them
        // parallel with the time axis.
        DXVA_DeinterlaceTech_MotionVectorSteered = $0080
        );

    TDXVA_VideoSample = record
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        SampleFormat: TDXVA_SampleFormat;   // only lower 8 bits used
        lpDDSSrcSurface: pointer;
    end;
    PDXVA_VideoSample = ^TDXVA_VideoSample;

    // -------------------------------------------------------------------------
    // DeinterlaceBltEx declarations
    // -------------------------------------------------------------------------


    TDXVA_SampleFlags = (
        DXVA_SampleFlagsMask = (1 shl 3) or (1 shl 2) or (1 shl 1) or (1 shl 1),
        DXVA_SampleFlag_Palette_Changed = $0001,
        DXVA_SampleFlag_SrcRect_Changed = $0002,
        DXVA_SampleFlag_DstRect_Changed = $0004,
        DXVA_SampleFlag_ColorData_Changed = $0008);

    TDXVA_DestinationFlags = (
        DXVA_DestinationFlagMask = (1 shl 3) or (1 shl 2) or (1 shl 1) or (1 shl 1),

        DXVA_DestinationFlag_Background_Changed = $0001,
        DXVA_DestinationFlag_TargetRect_Changed = $0002,
        DXVA_DestinationFlag_ColorData_Changed = $0004,
        DXVA_DestinationFlag_Alpha_Changed = $0008);

    TDXVA_VideoSample2 = record
{$IFDEF WIN64}
        Size: DWORD;
        Reserved: DWORD;
{$ENDIF}
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        SampleFormat: DWORD;   // cast to DXVA_ExtendedFormat, or use Extract macros
        SampleFlags: DWORD;
        lpDDSSrcSurface: pointer;
        rcSrc: TRECT;
        rcDst: TRECT;
        Palette: array [0..15] of TDXVA_AYUVsample2;
    end;
    PDXVA_VideoSample2 = ^TDXVA_VideoSample2;

    TDXVA_DeinterlaceCaps = record
        Size: DWORD;
        NumPreviousOutputFrames: DWORD;
        InputPool: DWORD;
        NumForwardRefSamples: DWORD;
        NumBackwardRefSamples: DWORD;
        d3dOutputFormat: TD3DFORMAT;
        VideoProcessingCaps: TDXVA_VideoProcessCaps;
        DeinterlaceTechnology: TDXVA_DeinterlaceTech;
    end;
    PDXVA_DeinterlaceCaps = ^TDXVA_DeinterlaceCaps;

    // -------------------------------------------------------------------------
    // Data types used with RenderMoComp in kernel mode
    // -------------------------------------------------------------------------


    // Function codes for RenderMoComp


{$IFDEF WIN64}

    // These structures are used for thunking 32 bit DeinterlaceBltEx calls on
    // 64 bit drivers.

    TDXVA_VideoSample32 = record
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        SampleFormat: DWORD;
        SampleFlags: DWORD;
        lpDDSSrcSurface: DWORD;  // 32 bit pointer size
        rcSrc: TRECT;
        rcDst: TRECT;
        Palette: array [0..15] of TDXVA_AYUVsample2;
        // DWORD Pad;
        // 4 bytes of padding added by the compiler to align the struct to 8 bytes.
    end;

    TDXVA_DeinterlaceBltEx32 = record
        Size: DWORD;
        BackgroundColor: TDXVA_AYUVsample2;
        rcTarget: TRECT;
        rtTarget: TREFERENCE_TIME;
        NumSourceSurfaces: DWORD;
        Alpha: single;
        Source: array [0..MAX_DEINTERLACE_SURFACES - 1] of TDXVA_VideoSample32;
        DestinationFormat: DWORD;
        DestinationFlags: DWORD;
    end;
{$ENDIF}

    TDXVA_DeinterlaceBlt = record
        Size: DWORD;
        Reserved: DWORD;
        rtTarget: TREFERENCE_TIME;
        DstRect: TRECT;
        SrcRect: TRECT;
        NumSourceSurfaces: DWORD;
        Alpha: single;
        Source: array [0..MAX_DEINTERLACE_SURFACES - 1] of TDXVA_VideoSample;
    end;


    // lpInput => DXVA_DeinterlaceBlt*
    // lpOuput => NULL { not currently used }

    TDXVA_DeinterlaceBltEx = record
        Size: DWORD;
        BackgroundColor: TDXVA_AYUVsample2;
        rcTarget: TRECT;
        rtTarget: TREFERENCE_TIME;
        NumSourceSurfaces: DWORD;
        Alpha: single;
        Source: array[0..MAX_DEINTERLACE_SURFACES - 1] of TDXVA_VideoSample2;
        DestinationFormat: DWORD;
        DestinationFlags: DWORD;
    end;


    TDXVA_DeinterlaceQueryAvailableModes = record
        Size: DWORD;
        NumGuids: DWORD;
        Guids: array [0..MAX_DEINTERLACE_DEVICE_GUIDS - 1] of TGUID;
    end;


    TDXVA_DeinterlaceQueryModeCaps = record
        Size: DWORD;
        Guid: TGUID;
        VideoDesc: TDXVA_VideoDesc;
    end;


    // -------------------------------------------------------------------------

    // The definitions that follow describe the video ProcAmp interface
    // between the VMR and the graphics device driver.  This interface is not
    // accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------


    TDXVA_ProcAmpControlProp = (
        DXVA_ProcAmp_None = $0000,
        DXVA_ProcAmp_Brightness = $0001,
        DXVA_ProcAmp_Contrast = $0002,
        DXVA_ProcAmp_Hue = $0004,
        DXVA_ProcAmp_Saturation = $0008);

    TDXVA_ProcAmpControlCaps = record
        Size: DWORD;
        InputPool: DWORD;
        d3dOutputFormat: TD3DFORMAT;
        ProcAmpControlProps: DWORD;// see DXVA_ProcAmpControlProp
        VideoProcessingCaps: DWORD;// see DXVA_VideoProcessCaps
    end;
    PDXVA_ProcAmpControlCaps = ^TDXVA_ProcAmpControlCaps;


    TDXVA_ProcAmpControlQueryRange = record
        Size: DWORD;
        ProcAmpControlProp: TDXVA_ProcAmpControlProp;
        VideoDesc: TDXVA_VideoDesc;
    end;
    PDXVA_ProcAmpControlQueryRange = ^TDXVA_ProcAmpControlQueryRange;

    TDXVA_VideoPropertyRange = record
        MinValue: single;
        MaxValue: single;
        DefaultValue: single;
        StepSize: single;
    end;
    PDXVA_VideoPropertyRange = ^TDXVA_VideoPropertyRange;


    TDXVA_ProcAmpControlBlt = record
        Size: DWORD;
        DstRect: TRECT;
        SrcRect: TRECT;
        Alpha: single;
        Brightness: single;
        Contrast: single;
        Hue: single;
        Saturation: single;
    end;


    // -------------------------------------------------------------------------

    // The definitions that follow describe the Certified Output Protection
    // Protocol between the VMR and the graphics device driver.  This interface
    // is not accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------


    // -------------------------------------------------------------------------
    // COPPSequenceStart
    // -------------------------------------------------------------------------
    TDXVA_COPPSignature = record
        Signature: array [0..255] of UCHAR;
    end;
    PDXVA_COPPSignature = ^TDXVA_COPPSignature;


    // -------------------------------------------------------------------------
    // COPPCommand
    // -------------------------------------------------------------------------
    TDXVA_COPPCommand = record
        macKDI: TGUID;             //   16 bytes
        guidCommandID: TGUID;      //   16 bytes
        dwSequence: ULONG;         //    4 bytes
        cbSizeData: ULONG;         //    4 bytes
        CommandData: array [0..4056 - 1] of UCHAR;  // 4056 bytes (4056+4+4+16+16 = 4096)
    end;
    PDXVA_COPPCommand = ^TDXVA_COPPCommand;


    TDXVA_COPPSetProtectionLevelCmdData = record
        ProtType: ULONG;
        ProtLevel: ULONG;
        ExtendedInfoChangeMask: ULONG;
        ExtendedInfoData: ULONG;
    end;
    PDXVA_COPPSetProtectionLevelCmdData = ^TDXVA_COPPSetProtectionLevelCmdData;

    // Set the HDCP protection level - (0 - 1 DWORD, 4 bytes)

    TCOPP_HDCP_Protection_Level = (
        COPP_HDCP_Level0 = 0,
        COPP_HDCP_LevelMin = COPP_HDCP_Level0,
        COPP_HDCP_Level1 = 1,
        COPP_HDCP_LevelMax = COPP_HDCP_Level1,
        COPP_HDCP_ForceDWORD = $7fffffff);

    TCOPP_CGMSA_Protection_Level = (
        COPP_CGMSA_Disabled = 0,
        COPP_CGMSA_LevelMin = COPP_CGMSA_Disabled,
        COPP_CGMSA_CopyFreely = 1,
        COPP_CGMSA_CopyNoMore = 2,
        COPP_CGMSA_CopyOneGeneration = 3,
        COPP_CGMSA_CopyNever = 4,
        COPP_CGMSA_RedistributionControlRequired = $08,
        COPP_CGMSA_LevelMax = (COPP_CGMSA_RedistributionControlRequired + COPP_CGMSA_CopyNever),
        COPP_CGMSA_ForceDWORD = $7fffffff);

    TCOPP_ACP_Protection_Level = (
        COPP_ACP_Level0 = 0,
        COPP_ACP_LevelMin = COPP_ACP_Level0,
        COPP_ACP_Level1 = 1,
        COPP_ACP_Level2 = 2,
        COPP_ACP_Level3 = 3,
        COPP_ACP_LevelMax = COPP_ACP_Level3,
        COPP_ACP_ForceDWORD = $7fffffff);


    TDXVA_COPPSetSignalingCmdData = record
        ActiveTVProtectionStandard: ULONG;           // See COPP_TVProtectionStandard
        AspectRatioChangeMask1: ULONG;
        AspectRatioData1: ULONG;                     // See COPP_ImageAspectRatio_EN300294 for ETSI EN 300 294 values
        AspectRatioChangeMask2: ULONG;
        AspectRatioData2: ULONG;
        AspectRatioChangeMask3: ULONG;
        AspectRatioData3: ULONG;
        ExtendedInfoChangeMask: array [0..3] of ULONG;
        ExtendedInfoData: array [0..3] of ULONG;
        Reserved: ULONG;
    end;

    // Add format enum and data enum
    TCOPP_TVProtectionStandard = (
        COPP_ProtectionStandard_Unknown = $80000000,
        COPP_ProtectionStandard_None = $00000000,
        COPP_ProtectionStandard_IEC61880_525i = $00000001,
        COPP_ProtectionStandard_IEC61880_2_525i = $00000002,
        COPP_ProtectionStandard_IEC62375_625p = $00000004,
        COPP_ProtectionStandard_EIA608B_525 = $00000008,
        COPP_ProtectionStandard_EN300294_625i = $00000010,
        COPP_ProtectionStandard_CEA805A_TypeA_525p = $00000020,
        COPP_ProtectionStandard_CEA805A_TypeA_750p = $00000040,
        COPP_ProtectionStandard_CEA805A_TypeA_1125i = $00000080,
        COPP_ProtectionStandard_CEA805A_TypeB_525p = $00000100,
        COPP_ProtectionStandard_CEA805A_TypeB_750p = $00000200,
        COPP_ProtectionStandard_CEA805A_TypeB_1125i = $00000400,
        COPP_ProtectionStandard_ARIBTRB15_525i = $00000800,
        COPP_ProtectionStandard_ARIBTRB15_525p = $00001000,
        COPP_ProtectionStandard_ARIBTRB15_750p = $00002000,
        COPP_ProtectionStandard_ARIBTRB15_1125i = $00004000,
        COPP_ProtectionStandard_Mask = $80007FFF,
        COPP_ProtectionStandard_Reserved = $7FFF8000);


    TCOPP_ImageAspectRatio_EN300294 = (
        COPP_AspectRatio_EN300294_FullFormat4by3 = 0,
        COPP_AspectRatio_EN300294_Box14by9Center = 1,
        COPP_AspectRatio_EN300294_Box14by9Top = 2,
        COPP_AspectRatio_EN300294_Box16by9Center = 3,
        COPP_AspectRatio_EN300294_Box16by9Top = 4,
        COPP_AspectRatio_EN300294_BoxGT16by9Center = 5,
        COPP_AspectRatio_EN300294_FullFormat4by3ProtectedCenter = 6,
        COPP_AspectRatio_EN300294_FullFormat16by9Anamorphic = 7,
        COPP_AspectRatio_ForceDWORD = $7fffffff);

    // -------------------------------------------------------------------------
    // COPPQueryStatus
    // -------------------------------------------------------------------------
    TDXVA_COPPStatusInput = record
        rApp: TGUID;               //   16 bytes
        guidStatusRequestID: TGUID;//   16 bytes
        dwSequence: ULONG;         //    4 bytes
        cbSizeData: ULONG;         //    4 bytes
        StatusData: array [0..4056 - 1] of UCHAR;   // 4056 bytes (4056+4+4+16+16 = 4096)
    end;
    PDXVA_COPPStatusInput = ^TDXVA_COPPStatusInput;

    TDXVA_COPPStatusOutput = record
        macKDI: TGUID;             //   16 bytes
        cbSizeData: ULONG;         //    4 bytes
        COPPStatus: array [0..4076 - 1] of UCHAR;   // 4076 bytes (4076+16+4 = 4096)
    end;
    PDXVA_COPPStatusOutput = ^TDXVA_COPPStatusOutput;

    TCOPP_StatusFlags = (
        COPP_StatusNormal = $00,
        COPP_LinkLost = $01,
        COPP_RenegotiationRequired = $02,
        COPP_StatusFlagsReserved = $FFFFFFFC);

    TDXVA_COPPStatusData = record
        rApp: TGUID;
        dwFlags: ULONG;    // See COPP_StatusFlags above
        dwData: ULONG;
        ExtendedInfoValidMask: ULONG;
        ExtendedInfoData: ULONG;
    end;

    TDXVA_COPPStatusDisplayData = record
        rApp: TGUID;
        dwFlags: ULONG;    // See COPP_StatusFlags above
        DisplayWidth: ULONG;
        DisplayHeight: ULONG;
        Format: ULONG;     // also contains extended color data
        d3dFormat: ULONG;
        FreqNumerator: ULONG;
        FreqDenominator: ULONG;
    end;

    TCOPP_StatusHDCPFlags = (
        COPP_HDCPRepeater = $01,
        COPP_HDCPFlagsReserved = $FFFFFFFE);

    TDXVA_COPPStatusHDCPKeyData = record
        rApp: TGUID;
        dwFlags: ULONG;        // See COPP_StatusFlags above
        dwHDCPFlags: ULONG;    // See COPP_StatusHDCPFlags above
        BKey: TGUID;           // Lower 40 bits
        Reserved1: TGUID;
        Reserved2: TGUID;
    end;


    TCOPP_ConnectorType = (
        COPP_ConnectorType_Unknown = -1,
        COPP_ConnectorType_VGA = 0,
        COPP_ConnectorType_SVideo = 1,
        COPP_ConnectorType_CompositeVideo = 2,
        COPP_ConnectorType_ComponentVideo = 3,
        COPP_ConnectorType_DVI = 4,
        COPP_ConnectorType_HDMI = 5,
        COPP_ConnectorType_LVDS = 6,
        COPP_ConnectorType_TMDS = 7,
        COPP_ConnectorType_D_JPN = 8,
        COPP_ConnectorType_Internal = $80000000,   // can be combined with the other connector types
        COPP_ConnectorType_ForceDWORD = $7fffffff  { force 32-bit size enum });


    TCOPP_BusType = (
        COPP_BusType_Unknown = 0,
        COPP_BusType_PCI = 1,
        COPP_BusType_PCIX = 2,
        COPP_BusType_PCIExpress = 3,
        COPP_BusType_AGP = 4,
        COPP_BusType_Integrated = $80000000, // can be combined with the other bus types
        COPP_BusType_ForceDWORD = $7fffffff  { force 32-bit size enum });


    TDXVA_COPPStatusSignalingCmdData = record
        rApp: TGUID;
        dwFlags: ULONG;                                // See COPP_StatusFlags above
        AvailableTVProtectionStandards: ULONG;         // See COPP_TVProtectionStandard
        ActiveTVProtectionStandard: ULONG;             // See COPP_TVProtectionStandard
        TVType: ULONG;
        AspectRatioValidMask1: ULONG;
        AspectRatioData1: ULONG;                       // See COPP_AspectRatio_EN300294 for ETSI EN 300 294 values
        AspectRatioValidMask2: ULONG;
        AspectRatioData2: ULONG;
        AspectRatioValidMask3: ULONG;
        AspectRatioData3: ULONG;
        ExtendedInfoValidMask: array [0..3] of ULONG;
        ExtendedInfoData: array [0..3] of ULONG;
    end;


function DXVA_ExtractSampleFormat(sf: byte): DWORD; inline;
function DXVA_ExtractExtColorData(sf, Mask, Shift: UINT): DWORD; inline;
function DXVABitMask(n: uint): Dword; inline;

implementation



function DXVABit(x: UINT): DWORD; inline;
begin
    Result := 1 shl x;
end;



function DXVA_ExtractSampleFormat(sf: byte): DWORD; inline;
begin
    Result := sf and Ord(DXVA_SampleFormatMask);
end;



function DXVA_ExtractExtColorData(sf, Mask, Shift: UINT): DWORD; inline;
begin
    Result := (sf and Mask) shr Shift;
end;



function DXVABitMask(n: uint): Dword; inline;
begin
    // #define DXVABitMask(__n) (~((~0) << __n))
    Result := ($FFFFFFFF shl n) xor $FFFFFFFF;
end;



function DXVAColorMask(bits: UINT; base: UINT): DWORD;
begin
    Result := (DXVABitMask(bits) shl base);
end;


end.





































