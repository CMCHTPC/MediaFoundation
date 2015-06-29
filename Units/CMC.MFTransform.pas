unit CMC.MFTransform;
{$IFDEF FPC}
{$MODE delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, CMC.MFObjects, CMC.WTypes;

const
    MFPlat_DLL = 'MFPlat.dll';

const
    IID_IMFTransform: TGUID = '{bf94c121-5b05-4e6f-8000-ba598961414d}';

    MF_SA_D3D_AWARE: TGUID = '{eaa35c29-775e-488e-9b61-b3283e49583b}';
    MF_SA_REQUIRED_SAMPLE_COUNT: TGUID = '{18802c61-324b-4952-abd0-176ff5c696ff}';
    MFT_END_STREAMING_AWARE: TGUID = '{70fbc845-b07e-4089-b064-399dc6110f29}';
    MF_SA_REQUIRED_SAMPLE_COUNT_PROGRESSIVE: TGUID = '{b172d58e-fa77-4e48-8d2a-1df2d850eac2}';
    MF_SA_MINIMUM_OUTPUT_SAMPLE_COUNT: TGUID = '{851745d5-c3d6-476d-9527-498ef2d10d18}';
    MF_SA_MINIMUM_OUTPUT_SAMPLE_COUNT_PROGRESSIVE: TGUID = '{0f5523a5-1cb2-47c5-a550-2eeb84b4d14a}';
    MFT_SUPPORT_3DVIDEO: TGUID = '{093f81b1-4f2e-4631-8168-7934032a01d3}';
    MF_ENABLE_3DVIDEO_OUTPUT: TGUID = '{bdad7bca-0e5f-4b10-ab16-26de381b6293}';
    MF_SA_D3D11_BINDFLAGS: TGUID = '{eacf97ad-065c-4408-bee3-fdcbfd128be2}';
    MF_SA_D3D11_USAGE: TGUID = '{e85fe442-2ca3-486e-a9c7-109dda609880}';
    MF_SA_D3D11_AWARE: TGUID = '{206b4fc8-fcf9-4c51-afe3-9764369e33a0}';
    MF_SA_D3D11_SHARED: TGUID = '{7b8f32c3-6d96-4b89-9203-dd38b61414f3}';
    MF_SA_D3D11_SHARED_WITHOUT_MUTEX: TGUID = '{39dbd44d-2e44-4931-a4c8-352d3dc42115}';
    MF_SA_D3D11_ALLOW_DYNAMIC_YUV_TEXTURE: TGUID = '{ce06d49f-0613-4b9d-86a6-d8c4f9c10075}';
    MF_SA_D3D11_HW_PROTECTED: TGUID = '{3a8ba9d9-92ca-4307-a391-6999dbf3b6ce}';
    MF_SA_BUFFERS_PER_SAMPLE: TGUID = '{873c5171-1e3d-4e25-988d-b433ce041983}';
    MFT_DECODER_EXPOSE_OUTPUT_TYPES_IN_NATIVE_ORDER: TGUID = '{ef80833f-f8fa-44d9-80d8-41ed6232670c}';
    MFT_DECODER_QUALITY_MANAGEMENT_CUSTOM_CONTROL: TGUID = '{a24e30d7-de25-4558-bbfb-71070a2d332e}';
    MFT_DECODER_QUALITY_MANAGEMENT_RECOVERY_WITHOUT_ARTIFACTS: TGUID = '{d8980deb-0a48-425f-8623-611db41d3810}';
    MFT_REMUX_MARK_I_PICTURE_AS_CLEAN_POINT: TGUID = '{364e8f85-3f2e-436c-b2a2-4440a012a9e8}';
    MFT_DECODER_FINAL_VIDEO_RESOLUTION_HINT: TGUID = '{dc2f8496-15c4-407a-b6f0-1b66ab5fbf53}';
    MFT_ENCODER_SUPPORTS_CONFIG_EVENT: TGUID = '{86a355ae-3a77-4ec4-9f31-01149a4e92de}';
    MFT_ENUM_HARDWARE_VENDOR_ID_Attribute: TGUID = '{3aecb0cc-035b-4bcc-8185-2b8d551ef3af}';
    MF_TRANSFORM_ASYNC: TGUID = '{f81a699a-649a-497d-8c73-29f8fed6ad7a}';
    MF_TRANSFORM_ASYNC_UNLOCK: TGUID = '{e5666d6b-3422-4eb6-a421-da7db1f8e207}';
    MF_TRANSFORM_FLAGS_Attribute: TGUID = '{9359bb7e-6275-46c4-a025-1c01e45f1a86}';
    MF_TRANSFORM_CATEGORY_Attribute: TGUID = '{ceabba49-506d-4757-a6ff-66c184987e4e}';
    MFT_TRANSFORM_CLSID_Attribute: TGUID = '{6821c42b-65a4-4e82-99bc-9a88205ecd0c}';
    MFT_INPUT_TYPES_Attributes: TGUID = '{4276c9b1-759d-4bf3-9cd0-0d723d138f96}';
    MFT_OUTPUT_TYPES_Attributes: TGUID = '{8eae8cf3-a44f-4306-ba5c-bf5dda242818}';
    MFT_ENUM_HARDWARE_URL_Attribute: TGUID = '{2fb866ac-b078-4942-ab6c-003d05cda674}';
    MFT_FRIENDLY_NAME_Attribute: TGUID = '{314ffbae-5b41-4c95-9c19-4e7d586face3}';
    MFT_CONNECTED_STREAM_ATTRIBUTE: TGUID = '{71eeb820-a59f-4de2-bcec-38db1dd611a4}';
    MFT_CONNECTED_TO_HW_STREAM: TGUID = '{34e6e728-06d6-4491-a553-4795650db912}';
    MFT_PREFERRED_OUTPUTTYPE_Attribute: TGUID = '{7e700499-396a-49ee-b1b4-f628021e8c9d}';
    MFT_PROCESS_LOCAL_Attribute: TGUID = '{543186e4-4649-4e65-b588-4aa352aff379}';
    MFT_PREFERRED_ENCODER_PROFILE: TGUID = '{53004909-1ef5-46d7-a18e-5a75f8b5905f}';
    MFT_HW_TIMESTAMP_WITH_QPC_Attribute: TGUID = '{8d030fb8-cc43-4258-a22e-9210bef89be4}';
    MFT_FIELDOFUSE_UNLOCK_Attribute: TGUID = '{8ec2e9fd-9148-410d-831e-702439461a8e}';
    MFT_CODEC_MERIT_Attribute: TGUID = '{88a7cb15-7b07-4a34-9128-e64c6703c4d3}';
    MFT_ENUM_TRANSCODE_ONLY_ATTRIBUTE: TGUID = '{111ea8cd-b62a-4bdb-89f6-67ffcdc2458b}';

    MFPKEY_CLSID: TPROPERTYKEY = (fmtid: '{c57a84c0-1a80-40a3-97b5-9272a403c8ae}'; pid: $01);
    MFPKEY_CATEGORY: TPROPERTYKEY = (fmtid: '{c57a84c0-1a80-40a3-97b5-9272a403c8ae}'; pid: $02);
    MFPKEY_EXATTRIBUTE_SUPPORTED: TPROPERTYKEY = (fmtid: '{456fe843-3c87-40c0-949d-1409c97dab2c}'; pid: $01);
    MFPKEY_MULTICHANNEL_CHANNEL_MASK: TPROPERTYKEY = (fmtid: '{58bdaf8c-3224-4692-86d0-44d65c5bf82b}'; pid: $01);

const
    MFT_STREAMS_UNLIMITED = $FFFFFFFF;

    MFT_OUTPUT_BOUND_LOWER_UNBOUNDED = $8000000000000000;
    MFT_OUTPUT_BOUND_UPPER_UNBOUNDED = $7fffffffffffffff;

type

    TMFT_INPUT_DATA_BUFFER_FLAGS = (MFT_INPUT_DATA_BUFFER_PLACEHOLDER = $FFFFFFFF);

    TMFT_OUTPUT_DATA_BUFFER_FLAGS = (MFT_OUTPUT_DATA_BUFFER_INCOMPLETE = $1000000, MFT_OUTPUT_DATA_BUFFER_FORMAT_CHANGE = $100,
        MFT_OUTPUT_DATA_BUFFER_STREAM_END = $200, MFT_OUTPUT_DATA_BUFFER_NO_SAMPLE = $300);

    TMFT_INPUT_STATUS_FLAGS = (MFT_INPUT_STATUS_ACCEPT_DATA = $1);

    TMFT_OUTPUT_STATUS_FLAGS = (MFT_OUTPUT_STATUS_SAMPLE_READY = $1);

    TMFT_INPUT_STREAM_INFO_FLAGS = (MFT_INPUT_STREAM_WHOLE_SAMPLES = $1, MFT_INPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER = $2,
        MFT_INPUT_STREAM_FIXED_SAMPLE_SIZE = $4, MFT_INPUT_STREAM_HOLDS_BUFFERS = $8, MFT_INPUT_STREAM_DOES_NOT_ADDREF = $100,
        MFT_INPUT_STREAM_REMOVABLE = $200, MFT_INPUT_STREAM_OPTIONAL = $400, MFT_INPUT_STREAM_PROCESSES_IN_PLACE = $800);

    TMFT_OUTPUT_STREAM_INFO_FLAGS = (MFT_OUTPUT_STREAM_WHOLE_SAMPLES = $1, MFT_OUTPUT_STREAM_SINGLE_SAMPLE_PER_BUFFER = $2,
        MFT_OUTPUT_STREAM_FIXED_SAMPLE_SIZE = $4, MFT_OUTPUT_STREAM_DISCARDABLE = $8, MFT_OUTPUT_STREAM_OPTIONAL = $10,
        MFT_OUTPUT_STREAM_PROVIDES_SAMPLES = $100, MFT_OUTPUT_STREAM_CAN_PROVIDE_SAMPLES = $200, MFT_OUTPUT_STREAM_LAZY_READ = $400,
        MFT_OUTPUT_STREAM_REMOVABLE = $800);

    TMFT_SET_TYPE_FLAGS = (MFT_SET_TYPE_TEST_ONLY = $1);

    TMFT_PROCESS_OUTPUT_FLAGS = (MFT_PROCESS_OUTPUT_DISCARD_WHEN_NO_BUFFER = $1, MFT_PROCESS_OUTPUT_REGENERATE_LAST_OUTPUT = $2);

    TMFT_PROCESS_OUTPUT_STATUS = (MFT_PROCESS_OUTPUT_STATUS_NEW_STREAMS = $100);

    TMFT_DRAIN_TYPE = (MFT_DRAIN_PRODUCE_TAILS = 0, MFT_DRAIN_NO_TAILS = $1);

    TMFT_MESSAGE_TYPE = (MFT_MESSAGE_COMMAND_FLUSH = 0, MFT_MESSAGE_COMMAND_DRAIN = $1, MFT_MESSAGE_SET_D3D_MANAGER = $2, MFT_MESSAGE_DROP_SAMPLES = $3,
        MFT_MESSAGE_COMMAND_TICK = $4, MFT_MESSAGE_NOTIFY_BEGIN_STREAMING = $10000000, MFT_MESSAGE_NOTIFY_END_STREAMING = $10000001,
        MFT_MESSAGE_NOTIFY_END_OF_STREAM = $10000002, MFT_MESSAGE_NOTIFY_START_OF_STREAM = $10000003, MFT_MESSAGE_NOTIFY_RELEASE_RESOURCES = $10000004,
        MFT_MESSAGE_NOTIFY_REACQUIRE_RESOURCES = $10000005, MFT_MESSAGE_COMMAND_MARKER = $20000000);

    TMFT_INPUT_STREAM_INFO = record
        hnsMaxLatency: LONGLONG;
        dwFlags: DWORD;
        cbSize: DWORD;
        cbMaxLookahead: DWORD;
        cbAlignment: DWORD;
    end;

    TMFT_OUTPUT_STREAM_INFO = record
        dwFlags: DWORD;
        cbSize: DWORD;
        cbAlignment: DWORD;
    end;

    TMFT_OUTPUT_DATA_BUFFER = record
        dwStreamID: DWORD;
        pSample: IMFSample;
        dwStatus: DWORD;
        pEvents: IMFCollection;
    end;

    PMFT_OUTPUT_DATA_BUFFER = ^TMFT_OUTPUT_DATA_BUFFER;

    IMFTransform = interface(IUnknown)
        ['{bf94c121-5b05-4e6f-8000-ba598961414d}']
        function GetStreamLimits(out pdwInputMinimum: DWORD; out pdwInputMaximum: DWORD; out pdwOutputMinimum: DWORD; out pdwOutputMaximum: DWORD): HResult;
          stdcall;
        function GetStreamCount(out pcInputStreams: DWORD; out pcOutputStreams: DWORD): HResult; stdcall;
        function GetStreamIDs(dwInputIDArraySize: DWORD; out pdwInputIDs: PDWORD; dwOutputIDArraySize: DWORD; out pdwOutputIDs: PDWORD): HResult; stdcall;
        function GetInputStreamInfo(dwInputStreamID: DWORD; out pStreamInfo: TMFT_INPUT_STREAM_INFO): HResult; stdcall;
        function GetOutputStreamInfo(dwOutputStreamID: DWORD; out pStreamInfo: TMFT_OUTPUT_STREAM_INFO): HResult; stdcall;
        function GetAttributes(out pAttributes: IMFAttributes): HResult; stdcall;
        function GetInputStreamAttributes(dwInputStreamID: DWORD; out pAttributes: IMFAttributes): HResult; stdcall;
        function GetOutputStreamAttributes(dwOutputStreamID: DWORD; out pAttributes: IMFAttributes): HResult; stdcall;
        function DeleteInputStream(dwStreamID: DWORD): HResult; stdcall;
        function AddInputStreams(cStreams: DWORD; adwStreamIDs: PDWORD): HResult; stdcall;
        function GetInputAvailableType(dwInputStreamID: DWORD; dwTypeIndex: DWORD; out ppType: IMFMediaType): HResult; stdcall;
        function GetOutputAvailableType(dwOutputStreamID: DWORD; dwTypeIndex: DWORD; out ppType: IMFMediaType): HResult; stdcall;
        function SetInputType(dwInputStreamID: DWORD; pType: IMFMediaType; dwFlags: DWORD): HResult; stdcall;
        function SetOutputType(dwOutputStreamID: DWORD; pType: IMFMediaType; dwFlags: DWORD): HResult; stdcall;
        function GetInputCurrentType(dwInputStreamID: DWORD; out ppType: IMFMediaType): HResult; stdcall;
        function GetOutputCurrentType(dwOutputStreamID: DWORD; out ppType: IMFMediaType): HResult; stdcall;
        function GetInputStatus(dwInputStreamID: DWORD; out pdwFlags: DWORD): HResult; stdcall;
        function GetOutputStatus(out pdwFlags: DWORD): HResult; stdcall;
        function SetOutputBounds(hnsLowerBound: LONGLONG; hnsUpperBound: LONGLONG): HResult; stdcall;
        function ProcessEvent(dwInputStreamID: DWORD; pEvent: IMFMediaEvent): HResult; stdcall;
        function ProcessMessage(eMessage: TMFT_MESSAGE_TYPE; ulParam: ULONG_PTR): HResult; stdcall;
        function ProcessInput(dwInputStreamID: DWORD; pSample: IMFSample; dwFlags: DWORD): HResult; stdcall;
        function ProcessOutput(dwFlags: DWORD; cOutputBufferCount: DWORD; var pOutputSamples: PMFT_OUTPUT_DATA_BUFFER; out pdwStatus: DWORD): HResult; stdcall;
    end;

    TSTREAM_MEDIUM = record
        gidMedium: TGUID;
        unMediumInstance: UINT32;
    end;

    PSTREAM_MEDIUM = ^TSTREAM_MEDIUM;

    TMF3DVideoOutputType = (MF3DVideoOutputType_BaseView = 0, MF3DVideoOutputType_Stereo = 1);

function MFCreateTransformActivate(out ppActivate: IMFActivate): HResult; stdcall; external MFPlat_DLL;

implementation

end.
