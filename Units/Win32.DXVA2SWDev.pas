//------------------------------------------------------------------------------
// File: dxva2SWDev.h

// Desc: DirectX Video Acceleration 2 header file for software video
// processing devices

// Copyright (c) 1999 - 2002, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------

unit Win32.DXVA2SWDev;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils, Direct3D9,
    Win32.DXVA2API;

type


    TDXVA2_SampleFlags = (
        DXVA2_SampleFlag_Palette_Changed = $00000001,
        DXVA2_SampleFlag_SrcRect_Changed = $00000002,
        DXVA2_SampleFlag_DstRect_Changed = $00000004,
        DXVA2_SampleFlag_ColorData_Changed = $00000008,
        DXVA2_SampleFlag_PlanarAlpha_Changed = $00000010,
        DXVA2_SampleFlag_RFF = $00010000,
        DXVA2_SampleFlag_TFF = $00020000,
        DXVA2_SampleFlag_RFF_TFF_Present = $00040000,
        DXVA2_SampleFlagsMask = $FFFF001F);

    TDXVA2_DestinationFlags = (
        DXVA2_DestinationFlag_Background_Changed = $00000001,
        DXVA2_DestinationFlag_TargetRect_Changed = $00000002,
        DXVA2_DestinationFlag_ColorData_Changed = $00000004,
        DXVA2_DestinationFlag_Alpha_Changed = $00000008,
        DXVA2_DestinationFlag_RFF = $00010000,
        DXVA2_DestinationFlag_TFF = $00020000,
        DXVA2_DestinationFlag_RFF_TFF_Present = $00040000,
        DXVA2_DestinationFlagMask = $FFFF000F);

    TDXVA2_VIDEOSAMPLE = record
        Start: TREFERENCE_TIME;
        Ende: TREFERENCE_TIME;
        SampleFormat: TDXVA2_ExtendedFormat;
        SampleFlags: UINT;
        SrcResource: Pointer;
        SrcRect: TRECT;
        DstRect: TRECT;
        Pal: array[0..15] of TDXVA2_AYUVSample8;
        PlanarAlpha: TDXVA2_Fixed32;
    end;

    TDXVA2_VIDEOPROCESSBLT = record
        TargetFrame: TREFERENCE_TIME;
        TargetRect: TRECT;
        ConstrictionSize: TSIZE;
        StreamingFlags: UINT;
        BackgroundColor: TDXVA2_AYUVSample16;
        DestFormat: TDXVA2_ExtendedFormat;
        DestFlags: UINT;
        ProcAmpValues: TDXVA2_ProcAmpValues;
        Alpha: TDXVA2_Fixed32;
        NoiseFilterLuma: TDXVA2_FilterValues;
        NoiseFilterChroma: TDXVA2_FilterValues;
        DetailFilterLuma: TDXVA2_FilterValues;
        DetailFilterChroma: TDXVA2_FilterValues;
        pSrcSurfaces: PDXVA2_VIDEOSAMPLE;
        NumSrcSurfaces: UINT;
    end;


    PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETCOUNT = function(const pVideoDesc: TDXVA2_VideoDesc; out pCount: UINT): HResult; stdcall;

    PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETS = function(const pVideoDesc: TDXVA2_VideoDesc; Count: UINT;
        out pFormats {arraysize Count}: PD3DFORMAT): HResult; stdcall;

    PDXVA2SW_GETVIDEOPROCESSORCAPS = function(const pVideoDesc: TDXVA2_VideoDesc; RenderTargetFormat: TD3DFORMAT;
        out pCaps: TDXVA2_VideoProcessorCaps): HResult; stdcall;

    PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATCOUNT = function(const pVideoDesc: TDXVA2_VideoDesc;
        RenderTargetFormat: TD3DFORMAT; out pCount: UINT): HResult; stdcall;

    PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATS = function(const pVideoDesc: TDXVA2_VideoDesc; RenderTargetFormat: TD3DFORMAT;
        Count: UINT; out pFormats {arraysize Count}: PD3DFORMAT): HResult; stdcall;

    PDXVA2SW_GETPROCAMPRANGE = function(const pVideoDesc: TDXVA2_VideoDesc; RenderTargetFormat: TD3DFORMAT;
        ProcAmpCap: UINT; out pRange: TDXVA2_ValueRange): HResult; stdcall;

    PDXVA2SW_GETFILTERPROPERTYRANGE = function(const pVideoDesc: TDXVA2_VideoDesc; RenderTargetFormat: TD3DFORMAT;
        FilterSetting: UINT; out pRange: TDXVA2_ValueRange): HResult; stdcall;

    PDXVA2SW_CREATEVIDEOPROCESSDEVICE = function(pD3DD9: IDirect3DDevice9; const pVideoDesc: TDXVA2_VideoDesc;
        RenderTargetFormat: TD3DFORMAT; MaxSubStreams: UINT; out phDevice: THANDLE): HResult; stdcall;

    PDXVA2SW_DESTROYVIDEOPROCESSDEVICE = function(hDevice: THANDLE): HResult; stdcall;

    PDXVA2SW_VIDEOPROCESSBEGINFRAME = function(hDevice: THANDLE): HResult; stdcall;

    PDXVA2SW_VIDEOPROCESSENDFRAME = function(hDevice: THANDLE; var pHandleComplete: THANDLE): HResult; stdcall;

    PDXVA2SW_VIDEOPROCESSSETRENDERTARGET = function(hDevice: THANDLE; pRenderTarget: IDirect3DSurface9): HResult; stdcall;

    PDXVA2SW_VIDEOPROCESSBLT = function(hDevice: THANDLE; const pBlt: TDXVA2_VIDEOPROCESSBLT): HResult; stdcall;

    TDXVA2SW_CALLBACKS = record
        Size: UINT;
        GetVideoProcessorRenderTargetCount: PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETCOUNT;
        GetVideoProcessorRenderTargets: PDXVA2SW_GETVIDEOPROCESSORRENDERTARGETS;
        GetVideoProcessorCaps: PDXVA2SW_GETVIDEOPROCESSORCAPS;
        GetVideoProcessorSubStreamFormatCount: PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATCOUNT;
        GetVideoProcessorSubStreamFormats: PDXVA2SW_GETVIDEOPROCESSORSUBSTREAMFORMATS;
        GetProcAmpRange: PDXVA2SW_GETPROCAMPRANGE;
        GetFilterPropertyRange: PDXVA2SW_GETFILTERPROPERTYRANGE;
        CreateVideoProcessDevice: PDXVA2SW_CREATEVIDEOPROCESSDEVICE;
        DestroyVideoProcessDevice: PDXVA2SW_DESTROYVIDEOPROCESSDEVICE;
        VideoProcessBeginFrame: PDXVA2SW_VIDEOPROCESSBEGINFRAME;
        VideoProcessEndFrame: PDXVA2SW_VIDEOPROCESSENDFRAME;
        VideoProcessSetRenderTarget: PDXVA2SW_VIDEOPROCESSSETRENDERTARGET;
        VideoProcessBlt: PDXVA2SW_VIDEOPROCESSBLT;
    end;
    PDXVA2SW_CALLBACKS = ^TDXVA2SW_CALLBACKS;

implementation

end.
