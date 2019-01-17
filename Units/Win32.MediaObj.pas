unit Win32.MediaObj;

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils;

{$Z4}
{$A4}

const
    IID_IMediaBuffer: TGUID = '{59eff8b9-938c-4a26-82f2-95cb84cdc837}';
    IID_IMediaObject: TGUID = '{d8ad0f58-5494-4102-97c5-ec798e59bcf4}';
    IID_IEnumDMO: TGUID = '{2c3cd98a-2bfa-4a53-9c27-5249ba64ba0f}';
    IID_IMediaObjectInPlace: TGUID = '{651b9ad0-0fc7-4aa9-9538-d89931010741}';
    IID_IDMOQualityControl: TGUID = '{65abea96-cf36-453f-af8a-705e98f16260}';
    IID_IDMOVideoOutputOptimizations: TGUID = '{be8f4f4e-5b16-4d29-b350-7f6b5d9298ac}';

type
    {$IFNDEF FPC}
    CLSID = TGUID;
    PCLSID = ^CLSID;
    {$ENDIF}
    // TDMO_MEDIA_TYPE = TAM_MEDIA_TYPE;

    TDMO_MEDIA_TYPE = record
        majortype: TGUID;
        subtype: TGUID;
        bFixedSizeSamples: boolean;
        bTemporalCompression: boolean;
        lSampleSize: ULONG;
        formattype: TGUID;
        pUnk: IUnknown;
        cbFormat: ULONG;
        pbFormat: PBYTE;
    end;

    TREFERENCE_TIME = LONGLONG;


    TDMO_INPUT_DATA_BUFFER_FLAGS = (
        DMO_INPUT_DATA_BUFFERF_SYNCPOINT = $1,
        DMO_INPUT_DATA_BUFFERF_TIME = $2,
        DMO_INPUT_DATA_BUFFERF_TIMELENGTH = $4,
        DMO_INPUT_DATA_BUFFERF_DISCONTINUITY = $8
        );

    TDMO_OUTPUT_DATA_BUFFER_FLAGS = (
        DMO_OUTPUT_DATA_BUFFERF_SYNCPOINT = $1,
        DMO_OUTPUT_DATA_BUFFERF_TIME = $2,
        DMO_OUTPUT_DATA_BUFFERF_TIMELENGTH = $4,
        DMO_OUTPUT_DATA_BUFFERF_DISCONTINUITY = $8,
        DMO_OUTPUT_DATA_BUFFERF_INCOMPLETE = $1000000
        );

    TDMO_INPUT_STATUS_FLAGS = (
        DMO_INPUT_STATUSF_ACCEPT_DATA = $1
        );

    TDMO_INPUT_STREAM_INFO_FLAGS = (
        DMO_INPUT_STREAMF_WHOLE_SAMPLES = $1,
        DMO_INPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = $2,
        DMO_INPUT_STREAMF_FIXED_SAMPLE_SIZE = $4,
        DMO_INPUT_STREAMF_HOLDS_BUFFERS = $8
        );

    TDMO_OUTPUT_STREAM_INFO_FLAGS = (
        DMO_OUTPUT_STREAMF_WHOLE_SAMPLES = $1,
        DMO_OUTPUT_STREAMF_SINGLE_SAMPLE_PER_BUFFER = $2,
        DMO_OUTPUT_STREAMF_FIXED_SAMPLE_SIZE = $4,
        DMO_OUTPUT_STREAMF_DISCARDABLE = $8,
        DMO_OUTPUT_STREAMF_OPTIONAL = $10
        );

    TDMO_SET_TYPE_FLAGS = (
        DMO_SET_TYPEF_TEST_ONLY = $1,
        DMO_SET_TYPEF_CLEAR = $2
        );

    TDMO_PROCESS_OUTPUT_FLAGS = (
        DMO_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = $1
        );


    IMediaBuffer = interface(IUnknown)
        ['{59eff8b9-938c-4a26-82f2-95cb84cdc837}']
        function SetLength(cbLength: DWORD): HResult; stdcall;
        function GetMaxLength(out pcbMaxLength: DWORD): HResult; stdcall;
        function GetBufferAndLength(out ppBuffer: PBYTE; out pcbLength: DWORD): HResult; stdcall;
    end;


    TDMO_OUTPUT_DATA_BUFFER = record
        pBuffer: IMediaBuffer;
        dwStatus: DWORD;
        rtTimestamp: TREFERENCE_TIME;
        rtTimelength: TREFERENCE_TIME;
    end;

    PDMO_OUTPUT_DATA_BUFFER = ^TDMO_OUTPUT_DATA_BUFFER;

    IMediaObject = interface(IUnknown)
        ['{d8ad0f58-5494-4102-97c5-ec798e59bcf4}']
        function GetStreamCount(out pcInputStreams: DWORD; out pcOutputStreams: DWORD): HResult; stdcall;
        function GetInputStreamInfo(dwInputStreamIndex: DWORD; out pdwFlags: DWORD): HResult; stdcall;
        function GetOutputStreamInfo(dwOutputStreamIndex: DWORD; out pdwFlags: DWORD): HResult; stdcall;
        function GetInputType(dwInputStreamIndex: DWORD; dwTypeIndex: DWORD; out pmt: TDMO_MEDIA_TYPE): HResult; stdcall;
        function GetOutputType(dwOutputStreamIndex: DWORD; dwTypeIndex: DWORD; out pmt: TDMO_MEDIA_TYPE): HResult; stdcall;
        function SetInputType(dwInputStreamIndex: DWORD; const pmt: TDMO_MEDIA_TYPE; dwFlags: DWORD): HResult; stdcall;
        function SetOutputType(dwOutputStreamIndex: DWORD; const pmt: TDMO_MEDIA_TYPE; dwFlags: DWORD): HResult; stdcall;
        function GetInputCurrentType(dwInputStreamIndex: DWORD; out pmt: TDMO_MEDIA_TYPE): HResult; stdcall;
        function GetOutputCurrentType(dwOutputStreamIndex: DWORD; out pmt: TDMO_MEDIA_TYPE): HResult; stdcall;
        function GetInputSizeInfo(dwInputStreamIndex: DWORD; out pcbSize: DWORD; out pcbMaxLookahead: DWORD;
            out pcbAlignment: DWORD): HResult; stdcall;
        function GetOutputSizeInfo(dwOutputStreamIndex: DWORD; out pcbSize: DWORD; out pcbAlignment: DWORD): HResult; stdcall;
        function GetInputMaxLatency(dwInputStreamIndex: DWORD; out prtMaxLatency: TREFERENCE_TIME): HResult; stdcall;
        function SetInputMaxLatency(dwInputStreamIndex: DWORD; rtMaxLatency: TREFERENCE_TIME): HResult; stdcall;
        function Flush(): HResult; stdcall;
        function Discontinuity(dwInputStreamIndex: DWORD): HResult; stdcall;
        function AllocateStreamingResources(): HResult; stdcall;
        function FreeStreamingResources(): HResult; stdcall;
        function GetInputStatus(dwInputStreamIndex: DWORD; out dwFlags: DWORD): HResult; stdcall;
        function ProcessInput(dwInputStreamIndex: DWORD; pBuffer: IMediaBuffer; dwFlags: DWORD; rtTimestamp: TREFERENCE_TIME;
            rtTimelength: TREFERENCE_TIME): HResult; stdcall;
        function ProcessOutput(dwFlags: DWORD; cOutputBufferCount: DWORD; out pOutputBuffers: PDMO_OUTPUT_DATA_BUFFER;
            out pdwStatus: DWORD): HResult; stdcall;
        function Lock(bLock: longint): HResult; stdcall;
    end;

    IEnumDMO = interface(IUnknown)
        ['{2c3cd98a-2bfa-4a53-9c27-5249ba64ba0f}']
        function Next(cItemsToFetch: DWORD; out pCLSID: PCLSID; // size of pcItemsFetched
            out Names: PLPWSTR;// size of pcItemsFetched
            out pcItemsFetched: DWORD): HResult; stdcall;
        function Skip(cItemsToSkip: DWORD): HResult; stdcall;
        function Reset(): HResult; stdcall;
        function Clone(out ppEnum: IEnumDMO): HResult; stdcall;
    end;


    TDMO_INPLACE_PROCESS_FLAGS = (
        DMO_INPLACE_NORMAL = 0,
        DMO_INPLACE_ZERO = $1
        );


    IMediaObjectInPlace = interface(IUnknown)
        ['{651b9ad0-0fc7-4aa9-9538-d89931010741}']
        function Process(ulSize: ULONG; out pData: PBYTE; refTimeStart: TREFERENCE_TIME; dwFlags: DWORD): HResult; stdcall;
        function Clone(out ppMediaObject: IMediaObjectInPlace): HResult; stdcall;
        function GetLatency(out pLatencyTime: TREFERENCE_TIME): HResult; stdcall;
    end;


    TDMO_QUALITY_STATUS_FLAGS = (
        DMO_QUALITY_STATUS_ENABLED = $1
        );


    IDMOQualityControl = interface(IUnknown)
        ['{65abea96-cf36-453f-af8a-705e98f16260}']
        function SetNow(rtNow: TREFERENCE_TIME): HResult; stdcall;
        function SetStatus(dwFlags: DWORD): HResult; stdcall;
        function GetStatus(out pdwFlags: DWORD): HResult; stdcall;
    end;


    TDMO_VIDEO_OUTPUT_STREAM_FLAGS = (
        DMO_VOSF_NEEDS_PREVIOUS_SAMPLE = $1
        );


    IDMOVideoOutputOptimizations = interface(IUnknown)
        ['{be8f4f4e-5b16-4d29-b350-7f6b5d9298ac}']
        function QueryOperationModePreferences(ulOutputStreamIndex: ULONG; out pdwRequestedCapabilities: DWORD): HResult; stdcall;
        function SetOperationMode(ulOutputStreamIndex: ULONG; dwEnabledFeatures: DWORD): HResult; stdcall;
        function GetCurrentOperationMode(ulOutputStreamIndex: ULONG; out pdwEnabledFeatures: DWORD): HResult; stdcall;
        function GetCurrentSampleRequirements(ulOutputStreamIndex: ULONG; out pdwRequestedFeatures: DWORD): HResult; stdcall;
    end;

implementation

end.
