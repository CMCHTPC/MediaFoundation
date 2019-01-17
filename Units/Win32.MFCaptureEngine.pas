unit Win32.MFCaptureEngine;

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, ActiveX,
    Win32.MFObjects, Win32.MFIdl;

const
    IID_IMFCaptureEngineOnEventCallback: TGUID = '{aeda51c0-9025-4983-9012-de597b88b089}';
    IID_IMFCaptureEngineOnSampleCallback: TGUID = '{52150b82-ab39-4467-980f-e48bf0822ecd}';
    IID_IMFCaptureSink: TGUID = '{72d6135b-35e9-412c-b926-fd5265f2a885}';
    IID_IMFCaptureRecordSink: TGUID = '{3323b55a-f92a-4fe2-8edc-e9bfc0634d77}';
    IID_IMFCapturePreviewSink: TGUID = '{77346cfd-5b49-4d73-ace0-5b52a859f2e0}';
    IID_IMFCapturePhotoSink: TGUID = '{d2d43cc8-48bb-4aa7-95db-10c06977e777}';
    IID_IMFCaptureSource: TGUID = '{439a42a8-0d2c-4505-be83-f79b2a05d5c4}';
    IID_IMFCaptureEngine: TGUID = '{a6bba433-176b-48b2-b375-53aa03473207}';
    IID_IMFCaptureEngineClassFactory: TGUID = '{8f02d140-56fc-4302-a705-3a97c78be779}';
    IID_IMFCaptureEngineOnSampleCallback2: TGUID = '{e37ceed7-340f-4514-9f4d-9c2ae026100b}';
    IID_IMFCaptureSink2: TGUID = '{f9e4219e-6197-4b5e-b888-bee310ab2c59}';
    IID_IMFCapturePhotoConfirmation: TGUID = '{19f68549-ca8a-4706-a4ef-481dbc95e12c}';

const
    MF_CAPTURE_ENGINE_INITIALIZED: TGUID = '{219992bc-cf92-4531-a1ae-96e1e886c8f1}';
    MF_CAPTURE_ENGINE_PREVIEW_STARTED: TGUID = '{a416df21-f9d3-4a74-991b-b817298952c4}';
    MF_CAPTURE_ENGINE_PREVIEW_STOPPED: TGUID = '{13d5143c-1edd-4e50-a2ef-350a47678060}';
    MF_CAPTURE_ENGINE_RECORD_STARTED: TGUID = '{ac2b027b-ddf9-48a0-89be-38ab35ef45c0}';
    MF_CAPTURE_ENGINE_RECORD_STOPPED: TGUID = '{55e5200a-f98f-4c0d-a9ec-9eb25ed3d773}';
    MF_CAPTURE_ENGINE_PHOTO_TAKEN: TGUID = '{3c50c445-7304-48eb-865d-bba19ba3af5c}';
    MF_CAPTURE_SOURCE_CURRENT_DEVICE_MEDIA_TYPE_SET: TGUID = '{e7e75e4c-039c-4410-815b-8741307b63aa}';
    MF_CAPTURE_ENGINE_ERROR: TGUID = '{46b89fc6-33cc-4399-9dad-784de77d587c}';
    MF_CAPTURE_ENGINE_EFFECT_ADDED: TGUID = '{aa8dc7b5-a048-4e13-8ebe-f23c46c830c1}';
    MF_CAPTURE_ENGINE_EFFECT_REMOVED: TGUID = '{c6e8db07-fb09-4a48-89c6-bf92a04222c9}';
    MF_CAPTURE_ENGINE_ALL_EFFECTS_REMOVED: TGUID = '{fded7521-8ed8-431a-a96b-f3e2565e981c}';
    MF_CAPTURE_SINK_PREPARED: TGUID = '{7BFCE257-12B1-4409-8C34-D445DAAB7578}';
    MF_CAPTURE_ENGINE_OUTPUT_MEDIA_TYPE_SET: TGUID = '{caaad994-83ec-45e9-a30a-1f20aadb9831}';
    MF_CAPTURE_ENGINE_CAMERA_STREAM_BLOCKED: TGUID = '{A4209417-8D39-46F3-B759-5912528F4207}';
    MF_CAPTURE_ENGINE_CAMERA_STREAM_UNBLOCKED: TGUID = '{9BE9EEF0-CDAF-4717-8564-834AAE66415C}';
    MF_CAPTURE_ENGINE_D3D_MANAGER: TGUID = '{76e25e7b-d595-4283-962c-c594afd78ddf}';
    MF_CAPTURE_ENGINE_MEDIA_CATEGORY: TGUID = '{8e3f5bd5-dbbf-42f0-8542-d07a3971762a}';
    MF_CAPTURE_ENGINE_AUDIO_PROCESSING: TGUID = '{10f1be5e-7e11-410b-973d-f4b6109000fe}';


    MF_CAPTURE_ENGINE_RECORD_SINK_VIDEO_MAX_UNPROCESSED_SAMPLES: TGUID = '{b467f705-7913-4894-9d42-a215fea23da9}';
    MF_CAPTURE_ENGINE_RECORD_SINK_AUDIO_MAX_UNPROCESSED_SAMPLES: TGUID = '{1cddb141-a7f4-4d58-9896-4d15a53c4efe}';
    MF_CAPTURE_ENGINE_RECORD_SINK_VIDEO_MAX_PROCESSED_SAMPLES: TGUID = '{e7b4a49e-382c-4aef-a946-aed5490b7111}';
    MF_CAPTURE_ENGINE_RECORD_SINK_AUDIO_MAX_PROCESSED_SAMPLES: TGUID = '{9896e12a-f707-4500-b6bd-db8eb810b50f}';
    MF_CAPTURE_ENGINE_USE_AUDIO_DEVICE_ONLY: TGUID = '{1c8077da-8466-4dc4-8b8e-276b3f85923b}';
    MF_CAPTURE_ENGINE_USE_VIDEO_DEVICE_ONLY: TGUID = '{7e025171-cf32-4f2e-8f19-410577b73a66}';
    MF_CAPTURE_ENGINE_DISABLE_HARDWARE_TRANSFORMS: TGUID = '{b7c42a6b-3207-4495-b4e7-81f9c35d5991}';
    MF_CAPTURE_ENGINE_DISABLE_DXVA: TGUID = '{f9818862-179d-433f-a32f-74cbcf74466d}';
    MF_CAPTURE_ENGINE_MEDIASOURCE_CONFIG: TGUID = '{bc6989d2-0fc1-46e1-a74f-efd36bc788de}';
    MF_CAPTURE_ENGINE_DECODER_MFT_FIELDOFUSE_UNLOCK_Attribute: TGUID = '{2b8ad2e8-7acb-4321-a606-325c4249f4fc}';
    MF_CAPTURE_ENGINE_ENCODER_MFT_FIELDOFUSE_UNLOCK_Attribute: TGUID = '{54c63a00-78d5-422f-aa3e-5e99ac649269}';
    MF_CAPTURE_ENGINE_ENABLE_CAMERA_STREAMSTATE_NOTIFICATION: TGUID = '{4C808E9D-AAED-4713-90FB-CB24064AB8DA}';
    MF_CAPTURE_ENGINE_EVENT_GENERATOR_GUID: TGUID = '{abfa8ad5-fc6d-4911-87e0-961945f8f7ce}';
    MF_CAPTURE_ENGINE_EVENT_STREAM_INDEX: TGUID = '{82697f44-b1cf-42eb-9753-f86d649c8865}';
    MF_CAPTURE_ENGINE_SELECTEDCAMERAPROFILE: TGUID = '{03160B7E-1C6F-4DB2-AD56-A7C430F82392}';
    MF_CAPTURE_ENGINE_SELECTEDCAMERAPROFILE_INDEX: TGUID = '{3CE88613-2214-46C3-B417-82F8A313C9C3}';
    CLSID_MFCaptureEngine: TGUID = '{efce38d3-8914-4674-a7df-ae1b3d654b8a}';
    CLSID_MFCaptureEngineClassFactory: TGUID = '{efce38d3-8914-4674-a7df-ae1b3d654b8a}';
    MFSampleExtension_DeviceReferenceSystemTime: TGUID = '{6523775a-ba2d-405f-b2c5-01ff88e2e8f6}';


const
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_PREVIEW = $fffffffa;
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_VIDEO_RECORD = $fffffff9;
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_PHOTO = $fffffff8;
    MF_CAPTURE_ENGINE_PREFERRED_SOURCE_STREAM_FOR_AUDIO = $fffffff7;
    MF_CAPTURE_ENGINE_MEDIASOURCE = $ffffffff;


type

    TMFVideoNormalizedRect = record
        left: single;
        top: single;
        right: single;
        bottom: single;
    end;


    TMF_CAPTURE_ENGINE_DEVICE_TYPE = (
        MF_CAPTURE_ENGINE_DEVICE_TYPE_AUDIO = 0,
        MF_CAPTURE_ENGINE_DEVICE_TYPE_VIDEO = $1
        );

    TMF_CAPTURE_ENGINE_SINK_TYPE = (
        MF_CAPTURE_ENGINE_SINK_TYPE_RECORD = 0,
        MF_CAPTURE_ENGINE_SINK_TYPE_PREVIEW = $1,
        MF_CAPTURE_ENGINE_SINK_TYPE_PHOTO = $2
        );


    TMF_CAPTURE_ENGINE_STREAM_CATEGORY = (
        MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_PREVIEW = 0,
        MF_CAPTURE_ENGINE_STREAM_CATEGORY_VIDEO_CAPTURE = $1,
        MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_INDEPENDENT = $2,
        MF_CAPTURE_ENGINE_STREAM_CATEGORY_PHOTO_DEPENDENT = $3,
        MF_CAPTURE_ENGINE_STREAM_CATEGORY_AUDIO = $4,
        MF_CAPTURE_ENGINE_STREAM_CATEGORY_UNSUPPORTED = $5
        );

    TMF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE = (
        MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_OTHER = 0,
        MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_COMMUNICATIONS = 1,
        MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_MEDIA = 2,
        MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_GAMECHAT = 3,
        MF_CAPTURE_ENGINE_MEDIA_CATEGORY_TYPE_SPEECH = 4
        );

    TMF_CAPTURE_ENGINE_AUDIO_PROCESSING_MODE = (
        MF_CAPTURE_ENGINE_AUDIO_PROCESSING_DEFAULT = 0,
        MF_CAPTURE_ENGINE_AUDIO_PROCESSING_RAW = 1
        );


    IMFCaptureEngineOnEventCallback = interface(IUnknown)
        ['{aeda51c0-9025-4983-9012-de597b88b089}']
        function OnEvent(pEvent: IMFMediaEvent): HResult; stdcall;
    end;


    IMFCaptureEngineOnSampleCallback = interface(IUnknown)
        ['{52150b82-ab39-4467-980f-e48bf0822ecd}']
        function OnSample(pSample: IMFSample): HResult; stdcall;
    end;


    IMFCaptureSink = interface(IUnknown)
        ['{72d6135b-35e9-412c-b926-fd5265f2a885}']
        function GetOutputMediaType(dwSinkStreamIndex: DWORD; out ppMediaType: IMFMediaType): HResult; stdcall;
        function GetService(dwSinkStreamIndex: DWORD; const rguidService: TGUID; const riid: TGUID;
            out ppUnknown: IUnknown): HResult; stdcall;
        function AddStream(dwSourceStreamIndex: DWORD; pMediaType: IMFMediaType; pAttributes: IMFAttributes;
            out pdwSinkStreamIndex: DWORD): HResult; stdcall;
        function Prepare(): HResult; stdcall;
        function RemoveAllStreams(): HResult; stdcall;
    end;

    IMFCaptureRecordSink = interface(IMFCaptureSink)
        ['{3323b55a-f92a-4fe2-8edc-e9bfc0634d77}']
        function SetOutputByteStream(pByteStream: IMFByteStream; const guidContainerType: TGUID): HResult; stdcall;
        function SetOutputFileName(fileName: LPCWSTR): HResult; stdcall;
        function SetSampleCallback(dwStreamSinkIndex: DWORD; pCallback: IMFCaptureEngineOnSampleCallback): HResult;
            stdcall;
        function SetCustomSink(pMediaSink: IMFMediaSink): HResult; stdcall;
        function GetRotation(dwStreamIndex: DWORD; Out pdwRotationValue: DWORD): HResult; stdcall;
        function SetRotation(dwStreamIndex: DWORD; dwRotationValue: DWORD): HResult; stdcall;
    end;


    IMFCapturePreviewSink = interface(IMFCaptureSink)
        ['{77346cfd-5b49-4d73-ace0-5b52a859f2e0}']
        function SetRenderHandle(handle: THANDLE): HResult; stdcall;
        function SetRenderSurface(pSurface: IUnknown): HResult; stdcall;
        function UpdateVideo(const pSrc: TMFVideoNormalizedRect; const pDst: TRECT; const pBorderClr: COLORREF): HResult; stdcall;
        function SetSampleCallback(dwStreamSinkIndex: DWORD; pCallback: IMFCaptureEngineOnSampleCallback): HResult;
            stdcall;
        function GetMirrorState(out pfMirrorState: boolean): HResult; stdcall;
        function SetMirrorState(fMirrorState: boolean): HResult; stdcall;
        function GetRotation(dwStreamIndex: DWORD; out pdwRotationValue: DWORD): HResult; stdcall;
        function SetRotation(dwStreamIndex: DWORD; dwRotationValue: DWORD): HResult; stdcall;
        function SetCustomSink(pMediaSink: IMFMediaSink): HResult; stdcall;
    end;


    IMFCapturePhotoSink = interface(IMFCaptureSink)
        ['{d2d43cc8-48bb-4aa7-95db-10c06977e777}']
        function SetOutputFileName(fileName: LPCWSTR): HResult; stdcall;
        function SetSampleCallback(pCallback: IMFCaptureEngineOnSampleCallback): HResult; stdcall;
        function SetOutputByteStream(pByteStream: IMFByteStream): HResult; stdcall;
    end;


    IMFCaptureSource = interface(IUnknown)
        ['{439a42a8-0d2c-4505-be83-f79b2a05d5c4}']
        function GetCaptureDeviceSource(mfCaptureEngineDeviceType: TMF_CAPTURE_ENGINE_DEVICE_TYPE;
            out ppMediaSource: IMFMediaSource): HResult; stdcall;
        function GetCaptureDeviceActivate(mfCaptureEngineDeviceType: TMF_CAPTURE_ENGINE_DEVICE_TYPE;
            out ppActivate: IMFActivate): HResult; stdcall;
        function GetService(const rguidService: TGUID; const riid: TGUID; out ppUnknown: IUnknown): HResult; stdcall;
        function AddEffect(dwSourceStreamIndex: DWORD; pUnknown: IUnknown): HResult; stdcall;
        function RemoveEffect(dwSourceStreamIndex: DWORD; pUnknown: IUnknown): HResult; stdcall;
        function RemoveAllEffects(dwSourceStreamIndex: DWORD): HResult; stdcall;
        function GetAvailableDeviceMediaType(dwSourceStreamIndex: DWORD; dwMediaTypeIndex: DWORD;
            out ppMediaType: IMFMediaType): HResult; stdcall;
        function SetCurrentDeviceMediaType(dwSourceStreamIndex: DWORD; pMediaType: IMFMediaType): HResult; stdcall;
        function GetCurrentDeviceMediaType(dwSourceStreamIndex: DWORD; out ppMediaType: IMFMediaType): HResult; stdcall;
        function GetDeviceStreamCount(out pdwStreamCount: DWORD): HResult; stdcall;
        function GetDeviceStreamCategory(dwSourceStreamIndex: DWORD; out pStreamCategory: TMF_CAPTURE_ENGINE_STREAM_CATEGORY): HResult;
            stdcall;
        function GetMirrorState(dwStreamIndex: DWORD; out pfMirrorState: boolean): HResult; stdcall;
        function SetMirrorState(dwStreamIndex: DWORD; fMirrorState: boolean): HResult; stdcall;
        function GetStreamIndexFromFriendlyName(uifriendlyName: UINT32; out pdwActualStreamIndex: DWORD): HResult; stdcall;
    end;

    IMFCaptureEngine = interface(IUnknown)
        ['{a6bba433-176b-48b2-b375-53aa03473207}']
        function Initialize(pEventCallback: IMFCaptureEngineOnEventCallback; pAttributes: IMFAttributes;
            pAudioSource: IUnknown; pVideoSource: IUnknown): HResult; stdcall;
        function StartPreview(): HResult; stdcall;
        function StopPreview(): HResult; stdcall;
        function StartRecord(): HResult; stdcall;
        function StopRecord(bFinalize: boolean; bFlushUnprocessedSamples: boolean): HResult; stdcall;
        function TakePhoto(): HResult; stdcall;
        function GetSink(mfCaptureEngineSinkType: TMF_CAPTURE_ENGINE_SINK_TYPE; out ppSink: IMFCaptureSink): HResult; stdcall;
        function GetSource(out ppSource: IMFCaptureSource): HResult; stdcall;
    end;

    IMFCaptureEngineClassFactory = interface(IUnknown)
        ['{8f02d140-56fc-4302-a705-3a97c78be779}']
        function CreateInstance(const clsid: CLSID; const riid: TGUID; out ppvObject): HResult; stdcall;
    end;

    IMFCaptureEngineOnSampleCallback2 = interface(IMFCaptureEngineOnSampleCallback)
        ['{e37ceed7-340f-4514-9f4d-9c2ae026100b}']
        function OnSynchronizedEvent(pEvent: IMFMediaEvent): HResult; stdcall;
    end;


    IMFCaptureSink2 = interface(IMFCaptureSink)
        ['{f9e4219e-6197-4b5e-b888-bee310ab2c59}']
        function SetOutputMediaType(dwStreamIndex: DWORD; pMediaType: IMFMediaType; pEncodingAttributes: IMFAttributes): HResult; stdcall;
    end;


    // also defined in Win32.MFIdl
    IMFCapturePhotoConfirmation = interface(IUnknown)
        ['{19f68549-ca8a-4706-a4ef-481dbc95e12c}']
        function SetPhotoConfirmationCallback(pNotificationCallback: IMFAsyncCallback): HResult; stdcall;
        function SetPixelFormat(subtype: TGUID): HResult; stdcall;
        function GetPixelFormat(out subtype: TGUID): HResult; stdcall;
    end;

implementation

end.






























































































































































































