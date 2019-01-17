unit Win32.MFSharingEngine;

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}
interface

uses
    Windows, Classes, SysUtils, ActiveX,
    Win32.MFObjects,
    Win32.MFMediaEngine, CMC.Inspectable;

const
    IID_IMFSharingEngineClassFactory: TGUID = '{2BA61F92-8305-413B-9733-FAF15F259384}';
    IID_IMFMediaSharingEngine: TGUID = '{8D3CE1BF-2367-40E0-9EEE-40D377CC1B46}';
    IID_IMFMediaSharingEngineClassFactory: TGUID = '{524D2BC4-B2B1-4FE5-8FAC-FA4E4512B4E0}';
    IID_IMFImageSharingEngine: TGUID = '{CFA0AE8E-7E1C-44D2-AE68-FC4C148A6354}';
    IID_IMFImageSharingEngineClassFactory: TGUID = '{1FC55727-A7FB-4FC8-83AE-8AF024990AF1}';
    IID_IPlayToControl: TGUID = '{607574EB-F4B6-45C1-B08C-CB715122901D}';
    IID_IPlayToControlWithCapabilities: TGUID = '{AA9DD80F-C50A-4220-91C1-332287F82A34}';
    IID_IPlayToSourceClassFactory: TGUID = '{842B32A3-9B9B-4D1C-B3F3-49193248A554}';


const
    MF_MEDIA_SHARING_ENGINE_DEVICE_NAME: TGUID = '{771e05d1-862f-4299-95ac-ae81fd14f3e7}';
    MF_MEDIA_SHARING_ENGINE_DEVICE: TGUID = '{b461c58a-7a08-4b98-99a8-70fd5f3badfd}';
    MF_MEDIA_SHARING_ENGINE_INITIAL_SEEK_TIME: TGUID = '{6f3497f5-d528-4a4f-8dd7-db36657ec4c9}';
    MF_SHUTDOWN_RENDERER_ON_ENGINE_SHUTDOWN: TGUID = '{c112d94d-6b9c-48f8-b6f9-7950ff9ab71e}';
    MF_PREFERRED_SOURCE_URI: TGUID = '{5fc85488-436a-4db8-90af-4db402ae5c57}';
    MF_SHARING_ENGINE_SHAREDRENDERER: TGUID = '{efa446a0-73e7-404e-8ae2-fef60af5a32b}';
    MF_SHARING_ENGINE_CALLBACK: TGUID = '{57dc1e95-d252-43fa-9bbc-180070eefe6d}';
	
    CLSID_MFMediaSharingEngineClassFactory: TGUID = '{f8e307fb-6d45-4ad3-9993-66cd5a529659}';
    CLSID_MFImageSharingEngineClassFactory: TGUID = '{b22c3339-87f3-4059-a0c5-037aa9707eaf}';
    CLSID_PlayToSourceClassFactory: TGUID = '{DA17539A-3DC3-42C1-A749-A183B51F085E}';
    GUID_PlayToService: TGUID = '{f6a8ff9d-9e14-41c9-bf0f-120a2b3ce120}';
    GUID_NativeDeviceService: TGUID = '{ef71e53c-52f4-43c5-b86a-ad6cb216a61e}';


type
    TDEVICE_INFO = record
        pFriendlyDeviceName: BSTR;
        pUniqueDeviceName: BSTR;
        pManufacturerName: BSTR;
        pModelName: BSTR;
        pIconURL: BSTR;
    end;
	
	PDEVICE_INFO = ^TDEVICE_INFO;

    TMF_SHARING_ENGINE_EVENT = (
        MF_SHARING_ENGINE_EVENT_DISCONNECT = 2000,
        MF_SHARING_ENGINE_EVENT_LOCALRENDERINGSTARTED = 2001,
        MF_SHARING_ENGINE_EVENT_LOCALRENDERINGENDED = 2002,
        MF_SHARING_ENGINE_EVENT_STOPPED = 2003,
        MF_SHARING_ENGINE_EVENT_ERROR = 2501
        );

    TMF_MEDIA_SHARING_ENGINE_EVENT = (
        MF_MEDIA_SHARING_ENGINE_EVENT_DISCONNECT = 2000
        );


    IMFSharingEngineClassFactory = interface(IUnknown)
        ['{2BA61F92-8305-413B-9733-FAF15F259384}']
        function CreateInstance(dwFlags: DWORD; pAttr: IMFAttributes; out ppEngine: IUnknown): HResult; stdcall;
    end;


    IMFMediaSharingEngine = interface(IMFMediaEngine)
        ['{8D3CE1BF-2367-40E0-9EEE-40D377CC1B46}']
        function GetDevice(Out pDevice: TDEVICE_INFO): HResult; stdcall;
    end;


    IMFMediaSharingEngineClassFactory = interface(IUnknown)
        ['{524D2BC4-B2B1-4FE5-8FAC-FA4E4512B4E0}']
        function CreateInstance(dwFlags: DWORD; pAttr: IMFAttributes; out ppEngine: IMFMediaSharingEngine): HResult; stdcall;
    end;


    IMFImageSharingEngine = interface(IUnknown)
        ['{CFA0AE8E-7E1C-44D2-AE68-FC4C148A6354}']
        function SetSource(pStream: IUnknown): HResult; stdcall;
        function GetDevice(Out pDevice: TDEVICE_INFO): HResult; stdcall;
        function Shutdown(): HResult; stdcall;
    end;


    IMFImageSharingEngineClassFactory = interface(IUnknown)
        ['{1FC55727-A7FB-4FC8-83AE-8AF024990AF1}']
        function CreateInstanceFromUDN(pUniqueDeviceName: BSTR; out ppEngine: IMFImageSharingEngine): HResult; stdcall;
    end;


    TPLAYTO_SOURCE_CREATEFLAGS = (
        PLAYTO_SOURCE_NONE = 0,
        PLAYTO_SOURCE_IMAGE = $1,
        PLAYTO_SOURCE_AUDIO = $2,
        PLAYTO_SOURCE_VIDEO = $4,
        PLAYTO_SOURCE_PROTECTED = $8
        );


    IPlayToControl = interface(IUnknown)
        ['{607574EB-F4B6-45C1-B08C-CB715122901D}']
        function Connect(pFactory: IMFSharingEngineClassFactory): HResult; stdcall;
        function Disconnect(): HResult; stdcall;
    end;


    IPlayToControlWithCapabilities = interface(IPlayToControl)
        ['{AA9DD80F-C50A-4220-91C1-332287F82A34}']
        function GetCapabilities(out pCapabilities: TPLAYTO_SOURCE_CREATEFLAGS): HResult; stdcall;
    end;


    IPlayToSourceClassFactory = interface(IUnknown)
        ['{842B32A3-9B9B-4D1C-B3F3-49193248A554}']
        function CreateInstance(dwFlags: DWORD; pControl: IPlayToControl; out ppSource: IInspectable): HResult; stdcall;
    end;


implementation

end.

