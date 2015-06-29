unit CMC.MFReadWrite;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, ActiveX,
    CMC.MFObjects, CMC.MFTransform,CMC.MFIdl;

const
    MFReadWrite_DLL = 'Mfreadwrite.dll';

const
    IID_IMFReadWriteClassFactory: TGUID = '{E7FE2E12-661C-40DA-92F9-4F002AB67627}';
    IID_IMFSourceReader: TGUID = '{70ae66f2-c809-4e4f-8915-bdcb406b7993}';
    IID_IMFSourceReaderEx: TGUID = '{7b981cf0-560e-4116-9875-b099895f23d7}';
    IID_IMFSourceReaderCallback: TGUID = '{deec8d99-fa1d-4d82-84c2-2c8969944867}';
    IID_IMFSourceReaderCallback2: TGUID = '{CF839FE6-8C2A-4DD2-B6EA-C22D6961AF05}';
    IID_IMFSinkWriter: TGUID = '{3137f1cd-fe5e-4805-a5d8-fb477448cb3d}';
    IID_IMFSinkWriterEx: TGUID = '{588d72ab-5Bc1-496a-8714-b70617141b25}';
    IID_IMFSinkWriterEncoderConfig: TGUID = '{17C3779E-3CDE-4EDE-8C60-3899F5F53AD6}';
    IID_IMFSinkWriterCallback: TGUID = '{666f76de-33d2-41b9-a458-29ed0a972c58}';
    IID_IMFSinkWriterCallback2: TGUID = '{2456BD58-C067-4513-84FE-8D0C88FFDC61}';

const
    CLSID_MFReadWriteClassFactory: TGUID = '{48e2ed0f-98c2-4a37-bed5-166312ddd83f}';
    CLSID_MFSourceReader: TGUID = '{1777133c-0881-411b-a577-ad545f0714c4}';
    MF_SOURCE_READER_ASYNC_CALLBACK: TGUID = '{1e3dbeac-bb43-4c35-b507-cd644464c965}';
    MF_SOURCE_READER_D3D_MANAGER: TGUID = '{ec822da2-e1e9-4b29-a0d8-563c719f5269}';
    MF_SOURCE_READER_DISABLE_DXVA: TGUID = '{aa456cfd-3943-4a1e-a77d-1838c0ea2e35}';
    MF_SOURCE_READER_MEDIASOURCE_CONFIG: TGUID = '{9085abeb-0354-48f9-abb5-200df838c68e}';
    MF_SOURCE_READER_MEDIASOURCE_CHARACTERISTICS: TGUID = '{6d23f5c8-c5d7-4a9b-9971-5d11f8bca880}';
    MF_SOURCE_READER_ENABLE_VIDEO_PROCESSING: TGUID = '{fb394f3d-ccf1-42ee-bbb3-f9b845d5681d}';
    MF_SOURCE_READER_ENABLE_ADVANCED_VIDEO_PROCESSING: TGUID = '{0f81da2c-b537-4672-a8b2-a681b17307a3}';
    MF_SOURCE_READER_DISABLE_CAMERA_PLUGINS: TGUID = '{9d3365dd-058f-4cfb-9f97-b314cc99c8ad}';
    MF_SOURCE_READER_DISCONNECT_MEDIASOURCE_ON_SHUTDOWN: TGUID = '{56b67165-219e-456d-a22e-2d3004c7fe56}';
    MF_SOURCE_READER_ENABLE_TRANSCODE_ONLY_TRANSFORMS: TGUID = '{dfd4f008-b5fd-4e78-ae44-62a1e67bbe27}';
    MF_SOURCE_READER_D3D11_BIND_FLAGS: TGUID = '{33f3197b-f73a-4e14-8d85-0e4c4368788d}';
    CLSID_MFSinkWriter: TGUID = '{a3bbfb17-8273-4e52-9e0e-9739dc887990}';
    MF_SINK_WRITER_ASYNC_CALLBACK: TGUID = '{48cb183e-7b0b-46f4-822e-5e1d2dda4354}';
    MF_SINK_WRITER_DISABLE_THROTTLING: TGUID = '{08b845d8-2b74-4afe-9d53-be16d2d5ae4f}';
    MF_SINK_WRITER_D3D_MANAGER: TGUID = '{ec822da2-e1e9-4b29-a0d8-563c719f5269}';
    MF_SINK_WRITER_ENCODER_CONFIG: TGUID = '{ad91cd04-a7cc-4ac7-99b6-a57b9a4a7c70}';
    MF_READWRITE_DISABLE_CONVERTERS: TGUID = '{98d5b065-1374-4847-8d5d-31520fee7156}';
    MF_READWRITE_ENABLE_HARDWARE_TRANSFORMS: TGUID = '{a634a91c-822b-41b9-a494-4de4643612b0}';
    MF_READWRITE_MMCSS_CLASS: TGUID = '{39384300-d0eb-40b1-87a0-3318871b5a53}';
    MF_READWRITE_MMCSS_PRIORITY: TGUID = '{43ad19ce-f33f-4ba9-a580-e4cd12f2d144}';
    MF_READWRITE_MMCSS_CLASS_AUDIO: TGUID = '{430847da-0890-4b0e-938c-054332c547e1}';
    MF_READWRITE_MMCSS_PRIORITY_AUDIO: TGUID = '{273db885-2de2-4db2-a6a7-fdb66fb40b61}';
    MF_READWRITE_D3D_OPTIONAL: TGUID = '{216479d9-3071-42ca-bb6c-4c22102e1d18}';
    MF_MEDIASINK_AUTOFINALIZE_SUPPORTED: TGUID = '{48c131be-135a-41cb-8290-03652509c999}';
    MF_MEDIASINK_ENABLE_AUTOFINALIZE: TGUID = '{34014265-cb7e-4cde-ac7c-effd3b3c2530}';
    MF_READWRITE_ENABLE_AUTOFINALIZE: TGUID = '{dd7ca129-8cd1-4dc5-9dde-ce168675de61}';


const
    MF_SOURCE_READER_INVALID_STREAM_INDEX = $ffffffff;
    MF_SOURCE_READER_ALL_STREAMS = $fffffffe;
    MF_SOURCE_READER_ANY_STREAM = $fffffffe;
    MF_SOURCE_READER_FIRST_AUDIO_STREAM = $fffffffd;
    MF_SOURCE_READER_FIRST_VIDEO_STREAM = $fffffffc;
    MF_SOURCE_READER_MEDIASOURCE = $ffffffff;
    MF_SOURCE_READER_CURRENT_TYPE_INDEX = $ffffffff;

    MF_SINK_WRITER_INVALID_STREAM_INDEX = $ffffffff;
    MF_SINK_WRITER_ALL_STREAMS = $fffffffe;
    MF_SINK_WRITER_MEDIASINK = $ffffffff;

type

    TMF_SOURCE_READER_FLAG = (
        MF_SOURCE_READERF_ERROR = $1,
        MF_SOURCE_READERF_ENDOFSTREAM = $2,
        MF_SOURCE_READERF_NEWSTREAM = $4,
        MF_SOURCE_READERF_NATIVEMEDIATYPECHANGED = $10,
        MF_SOURCE_READERF_CURRENTMEDIATYPECHANGED = $20,
        MF_SOURCE_READERF_STREAMTICK = $100,
        MF_SOURCE_READERF_ALLEFFECTSREMOVED = $200
        );


    TMF_SOURCE_READER_CONTROL_FLAG = (
        MF_SOURCE_READER_CONTROLF_DRAIN = $1
        );


    TMF_SINK_WRITER_STATISTICS = record
        cb: DWORD;
        llLastTimestampReceived: LONGLONG;
        llLastTimestampEncoded: LONGLONG;
        llLastTimestampProcessed: LONGLONG;
        llLastStreamTickReceived: LONGLONG;
        llLastSinkSampleRequest: LONGLONG;
        qwNumSamplesReceived: QWORD;
        qwNumSamplesEncoded: QWORD;
        qwNumSamplesProcessed: QWORD;
        qwNumStreamTicksReceived: QWORD;
        dwByteCountQueued: DWORD;
        qwByteCountProcessed: QWORD;
        dwNumOutstandingSinkSampleRequests: DWORD;
        dwAverageSampleRateReceived: DWORD;
        dwAverageSampleRateEncoded: DWORD;
        dwAverageSampleRateProcessed: DWORD;
    end;

    PMF_SINK_WRITER_STATISTICS = ^TMF_SINK_WRITER_STATISTICS;


    IMFReadWriteClassFactory = interface(IUnknown)
        ['{E7FE2E12-661C-40DA-92F9-4F002AB67627}']
        function CreateInstanceFromURL(const clsid: CLSID; pwszURL: LPCWSTR; pAttributes: IMFAttributes;
            const riid: TGUID; out ppvObject: pointer): HResult; stdcall;
        function CreateInstanceFromObject(const clsid: CLSID; punkObject: IUnknown; pAttributes: IMFAttributes;
            const riid: TGUID; out ppvObject: pointer): HResult; stdcall;
    end;


    IMFSourceReader = interface(IUnknown)
        ['{70ae66f2-c809-4e4f-8915-bdcb406b7993}']
        function GetStreamSelection(dwStreamIndex: DWORD; out pfSelected: boolean): HResult; stdcall;
        function SetStreamSelection(dwStreamIndex: DWORD; fSelected: boolean): HResult; stdcall;
        function GetNativeMediaType(dwStreamIndex: DWORD; dwMediaTypeIndex: DWORD; out ppMediaType: IMFMediaType): HResult; stdcall;
        function GetCurrentMediaType(dwStreamIndex: DWORD; out ppMediaType: IMFMediaType): HResult; stdcall;
        function SetCurrentMediaType(dwStreamIndex: DWORD; var pdwReserved: DWORD; pMediaType: IMFMediaType): HResult; stdcall;
        function SetCurrentPosition(const guidTimeFormat: TGUID; const varPosition: PROPVARIANT): HResult; stdcall;
        function ReadSample(dwStreamIndex: DWORD; dwControlFlags: DWORD; out pdwActualStreamIndex: DWORD;
            out pdwStreamFlags: DWORD; out pllTimestamp: LONGLONG; out ppSample: IMFSample): HResult; stdcall;
        function Flush(dwStreamIndex: DWORD): HResult; stdcall;
        function GetServiceForStream(dwStreamIndex: DWORD; const guidService: TGUID; const riid: TGUID; out ppvObject): HResult; stdcall;
        function GetPresentationAttribute(dwStreamIndex: DWORD; const guidAttribute: TGUID;
            out pvarAttribute: PROPVARIANT): HResult; stdcall;
    end;


    IMFSourceReaderEx = interface(IMFSourceReader)
        ['{7b981cf0-560e-4116-9875-b099895f23d7}']
        function SetNativeMediaType(dwStreamIndex: DWORD; pMediaType: IMFMediaType; out pdwStreamFlags: DWORD): HResult; stdcall;
        function AddTransformForStream(dwStreamIndex: DWORD; pTransformOrActivate: IUnknown): HResult; stdcall;
        function RemoveAllTransformsForStream(dwStreamIndex: DWORD): HResult; stdcall;
        function GetTransformForStream(dwStreamIndex: DWORD; dwTransformIndex: DWORD; out pGuidCategory: TGUID;
            out ppTransform: IMFTransform): HResult; stdcall;
    end;


    IMFSourceReaderCallback = interface(IUnknown)
        ['{deec8d99-fa1d-4d82-84c2-2c8969944867}']
        function OnReadSample(hrStatus: HRESULT; dwStreamIndex: DWORD; dwStreamFlags: DWORD; llTimestamp: LONGLONG;
            pSample: IMFSample): HResult; stdcall;
        function OnFlush(dwStreamIndex: DWORD): HResult; stdcall;
        function OnEvent(dwStreamIndex: DWORD; pEvent: IMFMediaEvent): HResult; stdcall;
    end;


    IMFSourceReaderCallback2 = interface(IMFSourceReaderCallback)
        ['{CF839FE6-8C2A-4DD2-B6EA-C22D6961AF05}']
        function OnTransformChange(): HResult; stdcall;
        function OnStreamError(dwStreamIndex: DWORD; hrStatus: HRESULT): HResult; stdcall;
    end;


    IMFSinkWriter = interface(IUnknown)
        ['{3137f1cd-fe5e-4805-a5d8-fb477448cb3d}']
        function AddStream(pTargetMediaType: IMFMediaType; out pdwStreamIndex: DWORD): HResult; stdcall;
        function SetInputMediaType(dwStreamIndex: DWORD; pInputMediaType: IMFMediaType;
            pEncodingParameters: IMFAttributes): HResult; stdcall;
        function BeginWriting(): HResult; stdcall;
        function WriteSample(dwStreamIndex: DWORD; pSample: IMFSample): HResult; stdcall;
        function SendStreamTick(dwStreamIndex: DWORD; llTimestamp: LONGLONG): HResult; stdcall;
        function PlaceMarker(dwStreamIndex: DWORD; pvContext: pointer): HResult; stdcall;
        function NotifyEndOfSegment(dwStreamIndex: DWORD): HResult; stdcall;
        function Flush(dwStreamIndex: DWORD): HResult; stdcall;
        function Finalize(): HResult; stdcall;
        function GetServiceForStream(dwStreamIndex: DWORD; const guidService: TGUID; const riid: TGUID;
            out ppvObject: pointer): HResult; stdcall;
        function GetStatistics(dwStreamIndex: DWORD; out pStats: TMF_SINK_WRITER_STATISTICS): HResult; stdcall;
    end;


    IMFSinkWriterEx = interface(IMFSinkWriter)
        ['{588d72ab-5Bc1-496a-8714-b70617141b25}']
        function GetTransformForStream(dwStreamIndex: DWORD; dwTransformIndex: DWORD; out pGuidCategory: TGUID;
            out ppTransform: IMFTransform): HResult; stdcall;
    end;


    IMFSinkWriterEncoderConfig = interface(IUnknown)
        ['{17C3779E-3CDE-4EDE-8C60-3899F5F53AD6}']
        function SetTargetMediaType(dwStreamIndex: DWORD; pTargetMediaType: IMFMediaType;
            pEncodingParameters: IMFAttributes): HResult; stdcall;
        function PlaceEncodingParameters(dwStreamIndex: DWORD; pEncodingParameters: IMFAttributes): HResult; stdcall;
    end;


    IMFSinkWriterCallback = interface(IUnknown)
        ['{666f76de-33d2-41b9-a458-29ed0a972c58}']
        function OnFinalize(hrStatus: HRESULT): HResult; stdcall;
        function OnMarker(dwStreamIndex: DWORD; pvContext: pointer): HResult; stdcall;
    end;


    IMFSinkWriterCallback2 = interface(IMFSinkWriterCallback)
        ['{2456BD58-C067-4513-84FE-8D0C88FFDC61}']
        function OnTransformChange(): HResult; stdcall;
        function OnStreamError(dwStreamIndex: DWORD; hrStatus: HRESULT): HResult; stdcall;
    end;


function MFCreateSourceReaderFromURL(pwszURL: LPCWSTR; pAttributes: IMFAttributes; out ppSourceReader: IMFSourceReader): HResult;
    stdcall; external MFReadWrite_DLL;

function MFCreateSourceReaderFromByteStream(pByteStream: IMFByteStream; pAttributes: IMFAttributes; out ppSourceReader: IMFSourceReader): HResult;
    stdcall; external MFReadWrite_DLL;

function MFCreateSourceReaderFromMediaSource(pMediaSource: IMFMediaSource; pAttributes: IMFAttributes;
    out ppSourceReader: IMFSourceReader): HResult;
    stdcall; external MFReadWrite_DLL;

function MFCreateSinkWriterFromURL(pwszOutputURL: LPCWSTR; pByteStream: IMFByteStream; pAttributes: IMFAttributes;
    out ppSinkWriter: IMFSinkWriter): HResult;
    stdcall; external MFReadWrite_DLL;

function MFCreateSinkWriterFromMediaSink(pMediaSink: IMFMediaSink; pAttributes: IMFAttributes; out ppSinkWriter: IMFSinkWriter): HResult;
    stdcall; external MFReadWrite_DLL;


implementation

end.


















