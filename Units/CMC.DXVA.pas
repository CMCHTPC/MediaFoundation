// ------------------------------------------------------------------------------
// File: DXVA.h

// Desc: DirectX Video Acceleration header file.

// Copyright (c) 1999 - 2002, Microsoft Corporation.  All rights reserved.
// ------------------------------------------------------------------------------

unit CMC.DXVA;
{$IFDEF FPC}
{$MODE delphi}
{$ENDIF}

interface

{$Z4}
{$A4}

uses
    Windows, Classes, SysUtils, Direct3D9;


// -------------------------------------------------------------------------

// The definitions that follow describe the DirectX Video Acceleration
// decoding interface.
// This interface is accessable via the IAMVideoAccelerator interface.

// -------------------------------------------------------------------------

const
    IID_IDirect3DVideoDevice9: TGUID = '{694036ac-542a-4a3a-9a32-53bc20002c1b}';
    IID_IDirect3DDXVADevice9: TGUID = '{9f00c3d3-5ab6-465f-b955-9f0ebb2c5606}';

const

    DXVA_ModeNone: TGUID = '{1b81be00-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH261_A: TGUID = '{1b81be01-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH261_B: TGUID = '{1b81be02-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH263_A: TGUID = '{1b81be03-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH263_B: TGUID = '{1b81be04-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH263_C: TGUID = '{1b81be05-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH263_D: TGUID = '{1b81be06-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH263_E: TGUID = '{1b81be07-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH263_F: TGUID = '{1b81be08-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG1_A: TGUID = '{1b81be09-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG1_VLD: TGUID = '{6f3ec719-3735-42cc-8063-65cc3cb36616}';
    DXVA_ModeMPEG2_A: TGUID = '{1b81be0A-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG2_B: TGUID = '{1b81be0B-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG2_C: TGUID = '{1b81be0C-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG2_D: TGUID = '{1b81be0D-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG2and1_VLD: TGUID = '{86695f12-340e-4f04-9fd3-9253dd327460}';

    DXVA_ModeH264_A: TGUID = '{1b81be64-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_MoComp_NoFGT: TGUID = '{1b81be64-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_B: TGUID = '{1b81be65-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_MoComp_FGT: TGUID = '{1b81be65-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_C: TGUID = '{1b81be66-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_IDCT_NoFGT: TGUID = '{1b81be66-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_D: TGUID = '{1b81be67-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_IDCT_FGT: TGUID = '{1b81be67-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_E: TGUID = '{1b81be68-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_VLD_NoFGT: TGUID = '{1b81be68-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_F: TGUID = '{1b81be69-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeH264_VLD_FGT: TGUID = '{1b81be69-a0c7-11d3-b984-00c04f2e73c5}';

    DXVA_ModeH264_VLD_WithFMOASO_NoFGT: TGUID = '{d5f04ff9-3418-45d8-9561-32a76aae2ddd}';
    DXVA_ModeH264_VLD_Stereo_Progressive_NoFGT: TGUID = '{d79be8da-0cf1-4c81-b82a-69a4e236f43d}';
    DXVA_ModeH264_VLD_Stereo_NoFGT: TGUID = '{f9aaccbb-c2b6-4cfc-8779-5707b1760552}';
    DXVA_ModeH264_VLD_Multiview_NoFGT: TGUID = '{705b9d82-76cf-49d6-b7e6-ac8872db013c}';

    DXVA_ModeWMV8_A: TGUID = '{1b81be80-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV8_PostProc: TGUID = '{1b81be80-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV8_B: TGUID = '{1b81be81-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV8_MoComp: TGUID = '{1b81be81-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV9_A: TGUID = '{1b81be90-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV9_PostProc: TGUID = '{1b81be90-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV9_B: TGUID = '{1b81be91-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV9_MoComp: TGUID = '{1b81be91-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV9_C: TGUID = '{1b81be94-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeWMV9_IDCT: TGUID = '{1b81be94-a0c7-11d3-b984-00c04f2e73c5}';

    DXVA_ModeVC1_A: TGUID = '{1b81beA0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_PostProc: TGUID = '{1b81beA0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_B: TGUID = '{1b81beA1-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_MoComp: TGUID = '{1b81beA1-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_C: TGUID = '{1b81beA2-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_IDCT: TGUID = '{1b81beA2-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_D: TGUID = '{1b81beA3-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeVC1_VLD: TGUID = '{1b81beA3-a0c7-11d3-b984-00c04f2e73c5}';

    DXVA_ModeVC1_D2010: TGUID = '{1b81beA4-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_ModeMPEG4pt2_VLD_Simple: TGUID = '{efd64d74-c9e8-41d7-a5e9-e9b0e39fa319}';
    DXVA_ModeMPEG4pt2_VLD_AdvSimple_NoGMC: TGUID = '{ed418a9f-010d-4eda-9ae3-9a65358d8d2e}';
    DXVA_ModeMPEG4pt2_VLD_AdvSimple_GMC: TGUID = '{ab998b5b-4258-44a9-9feb-94e597a6baae}';
    DXVA_ModeHEVC_VLD_Main: TGUID = '{5b11d51b-2f4c-4452-bcc3-09f2a1160cc0}';
    DXVA_ModeHEVC_VLD_Main10: TGUID = '{107af0e0-ef1a-4d19-aba8-67a163073d13}';
    DXVA_NoEncrypt: TGUID = '{1b81beD0-a0c7-11d3-b984-00c04f2e73c5}';
    DXVA_DeinterlaceBobDevice: TGUID = '{335aa36e-7884-43a4-9c91-7f87faf3e37e}';
    DXVA_DeinterlaceContainerDevice: TGUID = '{0e85cb93-3046-4ff0-aecc-d58cb5f035fd}';
    DXVA_ProcAmpControlDevice: TGUID = '{9f200913-2ffd-4056-9f1e-e1b508f22dcf}';
    DXVA_COPPDevice: TGUID = '{d2457add-8999-45ed-8a8a-d1aa047ba4d5}';
    DXVA_COPPSetProtectionLevel: TGUID = '{9bb9327c-4eb5-4727-9f00-b42b0919c0da}';
    DXVA_COPPSetSignaling: TGUID = '{09a631a5-d684-4c60-8e4d-d3bb0f0be3ee}';
    DXVA_COPPQueryConnectorType: TGUID = '{81d0bfd5-6afe-48c2-99c0-95a08f97c5da}';
    DXVA_COPPQueryProtectionType: TGUID = '{38f2a801-9a6c-48bb-9107-b6696e6f1797}';
    DXVA_COPPQueryLocalProtectionLevel: TGUID = '{b2075857-3eda-4d5d-88db-748f8c1a0549}';
    DXVA_COPPQueryGlobalProtectionLevel: TGUID = '{1957210a-7766-452a-b99a-d27aed54f03a}';
    DXVA_COPPQueryDisplayData: TGUID = '{d7bf1ba3-ad13-4f8e-af98-0dcb3ca204cc}';
    DXVA_COPPQueryHDCPKeyData: TGUID = '{0db59d74-a992-492e-a0bd-c23fda564e00}';
    DXVA_COPPQueryBusData: TGUID = '{c6f4d673-6174-4184-8e35-f6db5200bcba}';
    DXVA_COPPQuerySignaling: TGUID = '{6629a591-3b79-4cf3-924a-11e8e7811671}';

const
    DXVA_RESTRICTED_MODE_UNRESTRICTED = $FFFF;
    DXVA_RESTRICTED_MODE_H261_A = 1;
    DXVA_RESTRICTED_MODE_H261_B = 2;

    DXVA_RESTRICTED_MODE_H263_A = 3;
    DXVA_RESTRICTED_MODE_H263_B = 4;
    DXVA_RESTRICTED_MODE_H263_C = 5;
    DXVA_RESTRICTED_MODE_H263_D = 6;
    DXVA_RESTRICTED_MODE_H263_E = 7;
    DXVA_RESTRICTED_MODE_H263_F = 8;

    DXVA_RESTRICTED_MODE_MPEG1_A = 9;

    DXVA_RESTRICTED_MODE_MPEG2_A = $A;
    DXVA_RESTRICTED_MODE_MPEG2_B = $B;
    DXVA_RESTRICTED_MODE_MPEG2_C = $C;
    DXVA_RESTRICTED_MODE_MPEG2_D = $D;
    DXVA_RESTRICTED_MODE_MPEG1_VLD = $10;
    DXVA_RESTRICTED_MODE_MPEG2and1_VLD = $11;

    DXVA_RESTRICTED_MODE_H264_A = $64;
    DXVA_RESTRICTED_MODE_H264_B = $65;
    DXVA_RESTRICTED_MODE_H264_C = $66;
    DXVA_RESTRICTED_MODE_H264_D = $67;
    DXVA_RESTRICTED_MODE_H264_E = $68;
    DXVA_RESTRICTED_MODE_H264_F = $69;

    DXVA_RESTRICTED_MODE_H264_VLD_WITHFMOASO_NOFGT = $70;

    DXVA_RESTRICTED_MODE_H264_VLD_STEREO_PROGRESSIVE_NOFGT = $71;
    DXVA_RESTRICTED_MODE_H264_VLD_STEREO_NOFGT = $72;
    DXVA_RESTRICTED_MODE_H264_VLD_MULTIVIEW_NOFGT = $73;

    DXVA_RESTRICTED_MODE_WMV8_A = $80;
    DXVA_RESTRICTED_MODE_WMV8_B = $81;

    DXVA_RESTRICTED_MODE_WMV9_A = $90;
    DXVA_RESTRICTED_MODE_WMV9_B = $91;
    DXVA_RESTRICTED_MODE_WMV9_C = $94;

    DXVA_RESTRICTED_MODE_VC1_A = $A0;
    DXVA_RESTRICTED_MODE_VC1_B = $A1;
    DXVA_RESTRICTED_MODE_VC1_C = $A2;
    DXVA_RESTRICTED_MODE_VC1_D = $A3;

    DXVA_RESTRICTED_MODE_VC1_D2010 = $A4;

    DXVA_RESTRICTED_MODE_MPEG4PT2_VLD_SIMPLE = $B0;
    DXVA_RESTRICTED_MODE_MPEG4PT2_VLD_ADV_SIMPLE_NOGMC = $B1;
    DXVA_RESTRICTED_MODE_MPEG4PT2_VLD_ADV_SIMPLE_GMC = $B2;

    DXVA_RESTRICTED_MODE_WMV8_POSTPROC = DXVA_RESTRICTED_MODE_WMV8_A;
    DXVA_RESTRICTED_MODE_WMV8_MOCOMP = DXVA_RESTRICTED_MODE_WMV8_B;

    DXVA_RESTRICTED_MODE_WMV9_POSTPROC = DXVA_RESTRICTED_MODE_WMV9_A;
    DXVA_RESTRICTED_MODE_WMV9_MOCOMP = DXVA_RESTRICTED_MODE_WMV9_B;
    DXVA_RESTRICTED_MODE_WMV9_IDCT = DXVA_RESTRICTED_MODE_WMV9_C;

    DXVA_RESTRICTED_MODE_VC1_POSTPROC = DXVA_RESTRICTED_MODE_VC1_A;
    DXVA_RESTRICTED_MODE_VC1_MOCOMP = DXVA_RESTRICTED_MODE_VC1_B;
    DXVA_RESTRICTED_MODE_VC1_IDCT = DXVA_RESTRICTED_MODE_VC1_C;
    DXVA_RESTRICTED_MODE_VC1_VLD = DXVA_RESTRICTED_MODE_VC1_D;

    DXVA_RESTRICTED_MODE_H264_MOCOMP_NOFGT = DXVA_RESTRICTED_MODE_H264_A;
    DXVA_RESTRICTED_MODE_H264_MOCOMP_FGT = DXVA_RESTRICTED_MODE_H264_B;
    DXVA_RESTRICTED_MODE_H264_IDCT_NOFGT = DXVA_RESTRICTED_MODE_H264_C;
    DXVA_RESTRICTED_MODE_H264_IDCT_FGT = DXVA_RESTRICTED_MODE_H264_D;
    DXVA_RESTRICTED_MODE_H264_VLD_NOFGT = DXVA_RESTRICTED_MODE_H264_E;
    DXVA_RESTRICTED_MODE_H264_VLD_FGT = DXVA_RESTRICTED_MODE_H264_F;

    DXVA_COMPBUFFER_TYPE_THAT_IS_NOT_USED = 0;
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

    (* H.264/AVC Additional buffer types *)
    DXVA_MOTION_VECTOR_BUFFER = 16;
    DXVA_FILM_GRAIN_BUFFER = 17;

    DXVA_NUM_TYPES_COMP_BUFFERS = 18;

    (* values for bDXVA_Func *)
    DXVA_PICTURE_DECODING_FUNCTION = 1;
    DXVA_ALPHA_BLEND_DATA_LOAD_FUNCTION = 2;
    DXVA_ALPHA_BLEND_COMBINATION_FUNCTION = 3;
    DXVA_PICTURE_RESAMPLE_FUNCTION = 4;
    DXVA_DEBLOCKING_FILTER_FUNCTION = 5;
    DXVA_FILM_GRAIN_SYNTHESIS_FUNCTION = 6;
    DXVA_STATUS_REPORTING_FUNCTION = 7;

    (* values returned from Execute command in absence of read-back *)
    DXVA_EXECUTE_RETURN_OK = 0;
    DXVA_EXECUTE_RETURN_DATA_ERROR_MINOR = 1;
    DXVA_EXECUTE_RETURN_DATA_ERROR_SIGNIF = 2;
    DXVA_EXECUTE_RETURN_DATA_ERROR_SEVERE = 3;
    DXVA_EXECUTE_RETURN_OTHER_ERROR_SEVERE = 4;

    DXVA_QUERYORREPLYFUNCFLAG_DECODER_PROBE_QUERY = $FFFFF1;
    DXVA_QUERYORREPLYFUNCFLAG_DECODER_LOCK_QUERY = $FFFFF5;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_OK_COPY = $FFFFF8;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_OK_PLUS = $FFFFF9;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_LOCK_OK_COPY = $FFFFFC;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_PROBE_FALSE_PLUS = $FFFFFB;
    DXVA_QUERYORREPLYFUNCFLAG_ACCEL_LOCK_FALSE_PLUS = $FFFFFF;

    DXVA_ENCRYPTPROTOCOLFUNCFLAG_HOST = $FFFF00;
    DXVA_ENCRYPTPROTOCOLFUNCFLAG_ACCEL = $FFFF08;

    DXVA_CHROMA_FORMAT_420 = 1;
    DXVA_CHROMA_FORMAT_422 = 2;
    DXVA_CHROMA_FORMAT_444 = 3;

    DXVA_PICTURE_STRUCTURE_TOP_FIELD = 1;
    DXVA_PICTURE_STRUCTURE_BOTTOM_FIELD = 2;
    DXVA_PICTURE_STRUCTURE_FRAME = 3;

    DXVA_BIDIRECTIONAL_AVERAGING_MPEG2_ROUND = 0;
    DXVA_BIDIRECTIONAL_AVERAGING_H263_TRUNC = 1;

    DXVA_MV_PRECISION_AND_CHROMA_RELATION_MPEG2 = 0;
    DXVA_MV_PRECISION_AND_CHROMA_RELATION_H263 = 1;
    DXVA_MV_PRECISION_AND_CHROMA_RELATION_H261 = 2;

    DXVA_SCAN_METHOD_ZIG_ZAG = 0;
    DXVA_SCAN_METHOD_ALTERNATE_VERTICAL = 1;
    DXVA_SCAN_METHOD_ALTERNATE_HORIZONTAL = 2;
    DXVA_SCAN_METHOD_ARBITRARY = 3;

    DXVA_BITSTREAM_CONCEALMENT_NEED_UNLIKELY = 0;
    DXVA_BITSTREAM_CONCEALMENT_NEED_MILD = 1;
    DXVA_BITSTREAM_CONCEALMENT_NEED_LIKELY = 2;
    DXVA_BITSTREAM_CONCEALMENT_NEED_SEVERE = 3;

    DXVA_BITSTREAM_CONCEALMENT_METHOD_UNSPECIFIED = 0;
    DXVA_BITSTREAM_CONCEALMENT_METHOD_INTRA = 1;
    DXVA_BITSTREAM_CONCEALMENT_METHOD_FORWARD = 2;
    DXVA_BITSTREAM_CONCEALMENT_METHOD_BACKWARD = 3;

    DXVA_USUAL_BLOCK_WIDTH = 8;
    DXVA_USUAL_BLOCK_HEIGHT = 8;
    DXVA_USUAL_BLOCK_SIZE = (DXVA_USUAL_BLOCK_WIDTH * DXVA_USUAL_BLOCK_HEIGHT);

    DXVA_NumMV_OBMC_off_BinPBwith4MV_off = 4;
    DXVA_NumMV_OBMC_off_BinPBwith4MV_on = (4 + 1);
    DXVA_NumMV_OBMC_on__BinPB_off = (10);
    DXVA_NumMV_OBMC_on__BinPB_on = (11); (* not current standards *)

    DXVA_NumBlocksPerMB_420 = (4 + 2 + 0);
    DXVA_NumBlocksPerMB_422 = (4 + 2 + 2);
    DXVA_NumBlocksPerMB_444 = (4 + 4 + 4);

    DXVA_CONFIG_DATA_TYPE_IA44 = 0;
    DXVA_CONFIG_DATA_TYPE_AI44 = 1;
    DXVA_CONFIG_DATA_TYPE_DPXD = 2;
    DXVA_CONFIG_DATA_TYPE_AYUV = 3;

    DXVA_CONFIG_BLEND_TYPE_FRONT_BUFFER = 0;
    DXVA_CONFIG_BLEND_TYPE_BACK_HARDWARE = 1;

    DXVA_ExtColorData_ShiftBase = 8;

    // Function codes for RenderMoComp

    MAX_DEINTERLACE_SURFACES = 32;

    DXVA_DeinterlaceBltFnCode = $01;
    // lpInput => DXVA_DeinterlaceBlt*
    // lpOuput => NULL (*  not currently used *)

    DXVA_DeinterlaceBltExFnCode = $02;
    // lpInput => DXVA_DeinterlaceBltEx*
    // lpOuput => NULL (*  not currently used *)

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
    // lpOuput => NULL (*  not currently used *)

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

    COPP_NoProtectionLevelAvailable = -1;
    COPP_DefaultProtectionLevel = 0;

    COPP_ImageAspectRatio_EN300294_Mask = $00000007;

    DXVA_COPPQueryStatusFnCode = $05;
    // lpInputData => DXVA_COPPStatusInput*
    // lpOuputData => DXVA_COPPStatusOutput*


    // Bit flags of possible protection types.  Note that it is possible to apply
    // different protection settings to a single connector.

    COPP_ProtectionType_Unknown = $80000000;
    COPP_ProtectionType_None = $00000000;
    COPP_ProtectionType_HDCP = $00000001;
    COPP_ProtectionType_ACP = $00000002;
    COPP_ProtectionType_CGMSA = $00000004;
    COPP_ProtectionType_DPCP = $00000010;
    COPP_ProtectionType_Mask = $80000017;
    COPP_ProtectionType_Reserved = $7FFFFFF8;

type
{$Z1}
{$A1}
    // pragma pack(push, BeforeDXVApacking, 1)
    TDXVA_ConnectMode = packed record
        guidMode: TGUID;
        wRestrictedMode: word;
    end;

    PDXVA_ConnectMode = ^TDXVA_ConnectMode;

    TDXVA_ConfigQueryOrReplyFunc = DWORD;

    PDXVA_ConfigQueryOrReplyFunc = ^TDXVA_ConfigQueryOrReplyFunc;

    TDXVA_EncryptProtocolFunc = DWORD;
    PDXVA_EncryptProtocolFunc = ^TDXVA_EncryptProtocolFunc;

    TDXVA_EncryptProtocolHeader = packed record
        dwFunction: TDXVA_EncryptProtocolFunc;
        ReservedBits: array [0 .. 2] of DWORD;
        guidEncryptProtocol: TGUID;
    end;

    PDXVA_EncryptProtocolHeader = ^TDXVA_EncryptProtocolHeader;

    TDXVA_ConfigPictureDecode = packed record
        // Operation Indicated
        dwFunction: TDXVA_ConfigQueryOrReplyFunc;
        // Alignment
        dwReservedBits: array [0 .. 2] of DWORD;
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

    (* Picture Decoding Parameters *)

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

    (* Picture Resampling *)

    TDXVA_PicResample = packed record
        wPicResampleSourcePicIndex: word;
        wPicResampleDestPicIndex: word;
        wPicResampleRcontrol: word;
        bPicResampleExtrapWidth: byte;
        bPicResampleExtrapHeight: byte;
        dwPicResampleSourceWidth: DWORD;
        dwPicResampleSourceHeight: DWORD;
        dwPicResampleDestWidth: DWORD;
        dwPicResampleDestHeight: DWORD;
        dwPicResampleFullDestWidth: DWORD;
        dwPicResampleFullDestHeight: DWORD;
    end;

    PDXVA_PicResample = ^TDXVA_PicResample;

    (* Buffer Description Data *)

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

    (* Off-Host IDCT Coefficient Data Structures *)

    TDXVA_TCoef4Group = packed record
        TCoefIDX: array [0 .. 3] of byte;
        TCoefValue: array [0 .. 3] of SHORT;
    end;

    PDXVA_TCoef4Group = ^TDXVA_TCoef4Group;

    TDXVA_TCoefSingle = packed record
        wIndexWithEOB: word;
        TCoefValue: SHORT;
    end;

    PDXVA_TCoefSingle = ^TDXVA_TCoefSingle;

    (* Spatial-Domain Residual Difference Blocks *)
    TDXVA_Sample16 = array [0 .. DXVA_USUAL_BLOCK_SIZE - 1] of SHORT;
    TDXVA_Sample8 = array [0 .. DXVA_USUAL_BLOCK_SIZE - 1] of shortint;

    (* Deblocking Filter Control Structure *)

    TDXVA_DeblockingEdgeControl = byte;

    PDXVA_DeblockingEdgeControl = ^TDXVA_DeblockingEdgeControl;

    (* Macroblock Control Command Data Structures *)

    TDXVA_MVvalue = packed record
        horz, vert: SHORT;
    end;

    PDXVA_MVvalue = ^TDXVA_MVvalue;

    (* Inverse Quantization Matrices *)

    TDXVA_QmatrixData = packed record
        bNewQmatrix: array [0 .. 3] of byte; (* intra Y, inter Y, intra chroma, inter chroma *)
        Qmatrix: array [0 .. 3, 0 .. DXVA_USUAL_BLOCK_WIDTH * DXVA_USUAL_BLOCK_HEIGHT - 1] of word;
    end;

    PDXVA_QmatrixData = ^TDXVA_QmatrixData;

    (* Slice Control Buffer Data *)

    TDXVA_SliceInfo = packed record
        wHorizontalPosition: word;
        wVerticalPosition: word;
        dwSliceBitsInBuffer: DWORD;
        dwSliceDataLocation: DWORD;
        bStartCodeBitOffset: byte;
        bReservedBits: byte;
        wMBbitOffset: word;
        wNumberMBsInSlice: word;
        wQuantizerScaleCode: word;
        wBadSliceChopping: word;
    end;

    PDXVA_SliceInfo = ^TDXVA_SliceInfo;

    (* Basic form for I pictures *)
    (* Host Residual Differences *)
    TDXVA_MBctrl_I_HostResidDiff_1 = packed record
        wMBaddress: word;
        wMBtype: word;
        dwMB_SNL: DWORD;
        wPatternCode: word;
        wPC_Overflow: word; (* zero if not overflow format *)
        dwReservedBits2: DWORD;
    end;

    (* Basic form for I pictures *)
    (* Off-Host IDCT, 4:2:0 sampling *)
    TDXVA_MBctrl_I_OffHostIDCT_1 = packed record
        wMBaddress: word;
        wMBtype: word;
        dwMB_SNL: DWORD;
        wPatternCode: word;
        bNumCoef: array [0 .. DXVA_NumBlocksPerMB_420 - 1] of byte;
    end;

    (* Basic form for P and B pictures *)
    (* Should also be used for concealment MVs in MPEG-2 I pictures *)
    (* Without OBMC, without BinPB and 4MV together, without MV RPS *)
    (* Host Residual Differences *)
    TDXVA_MBctrl_P_HostResidDiff_1 = packed record
        wMBaddress: word;
        wMBtype: word;
        dwMB_SNL: DWORD;
        wPatternCode: word;
        wPC_Overflow: word; (* zero if not overflow format *)
        dwReservedBits2: DWORD;
        MVector: array [0 .. DXVA_NumMV_OBMC_off_BinPBwith4MV_off - 1] of TDXVA_MVvalue;
    end;

    (* Basic form for P and B pictures *)
    (* Without OBMC, without BinPB and 4MV together, without MV RPS *)
    (* Off-Host IDCT, 4:2:0 sampling *)
    TDXVA_MBctrl_P_OffHostIDCT_1 = packed record
        wMBaddress: word;
        wMBtype: word;
        dwMB_SNL: DWORD;
        wPatternCode: word;
        bNumCoef: array [0 .. DXVA_NumBlocksPerMB_420 - 1] of byte;
        MVector: array [0 .. DXVA_NumMV_OBMC_off_BinPBwith4MV_off - 1] of TDXVA_MVvalue;
    end;

    (* How to load alpha blending graphic data *)
    TDXVA_ConfigAlphaLoad = packed record

        // Operation Indicated
        dwFunction: TDXVA_ConfigQueryOrReplyFunc;

        // Alignment
        dwReservedBits: array [0 .. 2] of DWORD;

        bConfigDataType: byte;
    end;

    PDXVA_ConfigAlphaLoad = ^TDXVA_ConfigAlphaLoad;

    (* How to combine alpha blending graphic data *)
    TDXVA_ConfigAlphaCombine = packed record

        // Operation Indicated
        dwFunction: TDXVA_ConfigQueryOrReplyFunc;

        // Alignment
        dwReservedBits: array [0 .. 2] of DWORD;

        bConfigBlendType: byte;
        bConfigPictureResizing: byte;
        bConfigOnlyUsePicDestRectArea: byte;
        bConfigGraphicResizing: byte;
        bConfigWholePlaneAlpha: byte;

    end;

    PDXVA_ConfigAlphaCombine = ^TDXVA_ConfigAlphaCombine;

    (* AYUV sample for 16-entry YUV palette or graphic surface *)

    TDXVA_AYUVsample2 = packed record
        bCrValue: byte;
        bCbValue: byte;
        bY_Value: byte;
        bSampleAlpha8: byte;
    end;

    PDXVA_AYUVsample2 = ^TDXVA_AYUVsample2;

    (* Macros for IA44 alpha blending surface samples *)

    TDXVA_IA44sample = byte;
    PDXVA_IA44sample = ^TDXVA_IA44sample;

    TDXVA_AI44sample = byte;
    PDXVA_AI44sample = ^TDXVA_AI44sample;

    (* Highlight data structure *)

    TDXVA_Highlight = packed record
        wHighlightActive: word;
        wHighlightIndices: word;
        wHighlightAlphas: word;
        HighlightRect: TRECT;
    end;

    PDXVA_Highlight = ^TDXVA_Highlight;

    TDXVA_DPXD = byte;
    PDXVA_DPXD = ^TDXVA_DPXD;
    TDXVA_DCCMD = word;
    PDXVA_DCCMD = ^TDXVA_DCCMD;

    (* Alpha blend combination *)

    TDXVA_BlendCombination = packed record
        wPictureSourceIndex: word;
        wBlendedDestinationIndex: word;
        PictureSourceRect16thPel: TRECT;
        PictureDestinationRect: TRECT;
        GraphicSourceRect: TRECT;
        GraphicDestinationRect: TRECT;
        wBlendDelay: word;
        bBlendOn: byte;
        bWholePlaneAlpha: byte;
        OutsideYUVcolor: TDXVA_AYUVsample2;
    end;

    PDXVA_BlendCombination = ^TDXVA_BlendCombination;

    (* H.264/AVC-specific structures *)

    (* H.264/AVC picture entry data structure *)
    TDXVA_PicEntry_H264 = packed record (* 1 byte *)
        case integer of
            0:
                (Index7Bits: 0 .. 127;
                    AssociatedFlag: 0 .. 1);
            1:
                (bPicEntry: UCHAR);

    end;

    PDXVA_PicEntry_H264 = ^TDXVA_PicEntry_H264;

    (* H.264/AVC picture parameters structure *)
    TDXVA_PicParams_H264 = packed record
        wFrameWidthInMbsMinus1: USHORT;
        wFrameHeightInMbsMinus1: USHORT;
        CurrPic: TDXVA_PicEntry_H264; (* flag is bot field flag *)
        num_ref_frames: UCHAR;
        // dummyrecord: record
        case integer of
            0:
                (field_pic_flag: 0 .. 1;
                    MbaffFrameFlag: 0 .. 1;
                    residual_colour_transform_flag: 0 .. 1;
                    sp_for_switch_flag: 0 .. 1;
                    chroma_format_idc: 0 .. 3;
                    RefPicFlag: 0 .. 1;
                    constrained_intra_pred_flag: 0 .. 1;

                    weighted_pred_flag: 0 .. 1;
                    weighted_bipred_idc: 0 .. 3;
                    MbsConsecutiveFlag: 0 .. 1;
                    frame_mbs_only_flag: 0 .. 1;
                    transform_8x8_mode_flag: 0 .. 1;
                    MinLumaBipredSize8x8Flag: 0 .. 1;
                    IntraPicFlag: 0 .. 1;

                    bit_depth_luma_minus8: UCHAR;
                    bit_depth_chroma_minus8: UCHAR;

                    Reserved16Bits: USHORT;
                    StatusReportFeedbackNumber: UINT;

                    RefFrameList: array [0 .. 15] of TDXVA_PicEntry_H264; (* flag LT *)
                    CurrFieldOrderCnt: array [0 .. 1] of integer;
                    FieldOrderCntList: array [0 .. 15, 0 .. 1] of integer;

                    pic_init_qs_minus26: char;
                    chroma_qp_index_offset: char; (* also used for QScb *)
                    second_chroma_qp_index_offset: char; (* also for QScr *)
                    ContinuationFlag: UCHAR;

                    (* remainder for parsing *)
                    pic_init_qp_minus26: char;
                    num_ref_idx_l0_active_minus1: UCHAR;
                    num_ref_idx_l1_active_minus1: UCHAR;
                    Reserved8BitsA: UCHAR;

                    FrameNumList: array [0 .. 15] of USHORT;
                    UsedForReferenceFlags: UINT;
                    NonExistingFrameFlags: USHORT;
                    frame_num: USHORT;

                    log2_max_frame_num_minus4: UCHAR;
                    pic_order_cnt_type: UCHAR;
                    log2_max_pic_order_cnt_lsb_minus4: UCHAR;
                    delta_pic_order_always_zero_flag: UCHAR;

                    direct_8x8_inference_flag: UCHAR;
                    entropy_coding_mode_flag: UCHAR;
                    pic_order_present_flag: UCHAR;
                    num_slice_groups_minus1: UCHAR;

                    slice_group_map_type: UCHAR;
                    deblocking_filter_control_present_flag: UCHAR;
                    redundant_pic_cnt_present_flag: UCHAR;
                    Reserved8BitsB: UCHAR;

                    slice_group_change_rate_minus1: USHORT;

                    SliceGroupMap: array [0 .. 810 - 1] of UCHAR; (* 4b/sgmu, Size BT.601 *)
                );
            1:
                (wBitFields: USHORT);

    end;

    PDXVA_PicParams_H264 = ^TDXVA_PicParams_H264;

    (* H.264/AVC quantization weighting matrix data structure *)
    TDXVA_Qmatrix_H264 = packed record
        bScalingLists4x4: array [0 .. 5, 0 .. 15] of UCHAR;
        bScalingLists8x8: array [0 .. 1, 0 .. 63] of UCHAR;

    end;

    PDXVA_Qmatrix_H264 = ^TDXVA_Qmatrix_H264;

    (* H.264/AVC slice control data structure - short form *)
    TDXVA_Slice_H264_Short = packed record
        BSNALunitDataLocation: UINT; (* type 1..5 *)
        SliceBytesInBuffer: UINT; (* for off-host parse *)
        wBadSliceChopping: USHORT; (* for off-host parse *)
    end;

    PDXVA_Slice_H264_Short = ^TDXVA_Slice_H264_Short;

    (* H.264/AVC picture entry data structure - long form *)
    TDXVA_Slice_H264_Long = packed record
        BSNALunitDataLocation: UINT; (* type 1..5 *)
        SliceBytesInBuffer: UINT; (* for off-host parse *)
        wBadSliceChopping: USHORT; (* for off-host parse *)

        first_mb_in_slice: USHORT;
        NumMbsForSlice: USHORT;

        BitOffsetToSliceData: USHORT; (* after CABAC alignment *)

        slice_type: UCHAR;
        luma_log2_weight_denom: UCHAR;
        chroma_log2_weight_denom: UCHAR;
        num_ref_idx_l0_active_minus1: UCHAR;
        num_ref_idx_l1_active_minus1: UCHAR;
        slice_alpha_c0_offset_div2: char;
        slice_beta_offset_div2: char;
        Reserved8Bits: UCHAR;
        RefPicList: array [0 .. 1, 0 .. 31] of TDXVA_PicEntry_H264; (* L0 & L1 *)
        Weights: array [0 .. 1, 0 .. 31, 0 .. 2, 0 .. 1] of SHORT; (* L0 & L1; Y, Cb, Cr *)
        slice_qs_delta: char;
        (* rest off-host parse *)
        slice_qp_delta: char;
        redundant_pic_cnt: UCHAR;
        direct_spatial_mv_pred_flag: UCHAR;
        cabac_init_idc: UCHAR;
        disable_deblocking_filter_idc: UCHAR;
        slice_id: USHORT;
    end;

    PDXVA_Slice_H264_Long = ^TDXVA_Slice_H264_Long;

    (* H.264/AVC macroblock control command data structure *)
    TDXVA_MBctrl_H264 = packed record
        case integer of
            0:
                (bSliceID: 0 .. 255; (* 1 byte *)
                    MbType5Bits: 0 .. 31;
                    IntraMbFlag: 0 .. 1;
                    mb_field_decoding_flag: 0 .. 1;
                    transform_size_8x8_flag: 0 .. 1; (* 2 bytes *)
                    HostResidDiff: 0 .. 1;
                    DcBlockCodedCrFlag: 0 .. 1;
                    DcBlockCodedCbFlag: 0 .. 1;
                    DcBlockCodedYFlag: 0 .. 1;
                    FilterInternalEdgesFlag: 0 .. 1;
                    FilterLeftMbEdgeFlag: 0 .. 1;
                    FilterTopMbEdgeFlag: 0 .. 1;
                    ReservedBit: 0 .. 1;
                    bMvQuantity: 0 .. 255; (* 4 bytes *)

                    CurrMbAddr: USHORT; (* 6 bytes so far *)
                    wPatternCode: array [0 .. 2] of USHORT; (* YCbCr, 16 4x4 blks, 1b each *)
                    (* 12 bytes so far *)
                    bQpPrime: array [0 .. 2] of UCHAR; (* Y, Cb, Cr, need just 7b QpY *)
                    bMBresidDataQuantity: UCHAR;
                    dwMBdataLocation: ULONG; (* offset into resid buffer *)
                    (* 20 bytes so far *)
                    case integer of 0: (
                        (* start here for Intra MB's  (9 useful bytes in branch) *)
                        LumaIntraPredModes: array [0 .. 3] of USHORT; (* 16 blocks, 4b each *)
                        (* 28 bytes so far *)
                        case integer of 0: (intra_chroma_pred_mode: 0 .. 3; IntraPredAvailFlags: 0 .. 31; ReservedIntraBit: 0 .. 1;

                            ReservedIntra24Bits: array [0 .. 2] of UCHAR; ); 1: (bMbIntraStruct: UCHAR); (* 29 bytes so far *)
                        (* 32 bytes total *)
                    );
                    1: (
                        (* start here for non-Intra MB's (12 bytes in branch) *)
                        bSubMbShapes: UCHAR; (* 4 subMbs, 2b each *)
                        bSubMbPredModes: UCHAR; (* 4 subMBs, 2b each *)
                        (* 22 bytes so far *)
                        wMvBuffOffset: USHORT; (* offset into MV buffer *)
                        bRefPicSelect: array [0 .. 1, 0 .. 3] of UCHAR; (* 32 bytes total *)
                    );

                );
            1:
                (dwMBtype: UINT); (* 4 bytes so far *)
    end;

    PDXVA_MBctrl_H264 = ^TDXVA_MBctrl_H264;

    (* H.264/AVC IndexA and IndexB data structure *)
    TDXVA_DeblockIndexAB_H264 = packed record
        bIndexAinternal: UCHAR; (* 6b - could get from MB CC *)
        bIndexBinternal: UCHAR; (* 6b - could get from MB CC *)

        bIndexAleft0: UCHAR;
        bIndexBleft0: UCHAR;

        bIndexAleft1: UCHAR;
        bIndexBleft1: UCHAR;

        bIndexAtop0: UCHAR;
        bIndexBtop0: UCHAR;

        bIndexAtop1: UCHAR;
        bIndexBtop1: UCHAR;
    end;

    PDXVA_DeblockIndexAB_H264 = ^TDXVA_DeblockIndexAB_H264;
    (* 10 bytes in struct *)

    (* H.264/AVC deblocking filter control data structure *)
    TDXVA_Deblock_H264 = packed record
        CurrMbAddr: USHORT; (* dup info *)   (* 2 bytes so far *)
        case integer of
            0:
                (ReservedBit: 0 .. 1;
                    FieldModeCurrentMbFlag: 0 .. 1; (* dup info *)
                    FieldModeLeftMbFlag: 0 .. 1;
                    FieldModeAboveMbFlag: 0 .. 1;
                    FilterInternal8x8EdgesFlag: 0 .. 1;
                    FilterInternal4x4EdgesFlag: 0 .. 1;
                    FilterLeftMbEdgeFlag: 0 .. 1;
                    FilterTopMbEdgeFlag: 0 .. 1;

                    Reserved8Bits: UCHAR; (* 4 bytes so far *)

                    bbSinternalLeftVert: UCHAR; (* 2 bits per bS *)
                    bbSinternalMidVert: UCHAR;

                    bbSinternalRightVert: UCHAR;
                    bbSinternalTopHorz: UCHAR; (* 8 bytes so far *)

                    bbSinternalMidHorz: UCHAR;
                    bbSinternalBotHorz: UCHAR; (* 10 bytes so far *)

                    wbSLeft0: USHORT; (* 4 bits per bS (1 wasted) *)
                    wbSLeft1: USHORT; (* 4 bits per bS (1 wasted) *)

                    wbSTop0: USHORT; (* 4 bits per bS (1 wasted) *)
                    wbSTop1: USHORT; (* 4b (2 wasted)  18 bytes so far *)

                    IndexAB: array [0 .. 2] of TDXVA_DeblockIndexAB_H264; (* Y, Cb, Cr *)
                );
            1:
                (FirstByte: UCHAR);
    end;

    PDXVA_Deblock_H264 = ^TDXVA_Deblock_H264; (* 48 bytes *)

    (* H.264/AVC film grain characteristics data structure *)
    TDXVA_FilmGrainCharacteristics = packed record

        wFrameWidthInMbsMinus1: USHORT;
        wFrameHeightInMbsMinus1: USHORT;

        InPic: TDXVA_PicEntry_H264; (* flag is bot field flag *)
        OutPic: TDXVA_PicEntry_H264; (* flag is field pic flag *)

        PicOrderCnt_offset: USHORT;
        CurrPicOrderCnt: INT32;
        StatusReportFeedbackNumber: UINT;

        model_id: UCHAR;
        separate_colour_description_present_flag: UCHAR;
        film_grain_bit_depth_luma_minus8: UCHAR;
        film_grain_bit_depth_chroma_minus8: UCHAR;

        film_grain_full_range_flag: UCHAR;
        film_grain_colour_primaries: UCHAR;
        film_grain_transfer_characteristics: UCHAR;
        film_grain_matrix_coefficients: UCHAR;

        blending_mode_id: UCHAR;
        log2_scale_factor: UCHAR;

        comp_model_present_flag: array [0 .. 3] of UCHAR;
        num_intensity_intervals_minus1: array [0 .. 3] of UCHAR;
        num_model_values_minus1: array [0 .. 3] of UCHAR;

        intensity_interval_lower_bound: array [0 .. 2, 0 .. 15] of UCHAR;
        intensity_interval_upper_bound: array [0 .. 2, 0 .. 15] of UCHAR;
        comp_model_value: array [0 .. 2, 0 .. 15, 0 .. 7] of SHORT;
    end;

    TDXVA_FilmGrainChar_H264 = TDXVA_FilmGrainCharacteristics;

    PDXVA_FilmGrainChar_H264 = ^TDXVA_FilmGrainChar_H264;

    (* H.264/AVC status reporting data structure *)
    TDXVA_Status_H264 = packed record
        StatusReportFeedbackNumber: UINT;
        CurrPic: TDXVA_PicEntry_H264; (* flag is bot field flag *)
        field_pic_flag: UCHAR;
        bDXVA_Func: UCHAR;
        bBufType: UCHAR;
        bStatus: UCHAR;
        bReserved8Bits: UCHAR;
        wNumMbsAffected: USHORT;
    end;

    PDXVA_Status_H264 = ^TDXVA_Status_H264;

    (* H.264 MVC picture parameters structure *)
    TDXVA_PicParams_H264_MVC = packed record
        wFrameWidthInMbsMinus1: USHORT;
        wFrameHeightInMbsMinus1: USHORT;
        CurrPic: TDXVA_PicEntry_H264; (* flag is bot field flag *)
        num_ref_frames: UCHAR;

        case integer of
            0:
                (field_pic_flag: 0 .. 1;
                    MbaffFrameFlag: 0 .. 1;
                    residual_colour_transform_flag: 0 .. 1;
                    sp_for_switch_flag: 0 .. 1;
                    chroma_format_idc: 0 .. 3;
                    RefPicFlag: 0 .. 1;
                    constrained_intra_pred_flag: 0 .. 1;

                    weighted_pred_flag: 0 .. 1;
                    weighted_bipred_idc: 0 .. 3;
                    MbsConsecutiveFlag: 0 .. 1;
                    frame_mbs_only_flag: 0 .. 1;
                    transform_8x8_mode_flag: 0 .. 1;
                    MinLumaBipredSize8x8Flag: 0 .. 1;
                    IntraPicFlag: 0 .. 1;

                    bit_depth_luma_minus8: UCHAR;
                    bit_depth_chroma_minus8: UCHAR;

                    Reserved16Bits: USHORT;
                    StatusReportFeedbackNumber: UINT;

                    RefFrameList: array [0 .. 15] of TDXVA_PicEntry_H264; (* flag LT *)
                    CurrFieldOrderCnt: array [0 .. 1] of INT32;
                    FieldOrderCntList: array [0 .. 15, 0 .. 1] of INT32;

                    pic_init_qs_minus26: char;
                    chroma_qp_index_offset: char; (* also used for QScb *)
                    second_chroma_qp_index_offset: char; (* also for QScr *)
                    ContinuationFlag: UCHAR;

                    (* remainder for parsing *)
                    pic_init_qp_minus26: char;
                    num_ref_idx_l0_active_minus1: UCHAR;
                    num_ref_idx_l1_active_minus1: UCHAR;
                    Reserved8BitsA: UCHAR;

                    FrameNumList: array [0 .. 15] of USHORT;
                    UsedForReferenceFlags: UINT;
                    NonExistingFrameFlags: USHORT;
                    frame_num: USHORT;

                    log2_max_frame_num_minus4: UCHAR;
                    pic_order_cnt_type: UCHAR;
                    log2_max_pic_order_cnt_lsb_minus4: UCHAR;
                    delta_pic_order_always_zero_flag: UCHAR;

                    direct_8x8_inference_flag: UCHAR;
                    entropy_coding_mode_flag: UCHAR;
                    pic_order_present_flag: UCHAR;
                    num_slice_groups_minus1: UCHAR;

                    slice_group_map_type: UCHAR;
                    deblocking_filter_control_present_flag: UCHAR;
                    redundant_pic_cnt_present_flag: UCHAR;
                    Reserved8BitsB: UCHAR;

                    slice_group_change_rate_minus1: USHORT;
                    (* SliceGroupMap is not needed for MVC, as MVC is for high profile only *)

                    (* Following are H.264 MVC Specific parameters *)
                    num_views_minus1: UCHAR;
                    view_id: array [0 .. 15] of USHORT;
                    num_anchor_refs_l0: array [0 .. 15] of UCHAR;
                    anchor_ref_l0: array [0 .. 15, 0 .. 15] of USHORT;
                    num_anchor_refs_l1: array [0 .. 15] of UCHAR;
                    anchor_ref_l1: array [0 .. 15, 0 .. 15] of USHORT;
                    num_non_anchor_refs_l0: array [0 .. 15] of UCHAR;
                    non_anchor_ref_l0: array [0 .. 15, 0 .. 15] of USHORT;
                    num_non_anchor_refs_l1: array [0 .. 15] of UCHAR;
                    non_anchor_ref_l1: array [0 .. 15, 0 .. 15] of USHORT;

                    curr_view_id: USHORT;
                    anchor_pic_flag: UCHAR;
                    inter_view_flag: UCHAR;
                    ViewIDList: array [0 .. 15] of USHORT;

                );
            1:
                (wBitFields: USHORT);

    end;

    PDXVA_PicParams_H264_MVC = ^TDXVA_PicParams_H264_MVC;

    (* VC-1 status reporting data structure *)
    TDXVA_Status_VC1 = packed record
        StatusReportFeedbackNumber: USHORT;
        wDecodedPictureIndex: word;
        wDeblockedPictureIndex: word;
        bPicStructure: UCHAR;
        bBufType: UCHAR;
        bStatus: UCHAR;
        bReserved8Bits: UCHAR;
        wNumMbsAffected: USHORT;
    end;

    PDXVA_Status_VC1 = ^TDXVA_Status_VC1;

    (* MPEG4PT2 Picture Parameter structure *)
    TDXVA_PicParams_MPEG4_PART2 = packed record
        short_video_header: UCHAR;
        vop_coding_type: UCHAR;
        vop_quant: UCHAR;
        wDecodedPictureIndex: word;
        wDeblockedPictureIndex: word;
        wForwardRefPictureIndex: word;
        wBackwardRefPictureIndex: word;
        vop_time_increment_resolution: USHORT;
        TRB: array [0 .. 1] of UINT;
        TRD: array [0 .. 1] of UINT;

        case integer of
            0:
                (unPicPostProc: 0 .. 3;
                    interlaced: 0 .. 1;
                    quant_type: 0 .. 1;
                    quarter_sample: 0 .. 1;
                    resync_marker_disable: 0 .. 1;
                    data_partitioned: 0 .. 1;
                    reversible_vlc: 0 .. 1;
                    reduced_resolution_vop_enable: 0 .. 1;
                    vop_coded: 0 .. 1;
                    vop_rounding_type: 0 .. 1;
                    intra_dc_vlc_thr: 0 .. 7;
                    top_field_first: 0 .. 1;
                    alternate_vertical_scan_flag: 0 .. 1;

                    profile_and_level_indication: UCHAR;
                    video_object_layer_verid: UCHAR;
                    vop_width: word;
                    vop_height: word;
                    case integer of 0: (sprite_enable: 0 .. 3; no_of_sprite_warping_points: 0 .. 63; sprite_warping_accuracy: 0 .. 3;

                        warping_mv: array [0 .. 3, 0 .. 1] of SHORT; case integer of 0: (vop_fcode_forward: 0 .. 7; vop_fcode_backward: 0 .. 7; dummy: 0 .. 3;
                            StatusReportFeedbackNumber: USHORT; Reserved16BitsA: USHORT; Reserved16BitsB: USHORT; ); 1: (wFcodeBitFields: UCHAR); );
                    1: (wSpriteBitFields: USHORT);

                );
            1:
                (wPicFlagBitFields: USHORT);
    end;

    PDXVA_PicParams_MPEG4_PART2 = ^TDXVA_PicParams_MPEG4_PART2;

    (* HEVC Picture Entry structure *)
    TDXVA_PicEntry_HEVC = packed record
        case integer of
            0:
                (Index7Bits: 0 .. 127;
                    AssociatedFlag: 0 .. 1; );
            1:
                (bPicEntry: UCHAR);

    end;

    PDXVA_PicEntry_HEVC = ^TDXVA_PicEntry_HEVC;

    (* HEVC Picture Parameter structure *)
    TDXVA_PicParams_HEVC = packed record
        PicWidthInMinCbsY: USHORT;
        PicHeightInMinCbsY: USHORT;
        case integer of
            0:
                (chroma_format_idc: 0 .. 3;
                    separate_colour_plane_flag: 0 .. 1;
                    bit_depth_luma_minus8: 0 .. 7;
                    bit_depth_chroma_minus8: 0 .. 7;
                    log2_max_pic_order_cnt_lsb_minus4: 0 .. 15;
                    NoPicReorderingFlag: 0 .. 1;
                    NoBiPredFlag: 0 .. 1;
                    ReservedBits1: 0 .. 1;

                    CurrPic: TDXVA_PicEntry_HEVC;
                    sps_max_dec_pic_buffering_minus1: UCHAR;
                    log2_min_luma_coding_block_size_minus3: UCHAR;
                    log2_diff_max_min_luma_coding_block_size: UCHAR;
                    log2_min_transform_block_size_minus2: UCHAR;
                    log2_diff_max_min_transform_block_size: UCHAR;
                    max_transform_hierarchy_depth_inter: UCHAR;
                    max_transform_hierarchy_depth_intra: UCHAR;
                    num_short_term_ref_pic_sets: UCHAR;
                    num_long_term_ref_pics_sps: UCHAR;
                    num_ref_idx_l0_default_active_minus1: UCHAR;
                    num_ref_idx_l1_default_active_minus1: UCHAR;
                    init_qp_minus26: char;
                    ucNumDeltaPocsOfRefRpsIdx: UCHAR;
                    wNumBitsForShortTermRPSInSlice: USHORT;
                    ReservedBits2: USHORT;

                    case integer of 0: (scaling_list_enabled_flag: 0 .. 1; amp_enabled_flag: 0 .. 1; sample_adaptive_offset_enabled_flag: 0 .. 1;
                        pcm_enabled_flag: 0 .. 1; pcm_sample_bit_depth_luma_minus1: 0 .. 15; pcm_sample_bit_depth_chroma_minus1: 0 .. 15;
                        log2_min_pcm_luma_coding_block_size_minus3: 0 .. 3; log2_diff_max_min_pcm_luma_coding_block_size: 0 .. 3;
                        pcm_loop_filter_disabled_flag: 0 .. 1; long_term_ref_pics_present_flag: 0 .. 1; sps_temporal_mvp_enabled_flag: 0 .. 1;
                        strong_intra_smoothing_enabled_flag: 0 .. 1; dependent_slice_segments_enabled_flag: 0 .. 1; output_flag_present_flag: 0 .. 1;
                        num_extra_slice_header_bits: 0 .. 7; sign_data_hiding_enabled_flag: 0 .. 1; cabac_init_present_flag: 0 .. 1; ReservedBits3: 0 .. 31;

                        case integer of 0: (constrained_intra_pred_flag: 0 .. 1; transform_skip_enabled_flag: 0 .. 1; cu_qp_delta_enabled_flag: 0 .. 1;
                            pps_slice_chroma_qp_offsets_present_flag: 0 .. 1; weighted_pred_flag: 0 .. 1; weighted_bipred_flag: 0 .. 1;
                            transquant_bypass_enabled_flag: 0 .. 1; tiles_enabled_flag: 0 .. 1; entropy_coding_sync_enabled_flag: 0 .. 1;
                            uniform_spacing_flag: 0 .. 1; loop_filter_across_tiles_enabled_flag: 0 .. 1; pps_loop_filter_across_slices_enabled_flag: 0 .. 1;
                            deblocking_filter_override_enabled_flag: 0 .. 1; pps_deblocking_filter_disabled_flag: 0 .. 1;
                            lists_modification_present_flag: 0 .. 1; slice_segment_header_extension_present_flag: 0 .. 1; IrapPicFlag: 0 .. 1;
                            IdrPicFlag: 0 .. 1; IntraPicFlag: 0 .. 1; ReservedBits4: 0 .. 8191;

                            pps_cb_qp_offset: char; pps_cr_qp_offset: char; num_tile_columns_minus1: UCHAR; num_tile_rows_minus1: UCHAR;
                            column_width_minus1: array [0 .. 18] of USHORT; row_height_minus1: array [0 .. 20] of USHORT; diff_cu_qp_delta_depth: UCHAR;
                            pps_beta_offset_div2: char; pps_tc_offset_div2: char; log2_parallel_merge_level_minus2: UCHAR; CurrPicOrderCntVal: INT32;
                            RefPicList: array [0 .. 14] of TDXVA_PicEntry_HEVC; ReservedBits5: UCHAR; PicOrderCntValList: array [0 .. 14] of INT32;
                            RefPicSetStCurrBefore: array [0 .. 7] of UCHAR; RefPicSetStCurrAfter: array [0 .. 7] of UCHAR;
                            RefPicSetLtCurr: array [0 .. 7] of UCHAR; ReservedBits6: USHORT; ReservedBits7: USHORT; StatusReportFeedbackNumber: UINT; );
                        1: (dwCodingSettingPicturePropertyFlags: UINT32);

                    );
                    1: (dwCodingParamToolFlags: UINT32);

                );
            1:
                (wFormatAndSequenceInfoFlags: USHORT);

    end;

    PDXVA_PicParams_HEVC = ^TDXVA_PicParams_HEVC;

    (* HEVC Quantizatiuon Matrix structure *)
    TDXVA_Qmatrix_HEVC = packed record
        ucScalingLists0: array [0 .. 5, 0 .. 15] of UCHAR;
        ucScalingLists1: array [0 .. 5, 0 .. 63] of UCHAR;
        ucScalingLists2: array [0 .. 5, 0 .. 63] of UCHAR;
        ucScalingLists3: array [0 .. 1, 0 .. 63] of UCHAR;
        ucScalingListDCCoefSizeID2: array [0 .. 5] of UCHAR;
        ucScalingListDCCoefSizeID3: array [0 .. 1] of UCHAR;
    end;

    PDXVA_Qmatrix_HEVC = ^TDXVA_Qmatrix_HEVC;

    (* HEVC Slice Control Structure *)
    TDXVA_Slice_HEVC_Short = packed record
        BSNALunitDataLocation: UINT;
        SliceBytesInBuffer: UINT;
        wBadSliceChopping: USHORT;
    end;

    PDXVA_Slice_HEVC_Short = ^TDXVA_Slice_HEVC_Short;
{$Z4}
{$A4}
    // pragma pack(pop, BeforeDXVApacking)


    // -------------------------------------------------------------------------

    // D3DFORMAT describes a pixel memory layout, DXVA sample format contains
    // additional information that describes how the pixels should be interpreted.

    // DXVA Extended color data - occupies the SampleFormat DWORD
    // data fields.
    // -------------------------------------------------------------------------

    TDXVA_SampleFormat = (DXVA_SampleFormatMask = $FF, // 8 bits used for DXVA Sample format
        DXVA_SampleUnknown = 0, DXVA_SamplePreviousFrame = 1, DXVA_SampleProgressiveFrame = 2, DXVA_SampleFieldInterleavedEvenFirst = 3,
        DXVA_SampleFieldInterleavedOddFirst = 4, DXVA_SampleFieldSingleEven = 5, DXVA_SampleFieldSingleOdd = 6, DXVA_SampleSubStream = 7);

    // DXVAColorMask(5, DXVA_VideoTransFuncShift),
    // (($FFFFFFFF shl 5) xor $FFFFFFFF) shl DXVA_VideoTransFuncShift

    TDXVA_VideoTransferFunction = (DXVA_VideoTransFuncShift = DXVA_ExtColorData_ShiftBase + 19,
        DXVA_VideoTransFuncMask = (($FFFFFFFF shl 5) xor $FFFFFFFF) shl Ord(DXVA_VideoTransFuncShift),

        DXVA_VideoTransFunc_Unknown = 0, DXVA_VideoTransFunc_10 = 1, DXVA_VideoTransFunc_18 = 2, DXVA_VideoTransFunc_20 = 3, DXVA_VideoTransFunc_22 = 4,
        DXVA_VideoTransFunc_22_709 = 5, DXVA_VideoTransFunc_22_240M = 6, DXVA_VideoTransFunc_22_8bit_sRGB = 7, DXVA_VideoTransFunc_28 = 8);

    TDXVA_VideoPrimaries = (DXVA_VideoPrimariesShift = (DXVA_ExtColorData_ShiftBase + 14),
        DXVA_VideoPrimariesMask = (($FFFFFFFF shl 5) xor $FFFFFFFF) shl Ord(DXVA_VideoPrimariesShift), // DXVAColorMask(5, DXVA_VideoPrimariesShift),

        DXVA_VideoPrimaries_Unknown = 0, DXVA_VideoPrimaries_reserved = 1, DXVA_VideoPrimaries_BT709 = 2, DXVA_VideoPrimaries_BT470_2_SysM = 3,
        DXVA_VideoPrimaries_BT470_2_SysBG = 4, DXVA_VideoPrimaries_SMPTE170M = 5, DXVA_VideoPrimaries_SMPTE240M = 6, DXVA_VideoPrimaries_EBU3213 = 7,
        DXVA_VideoPrimaries_SMPTE_C = 8);

    TDXVA_VideoLighting = (DXVA_VideoLightingShift = (DXVA_ExtColorData_ShiftBase + 10),
        DXVA_VideoLightingMask = (($FFFFFFFF shl 4) xor $FFFFFFFF) shl Ord(DXVA_VideoLightingShift), // DXVAColorMask(4, DXVA_VideoLightingShift),

        DXVA_VideoLighting_Unknown = 0, DXVA_VideoLighting_bright = 1, DXVA_VideoLighting_office = 2, DXVA_VideoLighting_dim = 3, DXVA_VideoLighting_dark = 4);

    TDXVA_VideoTransferMatrix = (DXVA_VideoTransferMatrixShift = (DXVA_ExtColorData_ShiftBase + 7),
        DXVA_VideoTransferMatrixMask = (($FFFFFFFF shl 3) xor $FFFFFFFF) shl Ord(DXVA_VideoTransferMatrixShift),
        // DXVAColorMask(3, DXVA_VideoTransferMatrixShift),

        DXVA_VideoTransferMatrix_Unknown = 0, DXVA_VideoTransferMatrix_BT709 = 1, DXVA_VideoTransferMatrix_BT601 = 2, DXVA_VideoTransferMatrix_SMPTE240M = 3);

    TDXVA_NominalRange = (DXVA_NominalRangeShift = (DXVA_ExtColorData_ShiftBase + 4),
        DXVA_NominalRangeMask = (($FFFFFFFF shl 3) xor $FFFFFFFF) shl Ord(DXVA_NominalRangeShift), // DXVAColorMask(3, DXVA_NominalRangeShift),

        DXVA_NominalRange_Unknown = 0, DXVA_NominalRange_Normal = 1, DXVA_NominalRange_Wide = 2,

        DXVA_NominalRange_0_255 = 1, DXVA_NominalRange_16_235 = 2, DXVA_NominalRange_48_208 = 3);

    TDXVA_VideoChromaSubsampling = (DXVA_VideoChromaSubsamplingShift = (DXVA_ExtColorData_ShiftBase + 0),
        DXVA_VideoChromaSubsamplingMask = (($FFFFFFFF shl 4) xor $FFFFFFFF) shl Ord(DXVA_VideoChromaSubsamplingShift),
        // DXVAColorMask(4, DXVA_VideoChromaSubsamplingShift),

        DXVA_VideoChromaSubsampling_Unknown = 0, DXVA_VideoChromaSubsampling_ProgressiveChroma = $8, DXVA_VideoChromaSubsampling_Horizontally_Cosited = $4,
        DXVA_VideoChromaSubsampling_Vertically_Cosited = $2, DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes = $1,

        // 4:2:0 variations
        DXVA_VideoChromaSubsampling_MPEG2 = Ord(DXVA_VideoChromaSubsampling_Horizontally_Cosited) or Ord
          (DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes),

        DXVA_VideoChromaSubsampling_MPEG1 = DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes,

        DXVA_VideoChromaSubsampling_DV_PAL = Ord(DXVA_VideoChromaSubsampling_Horizontally_Cosited) or Ord(DXVA_VideoChromaSubsampling_Vertically_Cosited),
        // 4:4:4, 4:2:2, 4:1:1
        DXVA_VideoChromaSubsampling_Cosited = Ord(DXVA_VideoChromaSubsampling_Horizontally_Cosited) or Ord(DXVA_VideoChromaSubsampling_Vertically_Cosited)
          or Ord(DXVA_VideoChromaSubsampling_Vertically_AlignedChromaPlanes));

    TDXVA_ExtendedFormat = { bitpacked } record
        SampleFormat: 0 .. 255; // See DXVA_SampleFormat
        VideoChromaSubsampling: 0 .. 15; // See DXVA_VideoChromaSubSampling
        NominalRange: 0 .. 7; // See DXVA_NominalRange
        VideoTransferMatrix: 0 .. 7; // See DXVA_VideoTransferMatrix
        VideoLighting: 0 .. 15; // See DXVA_VideoLighting
        VideoPrimaries: 0 .. 31; // See DXVA_VideoPrimaries
        VideoTransferFunction: 0 .. 31; // See DXVA_VideoTransferFunction
    end;


    // -------------------------------------------------------------------------

    // The definitions that follow describe the video de-interlace interface
    // between the VMR and the graphics device driver.  This interface is not
    // accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------

    TREFERENCE_TIME = LONGLONG;


    // -------------------------------------------------------------------------
    // data structures shared by User mode and Kernel mode.
    // -------------------------------------------------------------------------

    TD3DFORMAT = DWORD;
    PD3DFORMAT = ^TD3DFORMAT;
    TD3DPOOL = DWORD;

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

    TDXVA_VideoProcessCaps = (DXVA_VideoProcess_None = $0000, DXVA_VideoProcess_YUV2RGB = $0001, DXVA_VideoProcess_StretchX = $0002,
        DXVA_VideoProcess_StretchY = $0004, DXVA_VideoProcess_AlphaBlend = $0008, DXVA_VideoProcess_SubRects = $0010,
        DXVA_VideoProcess_SubStreams = $0020, DXVA_VideoProcess_SubStreamsExtended = $0040, DXVA_VideoProcess_YUV2RGBExtended = $0080,
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
        DXVA_DeinterlaceTech_MotionVectorSteered = $0080);

    TDXVA_VideoSample = record
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        SampleFormat: TDXVA_SampleFormat; // only lower 8 bits used
        lpDDSSrcSurface: pointer;
    end;

    PDXVA_VideoSample = ^TDXVA_VideoSample;


    // -------------------------------------------------------------------------
    // DeinterlaceBltEx declarations
    // -------------------------------------------------------------------------

    TDXVA_SampleFlags = (DXVA_SampleFlagsMask = (1 shl 3) or (1 shl 2) or (1 shl 1) or (1 shl 0),

        DXVA_SampleFlag_Palette_Changed = $0001, DXVA_SampleFlag_SrcRect_Changed = $0002, DXVA_SampleFlag_DstRect_Changed = $0004,
        DXVA_SampleFlag_ColorData_Changed = $0008);

    TDXVA_DestinationFlags = (DXVA_DestinationFlagMask = (1 shl 3) or (1 shl 2) or (1 shl 1) or (1 shl 0),

        DXVA_DestinationFlag_Background_Changed = $0001, DXVA_DestinationFlag_TargetRect_Changed = $0002, DXVA_DestinationFlag_ColorData_Changed = $0004,
        DXVA_DestinationFlag_Alpha_Changed = $0008);

    TDXVA_VideoSample2 = record
{$IFDEF WIN64}
        Size: DWORD;
        Reserved: DWORD;
{$ENDIF}
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        SampleFormat: DWORD; // cast to DXVA_ExtendedFormat, or use Extract macros
        SampleFlags: DWORD;
        lpDDSSrcSurface: pointer;
        rcSrc: TRECT;
        rcDst: TRECT;
        Palette: array [0 .. 15] of TDXVA_AYUVsample2;
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
{$IFDEF WIN64}

    // These structures are used for thunking 32 bit DeinterlaceBltEx calls on
    // 64 bit drivers.

    TDXVA_VideoSample32 = record
        rtStart: TREFERENCE_TIME;
        rtEnd: TREFERENCE_TIME;
        SampleFormat: DWORD;
        SampleFlags: DWORD;
        lpDDSSrcSurface: DWORD; // 32 bit pointer size
        rcSrc: TRECT;
        rcDst: TRECT;
        Palette: array [0 .. 15] of TDXVA_AYUVsample2;
        // DWORD Pad;
        // 4 bytes of padding added by the compiler to align the struct to 8 bytes.
    end;

    PDXVA_VideoSample32 = ^TDXVA_VideoSample32;

    TDXVA_DeinterlaceBltEx32 = record
        Size: DWORD;
        BackgroundColor: TDXVA_AYUVsample2;
        rcTarget: TRECT;
        rtTarget: TREFERENCE_TIME;
        NumSourceSurfaces: DWORD;
        Alpha: single;
        Source: array [0 .. MAX_DEINTERLACE_SURFACES - 1] of TDXVA_VideoSample32;
        DestinationFormat: DWORD;
        DestinationFlags: DWORD;
    end;

    PDXVA_DeinterlaceBltEx32 = ^TDXVA_DeinterlaceBltEx32;
{$ENDIF}

    TDXVA_DeinterlaceBlt = record
        Size: DWORD;
        Reserved: DWORD;
        rtTarget: TREFERENCE_TIME;
        DstRect: TRECT;
        SrcRect: TRECT;
        NumSourceSurfaces: DWORD;
        Alpha: single;
        Source: array [0 .. MAX_DEINTERLACE_SURFACES - 1] of TDXVA_VideoSample;
    end;

    PDXVA_DeinterlaceBlt = ^TDXVA_DeinterlaceBlt;

    TDXVA_DeinterlaceBltEx = record
        Size: DWORD;
        BackgroundColor: TDXVA_AYUVsample2;
        rcTarget: TRECT;
        rtTarget: TREFERENCE_TIME;
        NumSourceSurfaces: DWORD;
        Alpha: single;
        Source: array [0 .. MAX_DEINTERLACE_SURFACES - 1] of TDXVA_VideoSample2;
        DestinationFormat: DWORD;
        DestinationFlags: DWORD;
    end;

    PDXVA_DeinterlaceBltEx = ^TDXVA_DeinterlaceBltEx;

    TDXVA_DeinterlaceQueryAvailableModes = record
        Size: DWORD;
        NumGuids: DWORD;
        Guids: array [0 .. MAX_DEINTERLACE_DEVICE_GUIDS - 1] of TGUID;
    end;

    PDXVA_DeinterlaceQueryAvailableModes = ^TDXVA_DeinterlaceQueryAvailableModes;

    TDXVA_DeinterlaceQueryModeCaps = record
        Size: DWORD;
        Guid: TGUID;
        VideoDesc: TDXVA_VideoDesc;
    end;

    PDXVA_DeinterlaceQueryModeCaps = ^TDXVA_DeinterlaceQueryModeCaps;


    // -------------------------------------------------------------------------

    // The definitions that follow describe the video ProcAmp interface
    // between the VMR and the graphics device driver.  This interface is not
    // accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------

    TDXVA_ProcAmpControlProp = (DXVA_ProcAmp_None = $0000, DXVA_ProcAmp_Brightness = $0001, DXVA_ProcAmp_Contrast = $0002, DXVA_ProcAmp_Hue = $0004,
        DXVA_ProcAmp_Saturation = $0008);

    TDXVA_ProcAmpControlCaps = record
        Size: DWORD;
        InputPool: DWORD;
        d3dOutputFormat: TD3DFORMAT;
        ProcAmpControlProps: DWORD; // see DXVA_ProcAmpControlProp
        VideoProcessingCaps: DWORD; // see DXVA_VideoProcessCaps
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

    PDXVA_ProcAmpControlBlt = ^TDXVA_ProcAmpControlBlt;


    // -------------------------------------------------------------------------

    // The definitions that follow describe the Certified Output Protection
    // Protocol between the VMR and the graphics device driver.  This interface
    // is not accessable via the IAMVideoAccelerator interface.

    // -------------------------------------------------------------------------

    // -------------------------------------------------------------------------
    // COPPSequenceStart
    // -------------------------------------------------------------------------
    TDXVA_COPPSignature = record
        Signature: array [0 .. 255] of UCHAR;
    end;

    PDXVA_COPPSignature = ^TDXVA_COPPSignature;

    // -------------------------------------------------------------------------
    // COPPCommand
    // -------------------------------------------------------------------------
    TDXVA_COPPCommand = record
        macKDI: TGUID; // 16 bytes
        guidCommandID: TGUID; // 16 bytes
        dwSequence: ULONG; // 4 bytes
        cbSizeData: ULONG; // 4 bytes
        CommandData: array [0 .. 4056 - 1] of UCHAR; // 4056 bytes (4056+4+4+16+16 = 4096)
    end;

    PDXVA_COPPCommand = ^TDXVA_COPPCommand;

    TDXVA_COPPSetProtectionLevelCmdData = record
        ProtType: ULONG;
        ProtLevel: ULONG;
        ExtendedInfoChangeMask: ULONG;
        ExtendedInfoData: ULONG;
    end;

    TCOPP_DPCP_Protection_Level = (COPP_DPCP_Level0 = 0, COPP_DPCP_LevelMin = COPP_DPCP_Level0, COPP_DPCP_Level1 = 1, COPP_DPCP_LevelMax = COPP_DPCP_Level1,
        COPP_DPCP_ForceDWORD = $7FFFFFFF);

    // Set the HDCP protection level - (0 - 1 DWORD, 4 bytes)

    TCOPP_HDCP_Protection_Level = (COPP_HDCP_Level0 = 0, COPP_HDCP_LevelMin = COPP_HDCP_Level0, COPP_HDCP_Level1 = 1, COPP_HDCP_LevelMax = COPP_HDCP_Level1,
        COPP_HDCP_ForceDWORD = $7FFFFFFF);

    TCOPP_CGMSA_Protection_Level = (COPP_CGMSA_Disabled = 0, COPP_CGMSA_LevelMin = COPP_CGMSA_Disabled, COPP_CGMSA_CopyFreely = 1, COPP_CGMSA_CopyNoMore = 2,
        COPP_CGMSA_CopyOneGeneration = 3, COPP_CGMSA_CopyNever = 4, COPP_CGMSA_RedistributionControlRequired = $08,
        COPP_CGMSA_LevelMax = (COPP_CGMSA_RedistributionControlRequired + COPP_CGMSA_CopyNever), COPP_CGMSA_ForceDWORD = $7FFFFFFF);

    TCOPP_ACP_Protection_Level = (COPP_ACP_Level0 = 0, COPP_ACP_LevelMin = COPP_ACP_Level0, COPP_ACP_Level1 = 1, COPP_ACP_Level2 = 2, COPP_ACP_Level3 = 3,
        COPP_ACP_LevelMax = COPP_ACP_Level3, COPP_ACP_ForceDWORD = $7FFFFFFF);

    TDXVA_COPPSetSignalingCmdData = record
        ActiveTVProtectionStandard: ULONG; // See COPP_TVProtectionStandard
        AspectRatioChangeMask1: ULONG;
        AspectRatioData1: ULONG; // See COPP_ImageAspectRatio_EN300294 for ETSI EN 300 294 values
        AspectRatioChangeMask2: ULONG;
        AspectRatioData2: ULONG;
        AspectRatioChangeMask3: ULONG;
        AspectRatioData3: ULONG;
        ExtendedInfoChangeMask: array [0 .. 3] of ULONG;
        ExtendedInfoData: array [0 .. 3] of ULONG;
        Reserved: ULONG;
    end;

    // Add format enum and data enum
    TCOPP_TVProtectionStandard = (COPP_ProtectionStandard_Unknown = $80000000, COPP_ProtectionStandard_None = $00000000,
        COPP_ProtectionStandard_IEC61880_525i = $00000001, COPP_ProtectionStandard_IEC61880_2_525i = $00000002,
        COPP_ProtectionStandard_IEC62375_625p = $00000004, COPP_ProtectionStandard_EIA608B_525 = $00000008, COPP_ProtectionStandard_EN300294_625i = $00000010,
        COPP_ProtectionStandard_CEA805A_TypeA_525p = $00000020, COPP_ProtectionStandard_CEA805A_TypeA_750p = $00000040,
        COPP_ProtectionStandard_CEA805A_TypeA_1125i = $00000080, COPP_ProtectionStandard_CEA805A_TypeB_525p = $00000100,
        COPP_ProtectionStandard_CEA805A_TypeB_750p = $00000200, COPP_ProtectionStandard_CEA805A_TypeB_1125i = $00000400,
        COPP_ProtectionStandard_ARIBTRB15_525i = $00000800, COPP_ProtectionStandard_ARIBTRB15_525p = $00001000,
        COPP_ProtectionStandard_ARIBTRB15_750p = $00002000, COPP_ProtectionStandard_ARIBTRB15_1125i = $00004000, COPP_ProtectionStandard_Mask = $80007FFF,
        COPP_ProtectionStandard_Reserved = $7FFF8000);

    TCOPP_ImageAspectRatio_EN300294 = (COPP_AspectRatio_EN300294_FullFormat4by3 = 0, COPP_AspectRatio_EN300294_Box14by9Center = 1,
        COPP_AspectRatio_EN300294_Box14by9Top = 2, COPP_AspectRatio_EN300294_Box16by9Center = 3, COPP_AspectRatio_EN300294_Box16by9Top = 4,
        COPP_AspectRatio_EN300294_BoxGT16by9Center = 5, COPP_AspectRatio_EN300294_FullFormat4by3ProtectedCenter = 6,
        COPP_AspectRatio_EN300294_FullFormat16by9Anamorphic = 7, COPP_AspectRatio_ForceDWORD = $7FFFFFFF);

    // -------------------------------------------------------------------------
    // COPPQueryStatus
    // -------------------------------------------------------------------------
    TDXVA_COPPStatusInput = record
        rApp: TGUID; // 16 bytes
        guidStatusRequestID: TGUID; // 16 bytes
        dwSequence: ULONG; // 4 bytes
        cbSizeData: ULONG; // 4 bytes
        StatusData: array [0 .. 4056 - 1] of UCHAR; // 4056 bytes (4056+4+4+16+16 = 4096)
    end;

    PDXVA_COPPStatusInput = ^TDXVA_COPPStatusInput;

    TDXVA_COPPStatusOutput = record
        macKDI: TGUID; // 16 bytes
        cbSizeData: ULONG; // 4 bytes
        COPPStatus: array [0 .. 4076 - 1] of UCHAR; // 4076 bytes (4076+16+4 = 4096)
    end;

    PDXVA_COPPStatusOutput = ^TDXVA_COPPStatusOutput;

    TCOPP_StatusFlags = (COPP_StatusNormal = $00, COPP_LinkLost = $01, COPP_RenegotiationRequired = $02, COPP_StatusFlagsReserved = $FFFFFFFC);

    TDXVA_COPPStatusData = record
        rApp: TGUID;
        dwFlags: ULONG; // See COPP_StatusFlags above
        dwData: ULONG;
        ExtendedInfoValidMask: ULONG;
        ExtendedInfoData: ULONG;
    end;

    TDXVA_COPPStatusDisplayData = record
        rApp: TGUID;
        dwFlags: ULONG; // See COPP_StatusFlags above
        DisplayWidth: ULONG;
        DisplayHeight: ULONG;
        Format: ULONG; // also contains extended color data
        d3dFormat: ULONG;
        FreqNumerator: ULONG;
        FreqDenominator: ULONG;
    end;

    TCOPP_StatusHDCPFlags = (COPP_HDCPRepeater = $01, COPP_HDCPFlagsReserved = $FFFFFFFE);

    TDXVA_COPPStatusHDCPKeyData = record
        rApp: TGUID;
        dwFlags: ULONG; // See COPP_StatusFlags above
        dwHDCPFlags: ULONG; // See COPP_StatusHDCPFlags above
        BKey: TGUID; // Lower 40 bits
        Reserved1: TGUID;
        Reserved2: TGUID;
    end;

    TCOPP_ConnectorType = (COPP_ConnectorType_Unknown = -1, COPP_ConnectorType_VGA = 0, COPP_ConnectorType_SVideo = 1, COPP_ConnectorType_CompositeVideo = 2,
        COPP_ConnectorType_ComponentVideo = 3, COPP_ConnectorType_DVI = 4, COPP_ConnectorType_HDMI = 5, COPP_ConnectorType_LVDS = 6,
        COPP_ConnectorType_TMDS = 7, COPP_ConnectorType_D_JPN = 8, COPP_ConnectorType_SDI = 9, COPP_ConnectorType_DisplayPortExternal = 10,
        COPP_ConnectorType_DisplayPortEmbedded = 11, COPP_ConnectorType_UDIExternal = 12, COPP_ConnectorType_UDIEmbedded = 13,
        COPP_ConnectorType_Internal = $80000000, // can be combined with the other connector types
        COPP_ConnectorType_ForceDWORD = $7FFFFFFF (* force 32-bit size enum *)
    );

    TCOPP_BusType = (COPP_BusType_Unknown = 0, COPP_BusType_PCI = 1, COPP_BusType_PCIX = 2, COPP_BusType_PCIExpress = 3, COPP_BusType_AGP = 4,
        COPP_BusType_Integrated = $80000000, // can be combined with the other bus types
        COPP_BusType_ForceDWORD = $7FFFFFFF (* force 32-bit size enum *) );

    TDXVA_COPPStatusSignalingCmdData = record
        rApp: TGUID;
        dwFlags: ULONG; // See COPP_StatusFlags above
        AvailableTVProtectionStandards: ULONG; // See COPP_TVProtectionStandard
        ActiveTVProtectionStandard: ULONG; // See COPP_TVProtectionStandard
        TVType: ULONG;
        AspectRatioValidMask1: ULONG;
        AspectRatioData1: ULONG; // See COPP_AspectRatio_EN300294 for ETSI EN 300 294 values
        AspectRatioValidMask2: ULONG;
        AspectRatioData2: ULONG;
        AspectRatioValidMask3: ULONG;
        AspectRatioData3: ULONG;
        ExtendedInfoValidMask: array [0 .. 3] of ULONG;
        ExtendedInfoData: array [0 .. 3] of ULONG;
    end;

    IDirect3DVideoDevice9 = interface;
    IDirect3DDXVADevice9 = interface;

    TDXVAUncompDataInfo = record
        UncompWidth: DWORD; (* Width of uncompressed data *)
        UncompHeight: DWORD; (* Height of uncompressed data *)
        UncompFormat: TD3DFORMAT; (* Format of uncompressed data *)
    end;

    TDXVACompBufferInfo = record
        NumCompBuffers: DWORD; (* Number of buffers reqd for compressed data *)
        WidthToCreate: DWORD; (* Width of surface to create *)
        HeightToCreate: DWORD; (* Height of surface to create *)
        BytesToAllocate: DWORD; (* Total number of bytes used by each surface *)
        Usage: DWORD; (* Usage used to create the compressed buffer *)
        Pool: TD3DPOOL; (* Pool where the compressed buffer belongs *)
        Format: TD3DFORMAT; (* Format used to create the compressed buffer *)
    end;

    PDXVACompBufferInfo = ^TDXVACompBufferInfo;

    TDXVABufferInfo = record
        pCompSurface: pointer; (* Pointer to buffer containing compressed data *)
        DataOffset: DWORD; (* Offset of relevant data from the beginning of buffer *)
        DataSize: DWORD; (* Size of relevant data *)
    end;

    PDXVABufferInfo = ^TDXVABufferInfo;

    IDirect3DVideoDevice9 = interface(IUnknown)
        ['{694036ac-542a-4a3a-9a32-53bc20002c1b}']
        function CreateSurface(Width: UINT; Height: UINT; BackBuffers: UINT; Format: TD3DFORMAT; Pool: TD3DPOOL; Usage: DWORD;
            out ppSurface: IDirect3DSurface9; out pSharedHandle: THANDLE): HResult; stdcall;
        function GetDXVACompressedBufferInfo(const pGuid: TGUID; const pUncompData: TDXVAUncompDataInfo; var pNumBuffers: DWORD;
            var pBufferInfo: PDXVACompBufferInfo): HResult; stdcall;
        function GetDXVAGuids(var pNumGuids: DWORD; var pGuids: pGuid): HResult; stdcall;
        function GetDXVAInternalInfo(const pGuid: TGUID; const pUncompData: TDXVAUncompDataInfo; out pMemoryUsed: DWORD): HResult; stdcall;
        function GetUncompressedDXVAFormats(const pGuid: TGUID; var pNumFormats: DWORD; var pFormats: PD3DFORMAT): HResult; stdcall;
        function CreateDXVADevice(const pGuid: TGUID; const pUncompData: TDXVAUncompDataInfo; pData: pointer; DataSize: DWORD;
            out ppDXVADevice: IDirect3DDXVADevice9): HResult; stdcall;
    end;

    IDirect3DDXVADevice9 = interface(IUnknown)
        ['{9f00c3d3-5ab6-465f-b955-9f0ebb2c5606}']
        function BeginFrame(pDstSurface: IDirect3DSurface9; SizeInputData: DWORD; pInputData: pointer; out pSizeOutputData: DWORD;
            out pOutputData: pointer): HResult; stdcall;
        function EndFrame(SizeMiscData: DWORD; pMiscData: pointer): HResult; stdcall;
        function Execute(FunctionNum: DWORD; pInputData: pointer; InputSize: DWORD; OuputData: pointer; OutputSize: DWORD; NumBuffers: DWORD;
            pBufferInfo: PDXVABufferInfo): HResult; stdcall;
        function QueryStatus(pSurface: IDirect3DSurface9; Flags: DWORD): HResult; stdcall;
    end;

    { Helper functions }

function readDXVA_QueryOrReplyFuncFlag(ptr: DWORD): DWORD;
function readDXVA_QueryOrReplyFuncFlag_ACCEL(ptr: DWORD): DWORD;
function readDXVA_QueryOrReplyFuncFlag_LOCK(ptr: DWORD): DWORD;
function readDXVA_QueryOrReplyFuncFlag_BAD(ptr: DWORD): DWORD;
function readDXVA_QueryOrReplyFuncFlag_PLUS(ptr: DWORD): DWORD;
function readDXVA_QueryOrReplyFuncFunc(ptr: DWORD): DWORD;
function writeDXVA_QueryOrReplyFunc(out ptr: DWORD; flg, fnc: DWORD): DWORD;
function setDXVA_QueryOrReplyFuncFlag(var ptr: DWORD; flg: DWORD): DWORD;
function setDXVA_QueryOrReplyFuncFunc(var ptr: DWORD; fnc: DWORD): DWORD;
function readDXVA_EncryptProtocolFuncFlag(ptr: DWORD): DWORD;
function readDXVA_EncryptProtocolFuncFlag_ACCEL(ptr: DWORD): DWORD;
function readDXVA_EncryptProtocolFuncFunc(ptr: DWORD): DWORD;
function writeDXVA_EncryptProtocolFunc(out ptr: DWORD; flg, fnc: DWORD): DWORD;
function setDXVA_EncryptProtocolFuncFlag(var ptr: DWORD; flg: DWORD): DWORD;
function setDXVA_EncryptProtocolFuncFunc(var ptr: DWORD; fnc: DWORD): DWORD;

implementation

function readDXVA_QueryOrReplyFuncFlag(ptr: DWORD): DWORD;
begin
    result := (ptr shr 8);
end;

function readDXVA_QueryOrReplyFuncFlag_ACCEL(ptr: DWORD): DWORD;
begin
    result := (ptr shr 11) AND 1;
end;

function readDXVA_QueryOrReplyFuncFlag_LOCK(ptr: DWORD): DWORD;
begin
    result := (ptr shr 10) AND 1;
end;

function readDXVA_QueryOrReplyFuncFlag_BAD(ptr: DWORD): DWORD;
begin
    result := (ptr shr 9) AND 1;
end;

function readDXVA_QueryOrReplyFuncFlag_PLUS(ptr: DWORD): DWORD;
begin
    result := (ptr shr 8) AND 1;
end;

function readDXVA_QueryOrReplyFuncFunc(ptr: DWORD): DWORD;
begin
    result := (ptr AND $FF);
end;

function writeDXVA_QueryOrReplyFunc(out ptr: DWORD; flg, fnc: DWORD): DWORD;
begin
    result := ((flg shl 8) or fnc);
    ptr := result;
end;

function setDXVA_QueryOrReplyFuncFlag(var ptr: DWORD; flg: DWORD): DWORD;
begin
    ptr := ptr or (flg shl 8);
end;

function setDXVA_QueryOrReplyFuncFunc(var ptr: DWORD; fnc: DWORD): DWORD;
begin
    ptr := ptr or fnc;
end;

function readDXVA_EncryptProtocolFuncFlag(ptr: DWORD): DWORD;
begin
    result := ptr shr 8;
end;

function readDXVA_EncryptProtocolFuncFlag_ACCEL(ptr: DWORD): DWORD;
begin
    result := (ptr shr 11) and 1;
end;

function readDXVA_EncryptProtocolFuncFunc(ptr: DWORD): DWORD;
begin
    result := (ptr AND $FF);
end;

function writeDXVA_EncryptProtocolFunc(out ptr: DWORD; flg, fnc: DWORD): DWORD;
begin
    ptr := (flg shl 8) or fnc;
    result := ptr;
end;

function setDXVA_EncryptProtocolFuncFlag(var ptr: DWORD; flg: DWORD): DWORD;
begin
    ptr := ptr or (flg shl 8);
    result := ptr;
end;

function setDXVA_EncryptProtocolFuncFunc(var ptr: DWORD; fnc: DWORD): DWORD;
begin
    ptr := ptr or fnc;
    result := ptr;
end;

(* Macros for Reading EOB and Index Values *)

function readDXVA_TCoefSingleIDX(ptr: TDXVA_TCoefSingle): DWORD;
begin
    result := ptr.wIndexWithEOB shr 1;

end;

function readDXVA_TCoefSingleEOB(ptr: TDXVA_TCoefSingle): DWORD;
begin
    result := ptr.wIndexWithEOB AND 1;
end;

(* Macro for Writing EOB and Index Values *)

procedure writeDXVA_TCoefSingleIndexWithEOB(var ptr: TDXVA_TCoefSingle; idx, eob: DWORD);
begin
    ptr.wIndexWithEOB := ((idx shl 1) or eob)
end;

procedure setDXVA_TCoefSingleIDX(var ptr: TDXVA_TCoefSingle; idx: DWORD);
begin
    ptr.wIndexWithEOB := ptr.wIndexWithEOB or (idx shl 1);
end;

procedure setDXVA_TCoefSingleEOB(var ptr: TDXVA_TCoefSingle);
begin
    ptr.wIndexWithEOB := ptr.wIndexWithEOB or 1;
end;

(* Macros for Reading STRENGTH and FilterOn *)

function readDXVA_EdgeFilterStrength(ptr: DWORD): DWORD;
begin
    result := ptr shr 1;
end;

function readDXVA_EdgeFilterOn(ptr: DWORD): DWORD;
begin
    result := ptr and 1;
end;

(* Macro for Writing STRENGTH and FilterOn *)

function writeDXVA_DeblockingEdgeControl(out ptr: DWORD; str, fon: DWORD): DWORD;
begin
    ptr := (str shl 1) or fon;
end;

procedure setDXVA_EdgeFilterStrength(var ptr: DWORD; str: DWORD);
begin
    ptr := ptr or (str shl 1);
end;

procedure setDXVA_EdgeFilterOn(var ptr: DWORD);
begin
    ptr := ptr or 1;
end;

function readDXVA_IA44index(ptr: DWORD): DWORD;
begin
    result := (ptr AND $F0) shr 4;
end;

function readDXVA_IA44alpha(ptr: DWORD): DWORD;
begin
    result := ptr and $0F;
end;

procedure writeDXVA_IA44(out ptr: DWORD; idx, Alpha: DWORD);
begin
    ptr := (idx shl 4) or Alpha;
end;

procedure setDXVA_IA44index(var ptr: DWORD; idx: DWORD);
begin
    ptr := ptr or (idx shr 4);
end;

procedure setDXVA_IA44alpha(var ptr: DWORD; Alpha: DWORD);
begin
    ptr := ptr or Alpha;
end;

(* Macros for AI44 alpha blending surface samples *)

function readDXVA_AI44index(ptr: DWORD): DWORD;
begin
    result := ptr AND $0F;

end;

function readDXVA_AI44alpha(ptr: DWORD): DWORD;
begin
    result := (ptr and $F0) shr 4;
end;

procedure writeDXVA_AI44(out ptr: DWORD; idx, Alpha: DWORD);
begin
    ptr := (Alpha shl 4) or idx;
end;

procedure setDXVA_AI44index(var ptr: DWORD; idx: DWORD);
begin
    ptr := ptr or idx;
end;

procedure setDXVA_AI44alpha(var ptr: DWORD; Alpha: DWORD);
begin
    ptr := ptr or (Alpha shl 4);
end;

end.
