unit Win32.DDraw;

(*==========================================================================;
 *
 *  Copyright (C) Microsoft Corporation.  All Rights Reserved.
 *
 *  File:       ddraw.h
 *  Content:    DirectDraw include file
 *
 ***************************************************************************)

{$mode delphi}
{$MACRO ON}

interface


(*
 * If you wish an application built against the newest version of DirectDraw
 * to run against an older DirectDraw run time then define DIRECTDRAW_VERSION
 * to be the earlies version of DirectDraw you wish to run against. For,
 * example if you wish an application to run against a DX 3 runtime define
 * DIRECTDRAW_VERSION to be $0300.
 *)
{$IFNDEF DIRECTDRAW_VERSION}
{$DEFINE DIRECTDRAW_VERSION := $0700}
{$ENDIF}(* DIRECTDRAW_VERSION *)

uses
    Windows, Classes, SysUtils;

const

    (* GUIDS used by DirectDraw objects *)
    CLSID_DirectDraw: TGUID = '{D7B70EE0-4340-11CF-B063-0020AFC2CD35}';
    CLSID_DirectDraw7: TGUID = '{3c305196-50db-11d3-9cfe-00c04fd930c5}';
    CLSID_DirectDrawClipper: TGUID = '{593817A0-7DB3-11CF-A2DE-00AA00b93356}';
    IID_IDirectDraw: TGUID = '{6C14DB80-A733-11CE-A521-0020AF0BE560}';
    IID_IDirectDraw2: TGUID = '{B3A6F3E0-2B43-11CF-A2DE-00AA00B93356}';
    IID_IDirectDraw4: TGUID = '{9c59509a-39bd-11d1-8c4a-00c04fd930c5}';
    IID_IDirectDraw7: TGUID = '{15e65ec0-3b9c-11d2-b92f-00609797ea5b}';
    IID_IDirectDrawSurface: TGUID = '{6C14DB81-A733-11CE-A521-0020AF0BE560}';
    IID_IDirectDrawSurface2: TGUID = '{57805885-6eec-11cf-9441-a82303c10e27}';
    IID_IDirectDrawSurface3: TGUID = '{DA044E00-69B2-11D0-A1D5-00AA00B8DFBB}';
    IID_IDirectDrawSurface4: TGUID = '{0B2B8630-AD35-11D0-8EA6-00609797EA5B}';
    IID_IDirectDrawSurface7: TGUID = '{06675a80-3b9b-11d2-b92f-00609797ea5b}';
    IID_IDirectDrawPalette: TGUID = '{6C14DB84-A733-11CE-A521-0020AF0BE560}';
    IID_IDirectDrawClipper: TGUID = '{6C14DB85-A733-11CE-A521-0020AF0BE560}';
    IID_IDirectDrawColorControl: TGUID = '{4B9F0EE0-0D7E-11D0-9B06-00A0C903A3B8}';
    IID_IDirectDrawGammaControl: TGUID = '{69C11C3E-B46B-11D1-AD7A-00C04FC29B4E}';

const
    DD_ROP_SPACE = (256 div 32);        // space required to store ROP array



type
    (*============================================================================
     * DirectDraw Structures
     * Various structures used to invoke DirectDraw.
     *==========================================================================*)

    IDirectDraw = interface;
    IDirectDrawSurface = interface;
    IDirectDrawPalette = interface;
    IDirectDrawClipper = interface;

    PIDirectDraw = ^IDIRECTDRAW;
    PIDirectDraw2 = ^IDIRECTDRAW2;
    PIDirectDraw4 = ^IDIRECTDRAW4;
    PIDirectDraw7 = ^IDIRECTDRAW7;
    PIDirectDrawSurface = ^IDIRECTDRAWSURFACE;
    PIDirectDrawSurface2 = ^IDIRECTDRAWSURFACE2;
    PIDirectDrawSurface3 = ^IDIRECTDRAWSURFACE3;
    PIDirectDrawSurface4 = ^IDIRECTDRAWSURFACE4;
    PIDirectDrawSurface7 = ^IDIRECTDRAWSURFACE7;
    PIDirectDrawPalette = ^IDIRECTDRAWPALETTE;
    PIDirectDrawClipper = ^IDIRECTDRAWCLIPPER;
    PIDirectDrawColorControl = ^IDIRECTDRAWCOLORCONTROL;
    PIDirectDrawGammaControl = ^IDIRECTDRAWGAMMACONTROL;

    (* DDSCAPS *)
    TDDSCAPS = record
        dwCaps: DWORD;         // capabilities of surface wanted
    end;
    PDDSCAPS = ^TDDSCAPS;

    (* DDCAPS *)

  (*
 * NOTE: Our choosen structure number scheme is to append a single digit to
 * the end of the structure giving the version that structure is associated
 * with.
 *)

(*
 * This structure represents the DDCAPS structure released in DirectDraw 1.0.  It is used internally
 * by DirectDraw to interpret caps passed into ddraw by drivers written prior to the release of DirectDraw 2.0.
 * New applications should use the DDCAPS structure defined below.
 *)
    TDDCAPS_DX1 = record
        dwSize: DWORD;                 // size of the DDDRIVERCAPS structure
        dwCaps: DWORD;                 // driver specific capabilities
        dwCaps2: DWORD;                // more driver specific capabilites
        dwCKeyCaps: DWORD;             // color key capabilities of the surface
        dwFXCaps: DWORD;               // driver specific stretching and effects capabilites
        dwFXAlphaCaps: DWORD;          // alpha driver specific capabilities
        dwPalCaps: DWORD;              // palette capabilities
        dwSVCaps: DWORD;               // stereo vision capabilities
        dwAlphaBltConstBitDepths: DWORD;       // DDBD_2,4,8
        dwAlphaBltPixelBitDepths: DWORD;       // DDBD_1,2,4,8
        dwAlphaBltSurfaceBitDepths: DWORD;     // DDBD_1,2,4,8
        dwAlphaOverlayConstBitDepths: DWORD;   // DDBD_2,4,8
        dwAlphaOverlayPixelBitDepths: DWORD;   // DDBD_1,2,4,8
        dwAlphaOverlaySurfaceBitDepths: DWORD; // DDBD_1,2,4,8
        dwZBufferBitDepths: DWORD;             // DDBD_8,16,24,32
        dwVidMemTotal: DWORD;          // total amount of video memory
        dwVidMemFree: DWORD;           // amount of free video memory
        dwMaxVisibleOverlays: DWORD;   // maximum number of visible overlays
        dwCurrVisibleOverlays: DWORD;  // current number of visible overlays
        dwNumFourCCCodes: DWORD;       // number of four cc codes
        dwAlignBoundarySrc: DWORD;     // source rectangle alignment
        dwAlignSizeSrc: DWORD;         // source rectangle byte size
        dwAlignBoundaryDest: DWORD;    // dest rectangle alignment
        dwAlignSizeDest: DWORD;        // dest rectangle byte size
        dwAlignStrideAlign: DWORD;     // stride alignment
        dwRops: array[0..DD_ROP_SPACE - 1] of DWORD;   // ROPS supported
        ddsCaps: TDDSCAPS;                // DDSCAPS structure has all the general capabilities
        dwMinOverlayStretch: DWORD;    // minimum overlay stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
        dwMaxOverlayStretch: DWORD;    // maximum overlay stretch factor multiplied by 1000, eg 1000 == 1.0, 1300 == 1.3
        dwMinLiveVideoStretch: DWORD;  // OBSOLETE! This field remains for compatability reasons only
        dwMaxLiveVideoStretch: DWORD;  // OBSOLETE! This field remains for compatability reasons only
        dwMinHwCodecStretch: DWORD;    // OBSOLETE! This field remains for compatability reasons only
        dwMaxHwCodecStretch: DWORD;    // OBSOLETE! This field remains for compatability reasons only
        dwReserved1: DWORD;            // reserved
        dwReserved2: DWORD;            // reserved
        dwReserved3: DWORD;            // reserved
    end;
    PDDCAPS_DX1 = ^TDDCAPS_DX1;

    TDDCAPS_DX7 = record

    end;

    {$if DIRECTDRAW_VERSION <= $300}
    TDDCAPS = TDDCAPS_DX3;
    {$elif DIRECTDRAW_VERSION <= $500}
    TDDCAPS = TDDCAPS_DX5;
    {$elif DIRECTDRAW_VERSION <= $600}
    TDDCAPS = TDDCAPS_DX6;
    {$ELSE}
    TDDCAPS = TDDCAPS_DX7;
    {$ENDIF}

    PDDCAPS = ^TDDCAPS;

    (* DDPIXELFORMAT *)

    TDDSURFACEDESC = record

    end;
    PDDSURFACEDESC = ^TDDSURFACEDESC;

    TDDSURFACEDESC2 = record

    end;
    PDDSURFACEDESC2 = ^TDDSURFACEDESC2;

    TDDENUMMODESCALLBACK = function(lpDDSurfaceDesc: PDDSURFACEDESC; lpContext: pointer): HRESULT; stdcall;
    TDDENUMMODESCALLBACK2 = function(lpDDSurfaceDesc: PDDSURFACEDESC2; lpContext: pointer): HRESULT; stdcall;
    TDDENUMSURFACESCALLBACK = function(lpDDSurface: PIDIRECTDRAWSURFACE; lpDDSurfaceDesc: PDDSURFACEDESC; lpContext: pointer): HRESULT; stdcall;
    TDDENUMSURFACESCALLBACK2 = function(lpDDSurface: PIDIRECTDRAWSURFACE4; lpDDSurfaceDesc: PDDSURFACEDESC2; lpContext: pointer): HRESULT; stdcall;
    TDDENUMSURFACESCALLBACK7 = function(lpDDSurface: PIDIRECTDRAWSURFACE7; lpDDSurfaceDesc: PDDSURFACEDESC2; lpContext: pointer): HRESULT; stdcall;

    (* IDirectDraw *)

    IDirectDraw = interface(IUnknown)
        ['{6C14DB80-A733-11CE-A521-0020AF0BE560}']
        (*** IUnknown methods ***)
        (*** IDirectDraw methods ***)
        function Compact(): HResult; stdcall;
        function CreateClipper(dwFlags: DWORD; lplpDDClipper: PIDIRECTDRAWCLIPPER; pUnkOuter: IUnknown): HResult; stdcall;
        function CreatePalette(dwFlags: DWORD; lpColorTable: PPALETTEENTRY; lplpDDPalette: PIDIRECTDRAWPALETTE;
            pUnkOuter: IUnknown): HResult; stdcall;
        function CreateSurface(lpDDSurfaceDesc: PDDSURFACEDESC; lplpDDSurface: PIDIRECTDRAWSURFACE; pUnkOuter: IUnknown): HResult; stdcall;
        function DuplicateSurface(lpDDSurface: PIDIRECTDRAWSURFACE; lplpDupDDSurface: PIDIRECTDRAWSURFACE): HResult; stdcall;
        function EnumDisplayModes(dwFlags: DWORD; lpDDSurfaceDesc: PDDSURFACEDESC; lpContext: pointer;
            lpEnumCallback: TDDENUMMODESCALLBACK): HResult; stdcall;
        function EnumSurfaces(dwFlags: DWORD; lpDDSD: PDDSURFACEDESC; lpContext: pointer;
            lpEnumCallback: TDDENUMSURFACESCALLBACK): HResult; stdcall;
        function FlipToGDISurface(): HResult; stdcall;
        function GetCap(lpDDDriverCaps: PDDCAPS; lpDDHELCaps: PDDCAPS): HResult; stdcall;
        function GetDisplayMode(lpDDSurfaceDesc: PDDSURFACEDESC): HResult; stdcall;
        function GetFourCCCodes(lpNumCodes: PDWORD; lpCodes: PDWORD): HResult; stdcall;
        function GetGDISurface(lplpGDIDDSSurface: PIDIRECTDRAWSURFACE): HResult; stdcall;
        function GetMonitorFrequency(lpdwFrequency: PDWORD): HResult; stdcall;
        function GetScanLine(lpdwScanLine: PDWORD): HResult; stdcall;
        function GetVerticalBlankStatus(lpbIsInVB: PBOOL): HResult; stdcall;
        function Initialize(const lpGUID: TGUID): HResult; stdcall;
        function RestoreDisplayMode(): HResult; stdcall;
        function SetCooperativeLevel(Window: HWND; dwFlags: DWORD): HResult; stdcall;
        function SetDisplayMode(dwWidth: DWORD; dwHeight: DWORD; dwBpp: DWORD): HResult; stdcall;
        function WaitForVerticalBlank(dwFlags: DWORD; hEvent: THANDLE): HResult; stdcall;
    end;

    IDirectDraw2 = interface(IUnknown )
    ['{B3A6F3E0-2B43-11CF-A2DE-00AA00B93356}']
    // toDo
    end;

    IDirectDraw4 = interface(IUnknown)
    ['{9c59509a-39bd-11d1-8c4a-00c04fd930c5}']
    // toDo
    end;

    IDirectDraw7= interface(IUnknown )
    ['{15e65ec0-3b9c-11d2-b92f-00609797ea5b}']
    // toDo
    end;

    IDirectDrawSurface= interface(IUnknown )
    ['{6C14DB81-A733-11CE-A521-0020AF0BE560}']
    // toDo
    end;

    IDirectDrawSurface2= interface(IUnknown )
    ['{57805885-6eec-11cf-9441-a82303c10e27}']
    // toDo
    end;

    IDirectDrawSurface3= interface(IUnknown )
    ['{DA044E00-69B2-11D0-A1D5-00AA00B8DFBB}']
    // toDo
    end;

    IDirectDrawSurface4= interface(IUnknown )
    ['{0B2B8630-AD35-11D0-8EA6-00609797EA5B}']
    // toDo
    end;

    IDirectDrawSurface7= interface(IUnknown )
    ['{06675a80-3b9b-11d2-b92f-00609797ea5b}']
    // toDo
    end;

    IDirectDrawPalette= interface(IUnknown )
    ['{6C14DB84-A733-11CE-A521-0020AF0BE560}']
    // toDo
    end;

    IDirectDrawClipper= interface(IUnknown )
    ['{6C14DB85-A733-11CE-A521-0020AF0BE560}']
    // toDo
    end;

    IDirectDrawColorControl= interface(IUnknown )
    ['{4B9F0EE0-0D7E-11D0-9B06-00A0C903A3B8}']
    // toDo
    end;

    IDirectDrawGammaControl= interface(IUnknown )
    ['{69C11C3E-B46B-11D1-AD7A-00C04FC29B4E}']
    // toDo
    end;




implementation

end.
