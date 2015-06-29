unit CMC.MFObjects;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

{$Z4}
{$A4}

uses
    Windows, Classes, SysUtils, CMC.MediaObj, CMC.WTypes, ActiveX;

const
    MFPlat_DLL = 'MFPlat.dll';

const
    IID_IMFAttributes: TGUID = '{2cd2d921-c447-44a7-a13c-4adabfc247e3}';
    IID_IMFMediaBuffer: TGUID = '{045FA593-8799-42b8-BC8D-8968C6453507}';
    IID_IMFSample: TGUID = '{c40a00f2-b93a-4d80-ae8c-5a1c634f58e4}';
    IID_IMF2DBuffer: TGUID = '{7DC9D5F9-9ED9-44ec-9BBF-0600BB589FBB}';
    IID_IMF2DBuffer2: TGUID = '{33ae5ea6-4316-436f-8ddd-d73d22f829ec}';
    IID_IMFDXGIBuffer: TGUID = '{e7174cfa-1c9e-48b1-8866-626226bfc258}';
    IID_IMFMediaType: TGUID = '{44ae0fa8-ea31-4109-8d2e-4cae4997c555}';
    IID_IMFAudioMediaType: TGUID = '{26a0adc3-ce26-4672-9304-69552edd3faf}';
    IID_IMFVideoMediaType: TGUID = '{b99f381f-a8f9-47a2-a5af-ca3a225a3890}';
    IID_IMFAsyncResult: TGUID = '{ac6b7889-0740-4d51-8619-905994a55cc6}';
    IID_IMFAsyncCallback: TGUID = '{a27003cf-2354-4f2a-8d6a-ab7cff15437e}';
    IID_IMFAsyncCallbackLogging: TGUID = '{c7a4dca1-f5f0-47b6-b92b-bf0106d25791}';
    IID_IMFMediaEvent: TGUID = '{DF598932-F10C-4E39-BBA2-C308F101DAA3}';
    IID_IMFMediaEventGenerator: TGUID = '{2CD0BD52-BCD5-4B89-B62C-EADC0C031E7D}';
    IID_IMFRemoteAsyncCallback: TGUID = '{a27003d0-2354-4f2a-8d6a-ab7cff15437e}';
    IID_IMFByteStream: TGUID = '{ad4c1b00-4bf7-422f-9175-756693d9130d}';
    IID_IMFByteStreamProxyClassFactory: TGUID = '{a6b43f84-5c0a-42e8-a44d-b1857a76992f}';
    IID_IMFSampleOutputStream: TGUID = '{8feed468-6f7e-440d-869a-49bdd283ad0d}';
    IID_IMFCollection: TGUID = '{5BC8A76B-869A-46a3-9B03-FA218A66AEBE}';
    IID_IMFMediaEventQueue: TGUID = '{36f846fc-2256-48b6-b58e-e2b638316581}';
    IID_IMFActivate: TGUID = '{7FEE9E9A-4A89-47a6-899C-B6A53A70FB67}';
    IID_IMFPluginControl: TGUID = '{5c6c44bf-1db6-435b-9249-e8cd10fdec96}';
    IID_IMFPluginControl2: TGUID = '{C6982083-3DDC-45CB-AF5E-0F7A8CE4DE77}';
    IID_IMFDXGIDeviceManager: TGUID = '{eb533d5d-2db6-40f8-97a9-494692014f07}';
    MF_BYTESTREAM_ORIGIN_NAME: TGUID = '{fc358288-3cb6-460c-a424-b6681260375a}';
    MF_BYTESTREAM_CONTENT_TYPE: TGUID = '{fc358289-3cb6-460c-a424-b6681260375a}';
    MF_BYTESTREAM_DURATION: TGUID = '{fc35828a-3cb6-460c-a424-b6681260375a}';
    MF_BYTESTREAM_LAST_MODIFIED_TIME: TGUID = '{fc35828b-3cb6-460c-a424-b6681260375a}';
    MF_BYTESTREAM_IFO_FILE_URI: TGUID = '{fc35828c-3cb6-460c-a424-b6681260375a}';
    MF_BYTESTREAM_DLNA_PROFILE_ID: TGUID = '{fc35828d-3cb6-460c-a424-b6681260375a}';
    MF_BYTESTREAM_EFFECTIVE_URL: TGUID = '{9afa0209-89d1-42af-8456-1de6b562d691}';
    MF_BYTESTREAM_TRANSCODED: TGUID = '{b6c5c282-4dc9-4db9-ab48-cf3b6d8bc5e0}';
    CLSID_MFByteStreamProxyClassFactory: TGUID = '{770e8e77-4916-441c-a9a7-b342d0eebc71}';

const

    MF_MEDIATYPE_EQUAL_MAJOR_TYPES = $00000001;
    MF_MEDIATYPE_EQUAL_FORMAT_TYPES = $00000002;
    MF_MEDIATYPE_EQUAL_FORMAT_DATA = $00000004;
    MF_MEDIATYPE_EQUAL_FORMAT_USER_DATA = $00000008;

    MFASYNC_FAST_IO_PROCESSING_CALLBACK = $00000001;
    MFASYNC_SIGNAL_CALLBACK = $00000002;
    MFASYNC_BLOCKING_CALLBACK = $00000004;
    MFASYNC_REPLY_CALLBACK = $00000008;
    MFASYNC_LOCALIZE_REMOTE_CALLBACK = $00000010;
    MFASYNC_CALLBACK_QUEUE_UNDEFINED = $00000000;
    MFASYNC_CALLBACK_QUEUE_STANDARD = $00000001;
    MFASYNC_CALLBACK_QUEUE_RT = $00000002;
    MFASYNC_CALLBACK_QUEUE_IO = $00000003;
    MFASYNC_CALLBACK_QUEUE_TIMER = $00000004;
    MFASYNC_CALLBACK_QUEUE_MULTITHREADED = $00000005;
    MFASYNC_CALLBACK_QUEUE_LONG_FUNCTION = $00000007;
    MFASYNC_CALLBACK_QUEUE_PRIVATE_MASK = $FFFF0000;
    MFASYNC_CALLBACK_QUEUE_ALL = $FFFFFFFF;


    MFBYTESTREAM_IS_READABLE = $00000001;
    MFBYTESTREAM_IS_WRITABLE = $00000002;
    MFBYTESTREAM_IS_SEEKABLE = $00000004;
    MFBYTESTREAM_IS_REMOTE = $00000008;
    MFBYTESTREAM_IS_DIRECTORY = $00000080;
    MFBYTESTREAM_HAS_SLOW_SEEK = $00000100;
    MFBYTESTREAM_IS_PARTIALLY_DOWNLOADED = $00000200;

    MFBYTESTREAM_SHARE_WRITE = $00000400;


    MFBYTESTREAM_DOES_NOT_USE_NETWORK = $00000800;

    MFBYTESTREAM_SEEK_FLAG_CANCEL_PENDING_IO = $00000001;

    MF_EVENT_FLAG_NO_WAIT = $00000001;

const
    MEUnknown = 0;
    MEError = 1;
    MEExtendedType = 2;
    MENonFatalError = 3;
    MEGenericV1Anchor = MENonFatalError;
    MESessionUnknown = 100;
    MESessionTopologySet = 101;
    MESessionTopologiesCleared = 102;
    MESessionStarted = 103;
    MESessionPaused = 104;
    MESessionStopped = 105;
    MESessionClosed = 106;
    MESessionEnded = 107;
    MESessionRateChanged = 108;
    MESessionScrubSampleComplete = 109;
    MESessionCapabilitiesChanged = 110;
    MESessionTopologyStatus = 111;
    MESessionNotifyPresentationTime = 112;
    MENewPresentation = 113;
    MELicenseAcquisitionStart = 114;
    MELicenseAcquisitionCompleted = 115;
    MEIndividualizationStart = 116;
    MEIndividualizationCompleted = 117;
    MEEnablerProgress = 118;
    MEEnablerCompleted = 119;
    MEPolicyError = 120;
    MEPolicyReport = 121;
    MEBufferingStarted = 122;
    MEBufferingStopped = 123;
    MEConnectStart = 124;
    MEConnectEnd = 125;
    MEReconnectStart = 126;
    MEReconnectEnd = 127;
    MERendererEvent = 128;
    MESessionStreamSinkFormatChanged = 129;
    MESessionV1Anchor = MESessionStreamSinkFormatChanged;
    MESourceUnknown = 200;
    MESourceStarted = 201;
    MEStreamStarted = 202;
    MESourceSeeked = 203;
    MEStreamSeeked = 204;
    MENewStream = 205;
    MEUpdatedStream = 206;
    MESourceStopped = 207;
    MEStreamStopped = 208;
    MESourcePaused = 209;
    MEStreamPaused = 210;
    MEEndOfPresentation = 211;
    MEEndOfStream = 212;
    MEMediaSample = 213;
    MEStreamTick = 214;
    MEStreamThinMode = 215;
    MEStreamFormatChanged = 216;
    MESourceRateChanged = 217;
    MEEndOfPresentationSegment = 218;
    MESourceCharacteristicsChanged = 219;
    MESourceRateChangeRequested = 220;
    MESourceMetadataChanged = 221;
    MESequencerSourceTopologyUpdated = 222;
    MESourceV1Anchor = MESequencerSourceTopologyUpdated;
    MESinkUnknown = 300;
    MEStreamSinkStarted = 301;
    MEStreamSinkStopped = 302;
    MEStreamSinkPaused = 303;
    MEStreamSinkRateChanged = 304;
    MEStreamSinkRequestSample = 305;
    MEStreamSinkMarker = 306;
    MEStreamSinkPrerolled = 307;
    MEStreamSinkScrubSampleComplete = 308;
    MEStreamSinkFormatChanged = 309;
    MEStreamSinkDeviceChanged = 310;
    MEQualityNotify = 311;
    MESinkInvalidated = 312;
    MEAudioSessionNameChanged = 313;
    MEAudioSessionVolumeChanged = 314;
    MEAudioSessionDeviceRemoved = 315;
    MEAudioSessionServerShutdown = 316;
    MEAudioSessionGroupingParamChanged = 317;
    MEAudioSessionIconChanged = 318;
    MEAudioSessionFormatChanged = 319;
    MEAudioSessionDisconnected = 320;
    MEAudioSessionExclusiveModeOverride = 321;
    MESinkV1Anchor = MEAudioSessionExclusiveModeOverride;
    MECaptureAudioSessionVolumeChanged = 322;
    MECaptureAudioSessionDeviceRemoved = 323;
    MECaptureAudioSessionFormatChanged = 324;
    MECaptureAudioSessionDisconnected = 325;
    MECaptureAudioSessionExclusiveModeOverride = 326;
    MECaptureAudioSessionServerShutdown = 327;
    MESinkV2Anchor = MECaptureAudioSessionServerShutdown;
    METrustUnknown = 400;
    MEPolicyChanged = 401;
    MEContentProtectionMessage = 402;
    MEPolicySet = 403;
    METrustV1Anchor = MEPolicySet;
    MEWMDRMLicenseBackupCompleted = 500;
    MEWMDRMLicenseBackupProgress = 501;
    MEWMDRMLicenseRestoreCompleted = 502;
    MEWMDRMLicenseRestoreProgress = 503;
    MEWMDRMLicenseAcquisitionCompleted = 506;
    MEWMDRMIndividualizationCompleted = 508;
    MEWMDRMIndividualizationProgress = 513;
    MEWMDRMProximityCompleted = 514;
    MEWMDRMLicenseStoreCleaned = 515;
    MEWMDRMRevocationDownloadCompleted = 516;
    MEWMDRMV1Anchor = MEWMDRMRevocationDownloadCompleted;
    METransformUnknown = 600;
    METransformNeedInput = (METransformUnknown + 1);
    METransformHaveOutput = (METransformNeedInput + 1);
    METransformDrainComplete = (METransformHaveOutput + 1);
    METransformMarker = (METransformDrainComplete + 1);
    METransformInputStreamStateChanged = (METransformMarker + 1);
    MEByteStreamCharacteristicsChanged = 700;
    MEVideoCaptureDeviceRemoved = 800;
    MEVideoCaptureDevicePreempted = 801;
    MEStreamSinkFormatInvalidated = 802;
    MEEncodingParameters = 803;
    MEContentProtectionMetadata = 900;
    MEDeviceThermalStateChanged = 950;
    MEReservedMax = 10000;

type
    {$IFNDEF FPC}
    PUINT8 = PBYTE;
    {$ENDIF}
    QWORD = ULONGLONG;

    TREFGUID = ^TGUID;
    TMediaEventType = DWORD;

{$Z1}
{$A1}
    // pragma pack(push, 1)
    TWAVEFORMATEX = record
        wFormatTag: word;
        nChannels: word;
        nSamplesPerSec: DWORD;
        nAvgBytesPerSec: DWORD;
        nBlockAlign: word;
        wBitsPerSample: word;
        cbSize: word;
        pExtraBytes: PBYTE;
    end;
    PWAVEFORMATEX = ^TWAVEFORMATEX;


    TWAVEFORMATEXTENSIBLE = record
        wFormatTag: word;
        nChannels: word;
        nSamplesPerSec: DWORD;
        nAvgBytesPerSec: DWORD;
        nBlockAlign: word;
        wBitsPerSample: word;
        cbSize: word;
        wValidBitsPerSample: word;
        dwChannelMask: DWORD;
        SubFormat: TGUID;
    end;

    PWAVEFORMATEXTENSIBLE = ^TWAVEFORMATEXTENSIBLE;


    // pragma pack(pop)

{$Z4}
{$A4}


    TMF_ATTRIBUTE_TYPE = (
        MF_ATTRIBUTE_UINT32 = VT_UI4,
        MF_ATTRIBUTE_UINT64 = VT_UI8,
        MF_ATTRIBUTE_DOUBLE = VT_R8,
        MF_ATTRIBUTE_GUID = VT_CLSID,
        MF_ATTRIBUTE_STRING = VT_LPWSTR,
        MF_ATTRIBUTE_BLOB = (VT_VECTOR or VT_UI1),
        MF_ATTRIBUTE_IUNKNOWN = VT_UNKNOWN
        );

    TMF_ATTRIBUTES_MATCH_TYPE = (
        MF_ATTRIBUTES_MATCH_OUR_ITEMS = 0,
        MF_ATTRIBUTES_MATCH_THEIR_ITEMS = 1,
        MF_ATTRIBUTES_MATCH_ALL_ITEMS = 2,
        MF_ATTRIBUTES_MATCH_INTERSECTION = 3,
        MF_ATTRIBUTES_MATCH_SMALLER = 4
        );


    TMF_ATTRIBUTE_SERIALIZE_OPTIONS = (
        MF_ATTRIBUTE_SERIALIZE_UNKNOWN_BYREF = $1
        );

    IMFAttributes = interface(IUnknown)
        ['{2cd2d921-c447-44a7-a13c-4adabfc247e3}']
        function GetItem(const guidKey: TGUID; var pValue: TPROPVARIANT): HResult; stdcall;
        function GetItemType(const guidKey: TGUID; out pType: TMF_ATTRIBUTE_TYPE): HResult; stdcall;
        function CompareItem(const guidKey: TGUID; const Value: TPROPVARIANT; out pbResult: boolean): HResult; stdcall;
        function Compare(pTheirs: IMFAttributes; MatchType: TMF_ATTRIBUTES_MATCH_TYPE; out pbResult: boolean): HResult; stdcall;
        function GetUINT32(const guidKey: TGUID; out punValue: UINT32): HResult; stdcall;
        function GetUINT64(const guidKey: TGUID; out punValue: UINT64): HResult; stdcall;
        function GetDouble(const guidKey: TGUID; out pfValue: double): HResult; stdcall;
        function GetGUID(const guidKey: TGUID; out pguidValue: TGUID): HResult; stdcall;
        function GetStringLength(const guidKey: TGUID; out pcchLength: UINT32): HResult; stdcall;
        function GetString(const guidKey: TGUID; out pwszValue: LPWSTR; cchBufSize: UINT32; var pcchLength: UINT32): HResult; stdcall;
        function GetAllocatedString(const guidKey: TGUID; out ppwszValue: LPWSTR; out pcchLength: UINT32): HResult; stdcall;
        function GetBlobSize(const guidKey: TGUID; out pcbBlobSize: UINT32): HResult; stdcall;
        function GetBlob(const guidKey: TGUID; out pBuf: PUINT8; cbBufSize: UINT32; var pcbBlobSize: UINT32): HResult; stdcall;
        function GetAllocatedBlob(const guidKey: TGUID; out ppBuf: PUINT8; out pcbSize: UINT32): HResult; stdcall;
        function GetUnknown(const guidKey: TGUID; const riid: TGUID; out ppv: pointer): HResult; stdcall;
        function SetItem(const guidKey: TGUID; const Value: TPROPVARIANT): HResult; stdcall;
        function DeleteItem(const guidKey: TGUID): HResult; stdcall;
        function DeleteAllItems(): HResult; stdcall;
        function SetUINT32(const guidKey: TGUID; unValue: UINT32): HResult; stdcall;
        function SetUINT64(const guidKey: TGUID; unValue: UINT64): HResult; stdcall;
        function SetDouble(const guidKey: TGUID; fValue: double): HResult; stdcall;
        function SetGUID(const guidKey: TGUID; guidValue: TREFGUID): HResult; stdcall;
        function SetString(const guidKey: TGUID; wszValue: LPCWSTR): HResult; stdcall;
        function SetBlob(const guidKey: TGUID; const pBuf: PUINT8; cbBufSize: UINT32): HResult; stdcall;
        function SetUnknown(const guidKey: TGUID; pUnknown: IUnknown): HResult; stdcall;
        function LockStore(): HResult; stdcall;
        function UnlockStore(): HResult; stdcall;
        function GetCount(out pcItems: UINT32): HResult; stdcall;
        function GetItemByIndex(unIndex: UINT32; out pguidKey: TGUID; var pValue: PROPVARIANT): HResult; stdcall;
        function CopyAllItems(pDest: IMFAttributes): HResult; stdcall;
    end;


    IMFMediaBuffer = interface(IUnknown)
        ['{045FA593-8799-42b8-BC8D-8968C6453507}']
        function Lock(out ppbBuffer: PBYTE; out pcbMaxLength: DWORD; out pcbCurrentLength: DWORD): HResult; stdcall;
        function Unlock(): HResult; stdcall;
        function GetCurrentLength(out pcbCurrentLength: DWORD): HResult; stdcall;
        function SetCurrentLength(cbCurrentLength: DWORD): HResult; stdcall;
        function GetMaxLength(out pcbMaxLength: DWORD): HResult; stdcall;
    end;


    IMFSample = interface(IMFAttributes)
        ['{c40a00f2-b93a-4d80-ae8c-5a1c634f58e4}']
        function GetSampleFlags(out pdwSampleFlags: DWORD): HResult; stdcall;
        function SetSampleFlags(dwSampleFlags: DWORD): HResult; stdcall;
        function GetSampleTime(out phnsSampleTime: LONGLONG): HResult; stdcall;
        function SetSampleTime(hnsSampleTime: LONGLONG): HResult; stdcall;
        function GetSampleDuration(out phnsSampleDuration: LONGLONG): HResult; stdcall;
        function SetSampleDuration(hnsSampleDuration: LONGLONG): HResult; stdcall;
        function GetBufferCount(out pdwBufferCount: DWORD): HResult; stdcall;
        function GetBufferByIndex(dwIndex: DWORD; out ppBuffer: IMFMediaBuffer): HResult; stdcall;
        function ConvertToContiguousBuffer(out ppBuffer: IMFMediaBuffer): HResult; stdcall;
        function AddBuffer(pBuffer: IMFMediaBuffer): HResult; stdcall;
        function RemoveBufferByIndex(dwIndex: DWORD): HResult; stdcall;
        function RemoveAllBuffers(): HResult; stdcall;
        function GetTotalLength(out pcbTotalLength: DWORD): HResult; stdcall;
        function CopyToBuffer(pBuffer: IMFMediaBuffer): HResult; stdcall;
    end;


    IMF2DBuffer = interface(IUnknown)
        ['{7DC9D5F9-9ED9-44ec-9BBF-0600BB589FBB}']
        function Lock2D(out ppbScanline0: PBYTE; out plPitch: LONGINT): HResult; stdcall;
        function Unlock2D(): HResult; stdcall;
        function GetScanline0AndPitch(out pbScanline0: PBYTE; out plPitch: LONGINT): HResult; stdcall;
        function IsContiguousFormat(out pfIsContiguous: boolean): HResult; stdcall;
        function GetContiguousLength(out pcbLength: DWORD): HResult; stdcall;
        function ContiguousCopyTo(out pbDestBuffer: PBYTE; cbDestBuffer: DWORD): HResult; stdcall;
        function ContiguousCopyFrom(const pbSrcBuffer: PBYTE; cbSrcBuffer: DWORD): HResult; stdcall;
    end;

    TMF2DBuffer_LockFlags = (
        MF2DBuffer_LockFlags_LockTypeMask = (($1 or $2) or $3),
        MF2DBuffer_LockFlags_Read = $1,
        MF2DBuffer_LockFlags_Write = $2,
        MF2DBuffer_LockFlags_ReadWrite = $3,
        MF2DBuffer_LockFlags_ForceDWORD = $7fffffff
        );


    IMF2DBuffer2 = interface(IMF2DBuffer)
        ['{33ae5ea6-4316-436f-8ddd-d73d22f829ec}']
        function Lock2DSize(lockFlags: TMF2DBuffer_LockFlags; out ppbScanline0: PBYTE; out plPitch: LONGINT;
            out ppbBufferStart: PBYTE; out pcbBufferLength: DWORD): HResult; stdcall;
        function Copy2DTo(pDestBuffer: IMF2DBuffer2): HResult; stdcall;
    end;

    IMFDXGIBuffer = interface(IUnknown)
        ['{e7174cfa-1c9e-48b1-8866-626226bfc258}']
        function GetResource(const riid: TGUID; out ppvObject: pointer): HResult; stdcall;
        function GetSubresourceIndex(out puSubresource: UINT): HResult; stdcall;
        function GetUnknown(const guid: TGUID; const riid: TGUID; out ppvObject: pointer): HResult; stdcall;
        function SetUnknown(const guid: TGUID; pUnkData: IUnknown): HResult; stdcall;
    end;


    IMFMediaType = interface(IMFAttributes)
        ['{44ae0fa8-ea31-4109-8d2e-4cae4997c555}']
        function GetMajorType(out pguidMajorType: TGUID): HResult; stdcall;
        function IsCompressedFormat(out pfCompressed: boolean): HResult; stdcall;
        function IsEqual(pIMediaType: IMFMediaType; out pdwFlags: DWORD): HResult; stdcall;
        function GetRepresentation(guidRepresentation: TGUID; out ppvRepresentation: pointer): HResult; stdcall;
        function FreeRepresentation(guidRepresentation: TGUID; pvRepresentation: pointer): HResult; stdcall;
    end;

    PIMFMediaType = ^IMFMediaType;


    IMFAudioMediaType = interface(IMFMediaType)
        ['{26a0adc3-ce26-4672-9304-69552edd3faf}']
        function GetAudioFormat(): TWAVEFORMATEX; stdcall;
    end;


type
    RGBQUAD = DWORD;

    TBITMAPINFOHEADER = record
        biSize: DWORD;
        biWidth: LONGINT;
        biHeight: LONGINT;
        biPlanes: word;
        biBitCount: word;
        biCompression: DWORD;
        biSizeImage: DWORD;
        biXPelsPerMeter: LONGINT;
        biYPelsPerMeter: LONGINT;
        biClrUsed: DWORD;
        biClrImportant: DWORD;
    end;

    TBITMAPINFO = record
        bmiHeader: TBITMAPINFOHEADER;
        bmiColors: PRGBQUAD;
    end;


    TMFT_REGISTER_TYPE_INFO = record
        guidMajorType: TGUID;
        guidSubtype: TGUID;
    end;

    PMFT_REGISTER_TYPE_INFO = ^TMFT_REGISTER_TYPE_INFO;


    TMFVideoInterlaceMode = (
        MFVideoInterlace_Unknown = 0,
        MFVideoInterlace_Progressive = 2,
        MFVideoInterlace_FieldInterleavedUpperFirst = 3,
        MFVideoInterlace_FieldInterleavedLowerFirst = 4,
        MFVideoInterlace_FieldSingleUpper = 5,
        MFVideoInterlace_FieldSingleUpperFirst = MFVideoInterlace_FieldSingleUpper,
        MFVideoInterlace_FieldSingleLower = 6,
        MFVideoInterlace_FieldSingleLowerFirst = MFVideoInterlace_FieldSingleLower,
        MFVideoInterlace_MixedInterlaceOrProgressive = 7,
        MFVideoInterlace_Last = (MFVideoInterlace_MixedInterlaceOrProgressive + 1),
        MFVideoInterlace_ForceDWORD = $7fffffff
        );


    TMFVideoTransferFunction = (
        MFVideoTransFunc_Unknown = 0,
        MFVideoTransFunc_10 = 1,
        MFVideoTransFunc_18 = 2,
        MFVideoTransFunc_20 = 3,
        MFVideoTransFunc_22 = 4,
        MFVideoTransFunc_709 = 5,
        MFVideoTransFunc_240M = 6,
        MFVideoTransFunc_sRGB = 7,
        MFVideoTransFunc_28 = 8,
        MFVideoTransFunc_Log_100 = 9,
        MFVideoTransFunc_Log_316 = 10,
        MFVideoTransFunc_709_sym = 11,
        MFVideoTransFunc_2020_const = 12,
        MFVideoTransFunc_2020 = 13,
        MFVideoTransFunc_26 = 14,
        MFVideoTransFunc_Last = (MFVideoTransFunc_26 + 1),
        MFVideoTransFunc_ForceDWORD = $7fffffff
        );

    TMFVideoPrimaries = (
        MFVideoPrimaries_Unknown = 0,
        MFVideoPrimaries_reserved = 1,
        MFVideoPrimaries_BT709 = 2,
        MFVideoPrimaries_BT470_2_SysM = 3,
        MFVideoPrimaries_BT470_2_SysBG = 4,
        MFVideoPrimaries_SMPTE170M = 5,
        MFVideoPrimaries_SMPTE240M = 6,
        MFVideoPrimaries_EBU3213 = 7,
        MFVideoPrimaries_SMPTE_C = 8,
        MFVideoPrimaries_BT2020 = 9,
        MFVideoPrimaries_XYZ = 10,
        MFVideoPrimaries_Last = (MFVideoPrimaries_XYZ + 1),
        MFVideoPrimaries_ForceDWORD = $7fffffff
        );

    TMFVideoLighting = (
        MFVideoLighting_Unknown = 0,
        MFVideoLighting_bright = 1,
        MFVideoLighting_office = 2,
        MFVideoLighting_dim = 3,
        MFVideoLighting_dark = 4,
        MFVideoLighting_Last = (MFVideoLighting_dark + 1),
        MFVideoLighting_ForceDWORD = $7fffffff
        );

    TMFVideoTransferMatrix = (
        MFVideoTransferMatrix_Unknown = 0,
        MFVideoTransferMatrix_BT709 = 1,
        MFVideoTransferMatrix_BT601 = 2,
        MFVideoTransferMatrix_SMPTE240M = 3,
        MFVideoTransferMatrix_BT2020_10 = 4,
        MFVideoTransferMatrix_BT2020_12 = 5,
        MFVideoTransferMatrix_Last = (MFVideoTransferMatrix_BT2020_12 + 1),
        MFVideoTransferMatrix_ForceDWORD = $7fffffff
        );

    TMFVideoChromaSubsampling = (
        MFVideoChromaSubsampling_Unknown = 0,
        MFVideoChromaSubsampling_ProgressiveChroma = $8,
        MFVideoChromaSubsampling_Horizontally_Cosited = $4,
        MFVideoChromaSubsampling_Vertically_Cosited = $2,
        MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes = $1,
        MFVideoChromaSubsampling_MPEG2 = Ord(MFVideoChromaSubsampling_Horizontally_Cosited) or
        Ord(MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes),
        MFVideoChromaSubsampling_MPEG1 = MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes,
        MFVideoChromaSubsampling_DV_PAL = Ord(MFVideoChromaSubsampling_Horizontally_Cosited) or Ord(
        MFVideoChromaSubsampling_Vertically_Cosited),
        MFVideoChromaSubsampling_Cosited = Ord(MFVideoChromaSubsampling_Horizontally_Cosited) or Ord(
        MFVideoChromaSubsampling_Vertically_Cosited) or Ord(MFVideoChromaSubsampling_Vertically_AlignedChromaPlanes),
        MFVideoChromaSubsampling_Last = (MFVideoChromaSubsampling_Cosited + 1),
        MFVideoChromaSubsampling_ForceDWORD = $7fffffff
        );

    TMFNominalRange = (
        MFNominalRange_Unknown = 0,
        MFNominalRange_Normal = 1,
        MFNominalRange_Wide = 2,
        MFNominalRange_0_255 = 1,
        MFNominalRange_16_235 = 2,
        MFNominalRange_48_208 = 3,
        MFNominalRange_64_127 = 4,
        MFNominalRange_Last = (MFNominalRange_64_127 + 1),
        MFNominalRange_ForceDWORD = $7fffffff
        );


    TMFVideoFlags = (
        MFVideoFlag_PAD_TO_Mask = ($1 or $2),
        MFVideoFlag_PAD_TO_None = (0 * $1),
        MFVideoFlag_PAD_TO_4x3 = (1 * $1),
        MFVideoFlag_PAD_TO_16x9 = (2 * $1),
        MFVideoFlag_SrcContentHintMask = (($4 or $8) or $10),
        MFVideoFlag_SrcContentHintNone = (0 * $4),
        MFVideoFlag_SrcContentHint16x9 = (1 * $4),
        MFVideoFlag_SrcContentHint235_1 = (2 * $4),
        MFVideoFlag_AnalogProtected = $20,
        MFVideoFlag_DigitallyProtected = $40,
        MFVideoFlag_ProgressiveContent = $80,
        MFVideoFlag_FieldRepeatCountMask = (($100 or $200) or $400),
        MFVideoFlag_FieldRepeatCountShift = 8,
        MFVideoFlag_ProgressiveSeqReset = $800,
        MFVideoFlag_PanScanEnabled = $20000,
        MFVideoFlag_LowerFieldFirst = $40000,
        MFVideoFlag_BottomUpLinearRep = $80000,
        MFVideoFlags_DXVASurface = $100000,
        MFVideoFlags_RenderTargetSurface = $400000,
        MFVideoFlags_ForceQWORD = $7fffffff
        );


    TMFRatio = record
        Numerator: DWORD;
        Denominator: DWORD;
    end;

    TMFOffset = record
        fract: word;
        Value: short;
    end;

    TMFVideoArea = record
        OffsetX: TMFOffset;
        OffsetY: TMFOffset;
        Area: TSIZE;
    end;


    TMFVideoInfo = record
        dwWidth: DWORD;
        dwHeight: DWORD;
        PixelAspectRatio: TMFRatio;
        SourceChromaSubsampling: TMFVideoChromaSubsampling;
        InterlaceMode: TMFVideoInterlaceMode;
        TransferFunction: TMFVideoTransferFunction;
        ColorPrimaries: TMFVideoPrimaries;
        TransferMatrix: TMFVideoTransferMatrix;
        SourceLighting: TMFVideoLighting;
        FramesPerSecond: TMFRatio;
        NominalRange: TMFNominalRange;
        GeometricAperture: TMFVideoArea;
        MinimumDisplayAperture: TMFVideoArea;
        PanScanAperture: TMFVideoArea;
        VideoFlags: UINT64;
    end;


    TMFAYUVSample = record
        bCrValue: byte;
        bCbValue: byte;
        bYValue: byte;
        bSampleAlpha8: byte;
    end;

    TMFARGB = record
        rgbBlue: byte;
        rgbGreen: byte;
        rgbRed: byte;
        rgbAlpha: byte;
    end;

    TMFPaletteEntry = record
        case integer of
            0: (
                ARGB: TMFARGB);
            1: (
                AYCbCr: TMFAYUVSample);
    end;

    PMFPaletteEntry = ^TMFPaletteEntry;


    TMFVideoSurfaceInfo = record
        Format: DWORD;
        PaletteEntries: DWORD;
        Palette: PMFPaletteEntry;
    end;

    TMFVideoCompressedInfo = record
        AvgBitrate: LONGLONG;
        AvgBitErrorRate: LONGLONG;
        MaxKeyFrameSpacing: DWORD;
    end;

    TMFVIDEOFORMAT = record
        dwSize: DWORD;
        videoInfo: TMFVideoInfo;
        guidFormat: TGUID;
        compressedInfo: TMFVideoCompressedInfo;
        surfaceInfo: TMFVideoSurfaceInfo;
    end;

    PMFVIDEOFORMAT = ^TMFVIDEOFORMAT;


    TMFStandardVideoFormat = (
        MFStdVideoFormat_reserved = 0,
        MFStdVideoFormat_NTSC = (MFStdVideoFormat_reserved + 1),
        MFStdVideoFormat_PAL = (MFStdVideoFormat_NTSC + 1),
        MFStdVideoFormat_DVD_NTSC = (MFStdVideoFormat_PAL + 1),
        MFStdVideoFormat_DVD_PAL = (MFStdVideoFormat_DVD_NTSC + 1),
        MFStdVideoFormat_DV_PAL = (MFStdVideoFormat_DVD_PAL + 1),
        MFStdVideoFormat_DV_NTSC = (MFStdVideoFormat_DV_PAL + 1),
        MFStdVideoFormat_ATSC_SD480i = (MFStdVideoFormat_DV_NTSC + 1),
        MFStdVideoFormat_ATSC_HD1080i = (MFStdVideoFormat_ATSC_SD480i + 1),
        MFStdVideoFormat_ATSC_HD720p = (MFStdVideoFormat_ATSC_HD1080i + 1)
        );


    IMFVideoMediaType = interface(IMFMediaType)
        ['{b99f381f-a8f9-47a2-a5af-ca3a225a3890}']
        function GetVideoFormat(): PMFVIDEOFORMAT; stdcall;
        function GetVideoRepresentation(guidRepresentation: TGUID; out ppvRepresentation: pointer; lStride: LONGINT): HResult; stdcall;
    end;

    IMFAsyncResult = interface(IUnknown)
        ['{ac6b7889-0740-4d51-8619-905994a55cc6}']
        function GetState(out ppunkState: IUnknown): HResult; stdcall;
        function GetStatus(): HResult; stdcall;
        function SetStatus(hrStatus: HRESULT): HResult; stdcall;
        function GetObject(out ppObject: IUnknown): HResult; stdcall;
        function GetStateNoAddRef(): IUnknown; stdcall;
    end;

    IMFAsyncCallback = interface(IUnknown)
        ['{a27003cf-2354-4f2a-8d6a-ab7cff15437e}']
        function GetParameters(out pdwFlags: DWORD; out pdwQueue: DWORD): HResult; stdcall;
        function Invoke(pAsyncResult: IMFAsyncResult): HResult; stdcall;
    end;

    IMFAsyncCallbackLogging = interface(IMFAsyncCallback)
        ['{c7a4dca1-f5f0-47b6-b92b-bf0106d25791}']
        function GetObjectPointer(): Pointer; stdcall;
        function GetObjectTag(): DWORD; stdcall;
    end;

    IMFMediaEvent = interface(IMFAttributes)
        ['{DF598932-F10C-4E39-BBA2-C308F101DAA3}']
        function GetType(out pmet: TMediaEventType): HResult; stdcall;
        function GetExtendedType(out pguidExtendedType: TGUID): HResult; stdcall;
        function GetStatus(out phrStatus: HRESULT): HResult; stdcall;
        function GetValue(out pvValue: PROPVARIANT): HResult; stdcall;
    end;

    IMFMediaEventGenerator = interface(IUnknown)
        ['{2CD0BD52-BCD5-4B89-B62C-EADC0C031E7D}']
        function GetEvent(dwFlags: DWORD; out ppEvent: IMFMediaEvent): HResult; stdcall;
        function BeginGetEvent(pCallback: IMFAsyncCallback; punkState: IUnknown): HResult; stdcall;
        function EndGetEvent(pResult: IMFAsyncResult; out ppEvent: IMFMediaEvent): HResult; stdcall;
        function QueueEvent(met: TMediaEventType; guidExtendedType: TREFGUID; hrStatus: HRESULT;
            const pvValue: PROPVARIANT): HResult; stdcall;
    end;


    IMFRemoteAsyncCallback = interface(IUnknown)
        ['{a27003d0-2354-4f2a-8d6a-ab7cff15437e}']
        function Invoke(hr: HRESULT; pRemoteResult: IUnknown): HResult; stdcall;
    end;


    TMFBYTESTREAM_SEEK_ORIGIN = (
        msoBegin = 0,
        msoCurrent = (msoBegin + 1)
        );

    IMFByteStream = interface(IUnknown)
        ['{ad4c1b00-4bf7-422f-9175-756693d9130d}']
        function GetCapabilities(out pdwCapabilities: DWORD): HResult; stdcall;
        function GetLength(out pqwLength: QWORD): HResult; stdcall;
        function SetLength(qwLength: QWORD): HResult; stdcall;
        function GetCurrentPosition(out pqwPosition: QWORD): HResult; stdcall;
        function SetCurrentPosition(qwPosition: QWORD): HResult; stdcall;
        function IsEndOfStream(out pfEndOfStream: boolean): HResult; stdcall;
        function Read(out pb: PBYTE; cb: ULONG; out pcbRead: ULONG): HResult; stdcall;
        function BeginRead(out pb: PBYTE; cb: ULONG; pCallback: IMFAsyncCallback; punkState: IUnknown): HResult; stdcall;
        function EndRead(pResult: IMFAsyncResult; out pcbRead: ULONG): HResult; stdcall;
        function Write(const pb: PBYTE; cb: ULONG; out pcbWritten: ULONG): HResult; stdcall;
        function BeginWrite(const pb: PBYTE; cb: ULONG; pCallback: IMFAsyncCallback; punkState: IUnknown): HResult; stdcall;
        function EndWrite(pResult: IMFAsyncResult; out pcbWritten: ULONG): HResult; stdcall;
        function Seek(SeekOrigin: TMFBYTESTREAM_SEEK_ORIGIN; llSeekOffset: LONGLONG; dwSeekFlags: DWORD;
            out pqwCurrentPosition: QWORD): HResult; stdcall;
        function Flush(): HResult; stdcall;
        function Close(): HResult; stdcall;
    end;

    PIMFByteStream = ^IMFByteStream;

    IMFByteStreamProxyClassFactory = interface(IUnknown)
        ['{a6b43f84-5c0a-42e8-a44d-b1857a76992f}']
        function CreateByteStreamProxy(pByteStream: IMFByteStream; pAttributes: IMFAttributes;const  riid: TGUID;
            out ppvObject: pointer): HResult; stdcall;
    end;

    TMF_FILE_ACCESSMODE = (
        MF_ACCESSMODE_READ = 1,
        MF_ACCESSMODE_WRITE = 2,
        MF_ACCESSMODE_READWRITE = 3
        );

    TMF_FILE_OPENMODE = (
        MF_OPENMODE_FAIL_IF_NOT_EXIST = 0,
        MF_OPENMODE_FAIL_IF_EXIST = 1,
        MF_OPENMODE_RESET_IF_EXIST = 2,
        MF_OPENMODE_APPEND_IF_EXIST = 3,
        MF_OPENMODE_DELETE_IF_EXIST = 4
        );

    TMF_FILE_FLAGS = (
        MF_FILEFLAGS_NONE = 0,
        MF_FILEFLAGS_NOBUFFERING = $1,
        MF_FILEFLAGS_ALLOW_WRITE_SHARING = $2
        );


    IMFSampleOutputStream = interface(IUnknown)
        ['{8feed468-6f7e-440d-869a-49bdd283ad0d}']
        function BeginWriteSample(pSample: IMFSample; pCallback: IMFAsyncCallback; punkState: IUnknown): HResult; stdcall;
        function EndWriteSample(pResult: IMFAsyncResult): HResult; stdcall;
        function Close(): HResult; stdcall;
    end;

    IMFCollection = interface(IUnknown)
        ['{5BC8A76B-869A-46a3-9B03-FA218A66AEBE}']
        function GetElementCount(out pcElements: DWORD): HResult; stdcall;
        function GetElement(dwElementIndex: DWORD; out ppUnkElement: IUnknown): HResult; stdcall;
        function AddElement(pUnkElement: IUnknown): HResult; stdcall;
        function RemoveElement(dwElementIndex: DWORD; out ppUnkElement: IUnknown): HResult; stdcall;
        function InsertElementAt(dwIndex: DWORD; pUnknown: IUnknown): HResult; stdcall;
        function RemoveAllElements(): HResult; stdcall;
    end;

    IMFMediaEventQueue = interface(IUnknown)
        ['{36f846fc-2256-48b6-b58e-e2b638316581}']
        function GetEvent(dwFlags: DWORD; out ppEvent: IMFMediaEvent): HResult; stdcall;
        function BeginGetEvent(pCallback: IMFAsyncCallback; punkState: IUnknown): HResult; stdcall;
        function EndGetEvent(pResult: IMFAsyncResult; out ppEvent: IMFMediaEvent): HResult; stdcall;
        function QueueEvent(pEvent: IMFMediaEvent): HResult; stdcall;
        function QueueEventParamVar(met: TMediaEventType; const guidExtendedType: TGUID; hrStatus: HRESULT;
            const pvValue: PROPVARIANT): HResult; stdcall;
        function QueueEventParamUnk(met: TMediaEventType; const guidExtendedType: TGUID; hrStatus: HRESULT;
            pUnk: IUnknown): HResult; stdcall;
        function Shutdown(): HResult; stdcall;
    end;


    IMFActivate = interface(IMFAttributes)
        ['{7FEE9E9A-4A89-47a6-899C-B6A53A70FB67}']
        function ActivateObject(const riid: TGUID; out ppv: Pointer): HResult; stdcall;
        function ShutdownObject(): HResult; stdcall;
        function DetachObject(): HResult; stdcall;
    end;

    PIMFActivate = ^IMFActivate;


    TMF_Plugin_Type = (
        MF_Plugin_Type_MFT = 0,
        MF_Plugin_Type_MediaSource = 1,
        MF_Plugin_Type_MFT_MatchOutputType = 2,
        MF_Plugin_Type_Other = DWORD(-1)
        );


    IMFPluginControl = interface(IUnknown)
        ['{5c6c44bf-1db6-435b-9249-e8cd10fdec96}']
        function GetPreferredClsid(pluginType: DWORD; selector: LPCWSTR; out clsid: CLSID): HResult; stdcall;
        function GetPreferredClsidByIndex(pluginType: DWORD; index: DWORD; out selector: LPWSTR; out clsid: CLSID): HResult; stdcall;
        function SetPreferredClsid(pluginType: DWORD; selector: LPCWSTR; const clsid: CLSID): HResult; stdcall;
        function IsDisabled(pluginType: DWORD; const clsid: CLSID): HResult; stdcall;
        function GetDisabledByIndex(pluginType: DWORD; index: DWORD; out clsid: CLSID): HResult; stdcall;
        function SetDisabled(pluginType: DWORD; const clsid: CLSID; disabled: boolean): HResult; stdcall;
    end;


    TMF_PLUGIN_CONTROL_POLICY = (
        MF_PLUGIN_CONTROL_POLICY_USE_ALL_PLUGINS = 0,
        MF_PLUGIN_CONTROL_POLICY_USE_APPROVED_PLUGINS = 1,
        MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS = 2,
        MF_PLUGIN_CONTROL_POLICY_USE_WEB_PLUGINS_EDGEMODE = 3
        );


    IMFPluginControl2 = interface(IMFPluginControl)
        ['{C6982083-3DDC-45CB-AF5E-0F7A8CE4DE77}']
        function SetPolicy(policy: TMF_PLUGIN_CONTROL_POLICY): HResult; stdcall;
    end;

    IMFDXGIDeviceManager = interface(IUnknown)
        ['{eb533d5d-2db6-40f8-97a9-494692014f07}']
        function CloseDeviceHandle(hDevice: THANDLE): HResult; stdcall;
        function GetVideoService(hDevice: THANDLE; const riid: TGUID; out ppService: pointer): HResult; stdcall;
        function LockDevice(hDevice: THANDLE; const riid: TGUID; out ppUnkDevice: Pointer; fBlock: BOOL): HResult; stdcall;
        function OpenDeviceHandle(out phDevice: THANDLE): HResult; stdcall;
        function ResetDevice(pUnkDevice: IUnknown; resetToken: UINT): HResult; stdcall;
        function TestDevice(hDevice: THANDLE): HResult; stdcall;
        function UnlockDevice(hDevice: THANDLE; fSaveState: boolean): HResult; stdcall;
    end;


function MFSerializeAttributesToStream(pAttr: IMFAttributes; dwOptions: DWORD; pStm: IStream): HResult; stdcall; external MFPlat_DLL;
function MFDeserializeAttributesFromStream(pAttr: IMFAttributes; dwOptions: DWORD; pStm: IStream): HResult; stdcall; external MFPlat_DLL;

implementation

end.
