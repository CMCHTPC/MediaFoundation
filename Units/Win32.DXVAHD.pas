{
  FileName:   DXVAHD.h
}

unit Win32.DXVAHD;

interface

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

{$Z4}
{$A4}

uses
    Windows, Classes;

const
    DXVAHD_DLL = 'Dxva2.dll';

const
    IID_IDXVAHD_Device: TGUID = '{95f12dfd-d77e-49be-815f-57d579634d6d}';
    IID_IDXVAHD_VideoProcessor: TGUID =
        '{95f4edf4-6e03-4cd7-be1b-3075d665aa52}';
    DXVAHDControlGuid: TGUID = '{a0386e75-f70c-464c-a9ce-33c44e091623}';
    // DXVA2Trace_Control
    DXVAHDETWGUID_CREATEVIDEOPROCESSOR: TGUID =
        '{681e3d1e-5674-4fb3-a503-2f2055e91f60}';
    DXVAHDETWGUID_VIDEOPROCESSBLTSTATE: TGUID =
        '{76c94b5a-193f-4692-9484-a4d999da81a8}';
    DXVAHDETWGUID_VIDEOPROCESSSTREAMSTATE: TGUID =
        '{262c0b02-209d-47ed-94d8-82ae02b84aa7}';
    DXVAHDETWGUID_VIDEOPROCESSBLTHD: TGUID =
        '{bef3d435-78c7-4de3-9707-cd1b083b160a}';
    DXVAHDETWGUID_VIDEOPROCESSBLTHD_STREAM: TGUID =
        '{27ae473e-a5fc-4be5-b4e3-f24994d3c495}';
    DXVAHDETWGUID_DESTROYVIDEOPROCESSOR: TGUID =
        '{f943f0a0-3f16-43e0-8093-105a986aa5f1}';
    DXVAHD_STREAM_STATE_PRIVATE_IVTC: TGUID =
        '{9c601e3c-0f33-414c-a739-99540ee42da5}';


type

    IDirect3DDevice9Ex = DWORD;
    PIDirect3DDevice9Ex = ^IDirect3DDevice9Ex;

    IDirect3DSurface9 = DWORD;
    PIDirect3DSurface9 = ^IDirect3DSurface9;

    TD3DCOLOR = DWORD;
    PD3DCOLOR = ^TD3DCOLOR;
    TD3DFORMAT = DWORD;
    PD3DFORMAT = ^TD3DFORMAT;
    TD3DPOOL = DWORD;

    TDXVAHD_FRAME_FORMAT = (DXVAHD_FRAME_FORMAT_PROGRESSIVE =
        0, DXVAHD_FRAME_FORMAT_INTERLACED_TOP_FIELD_FIRST = 1,
        DXVAHD_FRAME_FORMAT_INTERLACED_BOTTOM_FIELD_FIRST = 2);

    TDXVAHD_DEVICE_USAGE = (DXVAHD_DEVICE_USAGE_PLAYBACK_NORMAL =
        0, DXVAHD_DEVICE_USAGE_OPTIMAL_SPEED = 1,
        DXVAHD_DEVICE_USAGE_OPTIMAL_QUALITY = 2);

    TDXVAHD_SURFACE_TYPE = (DXVAHD_SURFACE_TYPE_VIDEO_INPUT =
        0, DXVAHD_SURFACE_TYPE_VIDEO_INPUT_PRIVATE = 1,
        DXVAHD_SURFACE_TYPE_VIDEO_OUTPUT = 2);

    TDXVAHD_DEVICE_TYPE = (DXVAHD_DEVICE_TYPE_HARDWARE = 0,
        DXVAHD_DEVICE_TYPE_SOFTWARE = 1, DXVAHD_DEVICE_TYPE_REFERENCE =
        2, DXVAHD_DEVICE_TYPE_OTHER = 3);

    TDXVAHD_DEVICE_CAPS = (DXVAHD_DEVICE_CAPS_LINEAR_SPACE =
        $1, DXVAHD_DEVICE_CAPS_xvYCC = $2,
        DXVAHD_DEVICE_CAPS_RGB_RANGE_CONVERSION = $4,
        DXVAHD_DEVICE_CAPS_YCbCr_MATRIX_CONVERSION = $8);

    TDXVAHD_FEATURE_CAPS = (DXVAHD_FEATURE_CAPS_ALPHA_FILL =
        $1, DXVAHD_FEATURE_CAPS_CONSTRICTION = $2, DXVAHD_FEATURE_CAPS_LUMA_KEY = $4,
        DXVAHD_FEATURE_CAPS_ALPHA_PALETTE = $8);

    TDXVAHD_FILTER_CAPS = (DXVAHD_FILTER_CAPS_BRIGHTNESS = $1,
        DXVAHD_FILTER_CAPS_CONTRAST = $2, DXVAHD_FILTER_CAPS_HUE = $4,
        DXVAHD_FILTER_CAPS_SATURATION = $8,
        DXVAHD_FILTER_CAPS_NOISE_REDUCTION = $10,
        DXVAHD_FILTER_CAPS_EDGE_ENHANCEMENT = $20,
        DXVAHD_FILTER_CAPS_ANAMORPHIC_SCALING = $40);

    TDXVAHD_INPUT_FORMAT_CAPS = (DXVAHD_INPUT_FORMAT_CAPS_RGB_INTERLACED = $1,
        DXVAHD_INPUT_FORMAT_CAPS_RGB_PROCAMP = $2,
        DXVAHD_INPUT_FORMAT_CAPS_RGB_LUMA_KEY = $4,
        DXVAHD_INPUT_FORMAT_CAPS_PALETTE_INTERLACED = $8);

    TDXVAHD_PROCESSOR_CAPS = (DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BLEND =
        $1, DXVAHD_PROCESSOR_CAPS_DEINTERLACE_BOB = $2,
        DXVAHD_PROCESSOR_CAPS_DEINTERLACE_ADAPTIVE = $4,
        DXVAHD_PROCESSOR_CAPS_DEINTERLACE_MOTION_COMPENSATION = $8,
        DXVAHD_PROCESSOR_CAPS_INVERSE_TELECINE = $10,
        DXVAHD_PROCESSOR_CAPS_FRAME_RATE_CONVERSION = $20);

    TDXVAHD_ITELECINE_CAPS = (DXVAHD_ITELECINE_CAPS_32 = $1,
        DXVAHD_ITELECINE_CAPS_22 = $2, DXVAHD_ITELECINE_CAPS_2224 =
        $4, DXVAHD_ITELECINE_CAPS_2332 = $8,
        DXVAHD_ITELECINE_CAPS_32322 = $10, DXVAHD_ITELECINE_CAPS_55 =
        $20, DXVAHD_ITELECINE_CAPS_64 = $40, DXVAHD_ITELECINE_CAPS_87 = $80,
        DXVAHD_ITELECINE_CAPS_222222222223 = $100,
        DXVAHD_ITELECINE_CAPS_OTHER = $80000000);

    TDXVAHD_FILTER = (DXVAHD_FILTER_BRIGHTNESS = 0, DXVAHD_FILTER_CONTRAST =
        1, DXVAHD_FILTER_HUE = 2, DXVAHD_FILTER_SATURATION = 3,
        DXVAHD_FILTER_NOISE_REDUCTION = 4, DXVAHD_FILTER_EDGE_ENHANCEMENT =
        5, DXVAHD_FILTER_ANAMORPHIC_SCALING = 6);

    TDXVAHD_BLT_STATE = (DXVAHD_BLT_STATE_TARGET_RECT = 0,
        DXVAHD_BLT_STATE_BACKGROUND_COLOR = 1,
        DXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE = 2,
        DXVAHD_BLT_STATE_ALPHA_FILL = 3, DXVAHD_BLT_STATE_CONSTRICTION = 4,
        DXVAHD_BLT_STATE_PRIVATE = 1000);

    TDXVAHD_ALPHA_FILL_MODE = (DXVAHD_ALPHA_FILL_MODE_OPAQUE =
        0, DXVAHD_ALPHA_FILL_MODE_BACKGROUND = 1,
        DXVAHD_ALPHA_FILL_MODE_DESTINATION = 2,
        DXVAHD_ALPHA_FILL_MODE_SOURCE_STREAM = 3);

    TDXVAHD_STREAM_STATE = (DXVAHD_STREAM_STATE_D3DFORMAT = 0,
        DXVAHD_STREAM_STATE_FRAME_FORMAT = 1,
        DXVAHD_STREAM_STATE_INPUT_COLOR_SPACE = 2,
        DXVAHD_STREAM_STATE_OUTPUT_RATE = 3, DXVAHD_STREAM_STATE_SOURCE_RECT =
        4, DXVAHD_STREAM_STATE_DESTINATION_RECT =
        5, DXVAHD_STREAM_STATE_ALPHA = 6,
        DXVAHD_STREAM_STATE_PALETTE = 7, DXVAHD_STREAM_STATE_LUMA_KEY =
        8, DXVAHD_STREAM_STATE_ASPECT_RATIO = 9,
        DXVAHD_STREAM_STATE_FILTER_BRIGHTNESS = 100,
        DXVAHD_STREAM_STATE_FILTER_CONTRAST = 101,
        DXVAHD_STREAM_STATE_FILTER_HUE = 102,
        DXVAHD_STREAM_STATE_FILTER_SATURATION = 103,
        DXVAHD_STREAM_STATE_FILTER_NOISE_REDUCTION = 104,
        DXVAHD_STREAM_STATE_FILTER_EDGE_ENHANCEMENT = 105,
        DXVAHD_STREAM_STATE_FILTER_ANAMORPHIC_SCALING = 106,
        DXVAHD_STREAM_STATE_PRIVATE = 1000);

    TDXVAHD_OUTPUT_RATE = (DXVAHD_OUTPUT_RATE_NORMAL = 0,
        DXVAHD_OUTPUT_RATE_HALF = 1, DXVAHD_OUTPUT_RATE_CUSTOM = 2);

    TDXVAHD_RATIONAL = record
        Numerator: UINT;
        Denominator: UINT;
    end;

    TDXVAHD_COLOR_RGBA = record
        R: single;
        G: single;
        B: single;
        A: single;
    end;

    TDXVAHD_COLOR_YCbCrA = record
        Y: single;
        Cb: single;
        Cr: single;
        A: single;
    end;


    TDXVAHD_CONTENT_DESC = record
        InputFrameFormat: TDXVAHD_FRAME_FORMAT;
        InputFrameRate: TDXVAHD_RATIONAL;
        InputWidth: UINT;
        InputHeight: UINT;
        OutputFrameRate: TDXVAHD_RATIONAL;
        OutputWidth: UINT;
        OutputHeight: UINT;
    end;

    TDXVAHD_VPDEVCAPS = record
        DeviceType: TDXVAHD_DEVICE_TYPE;
        DeviceCaps: UINT;
        FeatureCaps: UINT;
        FilterCaps: UINT;
        InputFormatCaps: UINT;
        InputPool: TD3DPOOL;
        OutputFormatCount: UINT;
        InputFormatCount: UINT;
        VideoProcessorCount: UINT;
        MaxInputStreams: UINT;
        MaxStreamStates: UINT;
    end;

    TDXVAHD_VPCAPS = record
        VPGuid: TGUID;
        PastFrames: UINT;
        FutureFrames: UINT;
        ProcessorCaps: UINT;
        ITelecineCaps: UINT;
        CustomRateCount: UINT;
    end;

    PDXVAHD_VPCAPS = ^TDXVAHD_VPCAPS;

    TDXVAHD_CUSTOM_RATE_DATA = record
        CustomRate: TDXVAHD_RATIONAL;
        OutputFrames: UINT;
        InputInterlaced: boolean;
        InputFramesOrFields: UINT;
    end;

    PDXVAHD_CUSTOM_RATE_DATA = ^TDXVAHD_CUSTOM_RATE_DATA;

    TDXVAHD_FILTER_RANGE_DATA = record
        Minimum: integer;
        Maximum: integer;
        _Default: integer;
        Multiplier: single;
    end;

    TDXVAHD_BLT_STATE_TARGET_RECT_DATA = record
        Enable: boolean;
        TargetRect: TRECT;
    end;

    TDXVAHD_COLOR = record
        case integer of
            0: (RGB: TDXVAHD_COLOR_RGBA);
            1: (YCbCr: TDXVAHD_COLOR_YCbCrA);
    end;

    TDXVAHD_BLT_STATE_BACKGROUND_COLOR_DATA = record
        YCbCr: boolean;
        BackgroundColor: TDXVAHD_COLOR;
    end;
{$IFDEF FPC}

    TDXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE_DATA = bitpacked record
        case integer of
            0: (Usage: 0..1;
                RGB_Range: 0..1;
                YCbCr_Matrix: 0..1;
                YCbCr_xvYCC: 0..1;
                Reserved: 0..268435455);
            1: (Value: UINT);
    end;
{$ELSE}
    TDXVAHD_BLT_STATE_OUTPUT_COLOR_SPACE_DATA = record
        Value: UINT;
    end;

{$ENDIF}

    TDXVAHD_BLT_STATE_ALPHA_FILL_DATA = record
        Mode: TDXVAHD_ALPHA_FILL_MODE;
        StreamNumber: UINT;
    end;

    TDXVAHD_BLT_STATE_CONSTRICTION_DATA = record
        Enable: boolean;
        Size: TSIZE;
    end;

    TDXVAHD_BLT_STATE_PRIVATE_DATA = record
        Guid: TGUID;
        DataSize: UINT;
        pData: Pointer;
    end;

    TDXVAHD_STREAM_STATE_D3DFORMAT_DATA = record
        Format: TD3DFORMAT;
    end;

    TDXVAHD_STREAM_STATE_FRAME_FORMAT_DATA = record
        FrameFormat: TDXVAHD_FRAME_FORMAT;
    end;
{$IFDEF FPC}

    TDXVAHD_STREAM_STATE_INPUT_COLOR_SPACE_DATA = record
        case integer of
            0: (_Type: 0..1;
                RGB_Range: 0..1;
                YCbCr_Matrix: 0..1;
                YCbCr_xvYCC: 0..1;
                Reserved: 0..(1 shl 28)-1);
            1: (Value: UINT);

    end;

{$ELSE}
    TDXVAHD_STREAM_STATE_INPUT_COLOR_SPACE_DATA = record
        Value: UINT;
    end;
{$ENDIF}
    TDXVAHD_STREAM_STATE_OUTPUT_RATE_DATA = record
        RepeatFrame: boolean;
        OutputRate: TDXVAHD_OUTPUT_RATE;
        CustomRate: TDXVAHD_RATIONAL;
    end;

    TDXVAHD_STREAM_STATE_SOURCE_RECT_DATA = record
        Enable: boolean;
        SourceRect: TRECT;
    end;

    TDXVAHD_STREAM_STATE_DESTINATION_RECT_DATA = record
        Enable: boolean;
        DestinationRect: TRECT;
    end;

    TDXVAHD_STREAM_STATE_ALPHA_DATA = record
        Enable: boolean;
        Alpha: single;
    end;

    TDXVAHD_STREAM_STATE_PALETTE_DATA = record
        Count: UINT;
        pEntries: PD3DCOLOR;
    end;

    TDXVAHD_STREAM_STATE_LUMA_KEY_DATA = record
        Enable: boolean;
        Lower: single;
        Upper: single;
    end;

    TDXVAHD_STREAM_STATE_ASPECT_RATIO_DATA = record
        Enable: boolean;
        SourceAspectRatio: TDXVAHD_RATIONAL;
        DestinationAspectRatio: TDXVAHD_RATIONAL;
    end;

    TDXVAHD_STREAM_STATE_FILTER_DATA = record
        Enable: boolean;
        Level: integer;
    end;

    TDXVAHD_STREAM_STATE_PRIVATE_DATA = record
        Guid: TGUID;
        DataSize: UINT;
        pData: Pointer;
    end;

    TDXVAHD_STREAM_DATA = record
        Enable: boolean;
        OutputIndex: UINT;
        InputFrameOrField: UINT;
        PastFrames: UINT;
        FutureFrames: UINT;
        ppPastSurfaces: PIDirect3DSurface9;
        pInputSurface: PIDirect3DSurface9;
        ppFutureSurfaces: PIDirect3DSurface9;
    end;

    PDXVAHD_STREAM_DATA = ^TDXVAHD_STREAM_DATA;

    TDXVAHD_STREAM_STATE_PRIVATE_IVTC_DATA = record
        Enable: boolean;
        ITelecineFlags: UINT;
        Frames: UINT;
        InputField: UINT;
    end;

    PDXVAHDSW_CreateDevice = function(pD3DDevice: IDirect3DDevice9Ex;
        out phDevice: THANDLE): HResult;
        stdcall; // callback

    PDXVAHDSW_ProposeVideoPrivateFormat = function(hDevice: THANDLE;
        var pFormat: TD3DFORMAT): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessorDeviceCaps = function(hDevice: THANDLE;
        const pContentDesc: TDXVAHD_CONTENT_DESC; Usage: TDXVAHD_DEVICE_USAGE;
        out pCaps: TDXVAHD_VPDEVCAPS): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessorOutputFormats = function(hDevice: THANDLE;
        const pContentDesc: TDXVAHD_CONTENT_DESC; Usage: TDXVAHD_DEVICE_USAGE;
        Count: UINT; out pFormats: PD3DFORMAT): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessorInputFormats = function(hDevice: THANDLE;
        const pContentDesc: TDXVAHD_CONTENT_DESC; Usage: TDXVAHD_DEVICE_USAGE;
        Count: UINT; out pFormats: PD3DFORMAT): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessorCaps = function(hDevice: THANDLE;
        const pContentDesc: TDXVAHD_CONTENT_DESC; Usage: TDXVAHD_DEVICE_USAGE;
        Count: UINT; out pCaps: PDXVAHD_VPCAPS): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessorCustomRates = function(hDevice: THANDLE;
        const pVPGuid: TGUID; Count: UINT;
        out pRates: PDXVAHD_CUSTOM_RATE_DATA): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessorFilterRange = function(hDevice: THANDLE;
        Filter: TDXVAHD_FILTER; out pRange: TDXVAHD_FILTER_RANGE_DATA): HResult;
        stdcall;
    // callback
    PDXVAHDSW_DestroyDevice = function(hDevice: THANDLE): HResult;
        stdcall; // callback

    PDXVAHDSW_CreateVideoProcessor = function(hDevice: THANDLE;
        const pVPGuid: TGUID; out phVideoProcessor: THANDLE): HResult;
        stdcall; // callback

    PDXVAHDSW_SetVideoProcessBltState = function(hVideoProcessor: THANDLE;
        State: TDXVAHD_BLT_STATE; DataSize: UINT; const pData: Pointer): HResult;
        stdcall;
    // callback

    PDXVAHDSW_GetVideoProcessBltStatePrivate =
        function(hVideoProcessor: THANDLE;
        var pData: TDXVAHD_BLT_STATE_PRIVATE_DATA): HResult;
        stdcall; // callback

    PDXVAHDSW_SetVideoProcessStreamState = function(hVideoProcessor: THANDLE;
        StreamNumber: UINT; State: TDXVAHD_STREAM_STATE; DataSize: UINT;
        const pData: Pointer): HResult;
        stdcall; // callback

    PDXVAHDSW_GetVideoProcessStreamStatePrivate =
        function(hVideoProcessor: THANDLE; StreamNumber: UINT;
        var pData: TDXVAHD_STREAM_STATE_PRIVATE_DATA): HResult;
        stdcall; // callback

    PDXVAHDSW_VideoProcessBltHD = function(hVideoProcessor: THANDLE;
        pOutputSurface: IDirect3DSurface9; OutputFrame: UINT;
        StreamCount: UINT; const pStreams: PDXVAHD_STREAM_DATA): HResult;
        stdcall; // callback

    PDXVAHDSW_DestroyVideoProcessor =
        function(hVideoProcessor: THANDLE): HResult;
        stdcall; // callback

    TDXVAHDSW_CALLBACKS = record
        CreateDevice: PDXVAHDSW_CreateDevice;
        ProposeVideoPrivateFormat: PDXVAHDSW_ProposeVideoPrivateFormat;
        GetVideoProcessorDeviceCaps: PDXVAHDSW_GetVideoProcessorDeviceCaps;
        GetVideoProcessorOutputFormats:
        PDXVAHDSW_GetVideoProcessorOutputFormats;
        GetVideoProcessorInputFormats: PDXVAHDSW_GetVideoProcessorInputFormats;
        GetVideoProcessorCaps: PDXVAHDSW_GetVideoProcessorCaps;
        GetVideoProcessorCustomRates: PDXVAHDSW_GetVideoProcessorCustomRates;
        GetVideoProcessorFilterRange: PDXVAHDSW_GetVideoProcessorFilterRange;
        DestroyDevice: PDXVAHDSW_DestroyDevice;
        CreateVideoProcessor: PDXVAHDSW_CreateVideoProcessor;
        SetVideoProcessBltState: PDXVAHDSW_SetVideoProcessBltState;
        GetVideoProcessBltStatePrivate:
        PDXVAHDSW_GetVideoProcessBltStatePrivate;
        SetVideoProcessStreamState: PDXVAHDSW_SetVideoProcessStreamState;
        GetVideoProcessStreamStatePrivate:
        PDXVAHDSW_GetVideoProcessStreamStatePrivate;
        VideoProcessBltHD: PDXVAHDSW_VideoProcessBltHD;
        DestroyVideoProcessor: PDXVAHDSW_DestroyVideoProcessor;
    end;

    PDXVAHDSW_Plugin = function(Size: UINT; out pCallbacks: Pointer): HResult;
        stdcall; // CALLBACK*

    TDXVAHDETW_CREATEVIDEOPROCESSOR = record
        pObject: ULONGLONG;
        pD3D9Ex: ULONGLONG;
        VPGuid: TGUID;
    end;

    TDXVAHDETW_VIDEOPROCESSBLTSTATE = record
        pObject: ULONGLONG;
        State: TDXVAHD_BLT_STATE;
        DataSize: UINT;
        SetState: boolean;
    end;

    TDXVAHDETW_VIDEOPROCESSSTREAMSTATE = record
        pObject: ULONGLONG;
        StreamNumber: UINT;
        State: TDXVAHD_STREAM_STATE;
        DataSize: UINT;
        SetState: boolean;
    end;

    TDXVAHDETW_VIDEOPROCESSBLTHD = record
        pObject: ULONGLONG;
        pOutputSurface: ULONGLONG;
        TargetRect: TRECT;
        OutputFormat: TD3DFORMAT;
        ColorSpace: UINT;
        OutputFrame: UINT;
        StreamCount: UINT;
        Enter: boolean;
    end;

    TDXVAHDETW_VIDEOPROCESSBLTHD_STREAM = record
        pObject: ULONGLONG;
        pInputSurface: ULONGLONG;
        SourceRect: TRECT;
        DestinationRect: TRECT;
        InputFormat: TD3DFORMAT;
        FrameFormat: TDXVAHD_FRAME_FORMAT;
        ColorSpace: UINT;
        StreamNumber: UINT;
        OutputIndex: UINT;
        InputFrameOrField: UINT;
        PastFrames: UINT;
        FutureFrames: UINT;
    end;

    TDXVAHDETW_DESTROYVIDEOPROCESSOR = record
        pObject: ULONGLONG;
    end;

    IDXVAHD_VideoProcessor = interface(IUnknown)
        ['{95f4edf4-6e03-4cd7-be1b-3075d665aa52}']
        function SetVideoProcessBltState(State: TDXVAHD_BLT_STATE;
            DataSize: UINT; const pData: Pointer): HResult;
            stdcall;
        function GetVideoProcessBltState(State: TDXVAHD_BLT_STATE;
            DataSize: UINT; var pData: Pointer): HResult; stdcall;
        function SetVideoProcessStreamState(StreamNumber: UINT;
            State: TDXVAHD_STREAM_STATE; DataSize: UINT;
            const pData: Pointer): HResult; stdcall;
        function GetVideoProcessStreamState(StreamNumber: UINT;
            State: TDXVAHD_STREAM_STATE; DataSize: UINT;
            var pData: Pointer): HResult; stdcall;
        function VideoProcessBltHD(pOutputSurface: IDirect3DSurface9;
            OutputFrame: UINT; StreamCount: UINT;
            const pStreams: PDXVAHD_STREAM_DATA): HResult;
            stdcall;
    end;

    IDXVAHD_Device = interface(IUnknown)
        ['{95f12dfd-d77e-49be-815f-57d579634d6d}']
        function CreateVideoSurface(Width: UINT; Height: UINT;
            Format: TD3DFORMAT; Pool: TD3DPOOL; Usage: DWORD;
            _Type: TDXVAHD_SURFACE_TYPE; NumSurfaces: UINT;
            out ppSurfaces: PIDirect3DSurface9; var pSharedHandle: THANDLE): HResult;
            stdcall;
        function GetVideoProcessorDeviceCaps(
            out pCaps: TDXVAHD_VPDEVCAPS): HResult; stdcall;
        function GetVideoProcessorOutputFormats(Count: UINT;
            out pFormats: PD3DFORMAT): HResult; stdcall;
        function GetVideoProcessorInputFormats(Count: UINT;
            out pFormats: PD3DFORMAT): HResult; stdcall;
        function GetVideoProcessorCaps(Count: UINT;
            out pCaps: PDXVAHD_VPCAPS): HResult; stdcall;
        function GetVideoProcessorCustomRates(const pVPGuid: TGUID;
            Count: UINT; out pRates: PDXVAHD_CUSTOM_RATE_DATA): HResult; stdcall;
        function GetVideoProcessorFilterRange(Filter: TDXVAHD_FILTER;
            out pRange: TDXVAHD_FILTER_RANGE_DATA): HResult; stdcall;
        function CreateVideoProcessor(const pVPGuid: TGUID;
            out ppVideoProcessor: IDXVAHD_VideoProcessor): HResult; stdcall;
    end;

    PDXVAHD_CreateDevice = function (pD3DDevice: IDirect3DDevice9Ex;
    const pContentDesc: TDXVAHD_CONTENT_DESC; Usage: TDXVAHD_DEVICE_USAGE;
    pPlugin: PDXVAHDSW_Plugin; out ppDevice: IDXVAHD_Device): HResult;
    stdcall;


function DXVAHD_CreateDevice(pD3DDevice: IDirect3DDevice9Ex;
    const pContentDesc: TDXVAHD_CONTENT_DESC; Usage: TDXVAHD_DEVICE_USAGE;
    pPlugin: PDXVAHDSW_Plugin; out ppDevice: IDXVAHD_Device): HResult;
    stdcall; external DXVAHD_DLL;


implementation

end.
