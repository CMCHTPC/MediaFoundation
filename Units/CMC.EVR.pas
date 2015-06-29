unit CMC.EVR;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    CMC.MFIdl, CMC.MFObjects, CMC.MFTransform;

const
    EVR_DLL = 'evr.dll';
    MF_DLL ='mf.dll';

const
    IID_IMFVideoPositionMapper: TGUID = '{1F6A9F17-E70B-4e24-8AE4-0B2C3BA7A4AE}';
    IID_IMFVideoDeviceID: TGUID = '{A38D9567-5A9C-4f3c-B293-8EB415B279BA}';
    IID_IMFVideoDisplayControl: TGUID = '{a490b1e4-ab84-4d31-a1b2-181e03b1077a}';
    IID_IMFVideoPresenter: TGUID = '{29AFF080-182A-4a5d-AF3B-448F3A6346CB}';
    IID_IMFDesiredSample: TGUID = '{56C294D0-753E-4260-8D61-A3D8820B1D54}';
    IID_IMFVideoMixerControl2: TGUID = '{8459616d-966e-4930-b658-54fa7e5a16d3}';
    IID_IMFVideoRenderer: TGUID = '{DFDFD197-A9CA-43d8-B341-6AF3503792CD}';
    IID_IEVRFilterConfig: TGUID = '{83E91E85-82C1-4ea7-801D-85DC50B75086}';
    IID_IEVRFilterConfigEx: TGUID = '{aea36028-796d-454f-beee-b48071e24304}';
    IID_IMFTopologyServiceLookup: TGUID = '{fa993889-4383-415a-a930-dd472a8cf6f7}';
    IID_IMFTopologyServiceLookupClient: TGUID = '{fa99388a-4383-415a-a930-dd472a8cf6f7}';
    IID_IEVRTrustedVideoPlugin: TGUID = '{83A4CE40-7710-494b-A893-A472049AF630}';
    IID_IMFVideoMixerControl: TGUID = '{A5C6C53F-C202-4aa5-9695-175BA8C508A5}';

const
    MR_VIDEO_RENDER_SERVICE: TGUID = '{1092a86c-ab1a-459a-a336-831fbc4d11ff}';
    MR_VIDEO_MIXER_SERVICE: TGUID = '{073cd2fc-6cf4-40b7-8859-e89552c841f8}';
    MR_VIDEO_ACCELERATION_SERVICE: TGUID = '{efef5175-5c7d-4ce2-bbbd-34ff8bca6554}';
    MR_BUFFER_SERVICE: TGUID = '{a562248c-9ac6-4ffc-9fba-3af8f8ad1a4d}';
    VIDEO_ZOOM_RECT: TGUID = '{7aaa1638-1b7f-4c93-bd89-5b9c9fb6fcf0}';


type
    TD3DFORMAT = (
        D3DFMT_UNKNOWN = 0,
        D3DFMT_R8G8B8 = 20,
        D3DFMT_A8R8G8B8 = 21,
        D3DFMT_X8R8G8B8 = 22,
        D3DFMT_R5G6B5 = 23,
        D3DFMT_X1R5G5B5 = 24,
        D3DFMT_A1R5G5B5 = 25,
        D3DFMT_A4R4G4B4 = 26,
        D3DFMT_R3G3B2 = 27,
        D3DFMT_A8 = 28,
        D3DFMT_A8R3G3B2 = 29,
        D3DFMT_X4R4G4B4 = 30,
        D3DFMT_A2B10G10R10 = 31,
        D3DFMT_G16R16 = 34,
        D3DFMT_A8P8 = 40,
        D3DFMT_P8 = 41,
        D3DFMT_L8 = 50,
        D3DFMT_A8L8 = 51,
        D3DFMT_A4L4 = 52,
        D3DFMT_V8U8 = 60,
        D3DFMT_L6V5U5 = 61,
        D3DFMT_X8L8V8U8 = 62,
        D3DFMT_Q8W8V8U8 = 63,
        D3DFMT_V16U16 = 64,
        D3DFMT_W11V11U10 = 65,
        D3DFMT_A2W10V10U10 = 67,
        D3DFMT_D16_LOCKABLE = 70,
        D3DFMT_D32 = 71,
        D3DFMT_D15S1 = 73,
        D3DFMT_D24S8 = 75,
        D3DFMT_D16 = 80,
        D3DFMT_D24X8 = 77,
        D3DFMT_D24X4S4 = 79,
        D3DFMT_VERTEXDATA = 100,
        D3DFMT_INDEX16 = 101,
        D3DFMT_INDEX32 = 102,
        D3DFMT_FORCE_DWORD = $7fffffff
        );


    IMFVideoPositionMapper = interface(IUnknown)
        ['{1F6A9F17-E70B-4e24-8AE4-0B2C3BA7A4AE}']
        function MapOutputCoordinateToInputStream(xOut: single; yOut: single; dwOutputStreamIndex: DWORD;
            dwInputStreamIndex: DWORD; out pxIn: single; out pyIn: single): HResult; stdcall;
    end;

    IMFVideoDeviceID = interface(IUnknown)
        ['{A38D9567-5A9C-4f3c-B293-8EB415B279BA}']
        function GetDeviceID(out pDeviceID: TGUID): HResult; stdcall;
    end;


    TMFVideoAspectRatioMode = (
        MFVideoARMode_None = 0,
        MFVideoARMode_PreservePicture = $1,
        MFVideoARMode_PreservePixel = $2,
        MFVideoARMode_NonLinearStretch = $4,
        MFVideoARMode_Mask = $7
        );

    TMFVideoRenderPrefs = (
        MFVideoRenderPrefs_DoNotRenderBorder = $1,
        MFVideoRenderPrefs_DoNotClipToDevice = $2,
        MFVideoRenderPrefs_AllowOutputThrottling = $4,
        MFVideoRenderPrefs_ForceOutputThrottling = $8,
        MFVideoRenderPrefs_ForceBatching = $10,
        MFVideoRenderPrefs_AllowBatching = $20,
        MFVideoRenderPrefs_ForceScaling = $40,
        MFVideoRenderPrefs_AllowScaling = $80,
        MFVideoRenderPrefs_DoNotRepaintOnStop = $100,
        MFVideoRenderPrefs_Mask = $1ff
        );


    TMFVideoNormalizedRect = record
        left: single;
        top: single;
        right: single;
        bottom: single;
    end;


    IMFVideoDisplayControl = interface(IUnknown)
        ['{a490b1e4-ab84-4d31-a1b2-181e03b1077a}']
        function GetNativeVideoSize(var pszVideo: TSIZE; var pszARVideo: TSIZE): HResult; stdcall;
        function GetIdealVideoSize(var pszMin: TSIZE; var pszMax: TSIZE): HResult; stdcall;
        function SetVideoPosition(const pnrcSource: TMFVideoNormalizedRect; const prcDest: TRECT): HResult; stdcall;
        function GetVideoPosition(out pnrcSource: TMFVideoNormalizedRect; out prcDest: TRECT): HResult; stdcall;
        function SetAspectRatioMode(dwAspectRatioMode: DWORD): HResult; stdcall;
        function GetAspectRatioMode(out pdwAspectRatioMode: DWORD): HResult; stdcall;
        function SetVideoWindow(hwndVideo: HWND): HResult; stdcall;
        function GetVideoWindow(out phwndVideo: HWND): HResult; stdcall;
        function RepaintVideo(): HResult; stdcall;
        function GetCurrentImage(var pBih: TBITMAPINFOHEADER; out pDib: PBYTE; out pcbDib: DWORD;
            var pTimeStamp: LONGLONG): HResult; stdcall;
        function SetBorderColor(Clr: COLORREF): HResult; stdcall;
        function GetBorderColor(out pClr: COLORREF): HResult; stdcall;
        function SetRenderingPrefs(dwRenderFlags: DWORD): HResult; stdcall;
        function GetRenderingPrefs(out pdwRenderFlags: DWORD): HResult; stdcall;
        function SetFullscreen(fFullscreen: boolean): HResult; stdcall;
        function GetFullscreen(out pfFullscreen: boolean): HResult; stdcall;
    end;


    TMFVP_MESSAGE_TYPE = (
        MFVP_MESSAGE_FLUSH = 0,
        MFVP_MESSAGE_INVALIDATEMEDIATYPE = $1,
        MFVP_MESSAGE_PROCESSINPUTNOTIFY = $2,
        MFVP_MESSAGE_BEGINSTREAMING = $3,
        MFVP_MESSAGE_ENDSTREAMING = $4,
        MFVP_MESSAGE_ENDOFSTREAM = $5,
        MFVP_MESSAGE_STEP = $6,
        MFVP_MESSAGE_CANCELSTEP = $7
        );


    IMFVideoPresenter = interface(IMFClockStateSink)
        ['{29AFF080-182A-4a5d-AF3B-448F3A6346CB}']
        function ProcessMessage(eMessage: TMFVP_MESSAGE_TYPE; ulParam: ULONG_PTR): HResult; stdcall;
        function GetCurrentMediaType(out ppMediaType: IMFVideoMediaType): HResult; stdcall;
    end;


    IMFDesiredSample = interface(IUnknown)
        ['{56C294D0-753E-4260-8D61-A3D8820B1D54}']
        function GetDesiredSampleTimeAndDuration(out phnsSampleTime: LONGLONG; out phnsSampleDuration: LONGLONG): HResult; stdcall;
        procedure SetDesiredSampleTimeAndDuration(hnsSampleTime: LONGLONG; hnsSampleDuration: LONGLONG); stdcall;
        procedure Clear(); stdcall;
    end;


    IMFVideoMixerControl = interface(IUnknown)
        ['{A5C6C53F-C202-4aa5-9695-175BA8C508A5}']
        function SetStreamZOrder(dwStreamID: DWORD; dwZ: DWORD): HResult; stdcall;
        function GetStreamZOrder(dwStreamID: DWORD; out pdwZ: DWORD): HResult; stdcall;
        function SetStreamOutputRect(dwStreamID: DWORD; const pnrcOutput: TMFVideoNormalizedRect): HResult; stdcall;
        function GetStreamOutputRect(dwStreamID: DWORD; out pnrcOutput: TMFVideoNormalizedRect): HResult; stdcall;
    end;


    TMFVideoMixPrefs = (
        MFVideoMixPrefs_ForceHalfInterlace = $1,
        MFVideoMixPrefs_AllowDropToHalfInterlace = $2,
        MFVideoMixPrefs_AllowDropToBob = $4,
        MFVideoMixPrefs_ForceBob = $8,
        MFVideoMixPrefs_EnableRotation = $10,
        MFVideoMixPrefs_Mask = $1f
        );


    IMFVideoMixerControl2 = interface(IMFVideoMixerControl)
        ['{8459616d-966e-4930-b658-54fa7e5a16d3}']
        function SetMixingPrefs(dwMixFlags: DWORD): HResult; stdcall;
        function GetMixingPrefs(out pdwMixFlags: DWORD): HResult; stdcall;
    end;


    IMFVideoRenderer = interface(IUnknown)
        ['{DFDFD197-A9CA-43d8-B341-6AF3503792CD}']
        function InitializeRenderer(pVideoMixer: IMFTransform; pVideoPresenter: IMFVideoPresenter): HResult; stdcall;
    end;


    IEVRFilterConfig = interface(IUnknown)
        ['{83E91E85-82C1-4ea7-801D-85DC50B75086}']
        function SetNumberOfStreams(dwMaxStreams: DWORD): HResult; stdcall;
        function GetNumberOfStreams(out pdwMaxStreams: DWORD): HResult; stdcall;
    end;


    TEVRFilterConfig_Prefs = (
        EVRFilterConfigPrefs_EnableQoS = $1,
        EVRFilterConfigPrefs_Mask = $1
        );


    IEVRFilterConfigEx = interface(IEVRFilterConfig)
        ['{aea36028-796d-454f-beee-b48071e24304}']
        function SetConfigPrefs(dwConfigFlags: DWORD): HResult; stdcall;
        function GetConfigPrefs(out pdwConfigFlags: DWORD): HResult; stdcall;
    end;


    TMF_SERVICE_LOOKUP_TYPE = (
        MF_SERVICE_LOOKUP_UPSTREAM = 0,
        MF_SERVICE_LOOKUP_UPSTREAM_DIRECT = (MF_SERVICE_LOOKUP_UPSTREAM + 1),
        MF_SERVICE_LOOKUP_DOWNSTREAM = (MF_SERVICE_LOOKUP_UPSTREAM_DIRECT + 1),
        MF_SERVICE_LOOKUP_DOWNSTREAM_DIRECT = (MF_SERVICE_LOOKUP_DOWNSTREAM + 1),
        MF_SERVICE_LOOKUP_ALL = (MF_SERVICE_LOOKUP_DOWNSTREAM_DIRECT + 1),
        MF_SERVICE_LOOKUP_GLOBAL = (MF_SERVICE_LOOKUP_ALL + 1)
        );


    IMFTopologyServiceLookup = interface(IUnknown)
        ['{fa993889-4383-415a-a930-dd472a8cf6f7}']
        function LookupService(_Type: TMF_SERVICE_LOOKUP_TYPE; dwIndex: DWORD; const guidService: TGUID; const riid: TGUID;
            out ppvObjects: pointer; var pnObjects: DWORD): HResult; stdcall;
    end;

    IMFTopologyServiceLookupClient = interface(IUnknown)
        ['{fa99388a-4383-415a-a930-dd472a8cf6f7}']
        function InitServicePointers(pLookup: IMFTopologyServiceLookup): HResult; stdcall;
        function ReleaseServicePointers(): HResult; stdcall;
    end;


    IEVRTrustedVideoPlugin = interface(IUnknown)
        ['{83A4CE40-7710-494b-A893-A472049AF630}']
        function IsInTrustedVideoMode(out pYes: boolean): HResult; stdcall;
        function CanConstrict(out pYes: boolean): HResult; stdcall;
        function SetConstriction(dwKPix: DWORD): HResult; stdcall;
        function DisableImageExport(bDisable: boolean): HResult; stdcall;
    end;


function MFCreateVideoPresenter(pOwner: IUnknown; const riidDevice: TGUID; const riid: TGUID; out ppVideoPresenter): HResult;
    stdcall; external EVR_DLL;
function MFCreateVideoMixer(pOwner: IUnknown; const riidDevice: TGUID; const riid: TGUID; out ppv): HResult;
    stdcall; external EVR_DLL;
function MFCreateVideoMixerAndPresenter(pMixerOwner: IUnknown; pPresenterOwner: IUnknown; const riidMixer: TGUID;
    out ppvVideoMixer; const riidPresenter: TGUID; out ppvVideoPresenter): HResult;
    stdcall; external EVR_DLL;
function MFCreateVideoRenderer(const riidRenderer: TGUID; out ppVideoRenderer): HResult;
    stdcall; external MF_DLL;
function MFCreateVideoSampleFromSurface(pUnkSurface: IUnknown; out ppSample: IMFSample): HResult;
    stdcall; external EVR_DLL;
function MFCreateVideoSampleAllocator(const riid: TGUID; out ppSampleAllocator): HResult;
    stdcall; external EVR_DLL;


implementation

end.














































































































































