unit Win32.MFMediaEngine;

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, ActiveX,
    ShlObj,
    CMC.WTypes,
    Win32.MFIdl, Win32.MFObjects, Win32.MFTransform;

const
    IID_IMFMediaError: TGUID = '{fc0e10d2-ab2a-4501-a951-06bb1075184c}';
    IID_IMFMediaTimeRange: TGUID = '{db71a2fc-078a-414e-9df9-8c2531b0aa6c}';
    IID_IMFMediaEngineNotify: TGUID = '{fee7c112-e776-42b5-9bbf-0048524e2bd5}';
    IID_IMFMediaEngineSrcElements: TGUID = '{7a5e5354-b114-4c72-b991-3131d75032ea}';
    IID_IMFMediaEngine: TGUID = '{98a1b0bb-03eb-4935-ae7c-93c1fa0e1c93}';
    IID_IMFMediaEngineEx: TGUID = '{83015ead-b1e6-40d0-a98a-37145ffe1ad1}';
    IID_IMFMediaEngineExtension: TGUID = '{2f69d622-20b5-41e9-afdf-89ced1dda04e}';
    IID_IMFMediaEngineProtectedContent: TGUID = '{9f8021e8-9c8c-487e-bb5c-79aa4779938c}';
    IID_IAudioSourceProvider: TGUID = '{EBBAF249-AFC2-4582-91C6-B60DF2E84954}';
    IID_IMFMediaEngineWebSupport: TGUID = '{ba2743a1-07e0-48ef-84b6-9a2ed023ca6c}';
    IID_IMFMediaSourceExtensionNotify: TGUID = '{a7901327-05dd-4469-a7b7-0e01979e361d}';
    IID_IMFBufferListNotify: TGUID = '{24cd47f7-81d8-4785-adb2-af697a963cd2}';
    IID_IMFSourceBufferNotify: TGUID = '{87e47623-2ceb-45d6-9b88-d8520c4dcbbc}';
    IID_IMFSourceBuffer: TGUID = '{e2cd3a4b-af25-4d3d-9110-da0e6f8ee877}';
    IID_IMFSourceBufferAppendMode: TGUID = '{19666fb4-babe-4c55-bc03-0a074da37e2a}';
    IID_IMFSourceBufferList: TGUID = '{249981f8-8325-41f3-b80c-3b9e3aad0cbe}';
    IID_IMFMediaSourceExtension: TGUID = '{e467b94e-a713-4562-a802-816a42e9008a}';
    IID_IMFMediaEngineEME: TGUID = '{50dc93e4-ba4f-4275-ae66-83e836e57469}';
    IID_IMFMediaEngineSrcElementsEx: TGUID = '{654a6bb3-e1a3-424a-9908-53a43a0dfda0}';
    IID_IMFMediaEngineNeedKeyNotify: TGUID = '{46a30204-a696-4b18-8804-246b8f031bb1}';
    IID_IMFMediaKeys: TGUID = '{5cb31c05-61ff-418f-afda-caaf41421a38}';
    IID_IMFMediaKeySession: TGUID = '{24fa67d5-d1d0-4dc5-995c-c0efdc191fb5}';
    IID_IMFMediaKeySessionNotify: TGUID = '{6a0083f9-8947-4c1d-9ce0-cdee22b23135}';
    IID_IMFCdmSuspendNotify: TGUID = '{7a5645d2-43bd-47fd-87b7-dcd24cc7d692}';
    IID_IMFHDCPStatus: TGUID = '{DE400F54-5BF1-40CF-8964-0BEA136B1E3D}';
    IID_IMFMediaEngineOPMInfo: TGUID = '{765763e6-6c01-4b01-bb0f-b829f60ed28c}';
    IID_IMFMediaEngineClassFactory: TGUID = '{4D645ACE-26AA-4688-9BE1-DF3516990B93}';
    IID_IMFMediaEngineClassFactoryEx: TGUID = '{c56156c6-ea5b-48a5-9df8-fbe035d0929e}';
    IID_IMFMediaEngineClassFactory2: TGUID = '{09083cef-867f-4bf6-8776-dee3a7b42fca}';
    IID_IMFExtendedDRMTypeSupport: TGUID = '{332EC562-3758-468D-A784-E38F23552128}';
    IID_IMFMediaEngineSupportsSourceTransfer: TGUID = '{a724b056-1b2e-4642-a6f3-db9420c52908}';
    IID_IMFTimedText: TGUID = '{1f2a94c9-a3df-430d-9d0f-acd85ddc29af}';
    IID_IMFTimedTextNotify: TGUID = '{df6b87b6-ce12-45db-aba7-432fe054e57d}';
    IID_IMFTimedTextTrack: TGUID = '{8822c32d-654e-4233-bf21-d7f2e67d30d4}';
    IID_IMFTimedTextTrackList: TGUID = '{23ff334c-442c-445f-bccc-edc438aa11e2}';
    IID_IMFTimedTextCue: TGUID = '{1e560447-9a2b-43e1-a94c-b0aaabfbfbc9}';
    IID_IMFTimedTextFormattedText: TGUID = '{e13af3c1-4d47-4354-b1f5-e83ae0ecae60}';
    IID_IMFTimedTextStyle: TGUID = '{09b2455d-b834-4f01-a347-9052e21c450e}';
    IID_IMFTimedTextRegion: TGUID = '{c8d22afc-bc47-4bdf-9b04-787e49ce3f58}';
    IID_IMFTimedTextBinary: TGUID = '{4ae3a412-0545-43c4-bf6f-6b97a5c6c432}';
    IID_IMFTimedTextCueList: TGUID = '{ad128745-211b-40a0-9981-fe65f166d0fd}';
    IID_IMFMediaEngineAudioEndpointId: TGUID = '{7a3bac98-0e76-49fb-8c20-8a86fd98eaf2}';
    IID_IMFMediaSourceExtensionLiveSeekableRange: TGUID = '{5D1ABFD6-450A-4D92-9EFC-D6B6CBC1F4DA}';
    IID_IMFMediaEngineTransferSource: TGUID = '{24230452-fe54-40cc-94f3-fcc394c340d6}';
    IID_IMFMediaEngineEMENotify: TGUID = '{9e184d15-cdb7-4f86-b49e-566689f4a601}';
    IID_IMFMediaKeySessionNotify2: TGUID = '{c3a9e92a-da88-46b0-a110-6cf953026cb9}';
    IID_IMFMediaKeySystemAccess: TGUID = '{aec63fda-7a97-4944-b35c-6c6df8085cc3}';
    IID_IMFMediaEngineClassFactory3: TGUID = '{3787614f-65f7-4003-b673-ead8293a0e60}';
    IID_IMFMediaKeys2: TGUID = '{45892507-ad66-4de2-83a2-acbb13cd8d43}';
    IID_IMFMediaKeySession2: TGUID = '{e9707e05-6d55-4636-b185-3de21210bd75}';


const
    MF_MSE_CALLBACK: TGUID = '{9063a7c0-42c5-4ffd-a8a8-6fcf9ea3d00c}';
    MF_MSE_ACTIVELIST_CALLBACK: TGUID = '{949bda0f-4549-46d5-ad7f-b846e1ab1652}';
    MF_MSE_BUFFERLIST_CALLBACK: TGUID = '{42e669b0-d60e-4afb-a85b-d8e5fe6bdab5}';
    MF_MSE_VP9_SUPPORT: TGUID = '{92d78429-d88b-4ff0-8322-803efa6e9626}';
    MF_MSE_OPUS_SUPPORT: TGUID = '{4d224cc1-8cc4-48a3-a7a7-e4c16ce6388a}';

    MF_MEDIA_ENGINE_NEEDKEY_CALLBACK: TGUID = '{7ea80843-b6e4-432c-8ea4-7848ffe4220e}';
    MF_MEDIA_ENGINE_CALLBACK: TGUID = '{c60381b8-83a4-41f8-a3d0-de05076849a9}';
    MF_MEDIA_ENGINE_DXGI_MANAGER: TGUID = '{065702da-1094-486d-8617-ee7cc4ee4648}';
    MF_MEDIA_ENGINE_EXTENSION: TGUID = '{3109fd46-060d-4b62-8dcf-faff811318d2}';
    MF_MEDIA_ENGINE_PLAYBACK_HWND: TGUID = '{d988879b-67c9-4d92-baa7-6eadd446039d}';
    MF_MEDIA_ENGINE_OPM_HWND: TGUID = '{a0be8ee7-0572-4f2c-a801-2a151bd3e726}';
    MF_MEDIA_ENGINE_PLAYBACK_VISUAL: TGUID = '{6debd26f-6ab9-4d7e-b0ee-c61a73ffad15}';
    MF_MEDIA_ENGINE_COREWINDOW: TGUID = '{fccae4dc-0b7f-41c2-9f96-4659948acddc}';
    MF_MEDIA_ENGINE_VIDEO_OUTPUT_FORMAT: TGUID = '{5066893c-8cf9-42bc-8b8a-472212e52726}';
    MF_MEDIA_ENGINE_CONTENT_PROTECTION_FLAGS: TGUID = '{e0350223-5aaf-4d76-a7c3-06de70894db4}';
    MF_MEDIA_ENGINE_CONTENT_PROTECTION_MANAGER: TGUID = '{fdd6dfaa-bd85-4af3-9e0f-a01d539d876a}';
    MF_MEDIA_ENGINE_AUDIO_ENDPOINT_ROLE: TGUID = '{d2cb93d1-116a-44f2-9385-f7d0fda2fb46}';
    MF_MEDIA_ENGINE_AUDIO_CATEGORY: TGUID = '{c8d4c51d-350e-41f2-ba46-faebbb0857f6}';
    MF_MEDIA_ENGINE_STREAM_CONTAINS_ALPHA_CHANNEL: TGUID = '{5cbfaf44-d2b2-4cfb-80a7-d429c74c789d}';
    MF_MEDIA_ENGINE_BROWSER_COMPATIBILITY_MODE: TGUID = '{4e0212e2-e18f-41e1-95e5-c0e7e9235bc3}';
    MF_MEDIA_ENGINE_BROWSER_COMPATIBILITY_MODE_IE9: TGUID = '{052c2d39-40c0-4188-ab86-f828273b7522}';
    MF_MEDIA_ENGINE_BROWSER_COMPATIBILITY_MODE_IE10: TGUID = '{11a47afd-6589-4124-b312-6158ec517fc3}';
    MF_MEDIA_ENGINE_BROWSER_COMPATIBILITY_MODE_IE11: TGUID = '{1cf1315f-ce3f-4035-9391-16142f775189}';
    MF_MEDIA_ENGINE_BROWSER_COMPATIBILITY_MODE_IE_EDGE: TGUID = '{a6f3e465-3aca-442c-a3f0-ad6ddad839ae}';
    MF_MEDIA_ENGINE_COMPATIBILITY_MODE: TGUID = '{3ef26ad4-dc54-45de-b9af-76c8c66bfa8e}';
    MF_MEDIA_ENGINE_COMPATIBILITY_MODE_WWA_EDGE: TGUID = '{15b29098-9f01-4e4d-b65a-c06c6c89da2a}';
    MF_MEDIA_ENGINE_COMPATIBILITY_MODE_WIN10: TGUID = '{5b25e089-6ca7-4139-a2cb-fcaab39552a3}';


    MF_MEDIA_ENGINE_SOURCE_RESOLVER_CONFIG_STORE: TGUID = '{0ac0c497-b3c4-48c9-9cde-bb8ca2442ca3}';
    MF_MEDIA_ENGINE_TRACK_ID: TGUID = '{65bea312-4043-4815-8eab-44dce2ef8f2a}';
    MF_MEDIA_ENGINE_TELEMETRY_APPLICATION_ID: TGUID = '{1e7b273b-a7e4-402a-8f51-c48e88a2cabc}';
    MF_MEDIA_ENGINE_SYNCHRONOUS_CLOSE: TGUID = '{c3c2e12f-7e0e-4e43-b91c-dc992ccdfa5e}';
    MF_MEDIA_ENGINE_MEDIA_PLAYER_MODE: TGUID = '{3ddd8d45-5aa1-4112-82e5-36f6a2197e6e}';

    CLSID_MFMediaEngineClassFactory: TGUID = '{b44392da-499b-446b-a4cb-005fead0e6d5}';
    MF_MEDIA_ENGINE_TIMEDTEXT: TGUID = '{805ea411-92e0-4e59-9b6e-5c7d7915e64f}';
    MF_MEDIA_ENGINE_CONTINUE_ON_CODEC_ERROR: TGUID = '{dbcdb7f9-48e4-4295-b70d-d518234eeb38}';
    MF_MEDIA_ENGINE_EME_CALLBACK: TGUID = '{494553a7-a481-4cb7-bec5-380903513731}';

    MF_EME_INITDATATYPES: TPROPERTYKEY = (fmtid: '{497d231b-4eb9-4df0-b474-b9afeb0adf38}'; pid: PID_FIRST_USABLE + $00000001);
    MF_EME_DISTINCTIVEID: TPROPERTYKEY = (fmtid: '{7dc9c4a5-12be-497e-8bff-9b60b2dc5845}'; pid: PID_FIRST_USABLE + $00000002);
    MF_EME_PERSISTEDSTATE: TPROPERTYKEY = (fmtid: '{5d4df6ae-9af1-4e3d-955b-0e4bd22fedf0}'; pid: PID_FIRST_USABLE + $00000003);
    MF_EME_AUDIOCAPABILITIES: TPROPERTYKEY = (fmtid: '{980fbb84-297d-4ea7-895f-bcf28a462881}'; pid: PID_FIRST_USABLE + $00000004);
    MF_EME_VIDEOCAPABILITIES: TPROPERTYKEY = (fmtid: '{b172f83d-30dd-4c10-8006-ed53da4d3bdb}'; pid: PID_FIRST_USABLE + $00000005);
    MF_EME_LABEL: TPROPERTYKEY = (fmtid: '{9eae270e-b2d7-4817-b88f-540099f2ef4e}'; pid: PID_FIRST_USABLE + $00000006);
    MF_EME_SESSIONTYPES: TPROPERTYKEY = (fmtid: '{7623384f-00f5-4376-8698-3458db030ed5}'; pid: PID_FIRST_USABLE + $00000007);
    MF_EME_ROBUSTNESS: TPROPERTYKEY = (fmtid: '{9d3d2b9e-7023-4944-a8f5-ecca52a46990}'; pid: PID_FIRST_USABLE + $00000001);
    MF_EME_CONTENTTYPE: TPROPERTYKEY = (fmtid: '{289fb1fc-d9c4-4cc7-b2be-972b0e9b283a}'; pid: PID_FIRST_USABLE + $00000002);
    MF_EME_CDM_INPRIVATESTOREPATH: TPROPERTYKEY = (fmtid: '{ec305fd9-039f-4ac8-98da-e7921e006a90}'; pid: PID_FIRST_USABLE + $00000001);
    MF_EME_CDM_STOREPATH: TPROPERTYKEY = (fmtid: '{f795841e-99f9-44d7-afc0-d309c04c94ab}'; pid: PID_FIRST_USABLE + $00000002);

const
    MF_INVALID_PRESENTATION_TIME = $8000000000000000;

type
    {$IFNDEF FPC}
    BSTR = POLESTR;
    PDWORDLONG = ^UINT64;
    {$ENDIF}

    TMF_MEDIA_ENGINE_ERR = (
        MF_MEDIA_ENGINE_ERR_NOERROR = 0,
        MF_MEDIA_ENGINE_ERR_ABORTED = 1,
        MF_MEDIA_ENGINE_ERR_NETWORK = 2,
        MF_MEDIA_ENGINE_ERR_DECODE = 3,
        MF_MEDIA_ENGINE_ERR_SRC_NOT_SUPPORTED = 4,
        MF_MEDIA_ENGINE_ERR_ENCRYPTED = 5
        );


    IMFMediaError = interface(IUnknown)
        ['{fc0e10d2-ab2a-4501-a951-06bb1075184c}']
        function GetErrorCode(): USHORT; stdcall;
        function GetExtendedErrorCode(): HResult; stdcall;
        function SetErrorCode(error: TMF_MEDIA_ENGINE_ERR): HResult; stdcall;
        function SetExtendedErrorCode(error: HRESULT): HResult; stdcall;
    end;


    IMFMediaTimeRange = interface(IUnknown)
        ['{db71a2fc-078a-414e-9df9-8c2531b0aa6c}']
        function GetLength(): DWORD; stdcall;
        function GetStart(index: DWORD; out pStart: double): HResult; stdcall;
        function GetEnd(index: DWORD; out pEnd: double): HResult; stdcall;
        function ContainsTime(time: double): boolean; stdcall;
        function AddRange(startTime: double; endTime: double): HResult; stdcall;
        function Clear(): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_EVENT = (
        MF_MEDIA_ENGINE_EVENT_LOADSTART = 1,
        MF_MEDIA_ENGINE_EVENT_PROGRESS = 2,
        MF_MEDIA_ENGINE_EVENT_SUSPEND = 3,
        MF_MEDIA_ENGINE_EVENT_ABORT = 4,
        MF_MEDIA_ENGINE_EVENT_ERROR = 5,
        MF_MEDIA_ENGINE_EVENT_EMPTIED = 6,
        MF_MEDIA_ENGINE_EVENT_STALLED = 7,
        MF_MEDIA_ENGINE_EVENT_PLAY = 8,
        MF_MEDIA_ENGINE_EVENT_PAUSE = 9,
        MF_MEDIA_ENGINE_EVENT_LOADEDMETADATA = 10,
        MF_MEDIA_ENGINE_EVENT_LOADEDDATA = 11,
        MF_MEDIA_ENGINE_EVENT_WAITING = 12,
        MF_MEDIA_ENGINE_EVENT_PLAYING = 13,
        MF_MEDIA_ENGINE_EVENT_CANPLAY = 14,
        MF_MEDIA_ENGINE_EVENT_CANPLAYTHROUGH = 15,
        MF_MEDIA_ENGINE_EVENT_SEEKING = 16,
        MF_MEDIA_ENGINE_EVENT_SEEKED = 17,
        MF_MEDIA_ENGINE_EVENT_TIMEUPDATE = 18,
        MF_MEDIA_ENGINE_EVENT_ENDED = 19,
        MF_MEDIA_ENGINE_EVENT_RATECHANGE = 20,
        MF_MEDIA_ENGINE_EVENT_DURATIONCHANGE = 21,
        MF_MEDIA_ENGINE_EVENT_VOLUMECHANGE = 22,
        MF_MEDIA_ENGINE_EVENT_FORMATCHANGE = 1000,
        MF_MEDIA_ENGINE_EVENT_PURGEQUEUEDEVENTS = 1001,
        MF_MEDIA_ENGINE_EVENT_TIMELINE_MARKER = 1002,
        MF_MEDIA_ENGINE_EVENT_BALANCECHANGE = 1003,
        MF_MEDIA_ENGINE_EVENT_DOWNLOADCOMPLETE = 1004,
        MF_MEDIA_ENGINE_EVENT_BUFFERINGSTARTED = 1005,
        MF_MEDIA_ENGINE_EVENT_BUFFERINGENDED = 1006,
        MF_MEDIA_ENGINE_EVENT_FRAMESTEPCOMPLETED = 1007,
        MF_MEDIA_ENGINE_EVENT_NOTIFYSTABLESTATE = 1008,
        MF_MEDIA_ENGINE_EVENT_FIRSTFRAMEREADY = 1009,
        MF_MEDIA_ENGINE_EVENT_TRACKSCHANGE = 1010,
        MF_MEDIA_ENGINE_EVENT_OPMINFO = 1011,
        MF_MEDIA_ENGINE_EVENT_RESOURCELOST = 1012,
        MF_MEDIA_ENGINE_EVENT_DELAYLOADEVENT_CHANGED = 1013,
        MF_MEDIA_ENGINE_EVENT_STREAMRENDERINGERROR = 1014,
        MF_MEDIA_ENGINE_EVENT_SUPPORTEDRATES_CHANGED = 1015,
        MF_MEDIA_ENGINE_EVENT_AUDIOENDPOINTCHANGE = 1016
        );


    IMFMediaEngineNotify = interface(IUnknown)
        ['{fee7c112-e776-42b5-9bbf-0048524e2bd5}']
        function EventNotify(event: DWORD; param1: DWORD_PTR; param2: DWORD): HResult; stdcall;

    end;


    IMFMediaEngineSrcElements = interface(IUnknown)
        ['{7a5e5354-b114-4c72-b991-3131d75032ea}']
        function GetLength(): DWORD; stdcall;
        function GetURL(index: DWORD; out pURL: BSTR): HResult; stdcall;
        function GetType(index: DWORD; out pType: BSTR): HResult; stdcall;
        function GetMedia(index: DWORD; out pMedia: BSTR): HResult; stdcall;
        function AddElement(pURL: BSTR; pType: BSTR; pMedia: BSTR): HResult; stdcall;
        function RemoveAllElements(): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_NETWORK = (
        MF_MEDIA_ENGINE_NETWORK_EMPTY = 0,
        MF_MEDIA_ENGINE_NETWORK_IDLE = 1,
        MF_MEDIA_ENGINE_NETWORK_LOADING = 2,
        MF_MEDIA_ENGINE_NETWORK_NO_SOURCE = 3);

    TMF_MEDIA_ENGINE_READY = (
        MF_MEDIA_ENGINE_READY_HAVE_NOTHING = 0,
        MF_MEDIA_ENGINE_READY_HAVE_METADATA = 1,
        MF_MEDIA_ENGINE_READY_HAVE_CURRENT_DATA = 2,
        MF_MEDIA_ENGINE_READY_HAVE_FUTURE_DATA = 3,
        MF_MEDIA_ENGINE_READY_HAVE_ENOUGH_DATA = 4
        );

    TMF_MEDIA_ENGINE_CANPLAY = (
        MF_MEDIA_ENGINE_CANPLAY_NOT_SUPPORTED = 0,
        MF_MEDIA_ENGINE_CANPLAY_MAYBE = 1,
        MF_MEDIA_ENGINE_CANPLAY_PROBABLY = 2
        );

    TMF_MEDIA_ENGINE_PRELOAD = (
        MF_MEDIA_ENGINE_PRELOAD_MISSING = 0,
        MF_MEDIA_ENGINE_PRELOAD_EMPTY = 1,
        MF_MEDIA_ENGINE_PRELOAD_NONE = 2,
        MF_MEDIA_ENGINE_PRELOAD_METADATA = 3,
        MF_MEDIA_ENGINE_PRELOAD_AUTOMATIC = 4
        );

    TMFVideoNormalizedRect = record
        left: single;
        top: single;
        right: single;
        bottom: single;
    end;


    IMFMediaEngine = interface(IUnknown)
        ['{98a1b0bb-03eb-4935-ae7c-93c1fa0e1c93}']
        function GetError(out ppError: IMFMediaError): HResult; stdcall;
        function SetErrorCode(error: TMF_MEDIA_ENGINE_ERR): HResult; stdcall;
        function SetSourceElements(pSrcElements: IMFMediaEngineSrcElements): HResult; stdcall;
        function SetSource(pUrl: BSTR): HResult; stdcall;
        function GetCurrentSource(out ppUrl: BSTR): HResult; stdcall;
        function GetNetworkState(): USHORT; stdcall;
        function GetPreload(): TMF_MEDIA_ENGINE_PRELOAD; stdcall;
        function SetPreload(Preload: TMF_MEDIA_ENGINE_PRELOAD): HResult; stdcall;
        function GetBuffered(out ppBuffered: IMFMediaTimeRange): HResult; stdcall;
        function Load(): HResult; stdcall;
        function CanPlayType(_type: BSTR; out pAnswer: TMF_MEDIA_ENGINE_CANPLAY): HResult; stdcall;
        function GetReadyState(): USHORT; stdcall;
        function IsSeeking(): boolean; stdcall;
        function GetCurrentTime(): double; stdcall;
        function SetCurrentTime(seekTime: double): HResult; stdcall;
        function GetStartTime(): double; stdcall;
        function GetDuration(): double; stdcall;
        function IsPaused(): boolean; stdcall;
        function GetDefaultPlaybackRate(): double; stdcall;
        function SetDefaultPlaybackRate(Rate: double): HResult; stdcall;
        function GetPlaybackRate(): double; stdcall;
        function SetPlaybackRate(Rate: double): HResult; stdcall;
        function GetPlayed(out ppPlayed: IMFMediaTimeRange): HResult; stdcall;
        function GetSeekable(out ppSeekable: IMFMediaTimeRange): HResult; stdcall;
        function IsEnded(): boolean; stdcall;
        function GetAutoPlay(): boolean; stdcall;
        function SetAutoPlay(AutoPlay: boolean): HResult; stdcall;
        function GetLoop(): boolean; stdcall;
        function SetLoop(Loop: boolean): HResult; stdcall;
        function Play(): HResult; stdcall;
        function Pause(): HResult; stdcall;
        function GetMuted(): boolean; stdcall;
        function SetMuted(Muted: boolean): HResult; stdcall;
        function GetVolume(): double; stdcall;
        function SetVolume(Volume: double): HResult; stdcall;
        function HasVideo(): boolean; stdcall;
        function HasAudio(): boolean; stdcall;
        function GetNativeVideoSize(out cx: DWORD; out cy: DWORD): HResult; stdcall;
        function GetVideoAspectRatio(out cx: DWORD; out cy: DWORD): HResult; stdcall;
        function Shutdown(): HResult; stdcall;
        function TransferVideoFrame(pDstSurf: IUnknown; const pSrc: TMFVideoNormalizedRect; const pDst: TRECT;
            const pBorderClr: TMFARGB): HResult; stdcall;
        function OnVideoStreamTick(out pPts: LONGLONG): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_S3D_PACKING_MODE = (
        MF_MEDIA_ENGINE_S3D_PACKING_MODE_NONE = 0,
        MF_MEDIA_ENGINE_S3D_PACKING_MODE_SIDE_BY_SIDE = 1,
        MF_MEDIA_ENGINE_S3D_PACKING_MODE_TOP_BOTTOM = 2
        );

    TMF_MEDIA_ENGINE_STATISTIC = (
        MF_MEDIA_ENGINE_STATISTIC_FRAMES_RENDERED = 0,
        MF_MEDIA_ENGINE_STATISTIC_FRAMES_DROPPED = 1,
        MF_MEDIA_ENGINE_STATISTIC_BYTES_DOWNLOADED = 2,
        MF_MEDIA_ENGINE_STATISTIC_BUFFER_PROGRESS = 3,
        MF_MEDIA_ENGINE_STATISTIC_FRAMES_PER_SECOND = 4,
        MF_MEDIA_ENGINE_STATISTIC_PLAYBACK_JITTER = 5,
        MF_MEDIA_ENGINE_STATISTIC_FRAMES_CORRUPTED = 6,
        MF_MEDIA_ENGINE_STATISTIC_TOTAL_FRAME_DELAY = 7
        );

    TMF_MEDIA_ENGINE_SEEK_MODE = (
        MF_MEDIA_ENGINE_SEEK_MODE_NORMAL = 0,
        MF_MEDIA_ENGINE_SEEK_MODE_APPROXIMATE = 1
        );


    IMFMediaEngineEx = interface(IMFMediaEngine)
        ['{83015ead-b1e6-40d0-a98a-37145ffe1ad1}']
        function SetSourceFromByteStream(pByteStream: IMFByteStream; pURL: BSTR): HResult; stdcall;
        function GetStatistics(StatisticID: TMF_MEDIA_ENGINE_STATISTIC; out pStatistic: TPROPVARIANT): HResult; stdcall;
        function UpdateVideoStream(const pSrc: TMFVideoNormalizedRect; const pDst: TRECT; const pBorderClr: TMFARGB): HResult; stdcall;
        function GetBalance(): double; stdcall;
        function SetBalance(balance: double): HResult; stdcall;
        function IsPlaybackRateSupported(rate: double): boolean; stdcall;
        function FrameStep(_Forward: boolean): HResult; stdcall;
        function GetResourceCharacteristics(out pCharacteristics: DWORD): HResult; stdcall;
        function GetPresentationAttribute(const guidMFAttribute: TGUID; out pvValue: TPROPVARIANT): HResult; stdcall;
        function GetNumberOfStreams(out pdwStreamCount: DWORD): HResult; stdcall;
        function GetStreamAttribute(dwStreamIndex: DWORD; const guidMFAttribute: TGUID; out pvValue: TPROPVARIANT): HResult; stdcall;
        function GetStreamSelection(dwStreamIndex: DWORD; out pEnabled: boolean): HResult; stdcall;
        function SetStreamSelection(dwStreamIndex: DWORD; Enabled: boolean): HResult; stdcall;
        function ApplyStreamSelections(): HResult; stdcall;
        function IsProtected(out pProtected: boolean): HResult; stdcall;
        function InsertVideoEffect(pEffect: IUnknown; fOptional: boolean): HResult; stdcall;
        function InsertAudioEffect(pEffect: IUnknown; fOptional: boolean): HResult; stdcall;
        function RemoveAllEffects(): HResult; stdcall;
        function SetTimelineMarkerTimer(timeToFire: double): HResult; stdcall;
        function GetTimelineMarkerTimer(out pTimeToFire: double): HResult; stdcall;
        function CancelTimelineMarkerTimer(): HResult; stdcall;
        function IsStereo3D(): boolean; stdcall;
        function GetStereo3DFramePackingMode(out packMode: TMF_MEDIA_ENGINE_S3D_PACKING_MODE): HResult; stdcall;
        function SetStereo3DFramePackingMode(packMode: TMF_MEDIA_ENGINE_S3D_PACKING_MODE): HResult; stdcall;
        function GetStereo3DRenderMode(out outputType: TMF3DVideoOutputType): HResult; stdcall;
        function SetStereo3DRenderMode(outputType: TMF3DVideoOutputType): HResult; stdcall;
        function EnableWindowlessSwapchainMode(fEnable: boolean): HResult; stdcall;
        function GetVideoSwapchainHandle(out phSwapchain: THANDLE): HResult; stdcall;
        function EnableHorizontalMirrorMode(fEnable: boolean): HResult; stdcall;
        function GetAudioStreamCategory(out pCategory: UINT32): HResult; stdcall;
        function SetAudioStreamCategory(category: UINT32): HResult; stdcall;
        function GetAudioEndpointRole(out pRole: UINT32): HResult; stdcall;
        function SetAudioEndpointRole(role: UINT32): HResult; stdcall;
        function GetRealTimeMode(out pfEnabled: boolean): HResult; stdcall;
        function SetRealTimeMode(fEnable: boolean): HResult; stdcall;
        function SetCurrentTimeEx(seekTime: double; seekMode: TMF_MEDIA_ENGINE_SEEK_MODE): HResult; stdcall;
        function EnableTimeUpdateTimer(fEnableTimer: boolean): HResult; stdcall;
    end;

    IMFMediaEngineAudioEndpointId = interface(IUnknown)
        ['{7a3bac98-0e76-49fb-8c20-8a86fd98eaf2}']
        function SetAudioEndpointId(pszEndpointId: LPCWSTR): HResult; stdcall;
        function GetAudioEndpointId(out ppszEndpointId: LPWSTR): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_EXTENSION_TYPE = (
        MF_MEDIA_ENGINE_EXTENSION_TYPE_MEDIASOURCE = 0,
        MF_MEDIA_ENGINE_EXTENSION_TYPE_BYTESTREAM = 1
        );


    IMFMediaEngineExtension = interface(IUnknown)
        ['{2f69d622-20b5-41e9-afdf-89ced1dda04e}']
        function CanPlayType(AudioOnly: boolean; MimeType: BSTR; out pAnswer: TMF_MEDIA_ENGINE_CANPLAY): HResult; stdcall;
        function BeginCreateObject(bstrURL: BSTR; pByteStream: IMFByteStream; _type: TMF_OBJECT_TYPE;
            out ppIUnknownCancelCookie: IUnknown; pCallback: IMFAsyncCallback; punkState: IUnknown): HResult; stdcall;
        function CancelObjectCreation(pIUnknownCancelCookie: IUnknown): HResult; stdcall;
        function EndCreateObject(pResult: IMFAsyncResult; out ppObject: IUnknown): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_FRAME_PROTECTION_FLAGS = (
        MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_PROTECTED = $1,
        MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_SURFACE_PROTECTION = $2,
        MF_MEDIA_ENGINE_FRAME_PROTECTION_FLAG_REQUIRES_ANTI_SCREEN_SCRAPE_PROTECTION = $4
        );


    IMFMediaEngineProtectedContent = interface(IUnknown)
        ['{9f8021e8-9c8c-487e-bb5c-79aa4779938c}']
        function ShareResources(pUnkDeviceContext: IUnknown): HResult; stdcall;
        function GetRequiredProtections(out pFrameProtectionFlags: DWORD): HResult; stdcall;
        function SetOPMWindow(hwnd: HWND): HResult; stdcall;
        function TransferVideoFrame(pDstSurf: IUnknown; const pSrc: TMFVideoNormalizedRect; const pDst: TRECT;
            const pBorderClr: TMFARGB; out pFrameProtectionFlags: DWORD): HResult; stdcall;
        function SetContentProtectionManager(pCPM: IMFContentProtectionManager): HResult; stdcall;
        function SetApplicationCertificate(const pbBlob: PBYTE; cbBlob: DWORD): HResult; stdcall;
    end;

    IAudioSourceProvider = interface(IUnknown)
        ['{EBBAF249-AFC2-4582-91C6-B60DF2E84954}']
        function ProvideInput(dwSampleCount: DWORD; var pdwChannelCount: DWORD;
            out pInterleavedAudioData {arraysize: dwSampleCount * pdwChannelCount}: PSingle): HResult; stdcall;
    end;

    IMFMediaEngineWebSupport = interface(IUnknown)
        ['{ba2743a1-07e0-48ef-84b6-9a2ed023ca6c}']
        function ShouldDelayTheLoadEvent(): boolean; stdcall;
        function ConnectWebAudio(dwSampleRate: DWORD; out ppSourceProvider: IAudioSourceProvider): HResult; stdcall;
        function DisconnectWebAudio(): HResult; stdcall;
    end;

    TMF_MSE_VP9_SUPPORT_TYPE = (
        MF_MSE_VP9_SUPPORT_DEFAULT = 0,
        MF_MSE_VP9_SUPPORT_ON = 1,
        MF_MSE_VP9_SUPPORT_OFF = 2
        );

    TMF_MSE_OPUS_SUPPORT_TYPE = (
        MF_MSE_OPUS_SUPPORT_ON = 0,
        MF_MSE_OPUS_SUPPORT_OFF = 1
        );


    IMFMediaSourceExtensionNotify = interface(IUnknown)
        ['{a7901327-05dd-4469-a7b7-0e01979e361d}']
        procedure OnSourceOpen(); stdcall;
        procedure OnSourceEnded(); stdcall;
        procedure OnSourceClose(); stdcall;
    end;


    IMFSourceBufferNotify = interface(IUnknown)
        ['{87e47623-2ceb-45d6-9b88-d8520c4dcbbc}']
        procedure OnUpdateStart(); stdcall;
        procedure OnAbort(); stdcall;
        procedure OnError(hr: HRESULT); stdcall;
        procedure OnUpdate(); stdcall;
        procedure OnUpdateEnd(); stdcall;
    end;

    IMFBufferListNotify = interface(IUnknown)
        ['{24cd47f7-81d8-4785-adb2-af697a963cd2}']
        procedure OnAddSourceBuffer(); stdcall;
        procedure OnRemoveSourceBuffer(); stdcall;
    end;


    IMFSourceBuffer = interface(IUnknown)
        ['{e2cd3a4b-af25-4d3d-9110-da0e6f8ee877}']
        function GetUpdating(): boolean; stdcall;
        function GetBuffered(out ppBuffered: IMFMediaTimeRange): HResult; stdcall;
        function GetTimeStampOffset(): double; stdcall;
        function SetTimeStampOffset(offset: double): HResult; stdcall;
        function GetAppendWindowStart(): double; stdcall;
        function SetAppendWindowStart(time: double): HResult; stdcall;
        function GetAppendWindowEnd(): double; stdcall;
        function SetAppendWindowEnd(time: double): HResult; stdcall;
        function Append(const pData: PBYTE; len: DWORD): HResult; stdcall;
        function AppendByteStream(pStream: IMFByteStream; pMaxLen: PDWORDLONG): HResult; stdcall;
        function Abort(): HResult; stdcall;
        function Remove(start: double; ende: double): HResult; stdcall;
    end;


    TMF_MSE_APPEND_MODE = (
        MF_MSE_APPEND_MODE_SEGMENTS = 0,
        MF_MSE_APPEND_MODE_SEQUENCE = 1
        );


    IMFSourceBufferAppendMode = interface(IUnknown)
        ['{19666fb4-babe-4c55-bc03-0a074da37e2a}']
        function GetAppendMode(): TMF_MSE_APPEND_MODE; stdcall;
        function SetAppendMode(mode: TMF_MSE_APPEND_MODE): HResult; stdcall;
    end;


    IMFSourceBufferList = interface(IUnknown)
        ['{249981f8-8325-41f3-b80c-3b9e3aad0cbe}']
        function GetLength(): DWORD; stdcall;
        function GetSourceBuffer(index: DWORD): IMFSourceBuffer; stdcall;
    end;


    TMF_MSE_READY = (
        MF_MSE_READY_CLOSED = 1,
        MF_MSE_READY_OPEN = 2,
        MF_MSE_READY_ENDED = 3
        );

    TMF_MSE_ERROR = (
        MF_MSE_ERROR_NOERROR = 0,
        MF_MSE_ERROR_NETWORK = 1,
        MF_MSE_ERROR_DECODE = 2,
        MF_MSE_ERROR_UNKNOWN_ERROR = 3
        );


    IMFMediaSourceExtension = interface(IUnknown)
        ['{e467b94e-a713-4562-a802-816a42e9008a}']
        function GetSourceBuffers(): IMFSourceBufferList; stdcall;
        function GetActiveSourceBuffers(): IMFSourceBufferList; stdcall;
        function GetReadyState(): TMF_MSE_READY; stdcall;
        function GetDuration(): double; stdcall;
        function SetDuration(duration: double): HResult; stdcall;
        function AddSourceBuffer(_type: BSTR; pNotify: IMFSourceBufferNotify; out ppSourceBuffer: IMFSourceBuffer): HResult; stdcall;
        function RemoveSourceBuffer(pSourceBuffer: IMFSourceBuffer): HResult; stdcall;
        function SetEndOfStream(error: TMF_MSE_ERROR): HResult; stdcall;
        function IsTypeSupported(_type: BSTR): boolean; stdcall;
        function GetSourceBuffer(dwStreamIndex: DWORD): IMFSourceBuffer; stdcall;
    end;

    IMFMediaSourceExtensionLiveSeekableRange = interface(IUnknown)
        ['{5D1ABFD6-450A-4D92-9EFC-D6B6CBC1F4DA}']
        function SetLiveSeekableRange(start: double; _end: double): HResult; stdcall;
        function ClearLiveSeekableRange(): HResult; stdcall;
    end;


    IMFMediaKeys = interface;

    IMFMediaEngineEME = interface(IUnknown)
        ['{50dc93e4-ba4f-4275-ae66-83e836e57469}']
        function get_Keys(out keys: IMFMediaKeys): HResult; stdcall;
        function SetMediaKeys(keys: IMFMediaKeys): HResult; stdcall;
    end;


    IMFMediaEngineSrcElementsEx = interface(IMFMediaEngineSrcElements)
        ['{654a6bb3-e1a3-424a-9908-53a43a0dfda0}']
        function AddElementEx(pURL: BSTR; pType: BSTR; pMedia: BSTR; keySystem: BSTR): HResult; stdcall;
        function GetKeySystem(index: DWORD; out pType: BSTR): HResult; stdcall;
    end;

    IMFMediaEngineNeedKeyNotify = interface(IUnknown)
        ['{46a30204-a696-4b18-8804-246b8f031bb1}']
        procedure NeedKey(const initData: PBYTE; cb: DWORD); stdcall;
    end;


    IMFMediaKeySessionNotify = interface;
    IMFCdmSuspendNotify = interface;
    IMFMediaKeySession = interface;

    IMFMediaKeys = interface(IUnknown)
        ['{5cb31c05-61ff-418f-afda-caaf41421a38}']
        function CreateSession(mimeType: BSTR; const initData: PBYTE; cb: DWORD; const customData: PBYTE;
            cbCustomData: DWORD; notify: IMFMediaKeySessionNotify; out ppSession: IMFMediaKeySession): HResult; stdcall;
        function get_KeySystem(out keySystem: BSTR): HResult; stdcall;
        function Shutdown(): HResult; stdcall;
        function GetSuspendNotify(out notify: IMFCdmSuspendNotify): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_KEYERR = (
        MF_MEDIAENGINE_KEYERR_UNKNOWN = 1,
        MF_MEDIAENGINE_KEYERR_CLIENT = 2,
        MF_MEDIAENGINE_KEYERR_SERVICE = 3,
        MF_MEDIAENGINE_KEYERR_OUTPUT = 4,
        MF_MEDIAENGINE_KEYERR_HARDWARECHANGE = 5,
        MF_MEDIAENGINE_KEYERR_DOMAIN = 6
        );


    IMFMediaKeySession = interface(IUnknown)
        ['{24fa67d5-d1d0-4dc5-995c-c0efdc191fb5}']
        function GetError(out code: USHORT; out systemCode: DWORD): HResult; stdcall;
        function get_KeySystem(out keySystem: BSTR): HResult; stdcall;
        function get_SessionId(out sessionId: BSTR): HResult; stdcall;
        function Update(const key: PBYTE; cb: DWORD): HResult; stdcall;
        function Close(): HResult; stdcall;
    end;


    IMFMediaKeySessionNotify = interface(IUnknown)
        ['{6a0083f9-8947-4c1d-9ce0-cdee22b23135}']
        procedure KeyMessage(destinationURL: BSTR; const _message: PBYTE; cb: DWORD); stdcall;
        procedure KeyAdded(); stdcall;
        procedure KeyError(code: USHORT; systemCode: DWORD); stdcall;
    end;


    IMFCdmSuspendNotify = interface(IUnknown)
        ['{7a5645d2-43bd-47fd-87b7-dcd24cc7d692}']
        function _Begin(): HResult; stdcall;
        function _End(): HResult; stdcall;
    end;


    TMF_HDCP_STATUS = (
        MF_HDCP_STATUS_ON = 0,
        MF_HDCP_STATUS_OFF = 1,
        MF_HDCP_STATUS_ON_WITH_TYPE_ENFORCEMENT = 2
        );


    IMFHDCPStatus = interface(IUnknown)
        ['{DE400F54-5BF1-40CF-8964-0BEA136B1E3D}']
        function Query(var pStatus: TMF_HDCP_STATUS; var pfStatus: boolean): HResult; stdcall;
        function _Set(status: TMF_HDCP_STATUS): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_OPM_STATUS = (
        MF_MEDIA_ENGINE_OPM_NOT_REQUESTED = 0,
        MF_MEDIA_ENGINE_OPM_ESTABLISHED = 1,
        MF_MEDIA_ENGINE_OPM_FAILED_VM = 2,
        MF_MEDIA_ENGINE_OPM_FAILED_BDA = 3,
        MF_MEDIA_ENGINE_OPM_FAILED_UNSIGNED_DRIVER = 4,
        MF_MEDIA_ENGINE_OPM_FAILED = 5);


    IMFMediaEngineOPMInfo = interface(IUnknown)
        ['{765763e6-6c01-4b01-bb0f-b829f60ed28c}']
        function GetOPMInfo(out pStatus: TMF_MEDIA_ENGINE_OPM_STATUS; out pConstricted: boolean): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_CREATEFLAGS = (
        MF_MEDIA_ENGINE_AUDIOONLY = $1,
        MF_MEDIA_ENGINE_WAITFORSTABLE_STATE = $2,
        MF_MEDIA_ENGINE_FORCEMUTE = $4,
        MF_MEDIA_ENGINE_REAL_TIME_MODE = $8,
        MF_MEDIA_ENGINE_DISABLE_LOCAL_PLUGINS = $10,
        MF_MEDIA_ENGINE_CREATEFLAGS_MASK = $1f
        );

    TMF_MEDIA_ENGINE_PROTECTION_FLAGS = (
        MF_MEDIA_ENGINE_ENABLE_PROTECTED_CONTENT = 1,
        MF_MEDIA_ENGINE_USE_PMP_FOR_ALL_CONTENT = 2,
        MF_MEDIA_ENGINE_USE_UNPROTECTED_PMP = 4
        );


    IMFMediaEngineClassFactory = interface(IUnknown)
        ['{4D645ACE-26AA-4688-9BE1-DF3516990B93}']
        function CreateInstance(dwFlags: DWORD; pAttr: IMFAttributes; out ppPlayer: IMFMediaEngine): HResult; stdcall;
        function CreateTimeRange(out ppTimeRange: IMFMediaTimeRange): HResult; stdcall;
        function CreateError(out ppError: IMFMediaError): HResult; stdcall;
    end;

    IMFMediaEngineClassFactoryEx = interface(IMFMediaEngineClassFactory)
        ['{c56156c6-ea5b-48a5-9df8-fbe035d0929e}']
        function CreateMediaSourceExtension(dwFlags: DWORD; pAttr: IMFAttributes; out ppMSE: IMFMediaSourceExtension): HResult; stdcall;
        function CreateMediaKeys(keySystem: BSTR; cdmStorePath: BSTR; out ppKeys: IMFMediaKeys): HResult; stdcall;
        function IsTypeSupported(_type: BSTR; keySystem: BSTR; out isSupported: boolean): HResult; stdcall;
    end;


    IMFMediaEngineClassFactory2 = interface(IUnknown)
        ['{09083cef-867f-4bf6-8776-dee3a7b42fca}']
        function CreateMediaKeys2(keySystem: BSTR; defaultCdmStorePath: BSTR; inprivateCdmStorePath: BSTR;
            out ppKeys: IMFMediaKeys): HResult; stdcall;
    end;




    IMFMediaEngineSupportsSourceTransfer = interface(IUnknown)
        ['{a724b056-1b2e-4642-a6f3-db9420c52908}']
        function ShouldTransferSource(out pfShouldTransfer: boolean): HResult; stdcall;
        function DetachMediaSource(out ppByteStream: IMFByteStream; out ppMediaSource: IMFMediaSource;
            out ppMSE: IMFMediaSourceExtension): HResult; stdcall;
        function AttachMediaSource(pByteStream: IMFByteStream; pMediaSource: IMFMediaSource;
            pMSE: IMFMediaSourceExtension): HResult; stdcall;
    end;


    IMFExtendedDRMTypeSupport = interface(IUnknown)
        ['{332EC562-3758-468D-A784-E38F23552128}']
        function IsTypeSupportedEx(_type: BSTR; keySystem: BSTR; out pAnswer: TMF_MEDIA_ENGINE_CANPLAY): HResult; stdcall;
    end;

    IMFMediaEngineTransferSource = interface(IUnknown)
        ['{24230452-fe54-40cc-94f3-fcc394c340d6}']
        function TransferSourceToMediaEngine(destination: IMFMediaEngine): HResult; stdcall;
    end;


    TMF_TIMED_TEXT_TRACK_KIND = (
        MF_TIMED_TEXT_TRACK_KIND_UNKNOWN = 0,
        MF_TIMED_TEXT_TRACK_KIND_SUBTITLES = 1,
        MF_TIMED_TEXT_TRACK_KIND_CAPTIONS = 2,
        MF_TIMED_TEXT_TRACK_KIND_METADATA = 3
        );

    TMF_TIMED_TEXT_UNIT_TYPE = (
        MF_TIMED_TEXT_UNIT_TYPE_PIXELS = 0,
        MF_TIMED_TEXT_UNIT_TYPE_PERCENTAGE = 1
        );

    TMF_TIMED_TEXT_FONT_STYLE = (
        MF_TIMED_TEXT_FONT_STYLE_NORMAL = 0,
        MF_TIMED_TEXT_FONT_STYLE_OBLIQUE = 1,
        MF_TIMED_TEXT_FONT_STYLE_ITALIC = 2
        );

    TMF_TIMED_TEXT_ALIGNMENT = (
        MF_TIMED_TEXT_ALIGNMENT_START = 0,
        MF_TIMED_TEXT_ALIGNMENT_END = 1,
        MF_TIMED_TEXT_ALIGNMENT_CENTER = 2
        );

    TMF_TIMED_TEXT_DISPLAY_ALIGNMENT = (
        MF_TIMED_TEXT_DISPLAY_ALIGNMENT_BEFORE = 0,
        MF_TIMED_TEXT_DISPLAY_ALIGNMENT_AFTER = 1,
        MF_TIMED_TEXT_DISPLAY_ALIGNMENT_CENTER = 2
        );

    TMF_TIMED_TEXT_DECORATION = (
        MF_TIMED_TEXT_DECORATION_NONE = 0,
        MF_TIMED_TEXT_DECORATION_UNDERLINE = 1,
        MF_TIMED_TEXT_DECORATION_LINE_THROUGH = 2,
        MF_TIMED_TEXT_DECORATION_OVERLINE = 4
        );

    TMF_TIMED_TEXT_WRITING_MODE = (
        MF_TIMED_TEXT_WRITING_MODE_LRTB = 0,
        MF_TIMED_TEXT_WRITING_MODE_RLTB = 1,
        MF_TIMED_TEXT_WRITING_MODE_TBRL = 2,
        MF_TIMED_TEXT_WRITING_MODE_TBLR = 3,
        MF_TIMED_TEXT_WRITING_MODE_LR = 4,
        MF_TIMED_TEXT_WRITING_MODE_RL = 5,
        MF_TIMED_TEXT_WRITING_MODE_TB = 6
        );

    TMF_TIMED_TEXT_SCROLL_MODE = (
        MF_TIMED_TEXT_SCROLL_MODE_POP_ON = 0,
        MF_TIMED_TEXT_SCROLL_MODE_ROLL_UP = 1
        );

    TMF_TIMED_TEXT_ERROR_CODE = (
        MF_TIMED_TEXT_ERROR_CODE_NOERROR = 0,
        MF_TIMED_TEXT_ERROR_CODE_FATAL = 1,
        MF_TIMED_TEXT_ERROR_CODE_DATA_FORMAT = 2,
        MF_TIMED_TEXT_ERROR_CODE_NETWORK = 3,
        MF_TIMED_TEXT_ERROR_CODE_INTERNAL = 4
        );

    TMF_TIMED_TEXT_CUE_EVENT = (
        MF_TIMED_TEXT_CUE_EVENT_ACTIVE = 0,
        MF_TIMED_TEXT_CUE_EVENT_INACTIVE = (MF_TIMED_TEXT_CUE_EVENT_ACTIVE + 1),
        MF_TIMED_TEXT_CUE_EVENT_CLEAR = (MF_TIMED_TEXT_CUE_EVENT_INACTIVE + 1)
        );

    TMF_TIMED_TEXT_TRACK_READY_STATE = (
        MF_TIMED_TEXT_TRACK_READY_STATE_NONE = 0,
        MF_TIMED_TEXT_TRACK_READY_STATE_LOADING = (MF_TIMED_TEXT_TRACK_READY_STATE_NONE + 1),
        MF_TIMED_TEXT_TRACK_READY_STATE_LOADED = (MF_TIMED_TEXT_TRACK_READY_STATE_LOADING + 1),
        MF_TIMED_TEXT_TRACK_READY_STATE_ERROR = (MF_TIMED_TEXT_TRACK_READY_STATE_LOADED + 1));


    IMFTimedTextNotify = interface;
    IMFTimedTextTrack = interface;
    IMFTimedTextTrackList = interface;
    IMFTimedTextCue = interface;
    IMFTimedTextCueList = interface;
    IMFTimedTextBinary = interface;
    IMFTimedTextRegion = interface;
    IMFTimedTextStyle = interface;
    IMFTimedTextFormattedText = interface;

    IMFTimedText = interface(IUnknown)
        ['{1f2a94c9-a3df-430d-9d0f-acd85ddc29af}']
        function RegisterNotifications(notify: IMFTimedTextNotify): HResult; stdcall;
        function SelectTrack(trackId: DWORD; selected: boolean): HResult; stdcall;
        function AddDataSource(byteStream: IMFByteStream; _label: LPCWSTR; language: LPCWSTR; kind: TMF_TIMED_TEXT_TRACK_KIND;
            isDefault: boolean; out trackId: DWORD): HResult; stdcall;
        function AddDataSourceFromUrl(url: LPCWSTR; _label: LPCWSTR; language: LPCWSTR; kind: TMF_TIMED_TEXT_TRACK_KIND;
            isDefault: boolean; out trackId: DWORD): HResult; stdcall;
        function AddTrack(_label: LPCWSTR; language: LPCWSTR; kind: TMF_TIMED_TEXT_TRACK_KIND;
            out track: IMFTimedTextTrack): HResult; stdcall;
        function RemoveTrack(track: IMFTimedTextTrack): HResult; stdcall;
        function GetCueTimeOffset(out offset: double): HResult; stdcall;
        function SetCueTimeOffset(offset: double): HResult; stdcall;
        function GetTracks(out tracks: IMFTimedTextTrackList): HResult; stdcall;
        function GetActiveTracks(out activeTracks: IMFTimedTextTrackList): HResult; stdcall;
        function GetTextTracks(out textTracks: IMFTimedTextTrackList): HResult; stdcall;
        function GetMetadataTracks(out metadataTracks: IMFTimedTextTrackList): HResult; stdcall;
        function SetInBandEnabled(Enabled: boolean): HResult; stdcall;
        function IsInBandEnabled(): boolean; stdcall;
    end;

    IMFTimedTextNotify = interface(IUnknown)
        ['{df6b87b6-ce12-45db-aba7-432fe054e57d}']
        procedure TrackAdded(trackId: DWORD); stdcall;
        procedure TrackRemoved(trackId: DWORD); stdcall;
        procedure TrackSelected(trackId: DWORD; selected: boolean); stdcall;
        procedure TrackReadyStateChanged(trackId: DWORD); stdcall;
        procedure Error(errorCode: TMF_TIMED_TEXT_ERROR_CODE; extendedErrorCode: HRESULT; sourceTrackId: DWORD); stdcall;
        procedure Cue(cueEvent: TMF_TIMED_TEXT_CUE_EVENT; currentTime: double; cue: IMFTimedTextCue); stdcall;
        procedure Reset(); stdcall;
    end;


    IMFTimedTextTrack = interface(IUnknown)
        ['{8822c32d-654e-4233-bf21-d7f2e67d30d4}']
        function GetId(): DWORD; stdcall;
        function GetLabel(out _label: LPWSTR): HResult; stdcall;
        function SetLabel(_label: LPCWSTR): HResult; stdcall;
        function GetLanguage(out language: LPWSTR): HResult; stdcall;
        function GetTrackKind(): TMF_TIMED_TEXT_TRACK_KIND; stdcall;
        function IsInBand(): boolean; stdcall;
        function GetInBandMetadataTrackDispatchType(out dispatchType: LPWSTR): HResult; stdcall;
        function IsActive(): boolean; stdcall;
        function GetErrorCode(): TMF_TIMED_TEXT_ERROR_CODE; stdcall;
        function GetExtendedErrorCode(): HResult; stdcall;
        function GetDataFormat(out format: TGUID): HResult; stdcall;
        function GetReadyState(): TMF_TIMED_TEXT_TRACK_READY_STATE; stdcall;
        function GetCueList(out cues: IMFTimedTextCueList): HResult; stdcall;
    end;


    IMFTimedTextTrackList = interface(IUnknown)
        ['{23ff334c-442c-445f-bccc-edc438aa11e2}']
        function GetLength(): DWORD; stdcall;
        function GetTrack(index: DWORD; out track: IMFTimedTextTrack): HResult; stdcall;
        function GetTrackById(trackId: DWORD; out track: IMFTimedTextTrack): HResult; stdcall;
    end;

    IMFTimedTextCue = interface(IUnknown)
        ['{1e560447-9a2b-43e1-a94c-b0aaabfbfbc9}']
        function GetId(): DWORD; stdcall;
        function GetOriginalId(out originalId: LPWSTR): HResult; stdcall;
        function GetCueKind(): TMF_TIMED_TEXT_TRACK_KIND; stdcall;
        function GetStartTime(): double; stdcall;
        function GetDuration(): double; stdcall;
        function GetTrackId(): DWORD; stdcall;
        function GetData(out Data: IMFTimedTextBinary): HResult; stdcall;
        function GetRegion(out region: IMFTimedTextRegion): HResult; stdcall;
        function GetStyle(out style: IMFTimedTextStyle): HResult; stdcall;
        function GetLineCount(): DWORD; stdcall;
        function GetLine(index: DWORD; out line: IMFTimedTextFormattedText): HResult; stdcall;
    end;


    IMFTimedTextFormattedText = interface(IUnknown)
        ['{e13af3c1-4d47-4354-b1f5-e83ae0ecae60}']
        function GetText(out Text: LPWSTR): HResult; stdcall;
        function GetSubformattingCount(): DWORD; stdcall;
        function GetSubformatting(index: DWORD; out firstChar: DWORD; out charLength: DWORD;
            out style: IMFTimedTextStyle): HResult; stdcall;
    end;


    IMFTimedTextStyle = interface(IUnknown)
        ['{09b2455d-b834-4f01-a347-9052e21c450e}']
        function GetName(out Name: LPWSTR): HResult; stdcall;
        function IsExternal(): boolean; stdcall;
        function GetFontFamily(out fontFamily: LPWSTR): HResult; stdcall;
        function GetFontSize(out fontSize: double; out unitType: TMF_TIMED_TEXT_UNIT_TYPE): HResult; stdcall;
        function GetColor(out color: TMFARGB): HResult; stdcall;
        function GetBackgroundColor(out bgColor: TMFARGB): HResult; stdcall;
        function GetShowBackgroundAlways(out showBackgroundAlways: boolean): HResult; stdcall;
        function GetFontStyle(out fontStyle: TMF_TIMED_TEXT_FONT_STYLE): HResult; stdcall;
        function GetBold(out bold: boolean): HResult; stdcall;
        function GetRightToLeft(out rightToLeft: boolean): HResult; stdcall;
        function GetTextAlignment(out textAlign: TMF_TIMED_TEXT_ALIGNMENT): HResult; stdcall;
        function GetTextDecoration(out textDecoration: DWORD): HResult; stdcall;
        function GetTextOutline(out color: TMFARGB; out thickness: double; out blurRadius: double;
            out unitType: TMF_TIMED_TEXT_UNIT_TYPE): HResult; stdcall;
    end;


    IMFTimedTextRegion = interface(IUnknown)
        ['{c8d22afc-bc47-4bdf-9b04-787e49ce3f58}']
        function GetName(out Name: LPWSTR): HResult; stdcall;
        function GetPosition(out pX: double; out pY: double; out unitType: TMF_TIMED_TEXT_UNIT_TYPE): HResult; stdcall;
        function GetExtent(out pWidth: double; out pHeight: double; out unitType: TMF_TIMED_TEXT_UNIT_TYPE): HResult; stdcall;
        function GetBackgroundColor(out bgColor: TMFARGB): HResult; stdcall;
        function GetWritingMode(out writingMode: TMF_TIMED_TEXT_WRITING_MODE): HResult; stdcall;
        function GetDisplayAlignment(out displayAlign: TMF_TIMED_TEXT_DISPLAY_ALIGNMENT): HResult; stdcall;
        function GetLineHeight(out pLineHeight: double; out unitType: TMF_TIMED_TEXT_UNIT_TYPE): HResult; stdcall;
        function GetClipOverflow(out clipOverflow: boolean): HResult; stdcall;
        function GetPadding(out before: double; out start: double; out after: double; out _end: double;
            out unitType: TMF_TIMED_TEXT_UNIT_TYPE): HResult; stdcall;
        function GetWrap(out wrap: boolean): HResult; stdcall;
        function GetZIndex(out zIndex: INT32): HResult; stdcall;
        function GetScrollMode(out scrollMode: TMF_TIMED_TEXT_SCROLL_MODE): HResult; stdcall;
    end;


    IMFTimedTextBinary = interface(IUnknown)
        ['{4ae3a412-0545-43c4-bf6f-6b97a5c6c432}']
        function GetData(out Data: PBYTE; out length: DWORD): HResult; stdcall;
    end;


    IMFTimedTextCueList = interface(IUnknown)
        ['{ad128745-211b-40a0-9981-fe65f166d0fd}']
        function GetLength(): DWORD; stdcall;
        function GetCueByIndex(index: DWORD; out cue: IMFTimedTextCue): HResult; stdcall;
        function GetCueById(id: DWORD; out cue: IMFTimedTextCue): HResult; stdcall;
        function GetCueByOriginalId(originalId: LPCWSTR; out cue: IMFTimedTextCue): HResult; stdcall;
        function AddTextCue(start: double; duration: double; Text: LPCWSTR; out cue: IMFTimedTextCue): HResult; stdcall;
        function AddDataCue(start: double; duration: double; const Data: PBYTE; dataSize: DWORD;
            out cue: IMFTimedTextCue): HResult; stdcall;
        function RemoveCue(cue: IMFTimedTextCue): HResult; stdcall;
    end;


    TMF_MEDIA_ENGINE_STREAMTYPE_FAILED = (
        MF_MEDIA_ENGINE_STREAMTYPE_FAILED_UNKNOWN = 0,
        MF_MEDIA_ENGINE_STREAMTYPE_FAILED_AUDIO = 1,
        MF_MEDIA_ENGINE_STREAMTYPE_FAILED_VIDEO = 2
        );



    IMFMediaEngineEMENotify = interface(IUnknown)
        ['{9e184d15-cdb7-4f86-b49e-566689f4a601}']
        procedure Encrypted(const pbInitData: PByte; cb: DWORD; bstrInitDataType: BSTR); stdcall;
        procedure WaitingForKey(); stdcall;
    end;



    TMF_MEDIAKEYS_REQUIREMENT = (
        MF_MEDIAKEYS_REQUIREMENT_REQUIRED = 1,
        MF_MEDIAKEYS_REQUIREMENT_OPTIONAL = 2,
        MF_MEDIAKEYS_REQUIREMENT_NOT_ALLOWED = 3
        );


    IMFMediaKeySessionNotify2 = interface(IMFMediaKeySessionNotify)
        ['{c3a9e92a-da88-46b0-a110-6cf953026cb9}']
        procedure KeyMessage2(eMessageType: TMF_MEDIAKEYSESSION_MESSAGETYPE; destinationURL: BSTR; const pbMessage: PBYTE;
            cbMessage: DWORD); stdcall;
        procedure KeyStatusChange(); stdcall;
    end;

    IMFMediaKeys2 = interface;

    IMFMediaKeySystemAccess = interface(IUnknown)
        ['{aec63fda-7a97-4944-b35c-6c6df8085cc3}']
        function CreateMediaKeys(pCdmCustomConfig: IPropertyStore; out ppKeys: IMFMediaKeys2): HResult; stdcall;
        function get_SupportedConfiguration(out ppSupportedConfiguration: IPropertyStore): HResult; stdcall;
        function get_KeySystem(out pKeySystem: BSTR): HResult; stdcall;
    end;


    IMFMediaEngineClassFactory3 = interface(IUnknown)
        ['{3787614f-65f7-4003-b673-ead8293a0e60}']
        function CreateMediaKeySystemAccess(keySystem: BSTR; ppSupportedConfigurationsArray {arraysize: uSize}: IPropertyStore;
            uSize: UINT; out ppKeyAccess: IMFMediaKeySystemAccess): HResult; stdcall;
    end;

    IMFMediaKeySession2 = interface;

    IMFMediaKeys2 = interface(IMFMediaKeys)
        ['{45892507-ad66-4de2-83a2-acbb13cd8d43}']
        function CreateSession2(eSessionType: TMF_MEDIAKEYSESSION_TYPE; pMFMediaKeySessionNotify2: IMFMediaKeySessionNotify2;
            out ppSession: IMFMediaKeySession2): HResult; stdcall;
        function SetServerCertificate(const pbServerCertificate: PBYTE; cb: DWORD): HResult; stdcall;
        function GetDOMException(systemCode: HRESULT; out code: HRESULT): HResult; stdcall;
    end;



    IMFMediaKeySession2 = interface(IMFMediaKeySession)
        ['{e9707e05-6d55-4636-b185-3de21210bd75}']
        function get_KeyStatuses(out pKeyStatusesArray: PMFMediaKeyStatus; out puSize: UINT): HResult; stdcall;
        function Load(bstrSessionId: BSTR; out pfLoaded: boolean): HResult; stdcall;
        function GenerateRequest(initDataType: BSTR; const pbInitData: PBYTE; cb: DWORD): HResult; stdcall;
        function get_Expiration(out dblExpiration: double): HResult; stdcall;
        function Remove(): HResult; stdcall;
        function Shutdown(): HResult; stdcall;
    end;




implementation

end.
