unit Win32.MFPlay;

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner


{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

{$Z4}
{$A4}

uses
    Windows, Classes, SysUtils, ActiveX, ShlObj,
    CMC.WTypes, CMC.MFIdl, CMC.EVR, Win32.MFObjects;

const
    MFPlay_DLL = 'MFPlay.dll';

const
    IID_IMFPMediaPlayer: TGUID = '{A714590A-58AF-430a-85BF-44F5EC838D85}';
    IID_IMFPMediaItem: TGUID = '{90EB3E6B-ECBF-45cc-B1DA-C6FE3EA70D57}';
    IID_IMFPMediaPlayerCallback: TGUID = '{766C8FFB-5FDB-4fea-A28D-B912996F51BD}';

const
    MFP_POSITIONTYPE_100NS: TGUID = '{00000000-0000-0000-0000-000000000000}';

    MFP_PKEY_StreamIndex: TPROPERTYKEY = (fmtid: '{a7cf9740-e8d9-4a87-bd8e-2967001fd3ad}'; pid: $00);
    MFP_PKEY_StreamRenderingResults: TPROPERTYKEY = (fmtid: '{a7cf9740-e8d9-4a87-bd8e-2967001fd3ad}'; pid: $01);

type

    IMFPMediaItem = interface;

    TMFP_CREATION_OPTIONS = (
        MFP_OPTION_NONE = 0,
        MFP_OPTION_FREE_THREADED_CALLBACK = $1,
        MFP_OPTION_NO_MMCSS = $2,
        MFP_OPTION_NO_REMOTE_DESKTOP_OPTIMIZATION = $4
        );

    TMFP_MEDIAPLAYER_STATE = (
        MFP_MEDIAPLAYER_STATE_EMPTY = 0,
        MFP_MEDIAPLAYER_STATE_STOPPED = $1,
        MFP_MEDIAPLAYER_STATE_PLAYING = $2,
        MFP_MEDIAPLAYER_STATE_PAUSED = $3,
        MFP_MEDIAPLAYER_STATE_SHUTDOWN = $4
        );


    TMFP_MEDIAITEM_CHARACTERISTICS = (
        MFP_MEDIAITEM_IS_LIVE = $1,
        MFP_MEDIAITEM_CAN_SEEK = $2,
        MFP_MEDIAITEM_CAN_PAUSE = $4,
        MFP_MEDIAITEM_HAS_SLOW_SEEK = $8
        );

    TMFP_CREDENTIAL_FLAGS = (
        MFP_CREDENTIAL_PROMPT = $1,
        MFP_CREDENTIAL_SAVE = $2,
        MFP_CREDENTIAL_DO_NOT_CACHE = $4,
        MFP_CREDENTIAL_CLEAR_TEXT = $8,
        MFP_CREDENTIAL_PROXY = $10,
        MFP_CREDENTIAL_LOGGED_ON_USER = $20
        );


    IMFPMediaPlayer = interface(IUnknown)
        ['{A714590A-58AF-430a-85BF-44F5EC838D85}']
        function Play(): HResult; stdcall;
        function Pause(): HResult; stdcall;
        function Stop(): HResult; stdcall;
        function FrameStep(): HResult; stdcall;
        function SetPosition(const guidPositionType: TGUID; const pvPositionValue: PPROPVARIANT): HResult; stdcall;
        function GetPosition(const guidPositionType: TGUID; out pvPositionValue: TPROPVARIANT): HResult; stdcall;
        function GetDuration(const guidPositionType: TGUID; out pvDurationValue: TPROPVARIANT): HResult; stdcall;
        function SetRate(flRate: single): HResult; stdcall;
        function GetRate(out pflRate: single): HResult; stdcall;
        function GetSupportedRates(fForwardDirection: boolean; out pflSlowestRate: single; out pflFastestRate: single): HResult; stdcall;
        function GetState(out peState: TMFP_MEDIAPLAYER_STATE): HResult; stdcall;
        function CreateMediaItemFromURL(pwszURL: LPCWSTR; fSync: boolean; dwUserData: DWORD_PTR;
            out ppMediaItem: IMFPMediaItem): HResult; stdcall;
        function CreateMediaItemFromObject(pIUnknownObj: IUnknown; fSync: boolean; dwUserData: DWORD_PTR;
            out ppMediaItem: IMFPMediaItem): HResult; stdcall;
        function SetMediaItem(pIMFPMediaItem: IMFPMediaItem): HResult; stdcall;
        function ClearMediaItem(): HResult; stdcall;
        function GetMediaItem(out ppIMFPMediaItem: IMFPMediaItem): HResult; stdcall;
        function GetVolume(out pflVolume: single): HResult; stdcall;
        function SetVolume(flVolume: single): HResult; stdcall;
        function GetBalance(out pflBalance: single): HResult; stdcall;
        function SetBalance(flBalance: single): HResult; stdcall;
        function GetMute(out pfMute: boolean): HResult; stdcall;
        function SetMute(fMute: boolean): HResult; stdcall;
        function GetNativeVideoSize(out pszVideo: TSIZE; out pszARVideo: TSIZE): HResult; stdcall;
        function GetIdealVideoSize(out pszMin: TSIZE; out pszMax: TSIZE): HResult; stdcall;
        function SetVideoSourceRect(const pnrcSource: TMFVideoNormalizedRect): HResult; stdcall;
        function GetVideoSourceRect(out pnrcSource: TMFVideoNormalizedRect): HResult; stdcall;
        function SetAspectRatioMode(dwAspectRatioMode: DWORD): HResult; stdcall;
        function GetAspectRatioMode(out pdwAspectRatioMode: DWORD): HResult; stdcall;
        function GetVideoWindow(out phwndVideo: HWND): HResult; stdcall;
        function UpdateVideo(): HResult; stdcall;
        function SetBorderColor(Clr: COLORREF): HResult; stdcall;
        function GetBorderColor(out pClr: COLORREF): HResult; stdcall;
        function InsertEffect(pEffect: IUnknown; fOptional: boolean): HResult; stdcall;
        function RemoveEffect(pEffect: IUnknown): HResult; stdcall;
        function RemoveAllEffects(): HResult; stdcall;
        function Shutdown(): HResult; stdcall;
    end;


    IMFPMediaItem = interface(IUnknown)
        ['{90EB3E6B-ECBF-45cc-B1DA-C6FE3EA70D57}']
        function GetMediaPlayer(out ppMediaPlayer: IMFPMediaPlayer): HResult; stdcall;
        function GetURL(out ppwszURL: LPWSTR): HResult; stdcall;
        function GetObject(out ppIUnknown: IUnknown): HResult; stdcall;
        function GetUserData(out pdwUserData: DWORD_PTR): HResult; stdcall;
        function SetUserData(dwUserData: DWORD_PTR): HResult; stdcall;
        function GetStartStopPosition(out pguidStartPositionType: TGUID; out pvStartValue: PROPVARIANT;
            out pguidStopPositionType: TGUID; out pvStopValue: PROPVARIANT): HResult; stdcall;
        function SetStartStopPosition(const pguidStartPositionType: TGUID; const pvStartValue: PROPVARIANT;
            const pguidStopPositionType: TGUID; const pvStopValue: PROPVARIANT): HResult; stdcall;
        function HasVideo(out pfHasVideo: boolean; out pfSelected: boolean): HResult; stdcall;
        function HasAudio(out pfHasAudio: boolean; out pfSelected: boolean): HResult; stdcall;
        function IsProtected(out pfProtected: boolean): HResult; stdcall;
        function GetDuration(const guidPositionType: TGUID; out pvDurationValue: PROPVARIANT): HResult; stdcall;
        function GetNumberOfStreams(out pdwStreamCount: DWORD): HResult; stdcall;
        function GetStreamSelection(dwStreamIndex: DWORD; out pfEnabled: boolean): HResult; stdcall;
        function SetStreamSelection(dwStreamIndex: DWORD; fEnabled: boolean): HResult; stdcall;
        function GetStreamAttribute(dwStreamIndex: DWORD; const guidMFAttribute: TGUID; out pvValue: PROPVARIANT): HResult; stdcall;
        function GetPresentationAttribute(const guidMFAttribute: TGUID; out pvValue: PROPVARIANT): HResult; stdcall;
        function GetCharacteristics(out pCharacteristics: TMFP_MEDIAITEM_CHARACTERISTICS): HResult; stdcall;
        function SetStreamSink(dwStreamIndex: DWORD; pMediaSink: IUnknown): HResult; stdcall;
        function GetMetadata(out ppMetadataStore: IPropertyStore): HResult; stdcall;
    end;


    TMFP_EVENT_TYPE = (
        MFP_EVENT_TYPE_PLAY = 0,
        MFP_EVENT_TYPE_PAUSE = 1,
        MFP_EVENT_TYPE_STOP = 2,
        MFP_EVENT_TYPE_POSITION_SET = 3,
        MFP_EVENT_TYPE_RATE_SET = 4,
        MFP_EVENT_TYPE_MEDIAITEM_CREATED = 5,
        MFP_EVENT_TYPE_MEDIAITEM_SET = 6,
        MFP_EVENT_TYPE_FRAME_STEP = 7,
        MFP_EVENT_TYPE_MEDIAITEM_CLEARED = 8,
        MFP_EVENT_TYPE_MF = 9,
        MFP_EVENT_TYPE_ERROR = 10,
        MFP_EVENT_TYPE_PLAYBACK_ENDED = 11,
        MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL = 12
        );

    TMFP_EVENT_HEADER = record
        eEventType: TMFP_EVENT_TYPE;
        hrEvent: HRESULT;
        pMediaPlayer: IMFPMediaPlayer;
        eState: TMFP_MEDIAPLAYER_STATE;
        pPropertyStore: IPropertyStore;
    end;

    PMFP_EVENT_HEADER = ^TMFP_EVENT_HEADER;

    TMFP_PLAY_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_PLAY_EVENT = ^TMFP_PLAY_EVENT;

    TMFP_PAUSE_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_PAUSE_EVENT = ^TMFP_PAUSE_EVENT;

    TMFP_STOP_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_STOP_EVENT = ^TMFP_STOP_EVENT;

    TMFP_POSITION_SET_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_POSITION_SET_EVENT = ^TMFP_POSITION_SET_EVENT;

    TMFP_RATE_SET_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
        flRate: single;
    end;

    PMFP_RATE_SET_EVENT = ^TMFP_RATE_SET_EVENT;

    TMFP_MEDIAITEM_CREATED_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
        dwUserData: DWORD_PTR;
    end;

    PMFP_MEDIAITEM_CREATED_EVENT = ^TMFP_MEDIAITEM_CREATED_EVENT;

    TMFP_MEDIAITEM_SET_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_MEDIAITEM_SET_EVENT = ^TMFP_MEDIAITEM_SET_EVENT;

    TMFP_FRAME_STEP_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_FRAME_STEP_EVENT = ^TMFP_FRAME_STEP_EVENT;

    TMFP_MEDIAITEM_CLEARED_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_MEDIAITEM_CLEARED_EVENT = ^TMFP_MEDIAITEM_CLEARED_EVENT;

    TMFP_MF_EVENT = record
        header: TMFP_EVENT_HEADER;
        MFEventType: TMediaEventType;
        pMFMediaEvent: IMFMediaEvent;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_MF_EVENT = ^TMFP_MF_EVENT;

    TMFP_ERROR_EVENT = record
        header: TMFP_EVENT_HEADER;
    end;

    PMFP_ERROR_EVENT = ^TMFP_ERROR_EVENT;

    TMFP_PLAYBACK_ENDED_EVENT = record
        header: TMFP_EVENT_HEADER;
        pMediaItem: IMFPMediaItem;
    end;

    PMFP_PLAYBACK_ENDED_EVENT = ^TMFP_PLAYBACK_ENDED_EVENT;

    TMFP_ACQUIRE_USER_CREDENTIAL_EVENT = record
        header: TMFP_EVENT_HEADER;
        dwUserData: DWORD_PTR;
        fProceedWithAuthentication: boolean;
        hrAuthenticationStatus: HRESULT;
        pwszURL: LPCWSTR;
        pwszSite: LPCWSTR;
        pwszRealm: LPCWSTR;
        pwszPackage: LPCWSTR;
        nRetries: longint;
        flags: TMFP_CREDENTIAL_FLAGS;
        pCredential: IMFNetCredential;
    end;

    PMFP_ACQUIRE_USER_CREDENTIAL_EVENT = ^TMFP_ACQUIRE_USER_CREDENTIAL_EVENT;


    IMFPMediaPlayerCallback = interface(IUnknown)
        ['{766C8FFB-5FDB-4fea-A28D-B912996F51BD}']
        procedure OnMediaPlayerEvent(pEventHeader: PMFP_EVENT_HEADER); stdcall;
    end;


function MFPCreateMediaPlayer(pwszURL: LPCWSTR; fStartPlayback: boolean; creationOptions: TMFP_CREATION_OPTIONS;
    pCallback: IMFPMediaPlayerCallback; hWnd: HWND; out ppMediaPlayer: IMFPMediaPlayer): HResult;
    stdcall; external MFPlay_DLL;


{ Helper Functions for Events}

function MFP_GET_PLAY_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PLAY_EVENT;
function MFP_GET_PAUSE_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PAUSE_EVENT;
function MFP_GET_STOP_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_STOP_EVENT;
function MFP_GET_POSITION_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_POSITION_SET_EVENT;
function MFP_GET_RATE_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_RATE_SET_EVENT;

function MFP_GET_MEDIAITEM_CREATED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_CREATED_EVENT;
function MFP_GET_MEDIAITEM_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_SET_EVENT;

function MFP_GET_FRAME_STEP_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_FRAME_STEP_EVENT;
function MFP_GET_MEDIAITEM_CLEARED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_CLEARED_EVENT;
function MFP_GET_MF_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MF_EVENT;
function MFP_GET_ERROR_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_ERROR_EVENT;
function MFP_GET_PLAYBACK_ENDED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PLAYBACK_ENDED_EVENT;
function MFP_GET_ACQUIRE_USER_CREDENTIAL_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_ACQUIRE_USER_CREDENTIAL_EVENT;


implementation



function MFP_GET_PLAY_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PLAY_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_PLAY then
    begin
        Result := PMFP_PLAY_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_PAUSE_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PAUSE_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_PAUSE then
    begin
        Result := PMFP_PAUSE_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_STOP_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_STOP_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_STOP then
    begin
        Result := PMFP_STOP_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_POSITION_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_POSITION_SET_EVENT;
begin

    if pHdr.eEventType = MFP_EVENT_TYPE_POSITION_SET then
    begin
        Result := PMFP_POSITION_SET_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_RATE_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_RATE_SET_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_RATE_SET then
    begin
        Result := PMFP_RATE_SET_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_MEDIAITEM_CREATED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_CREATED_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_MEDIAITEM_CREATED then
    begin
        Result := PMFP_MEDIAITEM_CREATED_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_MEDIAITEM_SET_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_SET_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_MEDIAITEM_SET then
    begin
        Result := PMFP_MEDIAITEM_SET_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_FRAME_STEP_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_FRAME_STEP_EVENT;
begin

    if pHdr.eEventType = MFP_EVENT_TYPE_FRAME_STEP then
    begin
        Result := PMFP_FRAME_STEP_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_MEDIAITEM_CLEARED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MEDIAITEM_CLEARED_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_MEDIAITEM_CLEARED then
    begin
        Result := PMFP_MEDIAITEM_CLEARED_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_MF_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_MF_EVENT;
begin

    if pHdr.eEventType = MFP_EVENT_TYPE_MF then
    begin
        Result := PMFP_MF_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_ERROR_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_ERROR_EVENT;
begin

    if pHdr.eEventType = MFP_EVENT_TYPE_ERROR then
    begin
        Result := PMFP_ERROR_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_PLAYBACK_ENDED_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_PLAYBACK_ENDED_EVENT;
begin
    if pHdr.eEventType = MFP_EVENT_TYPE_PLAYBACK_ENDED then
    begin
        Result := PMFP_PLAYBACK_ENDED_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;



function MFP_GET_ACQUIRE_USER_CREDENTIAL_EVENT(const pHdr: PMFP_EVENT_HEADER): PMFP_ACQUIRE_USER_CREDENTIAL_EVENT;
begin

    if pHdr.eEventType = MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL then
    begin
        Result := PMFP_ACQUIRE_USER_CREDENTIAL_EVENT(pHdr);
    end
    else
    begin
        Result := nil;
    end;
end;

end.
