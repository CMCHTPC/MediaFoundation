unit Win32.AMVideo;
//------------------------------------------------------------------------------
// File: AMVideo.h

// Desc: Video related definitions and interfaces for ActiveMovie.

// Copyright (c) 1992 - 2001, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------

// Checked (and Updated) for SDK 10.0.17763.0 on 2018-12-04

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}


interface

uses
    Windows, Classes, SysUtils,
    Win32.DDraw,Win32.UUIDs;

const
    // This is an interface on the video renderer that provides information about
    // DirectDraw with respect to its use by the renderer. For example it allows
    // an application to get details of the surface and any hardware capabilities
    // that are available. It also allows someone to adjust the surfaces that the
    // renderer should use and furthermore even set the DirectDraw instance. We
    // allow someone to set the DirectDraw instance because DirectDraw can only
    // be opened once per process so it helps resolve conflicts. There is some
    // duplication in this interface as the hardware/emulated/FOURCCs available
    // can all be found through the IDirectDraw interface, this interface allows
    // simple access to that information without calling the DirectDraw provider
    // itself. The AMDDS prefix is ActiveMovie DirectDraw Switches abbreviated.

    AMDDS_NONE = $00;            // No use for DCI/DirectDraw
    AMDDS_DCIPS = $01;            // Use DCI primary surface
    AMDDS_PS = $02;               // Use DirectDraw primary
    AMDDS_RGBOVR = $04;           // RGB overlay surfaces
    AMDDS_YUVOVR = $08;           // YUV overlay surfaces
    AMDDS_RGBOFF = $10;         // RGB offscreen surfaces
    AMDDS_YUVOFF = $20;         // YUV offscreen surfaces
    AMDDS_RGBFLP = $40;         // RGB flipping surfaces
    AMDDS_YUVFLP = $80;          // YUV flipping surfaces
    AMDDS_ALL = $FF;            // ALL the previous flags
    AMDDS_DEFAULT = AMDDS_ALL;    // Use all available surfaces

    AMDDS_YUV = (AMDDS_YUVOFF or AMDDS_YUVOVR or AMDDS_YUVFLP);
    AMDDS_RGB = (AMDDS_RGBOFF or AMDDS_RGBOVR or AMDDS_RGBFLP);
    AMDDS_PRIMARY = (AMDDS_DCIPS or AMDDS_PS);


    iPALETTE_COLORS = 256;     // Maximum colours in palette
    iEGA_COLORS = 16;          // Number colours in EGA palette
    iMASK_COLORS = 3;          // Maximum three components
    iTRUECOLOR = 16;           // Minimum true colour device
    iRED = 0;                  // Index position for RED mask
    iGREEN = 1;                // Index position for GREEN mask
    iBLUE = 2;                 // Index position for BLUE mask
    iPALETTE = 8;              // Maximum colour depth using a palette
    iMAXBITS = 8;              // Maximum bits per colour component


    MAX_SIZE_MPEG1_SEQUENCE_INFO = 140;




type
    BSTR = PWideString;

    //  Duplicate DirectShow definition
    TREFERENCE_TIME = LONGLONG;

    // The BITMAPINFOHEADER contains all the details about the video stream such
    // as the actual image dimensions and their pixel depth. A source filter may
    // also request that the sink take only a section of the video by providing a
    // clipping rectangle in rcSource. In the worst case where the sink filter
    // forgets to check this on connection it will simply render the whole thing
    // which isn't a disaster. Ideally a sink filter will check the rcSource and
    // if it doesn't support image extraction and the rectangle is not empty then
    // it will reject the connection. A filter should use SetRectEmpty to reset a
    // rectangle to all zeroes (and IsRectEmpty to later check the rectangle).
    // The rcTarget specifies the destination rectangle for the video, for most
    // source filters they will set this to all zeroes, a downstream filter may
    // request that the video be placed in a particular area of the buffers it
    // supplies in which case it will call QueryAccept with a non empty target


    IDirectDrawVideo = interface(IUnknown)
        ['{36d39eb0-dd75-11ce-bf0e-00aa0055595a}']
        // IUnknown methods
        // IDirectDrawVideo methods

        function GetSwitches(out pSwitches: DWORD): HResult; stdcall;
        function SetSwitches(Switches: DWORD): HResult; stdcall;
        function GetCaps(out pCaps: TDDCAPS): HResult; stdcall;
        function GetEmulatedCaps(out pCaps: TDDCAPS): HResult; stdcall;
        function GetSurfaceDesc(var pSurfaceDesc: TDDSURFACEDESC): HResult; stdcall;
        function GetFourCCCodes(out pCount: DWORD; out pCodes: DWORD): HResult; stdcall;
        function SetDirectDraw(pDirectDraw: PIDIRECTDRAW): HResult; stdcall;
        function GetDirectDraw(out ppDirectDraw: PIDIRECTDRAW): HResult; stdcall;
        function GetSurfaceType(out pSurfaceType: DWORD): HResult; stdcall;
        function SetDefault(): HResult; stdcall;
        function UseScanLine(UseScanLine: longint): HResult; stdcall;
        function CanUseScanLine(out UseScanLine: longint): HResult; stdcall;
        function UseOverlayStretch(UseOverlayStretch: longint): HResult; stdcall;
        function CanUseOverlayStretch(out UseOverlayStretch: longint): HResult; stdcall;
        function UseWhenFullScreen(UseWhenFullScreen: longint): HResult; stdcall;
        function WillUseFullScreen(out UseWhenFullScreen: longint): HResult; stdcall;
    end;


    IQualProp = interface(IUnknown)
        ['{1bd0ecb0-f8e2-11ce-aac6-0020af0b99a3}']
        // IUnknown methods
        // Compare these with the functions in class CGargle in gargle.h
        function get_FramesDroppedInRenderer(out pcFrames: integer): HResult; stdcall;  // Out
        function get_FramesDrawn(out pcFramesDrawn: integer): HResult; stdcall;         // Out
        function get_AvgFrameRate(out piAvgFrameRate: integer): HResult; stdcall;       // Out
        function get_Jitter(out iJitter: integer): HResult; stdcall;                    // Out
        function get_AvgSyncOffset(out piAvg: integer): HResult; stdcall;               // Out
        function get_DevSyncOffset(out piDev: integer): HResult; stdcall;               // Out
    end;


    // This interface allows an application or plug in distributor to control a
    // full screen renderer. The Modex renderer supports this interface. When
    // connected a renderer should load the display modes it has available
    // The number of modes available can be obtained through CountModes. Then
    // information on each individual mode is available by calling GetModeInfo
    // and IsModeAvailable. An application may enable and disable any modes
    // by calling the SetEnabled flag with OATRUE or OAFALSE (not C/C++ TRUE
    // and FALSE values) - the current value may be queried by IsModeEnabled

    // A more generic way of setting the modes enabled that is easier to use
    // when writing applications is the clip loss factor. This defines the
    // amount of video that can be lost when deciding which display mode to
    // use. Assuming the decoder cannot compress the video then playing an
    // MPEG file (say 352x288) into a 32$200 display will lose about 25% of
    // the image. The clip loss factor specifies the upper range permissible.
    // To allow typical MPEG video to be played in 32$200 it defaults to 25%

    IFullScreenVideo = interface(IUnknown)
        ['{dd1d7110-7836-11cf-bf47-00aa0055595a}']
        // IFullScreenVideo methods
        function CountModes(out pModes: longint): HResult; stdcall;
        function GetModeInfo(Mode: longint; out pWidth: longint; out pHeight: longint; out pDepth: longint): HResult; stdcall;
        function GetCurrentMode(out pMode: longint): HResult; stdcall;
        function IsModeAvailable(Mode: longint): HResult; stdcall;
        function IsModeEnabled(Mode: longint): HResult; stdcall;
        function SetEnabled(Mode: longint; bEnabled: longint): HResult; stdcall;
        function GetClipFactor(out pClipFactor: longint): HResult; stdcall;
        function SetClipFactor(ClipFactor: longint): HResult; stdcall;
        function SetMessageDrain(hwnd: HWND): HResult; stdcall;
        function GetMessageDrain(out hwnd: HWND): HResult; stdcall;
        function SetMonitor(Monitor: longint): HResult; stdcall;
        function GetMonitor(out Monitor: longint): HResult; stdcall;
        function HideOnDeactivate(Hide: longint): HResult; stdcall;
        function IsHideOnDeactivate(): HResult; stdcall;
        function SetCaption(strCaption: BSTR): HResult; stdcall;
        function GetCaption(out pstrCaption: BSTR): HResult; stdcall;
        function SetDefault(): HResult; stdcall;
    end;

    // This adds the accelerator table capabilities in fullscreen. This is being
    // added between the original runtime release and the full SDK release. We
    // cannot just add the method to IFullScreenVideo as we don't want to force
    // applications to have to ship the ActiveMovie support DLLs - this is very
    // important to applications that plan on being downloaded over the Internet


    IFullScreenVideoEx = interface(IFullScreenVideo)
        ['{53479470-f1dd-11cf-bc42-00aa00ac74f6}']
        // IFullScreenVideoEx
        function SetAcceleratorTable(hwnd: HWND; hAccel: HACCEL): HResult; stdcall;
        function GetAcceleratorTable(out phwnd: HWND; out phAccel: HACCEL): HResult; stdcall;
        function KeepPixelAspectRatio(KeepAspect: longint): HResult; stdcall;
        function IsKeepPixelAspectRatio(out pKeepAspect: longint): HResult; stdcall;
    end;

    // The SDK base classes contain a base video mixer class. Video mixing in a
    // software environment is tricky because we typically have multiple streams
    // each sending data at unpredictable times. To work with this we defined a
    // pin that is the lead pin, when data arrives on this pin we do a mix. As
    // an alternative we may not want to have a lead pin but output samples at
    // predefined spaces, like one every 1/15 of a second, this interfaces also
    // supports that mode of operations (there is a working video mixer sample)


{$interfaces corba}
    IBaseVideoMixer = interface {( IUnknown)}
        ['{61ded640-e912-11ce-a099-00aa00479a58}']
        // no IUnknown Functions in the C header !!!
        function SetLeadPin(iPin: integer): HResult; stdcall;
        function GetLeadPin(out piPin: integer): HResult; stdcall;
        function GetInputPinCount(out piPinCount: integer): HResult; stdcall;
        function IsUsingClock(out pbValue: integer): HResult; stdcall;
        function SetUsingClock(bValue: integer): HResult; stdcall;
        function GetClockPeriod(out pbValue: integer): HResult; stdcall;
        function SetClockPeriod(bValue: integer): HResult; stdcall;
    end;

{$interfaces com}



    // Used for true colour images that also have a palette

    TTRUECOLORINFO = record
        dwBitMasks: array [0..iMASK_COLORS - 1] of DWORD;
        bmiColors: array [0..iPALETTE_COLORS - 1] of TRGBQUAD;
    end;
    PTRUECOLORINFO = ^TTRUECOLORINFO;


    // The BITMAPINFOHEADER contains all the details about the video stream such
    // as the actual image dimensions and their pixel depth. A source filter may
    // also request that the sink take only a section of the video by providing a
    // clipping rectangle in rcSource. In the worst case where the sink filter
    // forgets to check this on connection it will simply render the whole thing
    // which isn't a disaster. Ideally a sink filter will check the rcSource and
    // if it doesn't support image extraction and the rectangle is not empty then
    // it will reject the connection. A filter should use SetRectEmpty to reset a
    // rectangle to all zeroes (and IsRectEmpty to later check the rectangle).
    // The rcTarget specifies the destination rectangle for the video, for most
    // source filters they will set this to all zeroes, a downstream filter may
    // request that the video be placed in a particular area of the buffers it
    // supplies in which case it will call QueryAccept with a non empty target

    TVIDEOINFOHEADER = record
        rcSource: TRECT;          // The bit we really want to use
        rcTarget: TRECT;          // Where the video should go
        dwBitRate: DWORD;         // Approximate bit data rate
        dwBitErrorRate: DWORD;    // Bit error rate for this stream
        AvgTimePerFrame: TREFERENCE_TIME;   // Average time per frame (100ns units)
        bmiHeader: TBITMAPINFOHEADER;
    end;
    PVIDEOINFOHEADER = ^TVIDEOINFOHEADER;

    // All the image based filters use this to communicate their media types. It's
    // centred principally around the BITMAPINFO. This structure always contains a
    // BITMAPINFOHEADER followed by a number of other fields depending on what the
    // BITMAPINFOHEADER contains. If it contains details of a palettised format it
    // will be followed by one or more RGBQUADs defining the palette. If it holds
    // details of a true colour format then it may be followed by a set of three
    // DWORD bit masks that specify where the RGB data can be found in the image
    // (For more information regarding BITMAPINFOs see the Win32 documentation)

    // The rcSource and rcTarget fields are not for use by filters supplying the
    // data. The destination (target) rectangle should be set to all zeroes. The
    // source may also be zero filled or set with the dimensions of the video. So
    // if the video is 352x288 pixels then set it to (0,0,352,288). These fields
    // are mainly used by downstream filters that want to ask the source filter
    // to place the image in a different position in an output buffer. So when
    // using for example the primary surface the video renderer may ask a filter
    // to place the video images in a destination position of (100,100,452,388)
    // on the display since that's where the window is positioned on the display

    // !!! WARNING !!!
    // DO NOT use this structure unless you are sure that the BITMAPINFOHEADER
    // has a normal biSize == sizeof(BITMAPINFOHEADER) !
    // !!! WARNING !!!

    TVIDEOINFO = record
        rcSource: TRECT;          // The bit we really want to use
        rcTarget: TRECT;          // Where the video should go
        dwBitRate: DWORD;         // Approximate bit data rate
        dwBitErrorRate: DWORD;    // Bit error rate for this stream
        AvgTimePerFrame: TREFERENCE_TIME;   // Average time per frame (100ns units)
        bmiHeader: TBITMAPINFOHEADER;
        case integer of
            0: (bmiColors: array [0..iPALETTE_COLORS - 1] of TRGBQUAD);     // Colour palette
            1: (dwBitMasks: array [0..iMASK_COLORS - 1] of DWORD);       // True colour masks
            2: (TrueColorInfo: TTRUECOLORINFO);                  // Both of the above
    end;
    PVIDEOINFO = ^TVIDEOINFO;


const
    // These macros define some standard bitmap format sizes

    SIZE_EGA_PALETTE = (iEGA_COLORS * sizeof(TRGBQUAD));
    SIZE_PALETTE = (iPALETTE_COLORS * sizeof(TRGBQUAD));
    SIZE_MASKS = (iMASK_COLORS * sizeof(DWORD));
    SIZE_PREHEADER = integer(@TVIDEOINFOHEADER(nil^).bmiHeader);
    SIZE_VIDEOHEADER = (sizeof(TBITMAPINFOHEADER) + SIZE_PREHEADER);
// !!! for abnormal biSizes
// #define SIZE_VIDEOHEADER(pbmi) ((pbmi).bmiHeader.biSize + SIZE_PREHEADER)


type
    // MPEG variant - includes a DWORD length followed by the
    // video sequence header after the video header.

    // The sequence header includes the sequence header start code and the
    // quantization matrices associated with the first sequence header in the
    // stream so is a maximum of 140 bytes longint.

    TMPEG1VIDEOINFO = record
        hdr: TVIDEOINFOHEADER;                    // Compatible with VIDEOINFO
        dwStartTimeCode: DWORD;        // 25-bit Group of pictures time code
        // at start of data
        cbSequenceHeader: DWORD;       // Length in bytes of bSequenceHeader
        bSequenceHeader: PByte;     // Sequence header including
        // quantization matrices if any
    end;
    PMPEG1VIDEOINFO = ^TMPEG1VIDEOINFO;


    // Analog video variant - Use this when the format is FORMAT_AnalogVideo

    // rcSource defines the portion of the active video signal to use
    // rcTarget defines the destination rectangle
    //    both of the above are relative to the dwActiveWidth and dwActiveHeight fields
    // dwActiveWidth is currently set to 720 for all formats (but could change for HDTV)
    // dwActiveHeight is 483 for NTSC and 575 for PAL/SECAM  (but could change for HDTV)

    TANALOGVIDEOINFO = record
        rcSource: TRECT;           // Width max is 720, height varies w/ TransmissionStd
        rcTarget: TRECT;           // Where the video should go
        dwActiveWidth: DWORD;      // Always 720 (CCIR-601 active samples per line)
        dwActiveHeight: DWORD;     // 483 for NTSC, 575 for PAL/SECAM
        AvgTimePerFrame: TREFERENCE_TIME;    // Normal ActiveMovie units (100 nS)
    end;
    PANALOGVIDEOINFO = ^TANALOGVIDEOINFO;


    // AM_KSPROPSETID_FrameStep property set definitions

    TAM_PROPERTY_FRAMESTEP = (
        //  Step
        AM_PROPERTY_FRAMESTEP_STEP = $01,
        AM_PROPERTY_FRAMESTEP_CANCEL = $02,

        //  S_OK for these 2 means we can - S_FALSE if we can't
        AM_PROPERTY_FRAMESTEP_CANSTEP = $03,
        AM_PROPERTY_FRAMESTEP_CANSTEPMULTIPLE = $04);
    PAM_PROPERTY_FRAMESTEP = ^TAM_PROPERTY_FRAMESTEP;

    TAM_FRAMESTEP_STEP = record
        //  1 means step 1 frame forward
        //  0 is invalid
        //  n (n > 1) means skip n - 1 frames and show the nth
        dwFramesToStep: DWORD;
    end;
    PAM_FRAMESTEP_STEP = ^TAM_FRAMESTEP_STEP;




// make sure the pbmi is initialized before using these macros
function TRUECOLOR(pbmi: TVIDEOINFO): PTRUECOLORINFO;
function COLORS(pbmi: TVIDEOINFO): PRGBQUAD;
function BITMASKS(pbmi: TVIDEOINFO): PDWORD;

// DIBSIZE calculates the number of bytes required by an image

function WIDTHBYTES(bits: DWORD): Dword;
function DIBWIDTHBYTES(bi: TBITMAPINFOHEADER): DWORD;
function _DIBSIZE(bi: TBITMAPINFOHEADER): dword;
function DIBSIZE(bi: TBITMAPINFOHEADER): dword;

// Different from DIBSIZE, RAWSIZE does NOT align the width to be multiple of 4 bytes.
// Given width, height, and bitCount, RAWSIZE calculates the image size without any extra padding at the end of each row.
function WIDTHBYTES_RAW(bits: Dword): DWORD;
function RAWWIDTHBYTES(bi: TBITMAPINFOHEADER): DWORD;
function _RAWSIZE(bi: TBITMAPINFOHEADER): DWORD;
function RAWSIZE(bi: TBITMAPINFOHEADER): DWORD;

// This compares the bit masks between two VIDEOINFOHEADERs
function BIT_MASKS_MATCH(pbmi1, pbmi2: TVIDEOINFO): boolean;

// These zero fill different parts of the VIDEOINFOHEADER structure
// Only use these macros for pbmi's with a normal BITMAPINFOHEADER biSize
procedure RESET_MASKS(pbmi: TVIDEOINFO);
procedure RESET_HEADER(pbmi: TVIDEOINFO);
procedure RESET_PALETTE(pbmi: TVIDEOINFO);

// Other (hopefully) useful bits and bobs
function PALETTISED(pbmi: TVIDEOINFO): boolean;
function PALETTE_ENTRIES(pbmi: TVIDEOINFO): DWORD;

// Returns the address of the BITMAPINFOHEADER from the VIDEOINFOHEADER
function HEADER(pVideoInfo: TVIDEOINFO): PVIDEOINFOHEADER;

function SIZE_MPEG1VIDEOINFO(pv: TMPEG1VIDEOINFO): DWORD;
function MPEG1_SEQUENCE_INFO(pv: TMPEG1VIDEOINFO): PByte;




implementation

uses
    Win32.IntSafe;



// make sure the pbmi is initialized before using these macros
function TRUECOLOR(pbmi: TVIDEOINFO): PTRUECOLORINFO;
begin
    Result := (@pbmi.bmiHeader) + pbmi.bmiHeader.biSize;
end;



function COLORS(pbmi: TVIDEOINFO): PRGBQUAD;
begin
    Result := (@pbmi.bmiHeader) + pbmi.bmiHeader.biSize;
end;



function BITMASKS(pbmi: TVIDEOINFO): PDWORD;
begin
    Result := (@pbmi.bmiHeader) + pbmi.bmiHeader.biSize;
end;




function WIDTHBYTES(bits: DWORD): Dword;
begin
    Result := ((bits + 31) and (not 31)) div 8;
end;



function DIBWIDTHBYTES(bi: TBITMAPINFOHEADER): DWORD;
begin
    Result := WIDTHBYTES(bi.biWidth * bi.biBitCount);
end;



function _DIBSIZE(bi: TBITMAPINFOHEADER): dword;
begin
    Result := (DIBWIDTHBYTES(bi) * bi.biHeight);
end;



function DIBSIZE(bi: TBITMAPINFOHEADER): dword;
begin
    if (bi.biHeight < 0) then
        Result := (-1) * (_DIBSIZE(bi))
    else
        Result := _DIBSIZE(bi);
end;



function SAFE_DIBWIDTHBYTES(const pbi: TBITMAPINFOHEADER; out pcbWidth: DWORD): HResult; inline;
var
    dw: DWORD;
begin

    if (pbi.biWidth < 0) or (pbi.biBitCount <= 0) then
    begin
        Result := E_INVALIDARG;
        Exit;
    end;
    //  Calculate width in bits
    Result := DWordMult(pbi.biWidth, pbi.biBitCount, dw);

    if (FAILED(Result)) then
    begin
        Exit;
    end;
    //  Round up to bytes
    if (dw and 7) = 7 then
        dw := dw div 8 + 1
    else
        dw := dw div 8;

    //  Round up to a multiple of 4 bytes
    if (dw and 3) = 3 then
    begin
        dw += 4 - (dw and 3);
    end;

    pcbWidth := dw;
    Result := S_OK;
end;



function SAFE_DIBSIZE(const pbi: TBITMAPINFOHEADER; out pcbSize: DWORD): HRESULT;
var
    dw: DWORD;
    dwWidthBytes: DWORD;
begin
    if (pbi.biHeight = $80000000) then
    begin
        Result := E_INVALIDARG;
        Exit;
    end;
    Result := SAFE_DIBWIDTHBYTES(pbi, dwWidthBytes);
    if (FAILED(Result)) then
    begin
        Exit;
    end;
    dw := abs(pbi.biHeight);
    Result := DWordMult(dw, dwWidthBytes, dw);
    if (FAILED(Result)) then
    begin
        Exit;
    end;
    pcbSize := dw;
    Result := S_OK;
end;


// Different from DIBSIZE, RAWSIZE does NOT align the width to be multiple of 4 bytes.
// Given width, height, and bitCount, RAWSIZE calculates the image size without any extra padding at the end of each row.
function WIDTHBYTES_RAW(bits: Dword): DWORD;
begin
    Result := (bits + 7) div 8;
end;



function RAWWIDTHBYTES(bi: TBITMAPINFOHEADER): DWORD;
begin
    Result := WIDTHBYTES_RAW(bi.biWidth * bi.biBitCount);
end;



function _RAWSIZE(bi: TBITMAPINFOHEADER): DWORD;
begin
    Result := RAWWIDTHBYTES(bi) * bi.biHeight;
end;



function RAWSIZE(bi: TBITMAPINFOHEADER): DWORD;
begin
    if bi.biHeight < 0 then
        Result := (-1) * (_RAWSIZE(bi))
    else
        Result := _RAWSIZE(bi);
end;



// This compares the bit masks between two VIDEOINFOHEADERs
function BIT_MASKS_MATCH(pbmi1, pbmi2: TVIDEOINFO): boolean;
begin
    Result := ((pbmi1.dwBitMasks[iRED] = pbmi2.dwBitMasks[iRED]) and (pbmi1.dwBitMasks[iGREEN] = pbmi2.dwBitMasks[iGREEN]) and
        (pbmi1.dwBitMasks[iBLUE] = pbmi2.dwBitMasks[iBLUE]));
end;



// These zero fill different parts of the VIDEOINFOHEADER structure
// Only use these macros for pbmi's with a normal BITMAPINFOHEADER biSize
procedure RESET_MASKS(pbmi: TVIDEOINFO);
begin
    ZeroMemory(@pbmi.dwBitMasks, SIZE_MASKS);
end;



procedure RESET_HEADER(pbmi: TVIDEOINFO);
begin
    ZeroMemory(@pbmi, SIZE_VIDEOHEADER);
end;



procedure RESET_PALETTE(pbmi: TVIDEOINFO);
begin
    ZeroMemory(@pbmi.bmiColors, SIZE_PALETTE);
end;




// Other (hopefully) useful bits and bobs

function PALETTISED(pbmi: TVIDEOINFO): boolean;
begin
    Result := (pbmi.bmiHeader.biBitCount <= iPALETTE);
end;



function PALETTE_ENTRIES(pbmi: TVIDEOINFO): DWORD;
begin
    Result := (1 shl pbmi.bmiHeader.biBitCount);
end;

// Returns the address of the BITMAPINFOHEADER from the VIDEOINFOHEADER

function HEADER(pVideoInfo: TVIDEOINFO): PVIDEOINFOHEADER;
begin
    Result := @pVideoInfo.bmiHeader;
end;



function SIZE_MPEG1VIDEOINFO(pv: TMPEG1VIDEOINFO): DWORD;
begin
    Result := integer(@TMPEG1VIDEOINFO(nil^).bSequenceHeader[0]) + pv.cbSequenceHeader;
end;



function MPEG1_SEQUENCE_INFO(pv: TMPEG1VIDEOINFO): PByte;
begin
    Result := pv.bSequenceHeader;
end;


end.
