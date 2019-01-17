unit Win32.EVR9;

// Checked (and Updated) for SDK 10.0.17763.0 on 2018-12-04

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, ActiveX, Direct3D9,
    Win32.MFObjects, Win32.MFTransform, Win32.EVR,
    Win32.DXVA2API;

const
    IID_IEVRVideoStreamControl: TGUID = '{d0cfe38b-93e7-4772-8957-0400c49a4485}';
    IID_IMFVideoProcessor: TGUID = '{6AB0000C-FECE-4d1f-A2AC-A9573530656E}';
    IID_IMFVideoMixerBitmap: TGUID = '{814C7B20-0FDB-4eec-AF8F-F957C8F69EDC}';


type
    IEVRVideoStreamControl = interface(IUnknown)
        ['{d0cfe38b-93e7-4772-8957-0400c49a4485}']
        function SetStreamActiveState(fActive: boolean): HResult; stdcall;
        function GetStreamActiveState(out lpfActive: boolean): HResult; stdcall;
    end;


    IMFVideoProcessor = interface(IUnknown)
        ['{6AB0000C-FECE-4d1f-A2AC-A9573530656E}']
        function GetAvailableVideoProcessorModes(var lpdwNumProcessingModes: UINT; out ppVideoProcessingModes {arraysize lpdwNumProcessingModes}: PGUID): HResult; stdcall;
        function GetVideoProcessorCaps(const lpVideoProcessorMode: TGUID; out lpVideoProcessorCaps: TDXVA2_VideoProcessorCaps): HResult;
            stdcall;
        function GetVideoProcessorMode(out lpMode: TGUID): HResult; stdcall;
        function SetVideoProcessorMode(const lpMode: TGUID): HResult; stdcall;
        function GetProcAmpRange(dwProperty: DWORD; out pPropRange: TDXVA2_ValueRange): HResult; stdcall;
        function GetProcAmpValues(dwFlags: DWORD; out Values: TDXVA2_ProcAmpValues): HResult; stdcall;
        function SetProcAmpValues(dwFlags: DWORD; const pValues: TDXVA2_ProcAmpValues): HResult; stdcall;
        function GetFilteringRange(dwProperty: DWORD; out pPropRange: TDXVA2_ValueRange): HResult; stdcall;
        function GetFilteringValue(dwProperty: DWORD; out pValue: TDXVA2_Fixed32): HResult; stdcall;
        function SetFilteringValue(dwProperty: DWORD; pValue: PDXVA2_Fixed32): HResult; stdcall;
        function GetBackgroundColor(out lpClrBkg: COLORREF): HResult; stdcall;
        function SetBackgroundColor(ClrBkg: TCOLORREF): HResult; stdcall;
    end;


    TMFVideoAlphaBitmapParams = record
        dwFlags: DWORD;
        clrSrcKey: COLORREF;
        rcSrc: TRECT;
        nrcDest: TMFVideoNormalizedRect;
        fAlpha: single;
        dwFilterMode: DWORD;
    end;
    PMFVideoAlphaBitmapParams = ^TMFVideoAlphaBitmapParams;

    TMFVideoAlphaBitmap = record
        GetBitmapFromDC: boolean;
        case integer of
            0: (hdc: HDC;
                params: TMFVideoAlphaBitmapParams);
            1: (pDDS: pointer; { to IDirect3DSurface9 } );
    end;

    PMFVideoAlphaBitmap = ^TMFVideoAlphaBitmap;

    TMFVideoAlphaBitmapFlags = (
        MFVideoAlphaBitmap_EntireDDS = $1,
        MFVideoAlphaBitmap_SrcColorKey = $2,
        MFVideoAlphaBitmap_SrcRect = $4,
        MFVideoAlphaBitmap_DestRect = $8,
        MFVideoAlphaBitmap_FilterMode = $10,
        MFVideoAlphaBitmap_Alpha = $20,
        MFVideoAlphaBitmap_BitMask = $3f
        );


    IMFVideoMixerBitmap = interface(IUnknown)
        ['{814C7B20-0FDB-4eec-AF8F-F957C8F69EDC}']
        function SetAlphaBitmap(const pBmpParms: TMFVideoAlphaBitmap): HResult; stdcall;
        function ClearAlphaBitmap(): HResult; stdcall;
        function UpdateAlphaBitmapParameters(const pBmpParms: TMFVideoAlphaBitmapParams): HResult; stdcall;
        function GetAlphaBitmapParameters(out pBmpParms: TMFVideoAlphaBitmapParams): HResult; stdcall;
    end;

implementation

end.






























