program DXVA_VideoProc;

// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.

// Copyright (c) Microsoft Corporation. All rights reserved.

(*++

Copyright (c) 2006  Microsoft Corporation

Module Name:

    dxva2vp.cpp

Abstract:

    This sample code demonstrates DXVA2 Video Processor API.

Environment:

    Windows XP or later.

Command line options:

    -hh : Force to use hardware D3D9 device and hardware DXVA2 device.
    -hs : Force to use hardware D3D9 device and software DXVA2 device.
    -ss : Force to use software D3D9 device and software DXVA2 device.

Keyboard assignment:

    ESC or Alt + F4 : Exit.

    Alt + Enter : Mode change between Window mode and Fullscreen mode.

    F1 - F8 : Sub stream's color is changed and enters in the following modes.

    HOME : Reset to the default/initial values in each modes.

    END : Enable/Disable the frame drop debug spew.

    F1 : [WHITE] Increment and decrement alpha values.

        UP   : increment main and sub stream's planar alpha
        DOWN : decrement main and sub stream's planar alpha
        RIGHT: increment sub stream's pixel alpha
        LEFT : decrement sub stream's pixel alpha

    F2 : [RED] Increment and decrement main stream's source area.

        UP   : decrement in the vertical direction (zoom in)
        DOWN : increment in the vertical direction (zoom out)
        RIGHT: increment in the horizontal direction (zoom in)
        LEFT : decrement in the horizontal direction (zoom out)

    F3 : [YELLOW] Move main stream's source area.

        UP   : move up
        DOWN : move down
        RIGHT: move right
        LEFT : move left

    F4 : [GREEN] Increment and decrement main stream's destination area.

        UP   : increment in the vertical direction
        DOWN : decrement in the vertical direction
        RIGHT: increment in the horizontal direction
        LEFT : decrement in the horizontal direction

    F5 : [CYAN] Move main stream's destination area.

        UP   : move up
        DOWN : move down
        RIGHT: move right
        LEFT : move left

    F6 : [BLUE] Change background color or extended color information.

        UP   : change to the next extended color in EX_COLOR_INFO
        DOWN : change to the previous extended color in EX_COLOR_INFO
        RIGHT: change to the next background color in BACKGROUND_COLORS
        LEFT : change to the previous background color in BACKGROUND_COLORS

        EX_COLOR_INFO : SDTV ITU-R BT.601 YCbCr to driver's optimal RGB range,
                        SDTV ITU-R BT.601 YCbCr to studio RGB [16...235],
                        SDTV ITU-R BT.601 YCbCr to computer RGB [0...255],
                        HDTV ITU-R BT.709 YCbCr to driver's optimal RGB range,
                        HDTV ITU-R BT.709 YCbCr to studio RGB [16...235],
                        HDTV ITU-R BT.709 YCbCr to computer RGB [0...255]

        BACKGROUND_COLORS : WHITE, RED, YELLOW, GREEN, CYAN, BLUE, MAGENTA, BLACK

    F7 : [MAGENTA] Increment and decrement the brightness or contrast.

        UP   : increment brightness
        DOWN : decrement brightness
        RIGHT: increment contrast
        LEFT : decrement contrast

    F8 : [BLACK] Increment and decrement the hue or saturation.

        UP   : increment hue
        DOWN : decrement hue
        RIGHT: increment saturation
        LEFT : decrement saturation

    F9 : [ORANGE] Increment and decrement target area.

        UP   : decrement in the vertical direction
        DOWN : increment in the vertical direction
        RIGHT: increment in the horizontal direction
        LEFT : decrement in the horizontal direction

--*)


{$mode delphi}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
    cthreads, {$ENDIF} {$ENDIF}
    Interfaces, // this includes the LCL widgetset

    { you can add units after this }
    Windows,
    SysUtils,
    ActiveX,
    CMC.DXVA2API,
    CMC.MFAPI,
    CMC.DWMAPI,
    MMSystem,
    Math,
    Direct3D9;

const
    CLASS_NAME = 'DXVA2 VP Sample Class';
    WINDOW_NAME = 'DXVA2 VP Sample Application';

    VIDEO_MAIN_WIDTH = 640;
    VIDEO_MAIN_HEIGHT = 480;
    VIDEO_SUB_WIDTH = 128;
    VIDEO_SUB_HEIGHT = 128;
    VIDEO_SUB_VX = 5;
    VIDEO_SUB_VY = 3;
    VIDEO_FPS = 60;
    VIDEO_MSPF = UINT((1000 + VIDEO_FPS div 2) div VIDEO_FPS);
    VIDEO_100NSPF = VIDEO_MSPF * 10000;
    DEFAULT_PLANAR_ALPHA_VALUE = $FF;
    DEFAULT_PIXEL_ALPHA_VALUE = $80;
    VIDEO_REQUIED_OP = DXVA2_VideoProcess_YUV2RGB or DXVA2_VideoProcess_StretchX or DXVA2_VideoProcess_StretchY or
        DXVA2_VideoProcess_SubRects or DXVA2_VideoProcess_SubStreams;

    VIDEO_RENDER_TARGET_FORMAT = D3DFMT_X8R8G8B8;
    VIDEO_MAIN_FORMAT = D3DFMT_YUY2;
    BACK_BUFFER_COUNT = 1;
    SUB_STREAM_COUNT = 1;
    DWM_BUFFER_COUNT = 4;

    EX_COLOR_INFO: array [0..5, 0..1] of UINT = (

        // SDTV ITU-R BT.601 YCbCr to driver's optimal RGB range
        (Ord(DXVA2_VideoTransferMatrix_BT601), Ord(DXVA2_NominalRange_Unknown)),
        // SDTV ITU-R BT.601 YCbCr to studio RGB [16...235]
        (Ord(DXVA2_VideoTransferMatrix_BT601), Ord(DXVA2_NominalRange_16_235)),
        // SDTV ITU-R BT.601 YCbCr to computer RGB [0...255]
        (Ord(DXVA2_VideoTransferMatrix_BT601), Ord(DXVA2_NominalRange_0_255)),
        // HDTV ITU-R BT.709 YCbCr to driver's optimal RGB range
        (Ord(DXVA2_VideoTransferMatrix_BT709), Ord(DXVA2_NominalRange_Unknown)),
        // HDTV ITU-R BT.709 YCbCr to studio RGB [16...235]
        (Ord(DXVA2_VideoTransferMatrix_BT709), Ord(DXVA2_NominalRange_16_235)),
        // HDTV ITU-R BT.709 YCbCr to computer RGB [0...255]
        (Ord(DXVA2_VideoTransferMatrix_BT709), Ord(DXVA2_NominalRange_0_255)));


    VIDEO_MAIN_RECT: TRECT = (Left: 0; Top: 0; Right: VIDEO_MAIN_WIDTH; Bottom: VIDEO_MAIN_HEIGHT);
    VIDEO_SUB_RECT: TRECT = (Left: 0; Top: 0; Right: VIDEO_SUB_WIDTH; Bottom: VIDEO_SUB_HEIGHT);

type

    // Type definitions.
    PFNDWMISCOMPOSITIONENABLED = function(out pfEnabled: boolean): HResult; stdcall;
    PFNDWMGETCOMPOSITIONTIMINGINFO = function(hwnd: HWND; out pTimingInfo: TDWM_TIMING_INFO): HResult; stdcall;
    PFNDWMSETPRESENTPARAMETERS = function(hwnd: HWND; var pPresentParams: TDWM_PRESENT_PARAMETERS): HResult; stdcall;

var

    // Global variables.
    g_bD3D9HW: boolean = True;
    g_bD3D9SW: boolean = True;
    g_bDXVA2HW: boolean = True;
    g_bDXVA2SW: boolean = True;

    g_bWindowed: boolean = True;
    g_bTimerSet: boolean = False;
    g_bInModeChange: boolean = False;
    g_bUpdateSubStream: boolean = False;
    g_bDspFrameDrop: boolean = False;
    g_bDwmQueuing: boolean = False;

    g_Hwnd: HWND = 0;
    g_hTimer: THANDLE = 0;
    g_hRgb9rastDLL: HMODULE = 0;
    g_hDwmApiDLL: HMODULE = 0;

    g_StartSysTime: DWORD = 0;
    g_PreviousTime: DWORD = 0;

    g_pD3D9: IDirect3D9 = nil;
    g_pD3DD9: IDirect3DDevice9 = nil;
    g_pD3DRT: IDirect3DSurface9 = nil;

    g_pDXVAVPS: IDirectXVideoProcessorService = nil;
    g_pDXVAVPD: IDirectXVideoProcessor = nil;

    g_pMainStream: IDirect3DSurface9 = nil;
    g_pSubStream: IDirect3DSurface9 = nil;

    g_TargetWidthPercent: UINT = 100;
    g_TargetHeightPercent: UINT = 100;

    g_pfnD3D9GetSWInfo: pointer = nil;
    g_pfnDwmIsCompositionEnabled: pointer = nil;
    g_pfnDwmGetCompositionTimingInfo: pointer = nil;
    g_pfnDwmSetPresentParameters: pointer = nil;

    { initialize zero memory }
    g_D3DPP: D3DPRESENT_PARAMETERS;
    g_GuidVP: TGUID;
    g_VideoDesc: TDXVA2_VideoDesc;
    g_VPCaps: TDXVA2_VideoProcessorCaps;

    VIDEO_SUB_FORMAT: TD3DFormat; // ToDo

    g_ProcAmpRanges: array [0..3] of TDXVA2_ValueRange; // ={0}
    g_NFilterRanges: array [0..5] of TDXVA2_ValueRange;// = {0};
    g_DFilterRanges: array [0..5] of TDXVA2_ValueRange; // = {0};

    g_ProcAmpValues: array [0..3] of TDXVA2_Fixed32; // = {0};
    g_NFilterValues: array [0..5] of TDXVA2_Fixed32; // = {0};
    g_DFilterValues: array [0..5] of TDXVA2_Fixed32;// = {0};
    g_BackgroundColor: integer = 0;
    g_ExColorInfo: integer = 0;
    g_ProcAmpSteps: array [0..3] of integer; // = {0};

    g_VK_Fx: UINT = VK_F1;

    // 100%
    RGB_WHITE: TD3DCOLOR;//  = D3DCOLOR_XRGB($EB, $EB, $EB);
    RGB_RED: TD3DCOLOR;//  =       = D3DCOLOR_XRGB($EB, $10, $10);
    RGB_YELLOW: TD3DCOLOR;//       = D3DCOLOR_XRGB($EB, $EB, $10);
    RGB_GREEN: TD3DCOLOR;//       = D3DCOLOR_XRGB($10, $EB, $10);
    RGB_CYAN: TD3DCOLOR;//       = D3DCOLOR_XRGB($10, $EB, $EB);
    RGB_BLUE: TD3DCOLOR;//       = D3DCOLOR_XRGB($10, $10, $EB);
    RGB_MAGENTA: TD3DCOLOR;//     = D3DCOLOR_XRGB($EB, $10, $EB);
    RGB_BLACK: TD3DCOLOR;//       = D3DCOLOR_XRGB($10, $10, $10);
    RGB_ORANGE: TD3DCOLOR;//      = D3DCOLOR_XRGB($EB, $7E, $10);


    // 75%
    RGB_WHITE_75pc: TD3DCOLOR;//   = D3DCOLOR_XRGB($B4, $B4, $B4);
    RGB_YELLOW_75pc: TD3DCOLOR;//  = D3DCOLOR_XRGB($B4, $B4, $10);
    RGB_CYAN_75pc: TD3DCOLOR;//   = D3DCOLOR_XRGB($10, $B4, $B4);
    RGB_GREEN_75pc: TD3DCOLOR;//  = D3DCOLOR_XRGB($10, $B4, $10);
    RGB_MAGENTA_75pc: TD3DCOLOR;// = D3DCOLOR_XRGB($B4, $10, $B4);
    RGB_RED_75pc: TD3DCOLOR;//   = D3DCOLOR_XRGB($B4, $10, $10);
    RGB_BLUE_75pc: TD3DCOLOR;//   = D3DCOLOR_XRGB($10, $10, $B4);

    // -4% / +4%
    RGB_BLACK_n4pc: TD3DCOLOR;//  = D3DCOLOR_XRGB($07, $07, $07);
    RGB_BLACK_p4pc: TD3DCOLOR;//  = D3DCOLOR_XRGB($18, $18, $18);

    // -Inphase / +Quadrature
    RGB_I: TD3DCOLOR;//      = D3DCOLOR_XRGB($00, $1D, $42);
    RGB_Q: TD3DCOLOR;//     = D3DCOLOR_XRGB($2C, $00, $5C);


    g_PlanarAlphaValue: word = DEFAULT_PLANAR_ALPHA_VALUE;
    g_PixelAlphaValue: byte = DEFAULT_PIXEL_ALPHA_VALUE;

    g_RectWindow: TRECT;// = {0};

    BACKGROUND_COLORS: array [0..7] of D3DCOLOR;

    g_SrcRect: TRECT = (Left: 0; Top: 0; Right: VIDEO_MAIN_WIDTH; Bottom: VIDEO_MAIN_HEIGHT);
    g_DstRect: TRECT = (Left: 0; Top: 0; Right: VIDEO_MAIN_WIDTH; Bottom: VIDEO_MAIN_HEIGHT);


{$R *.res}


    function CompareDXVA2ValueRange(x, y: TDXVA2_ValueRange): boolean; inline;
    begin
        Result := CompareMem(@x, @y, sizeof(TDXVA2_ValueRange));
    end;



    function RegisterSoftwareRasterizer(): boolean;
    var
        hr: HRESULT;
    begin
        if (g_hRgb9rastDLL = 0) then
        begin
            Result := False;
            Exit;
        end;
        hr := g_pD3D9.RegisterSoftwareDevice(g_pfnD3D9GetSWInfo);
        if (FAILED(hr)) then
        begin
            //DBGMSG((TEXT("RegisterSoftwareDevice failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;
        Result := True;
    end;



    function InitializeD3D9(): boolean;
    var
        hr: HResult;
    begin
        g_pD3D9 := Direct3DCreate9(D3D_SDK_VERSION);
        if (g_pD3D9 = nil) then
        begin
            // DBGMSG((TEXT("Direct3DCreate9 failed.\n")));
            Result := False;
            Exit;
        end;


        // Register the inbox software rasterizer if software D3D9 could be used.
        // CreateDevice(D3DDEVTYPE_SW) will fail if software device is not registered.
        if (g_bD3D9SW) then
        begin
            RegisterSoftwareRasterizer();
        end;
        if (g_bWindowed) then
        begin
            g_D3DPP.BackBufferWidth := 0;
            g_D3DPP.BackBufferHeight := 0;
        end
        else
        begin
            g_D3DPP.BackBufferWidth := GetSystemMetrics(SM_CXSCREEN);
            g_D3DPP.BackBufferHeight := GetSystemMetrics(SM_CYSCREEN);
        end;

        g_D3DPP.BackBufferFormat := VIDEO_RENDER_TARGET_FORMAT;
        g_D3DPP.BackBufferCount := BACK_BUFFER_COUNT;
        g_D3DPP.SwapEffect := D3DSWAPEFFECT_DISCARD;
        g_D3DPP.hDeviceWindow := g_Hwnd;
        g_D3DPP.Windowed := g_bWindowed;
        g_D3DPP.Flags := D3DPRESENTFLAG_VIDEO;
        g_D3DPP.FullScreen_RefreshRateInHz := D3DPRESENT_RATE_DEFAULT;
        g_D3DPP.PresentationInterval := D3DPRESENT_INTERVAL_ONE;


        // Mark the back buffer lockable if software DXVA2 could be used.
        // This is because software DXVA2 device requires a lockable render target
        // for the optimal performance.

        if (g_bDXVA2SW) then
        begin
            g_D3DPP.Flags := g_D3DPP.Flags or D3DPRESENTFLAG_LOCKABLE_BACKBUFFER;
        end;

        // First try to create a hardware D3D9 device.
        if (g_bD3D9HW) then
        begin
            hr := g_pD3D9.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, g_Hwnd, D3DCREATE_FPU_PRESERVE or
                D3DCREATE_MULTITHREADED or D3DCREATE_SOFTWARE_VERTEXPROCESSING, @g_D3DPP, g_pD3DD9);
            if (FAILED(hr)) then
            begin
                // DBGMSG((TEXT("CreateDevice(HAL) failed with error $%x.\n"), hr));
            end;
        end;


        // Next try to create a software D3D9 device.

        if (g_pD3DD9 = nil) and (g_bD3D9SW) then
        begin
            hr := g_pD3D9.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_SW, g_Hwnd, D3DCREATE_FPU_PRESERVE or
                D3DCREATE_MULTITHREADED or D3DCREATE_SOFTWARE_VERTEXPROCESSING, @g_D3DPP, g_pD3DD9);

            if (FAILED(hr)) then
            begin
                // DBGMSG((TEXT("CreateDevice(SW) failed with error $%x.\n"), hr));
            end;
        end;

        if (g_pD3DD9 = nil) then
        begin
            Result := False;
            Exit;
        end;
        Result := True;
    end;



    procedure DestroyD3D9();
    begin
        if (g_pD3DD9 <> nil) then
            g_pD3DD9 := nil;
        if (g_pD3D9 <> nil) then
            g_pD3D9 := nil;
    end;



    function ComputeLongSteps(range: TDXVA2_ValueRange): integer;
    var
        f_step: single;
        f_max: single;
        f_min: single;
        steps: integer;
    begin
        f_step := DXVA2FixedToFloat(range.StepSize);
        if (f_step = 0.0) then
        begin
            Result := 0;
            Exit;
        end;
        f_max := DXVA2FixedToFloat(range.MaxValue);
        f_min := DXVA2FixedToFloat(range.MinValue);
        steps := trunc((f_max - f_min) / f_step / 32);
        Result := max(steps, 1);
    end;



    function CreateDXVA2VPDevice(const guid: TGUID): boolean;
    var
        hr: HResult;
        i, Count: UINT;
        formats: PD3DFORMAT;
        range: TDXVA2_ValueRange;
    begin
        // Query the supported render target format.
        formats := nil;
        hr := g_pDXVAVPS.GetVideoProcessorRenderTargets(guid, g_VideoDesc, Count, formats);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("GetVideoProcessorRenderTargets failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        for i := 0 to Count - 1 do
        begin
            if (formats[i] = VIDEO_RENDER_TARGET_FORMAT) then
            begin
                break;
            end;
        end;

        CoTaskMemFree(formats);

        if (i >= Count) then
        begin
            // DBGMSG((TEXT("GetVideoProcessorRenderTargets doesn't support that format.\n")));
            Result := False;
            Exit;
        end;

        // Query the supported substream format.
        formats := nil;
        hr := g_pDXVAVPS.GetVideoProcessorSubStreamFormats(guid, g_VideoDesc, VIDEO_RENDER_TARGET_FORMAT, Count, formats);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("GetVideoProcessorSubStreamFormats failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;
        for i := 0 to Count - 1 do
        begin
            if (formats[i] = VIDEO_SUB_FORMAT) then
            begin
                break;
            end;
        end;

        CoTaskMemFree(formats);

        if (i >= Count) then
        begin
            // DBGMSG((TEXT("GetVideoProcessorSubStreamFormats doesn't support that format.\n")));
            Result := False;
            Exit;
        end;

        // Query video processor capabilities.
        hr := g_pDXVAVPS.GetVideoProcessorCaps(guid, g_VideoDesc, VIDEO_RENDER_TARGET_FORMAT, g_VPCaps);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("GetVideoProcessorCaps failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Check to see if the device is software device.
        if (g_VPCaps.DeviceCaps and DXVA2_VPDev_SoftwareDevice = DXVA2_VPDev_SoftwareDevice) then
        begin
            if (not g_bDXVA2SW) then
            begin
                // DBGMSG((TEXT("The DXVA2 device isn't a hardware device.\n")));
                Result := False;
                Exit;
            end;
        end
        else
        begin
            if (not g_bDXVA2HW) then
            begin
                // DBGMSG((TEXT("The DXVA2 device isn't a software device.\n")));
                Result := False;
                Exit;
            end;
        end;

        // This is a progressive device and we cannot provide any reference sample.
        if (g_VPCaps.NumForwardRefSamples > 0) or (g_VPCaps.NumBackwardRefSamples > 0) then
        begin
            // DBGMSG((TEXT("NumForwardRefSamples or NumBackwardRefSamples is greater than 0.\n")));
            Result := False;
            Exit;
        end;

        // Check to see if the device supports all the VP operations we want.
        if ((g_VPCaps.VideoProcessorOperations and VIDEO_REQUIED_OP) <> VIDEO_REQUIED_OP) then
        begin
            // DBGMSG((TEXT("The DXVA2 device doesn't support the VP operations.\n")));
            Result := False;
            Exit;
        end;

        // Create a main stream surface.
        hr := g_pDXVAVPS.CreateSurface(VIDEO_MAIN_WIDTH, VIDEO_MAIN_HEIGHT, 0, VIDEO_MAIN_FORMAT, g_VPCaps.InputPool,
            0, DXVA2_VideoSoftwareRenderTarget, g_pMainStream, nil);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("CreateSurface(MainStream) failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Create a sub stream surface.
        hr := g_pDXVAVPS.CreateSurface(VIDEO_SUB_WIDTH, VIDEO_SUB_HEIGHT, 0, VIDEO_SUB_FORMAT, g_VPCaps.InputPool,
            0, DXVA2_VideoSoftwareRenderTarget, g_pSubStream, nil);

        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("CreateSurface(SubStream, InputPool) failed with error $%x.\n"), hr));
        end;


        // Fallback to default pool type if the suggested pool type failed.

        // This could happen when software DXVA2 device is used with hardware D3D9 device.
        // This is due to the fact that D3D9 doesn't understand AYUV format and D3D9 needs
        // an information from the driver in order to allocate it from the system memory.
        // Since software DXVA2 device suggests system memory pool type for the optimal
        // performance but the driver may not support it other than default pool type,
        // D3D9 will fail to create it.

        // Note that creating a default pool type surface will significantly reduce the
        // performance when it is used with software DXVA2 device.

        if (g_pSubStream = nil) and (Ord(g_VPCaps.InputPool) <> Ord(D3DPOOL_DEFAULT)) then
        begin
            hr := g_pDXVAVPS.CreateSurface(VIDEO_SUB_WIDTH, VIDEO_SUB_HEIGHT, 0, VIDEO_SUB_FORMAT, Ord(D3DPOOL_DEFAULT),
                0, DXVA2_VideoSoftwareRenderTarget, g_pSubStream, nil);
            if (FAILED(hr)) then
            begin
                // DBGMSG((TEXT("CreateSurface(SubStream, DEFAULT) failed with error $%x.\n"), hr));
            end;
        end;

        if (g_pSubStream = nil) then
        begin
            Result := False;
            Exit;
        end;

        // Query ProcAmp ranges.
        for i := 0 to Length(g_ProcAmpRanges) - 1 do
        begin
            if ((g_VPCaps.ProcAmpControlCaps and (1 shl i)) <> 0) then
            begin
                hr := g_pDXVAVPS.GetProcAmpRange(guid, g_VideoDesc, VIDEO_RENDER_TARGET_FORMAT, 1 shl i, range);
                if (FAILED(hr)) then
                begin
                    // DBGMSG((TEXT("GetProcAmpRange failed with error $%x.\n"), hr));
                    Result := False;
                    Exit;
                end;
                // Reset to default value if the range is changed.
                if not CompareDXVA2ValueRange(range, g_ProcAmpRanges[i]) then
                begin
                    g_ProcAmpRanges[i] := range;
                    g_ProcAmpValues[i] := range.DefaultValue;
                    g_ProcAmpSteps[i] := ComputeLongSteps(range);
                end;
            end;
        end;

        // Query Noise Filter ranges.
        if ((g_VPCaps.VideoProcessorOperations and DXVA2_VideoProcess_NoiseFilter) <> 0) then
        begin
            for i := 0 to length(g_NFilterRanges) - 1 do
            begin
                hr := g_pDXVAVPS.GetFilterPropertyRange(guid, g_VideoDesc, VIDEO_RENDER_TARGET_FORMAT,
                    DXVA2_NoiseFilterLumaLevel + i, range);
                if (FAILED(hr)) then
                begin
                    // DBGMSG((TEXT("GetFilterPropertyRange(Noise) failed with error $%x.\n"), hr));
                    Result := False;
                    Exit;
                end;
                // Reset to default value if the range is changed.
                if not CompareDXVA2ValueRange(range, g_NFilterRanges[i]) then
                begin
                    g_NFilterRanges[i] := range;
                    g_NFilterValues[i] := range.DefaultValue;
                end;
            end;
        end;
        // Query Detail Filter ranges.

        if ((g_VPCaps.VideoProcessorOperations and DXVA2_VideoProcess_DetailFilter) <> 0) then
        begin
            for i := 0 to length(g_DFilterRanges) - 1 do
            begin
                hr := g_pDXVAVPS.GetFilterPropertyRange(guid, g_VideoDesc, VIDEO_RENDER_TARGET_FORMAT,
                    DXVA2_DetailFilterLumaLevel + i, range);
                if (FAILED(hr)) then
                begin
                    // DBGMSG((TEXT("GetFilterPropertyRange(Detail) failed with error $%x.\n"), hr));
                    Result := False;
                    Exit;
                end;
                // Reset to default value if the range is changed.

                if not CompareDXVA2ValueRange(range, g_DFilterRanges[i]) then
                begin
                    g_DFilterRanges[i] := range;
                    g_DFilterValues[i] := range.DefaultValue;
                end;
            end;
        end;

        // Finally create a video processor device.
        hr := g_pDXVAVPS.CreateVideoProcessor(guid, g_VideoDesc, VIDEO_RENDER_TARGET_FORMAT, SUB_STREAM_COUNT, g_pDXVAVPD);

        if (FAILED(hr)) then
        begin
            //  DBGMSG((TEXT("CreateVideoProcessor failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        g_GuidVP := guid;
        Result := True;
    end;



    function RGBtoYUV(const rgb: TD3DCOLOR): DWORD;
    var
        A, R, G, B: integer;
        Y, U, V: integer;
    begin
        A := HIBYTE(HIWORD(rgb));
        R := LOBYTE(HIWORD(rgb)) - 16;
        G := HIBYTE(LOWORD(rgb)) - 16;
        B := LOBYTE(LOWORD(rgb)) - 16;
        // studio RGB [16...235] to SDTV ITU-R BT.601 YCbCr
        Y := (77 * R + 150 * G + 29 * B + 128) div 256 + 16;
        U := (-44 * R - 87 * G + 131 * B + 128) div 256 + 128;
        V := (131 * R - 110 * G - 21 * B + 128) div 256 + 128;
        Result := D3DCOLOR_AYUV(A, Y, U, V);
    end;



    function RGBtoYUY2(const rgb: TD3DCOLOR): DWORD;
    var
        yuv: TD3DCOLOR;
        y, u, v: byte;
    begin
        yuv := RGBtoYUV(rgb);
        Y := LOBYTE(HIWORD(yuv));
        U := HIBYTE(LOWORD(yuv));
        V := LOBYTE(LOWORD(yuv));
        Result := MAKELONG(MAKEWORD(Y, U), MAKEWORD(Y, V));
    end;



    procedure FillRectangle(lr: TD3DLOCKED_RECT; const sx: UINT; const sy: UINT; const ex: UINT; const ey: UINT; const color: DWORD);
    var
        y: uint;
        P: PDWORD;
        x: uint;
    begin
        p := lr.pBits;
        p := p + (lr.Pitch div 4) * sy; // cause the Pitch is in Byte and we have a pointer to a DWORD ;)

        for y := sy to ey - 1 do
        begin
            for  x := sx to ex - 1 do
            begin
                P[x] := Color;
            end;
            p := p + (lr.Pitch div 4);  // cause the Pitch is in Byte and we have a pointer to a DWORD ;)
        end;
    end;



    function UpdateSubStream(): boolean;
    var
        hr: HResult;
        color: TD3DCOLOR;
        lr: TD3DLOCKED_RECT;
        R, G, B: byte;
    begin
        if (not g_bUpdateSubStream) then
        begin
            Result := True;
            Exit;
        end;

        case (g_VK_Fx) of
            VK_F1:
            begin
                color := RGB_WHITE;
            end;
            VK_F2:
            begin
                color := RGB_RED;
            end;
            VK_F3:
            begin
                color := RGB_YELLOW;
            end;
            VK_F4:
            begin
                color := RGB_GREEN;
            end;
            VK_F5:
            begin
                color := RGB_CYAN;
            end;
            VK_F6:
            begin
                color := RGB_BLUE;
            end;
            VK_F7:
            begin
                color := RGB_MAGENTA;
            end;
            VK_F8:
            begin
                color := RGB_BLACK;
            end;
            VK_F9:
            begin
                color := RGB_ORANGE;
            end;
            else
            begin
                Result := False;
                Exit;
            end;
        end;

        hr := g_pSubStream.LockRect(lr, nil, D3DLOCK_NOSYSLOCK);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("LockRect failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        R := LOBYTE(HIWORD(color));
        G := HIBYTE(LOWORD(color));
        B := LOBYTE(LOWORD(color));

        FillRectangle(lr, 0, 0, VIDEO_SUB_WIDTH, VIDEO_SUB_HEIGHT,
            RGBtoYUV(D3DCOLOR_ARGB(g_PixelAlphaValue, R, G, B)));

        hr := g_pSubStream.UnlockRect();

        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("UnlockRect failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        g_bUpdateSubStream := False;

        Result := True;
    end;



    function InitializeVideo(): boolean;
    var
        hr: HRESULT;
        lr: TD3DLOCKED_RECT;
        dx, y1, y2, y3: UINT;
    begin
        // Draw the main stream (SMPTE color bars).
        hr := g_pMainStream.LockRect(lr, nil, D3DLOCK_NOSYSLOCK);

        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("LockRect failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // YUY2 is two pixels per DWORD.
        dx := VIDEO_MAIN_WIDTH div 2;

        // First row stripes.
        y1 := VIDEO_MAIN_HEIGHT * 2 div 3;

        FillRectangle(lr, dx * 0 div 7, 0, dx * 1 div 7, y1, RGBtoYUY2(RGB_WHITE_75pc));
        FillRectangle(lr, dx * 1 div 7, 0, dx * 2 div 7, y1, RGBtoYUY2(RGB_YELLOW_75pc));
        FillRectangle(lr, dx * 2 div 7, 0, dx * 3 div 7, y1, RGBtoYUY2(RGB_CYAN_75pc));
        FillRectangle(lr, dx * 3 div 7, 0, dx * 4 div 7, y1, RGBtoYUY2(RGB_GREEN_75pc));
        FillRectangle(lr, dx * 4 div 7, 0, dx * 5 div 7, y1, RGBtoYUY2(RGB_MAGENTA_75pc));
        FillRectangle(lr, dx * 5 div 7, 0, dx * 6 div 7, y1, RGBtoYUY2(RGB_RED_75pc));
        FillRectangle(lr, dx * 6 div 7, 0, dx * 7 div 7, y1, RGBtoYUY2(RGB_BLUE_75pc));

        // Second row stripes.
        y2 := VIDEO_MAIN_HEIGHT * 3 div 4;

        FillRectangle(lr, dx * 0 div 7, y1, dx * 1 div 7, y2, RGBtoYUY2(RGB_BLUE_75pc));
        FillRectangle(lr, dx * 1 div 7, y1, dx * 2 div 7, y2, RGBtoYUY2(RGB_BLACK));
        FillRectangle(lr, dx * 2 div 7, y1, dx * 3 div 7, y2, RGBtoYUY2(RGB_MAGENTA_75pc));
        FillRectangle(lr, dx * 3 div 7, y1, dx * 4 div 7, y2, RGBtoYUY2(RGB_BLACK));
        FillRectangle(lr, dx * 4 div 7, y1, dx * 5 div 7, y2, RGBtoYUY2(RGB_CYAN_75pc));
        FillRectangle(lr, dx * 5 div 7, y1, dx * 6 div 7, y2, RGBtoYUY2(RGB_BLACK));
        FillRectangle(lr, dx * 6 div 7, y1, dx * 7 div 7, y2, RGBtoYUY2(RGB_WHITE_75pc));

        // Third row stripes.
        y3 := VIDEO_MAIN_HEIGHT;

        FillRectangle(lr, dx * 0 div 28, y2, dx * 5 div 28, y3, RGBtoYUY2(RGB_I));
        FillRectangle(lr, dx * 5 div 28, y2, dx * 10 div 28, y3, RGBtoYUY2(RGB_WHITE));
        FillRectangle(lr, dx * 10 div 28, y2, dx * 15 div 28, y3, RGBtoYUY2(RGB_Q));
        FillRectangle(lr, dx * 15 div 28, y2, dx * 20 div 28, y3, RGBtoYUY2(RGB_BLACK));
        FillRectangle(lr, dx * 20 div 28, y2, dx * 16 div 21, y3, RGBtoYUY2(RGB_BLACK_n4pc));
        FillRectangle(lr, dx * 16 div 21, y2, dx * 17 div 21, y3, RGBtoYUY2(RGB_BLACK));
        FillRectangle(lr, dx * 17 div 21, y2, dx * 6 div 7, y3, RGBtoYUY2(RGB_BLACK_p4pc));
        FillRectangle(lr, dx * 6 div 7, y2, dx * 7 div 7, y3, RGBtoYUY2(RGB_BLACK));

        hr := g_pMainStream.UnlockRect();

        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("UnlockRect failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Draw the sub stream in the next video process.

        g_bUpdateSubStream := True;
        Result := True;
    end;



    function InitializeDXVA2(): boolean;
    var
        hr: HRESULT;
        Count: UINT;
        guids: PGUID = nil;
        I: integer;
    begin
        // Retrieve a back buffer as the video render target.
        hr := g_pD3DD9.GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, g_pD3DRT);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("GetBackBuffer failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Create DXVA2 Video Processor Service.
        hr := DXVA2CreateVideoService(g_pD3DD9, IID_IDirectXVideoProcessorService, g_pDXVAVPS);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("DXVA2CreateVideoService failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Initialize the video descriptor.

        g_VideoDesc.SampleWidth := VIDEO_MAIN_WIDTH;
        g_VideoDesc.SampleHeight := VIDEO_MAIN_HEIGHT;
        g_VideoDesc.SampleFormat.VideoChromaSubsampling := Ord(DXVA2_VideoChromaSubsampling_MPEG2);
        g_VideoDesc.SampleFormat.NominalRange := Ord(DXVA2_NominalRange_16_235);
        g_VideoDesc.SampleFormat.VideoTransferMatrix := EX_COLOR_INFO[g_ExColorInfo][0];
        g_VideoDesc.SampleFormat.VideoLighting := Ord(DXVA2_VideoLighting_dim);
        g_VideoDesc.SampleFormat.VideoPrimaries := Ord(DXVA2_VideoPrimaries_BT709);
        g_VideoDesc.SampleFormat.VideoTransferFunction := Ord(DXVA2_VideoTransFunc_709);
        g_VideoDesc.SampleFormat.SampleFormat := Ord(DXVA2_SampleProgressiveFrame);
        g_VideoDesc.Format := VIDEO_MAIN_FORMAT;
        g_VideoDesc.InputSampleFreq.Numerator := VIDEO_FPS;
        g_VideoDesc.InputSampleFreq.Denominator := 1;
        g_VideoDesc.OutputFrameFreq.Numerator := VIDEO_FPS;
        g_VideoDesc.OutputFrameFreq.Denominator := 1;

        // Query the video processor GUID.
        hr := g_pDXVAVPS.GetVideoProcessorDeviceGuids(g_VideoDesc, Count, guids);

        if (FAILED(hr)) then
        begin
            //DBGMSG((TEXT("GetVideoProcessorDeviceGuids failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Create a DXVA2 device.
        for  i := 0 to Count - 1 do
        begin
            if (CreateDXVA2VPDevice(guids[i])) then
            begin
                break;
            end;
        end;

        CoTaskMemFree(guids);

        if (g_pDXVAVPD = nil) then
        begin
            // DBGMSG((TEXT("Failed to create a DXVA2 device.\n")));
            Result := False;
            Exit;
        end;

        if (not InitializeVideo()) then
        begin
            Result := False;
            Exit;
        end;

        Result := True;
    end;



    procedure DestroyDXVA2();
    begin
        if (g_pSubStream <> nil) then
            g_pSubStream := nil;
        if (g_pMainStream <> nil) then
            g_pMainStream := nil;
        if (g_pDXVAVPD <> nil) then
            g_pDXVAVPD := nil;
        if (g_pDXVAVPS <> nil) then
            g_pDXVAVPS := nil;
        if (g_pD3DRT <> nil) then
            g_pD3DRT := nil;
    end;



    function EnableDwmQueuing(): boolean;
    var
        hr: HRESULT;
        bDWM: boolean;
        dwmti: TDWM_TIMING_INFO;
        dwmpp: TDWM_PRESENT_PARAMETERS;
    begin
        // DWM is not available.
        if (g_hDwmApiDLL = 0) then
        begin
            Result := True;
            Exit;
        end;


        // Check to see if DWM is currently enabled.
        bDWM := False;
        hr := PFNDWMISCOMPOSITIONENABLED(g_pfnDwmIsCompositionEnabled)(bDWM);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("DwmIsCompositionEnabled failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;


        // DWM queuing is disabled when DWM is disabled.
        if (not bDWM) then
        begin
            g_bDwmQueuing := False;
            Result := True;
            Exit;
        end;

        // DWM queuing is enabled already.
        if (g_bDwmQueuing) then
        begin
            Result := True;
            Exit;
        end;


        // Retrieve DWM refresh count of the last vsync.
        ZeroMemory(@dwmti, SizeOf(dwmti));
        dwmti.cbSize := sizeof(dwmti);
        hr := PFNDWMGETCOMPOSITIONTIMINGINFO(g_pfnDwmGetCompositionTimingInfo)(0, dwmti);

        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("DwmGetCompositionTimingInfo failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // Enable DWM queuing from the next refresh.
        ZeroMemory(@dwmpp, SizeOf(dwmpp));
        dwmpp.cbSize := sizeof(dwmpp);
        dwmpp.fQueue := True;
        dwmpp.cRefreshStart := dwmti.cRefresh + 1;
        dwmpp.cBuffer := DWM_BUFFER_COUNT;
        dwmpp.fUseSourceRate := False;
        dwmpp.cRefreshesPerFrame := 1;
        dwmpp.eSampling := DWM_SOURCE_FRAME_SAMPLING_POINT;

        hr := PFNDWMSETPRESENTPARAMETERS(g_pfnDwmSetPresentParameters)(g_Hwnd, dwmpp);
        if (FAILED(hr)) then
        begin
            // DBGMSG((TEXT("DwmSetPresentParameters failed with error $%x.\n"), hr));
            Result := False;
            Exit;
        end;

        // DWM queuing is enabled.
        g_bDwmQueuing := True;
        Result := True;
    end;



    function ChangeFullscreenMode(bFullscreen: boolean): boolean;
    begin
        // Mark the mode change in progress to prevent the device is being reset in OnSize.
        // This is because these API calls below will generate WM_SIZE messages.
        g_bInModeChange := True;
        if (bFullscreen) then
        begin
            // Save the window position.
            if (not GetWindowRect(g_Hwnd, g_RectWindow)) then
            begin
                // DBGMSG((TEXT("GetWindowRect failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;

            if (SetWindowLongPtr(g_Hwnd, GWL_STYLE, WS_POPUP or WS_VISIBLE) = 0) then
            begin
                // DBGMSG((TEXT("SetWindowLongPtr failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;

            if (not SetWindowPos(g_Hwnd, HWND_NOTOPMOST, 0, 0, GetSystemMetrics(SM_CXSCREEN), GetSystemMetrics(SM_CYSCREEN),
                SWP_FRAMECHANGED)) then
            begin
                // DBGMSG((TEXT("SetWindowPos failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;
        end
        else
        begin
            if (SetWindowLongPtr(g_Hwnd, GWL_STYLE, WS_OVERLAPPEDWINDOW or WS_VISIBLE) = 0) then
            begin
                //  DBGMSG((TEXT("SetWindowLongPtr failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;
            // Restore the window position.
            if (not SetWindowPos(g_Hwnd, HWND_NOTOPMOST, g_RectWindow.left, g_RectWindow.top, g_RectWindow.right -
                g_RectWindow.left, g_RectWindow.bottom - g_RectWindow.top, SWP_FRAMECHANGED)) then
            begin
                //  DBGMSG((TEXT("SetWindowPos failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;
        end;

        g_bInModeChange := False;
        Result := True;
    end;



    function ResetDevice(bChangeWindowMode: boolean = False): boolean;
    var
        hr: HRESULT;
        d3dpp: D3DPRESENT_PARAMETERS;
    begin
        if (bChangeWindowMode) then
        begin
            g_bWindowed := not g_bWindowed;

            if (not ChangeFullscreenMode(not g_bWindowed)) then
            begin
                Result := False;
                Exit;
            end;
        end;

        if (g_pD3DD9 <> nil) then
        begin
            // Destroy DXVA2 device because it may be holding any D3D9 resources.
            DestroyDXVA2();
            if (g_bWindowed) then
            begin
                g_D3DPP.BackBufferWidth := 0;
                g_D3DPP.BackBufferHeight := 0;
            end
            else
            begin
                g_D3DPP.BackBufferWidth := GetSystemMetrics(SM_CXSCREEN);
                g_D3DPP.BackBufferHeight := GetSystemMetrics(SM_CYSCREEN);
            end;
            g_D3DPP.Windowed := g_bWindowed;


            // Reset will change the parameters, so use a copy instead.
            d3dpp := g_D3DPP;
            hr := g_pD3DD9.Reset(d3dpp);

            if (FAILED(hr)) then
            begin
                // DBGMSG((TEXT("Reset failed with error $%x.\n"), hr));
            end;

            if (SUCCEEDED(hr) and InitializeDXVA2()) then
            begin
                Result := True;
                Exit;
            end;

            // If either Reset didn't work or failed to initialize DXVA2 device,
            // try to recover by recreating the devices from the scratch.

            DestroyDXVA2();
            DestroyD3D9();
        end;

        if (InitializeD3D9() and InitializeDXVA2()) then
        begin
            Result := True;
            Exit;
        end;

        // Fallback to Window mode, if failed to initialize Fullscreen mode.
        if (g_bWindowed) then
        begin
            Result := False;
            Exit;
        end;

        DestroyDXVA2();
        DestroyD3D9();

        if (not ChangeFullscreenMode(False)) then
        begin
            Result := False;
            Exit;
        end;

        g_bWindowed := True;

        if (InitializeD3D9() and InitializeDXVA2()) then
        begin
            Result := True;
            Exit;
        end;

        Result := False;
    end;



    function GetFrameNumber(): DWORD;
    var
        currentTime: DWORD;
        currentSysTime: DWORD;
        frame: dword;
        delta: dword;
    begin
        currentSysTime := timeGetTime();
        if (g_StartSysTime > currentSysTime) then
        begin
            currentTime := currentSysTime + ($FFFFFFFF - g_StartSysTime);
        end
        else
        begin
            currentTime := currentSysTime - g_StartSysTime;
        end;

        frame := currentTime div VIDEO_MSPF;
        delta := (currentTime - g_PreviousTime) div VIDEO_MSPF;
        if (delta > 1) then
        begin
            if (g_bDspFrameDrop) then
            begin
                //DBGMSG((TEXT("Frame dropped %u frame(s).\n"), delta - 1));
            end;
        end;

        if (delta > 0) then
        begin
            g_PreviousTime := currentTime;
        end;

        Result := frame;
    end;



    function GetBackgroundColor(): TDXVA2_AYUVSample16;
    var
        yuv: D3DCOLOR;
        y, u, v: byte;
        color: TDXVA2_AYUVSample16;
    begin
        yuv := RGBtoYUV(BACKGROUND_COLORS[g_BackgroundColor]);
        Y := LOBYTE(HIWORD(yuv));
        U := HIBYTE(LOWORD(yuv));
        V := LOBYTE(LOWORD(yuv));

        color.Cr := V * $100;
        color.Cb := U * $100;
        color.Y := Y * $100;
        color.Alpha := $FFFF;

        Result := color;
    end;



    function ScaleRectangle(const input: TRECT; const src: TRECT; const dst: TRECT): TRECT;
    var
        rect: TRECT;
        src_dx, src_dy, dst_dx, dst_dy: UINT;
    begin
        src_dx := src.right - src.left;
        src_dy := src.bottom - src.top;

        dst_dx := dst.right - dst.left;
        dst_dy := dst.bottom - dst.top;

        // Scale input rectangle within src rectangle to dst rectangle.

        rect.left := input.left * dst_dx div src_dx;
        rect.right := input.right * dst_dx div src_dx;
        rect.top := input.top * dst_dy div src_dy;
        rect.bottom := input.bottom * dst_dy div src_dy;

        Result := rect;
    end;



    function ProcessVideo(): boolean;
    var
        hr: HRESULT;
        rect: TRECT;

        blt: TDXVA2_VideoProcessBltParams;
        samples: array [0..1] of TDXVA2_VideoSample;
        frame: DWORD;
        start_100ns: LONGLONG;
        end_100ns: LONGLONG;
        client: TRECT;
        target: TRECT;

        ssdest: TRECT;
        x, y, wx, wy: integer;

        lHandle: THandle;
    begin
        if (g_pD3DD9 = nil) then
        begin
            Result := False;
            Exit;
        end;

        GetClientRect(g_Hwnd, rect);

        if (IsRectEmpty(rect)) then
        begin
            Result := True;
            Exit;
        end;

        // Check the current status of D3D9 device.
        hr := g_pD3DD9.TestCooperativeLevel();
        case (hr) of

            D3D_OK:
            begin
            end;

            D3DERR_DEVICELOST:
            begin
                // DBGMSG((TEXT("TestCooperativeLevel returned D3DERR_DEVICELOST.\n")));
                Result := True;
            end;

            D3DERR_DEVICENOTRESET:
            begin
                // DBGMSG((TEXT("TestCooperativeLevel returned D3DERR_DEVICENOTRESET.\n")));
                if (not ResetDevice()) then
                begin
                    Result := False;
                    Exit;
                end;

            end;

            else
            begin
                // DBGMSG((TEXT("TestCooperativeLevel failed with error $%x.\n"), hr));
                Result := False;
                Exit;
            end;
        end;

        ZeroMemory(@blt, SizeOf(TDXVA2_VideoProcessBltParams));
        ZeroMemory(@samples, SizeOf(samples));

        frame := GetFrameNumber();
        start_100ns := frame * LONGLONG(VIDEO_100NSPF);
        end_100ns := start_100ns + LONGLONG(VIDEO_100NSPF);

        GetClientRect(g_Hwnd, client);

        target.left := client.left + (client.right - client.left) div 2 * (100 - g_TargetWidthPercent) div 100;
        target.right := client.right - (client.right - client.left) div 2 * (100 - g_TargetWidthPercent) div 100;
        target.top := client.top + (client.bottom - client.top) div 2 * (100 - g_TargetHeightPercent) div 100;
        target.bottom := client.bottom - (client.bottom - client.top) div 2 * (100 - g_TargetHeightPercent) div 100;

        // Calculate sub stream destination based on the current frame number.
        x := frame * VIDEO_SUB_VX;
        wx := VIDEO_MAIN_WIDTH - VIDEO_SUB_WIDTH;
        if ((x div wx) and $1 <> 0) then
        begin
            x := wx - (x mod wx);
        end
        else
        begin
            x := x mod wx;
        end;

        y := frame * VIDEO_SUB_VY;
        wy := VIDEO_MAIN_HEIGHT - VIDEO_SUB_HEIGHT;
        if ((y div wy) and $1 <> 0) then
        begin
            y := wy - (y mod wy);
        end
        else
        begin
            y := y mod wy;
        end;

        SetRect(ssdest, x, y, x + VIDEO_SUB_WIDTH, y + VIDEO_SUB_HEIGHT);
        // Initialize VPBlt parameters.
        blt.TargetFrame := start_100ns;
        blt.TargetRect := target;

        // DXVA2_VideoProcess_Constriction
        blt.ConstrictionSize.cx := target.right - target.left;
        blt.ConstrictionSize.cy := target.bottom - target.top;

        blt.BackgroundColor := GetBackgroundColor();

        // DXVA2_VideoProcess_YUV2RGBExtended
        blt.DestFormat.VideoChromaSubsampling := Ord(DXVA2_VideoChromaSubsampling_Unknown);
        blt.DestFormat.NominalRange := EX_COLOR_INFO[g_ExColorInfo][1];
        blt.DestFormat.VideoTransferMatrix := Ord(DXVA2_VideoTransferMatrix_Unknown);
        blt.DestFormat.VideoLighting := Ord(DXVA2_VideoLighting_dim);
        blt.DestFormat.VideoPrimaries := Ord(DXVA2_VideoPrimaries_BT709);
        blt.DestFormat.VideoTransferFunction := Ord(DXVA2_VideoTransFunc_709);

        blt.DestFormat.SampleFormat := Ord(DXVA2_SampleProgressiveFrame);

        // DXVA2_ProcAmp_Brightness
        blt.ProcAmpValues.Brightness := g_ProcAmpValues[0];

        // DXVA2_ProcAmp_Contrast
        blt.ProcAmpValues.Contrast := g_ProcAmpValues[1];

        // DXVA2_ProcAmp_Hue
        blt.ProcAmpValues.Hue := g_ProcAmpValues[2];

        // DXVA2_ProcAmp_Saturation
        blt.ProcAmpValues.Saturation := g_ProcAmpValues[3];

        // DXVA2_VideoProcess_AlphaBlend
        blt.Alpha := DXVA2_Fixed32OpaqueAlpha();

        // DXVA2_VideoProcess_NoiseFilter
        blt.NoiseFilterLuma.Level := g_NFilterValues[0];
        blt.NoiseFilterLuma.Threshold := g_NFilterValues[1];
        blt.NoiseFilterLuma.Radius := g_NFilterValues[2];
        blt.NoiseFilterChroma.Level := g_NFilterValues[3];
        blt.NoiseFilterChroma.Threshold := g_NFilterValues[4];
        blt.NoiseFilterChroma.Radius := g_NFilterValues[5];

        // DXVA2_VideoProcess_DetailFilter
        blt.DetailFilterLuma.Level := g_DFilterValues[0];
        blt.DetailFilterLuma.Threshold := g_DFilterValues[1];
        blt.DetailFilterLuma.Radius := g_DFilterValues[2];
        blt.DetailFilterChroma.Level := g_DFilterValues[3];
        blt.DetailFilterChroma.Threshold := g_DFilterValues[4];
        blt.DetailFilterChroma.Radius := g_DFilterValues[5];


        // Initialize main stream video sample.
        samples[0].Start := start_100ns;
        samples[0].Ende := end_100ns;

        // DXVA2_VideoProcess_YUV2RGBExtended
        samples[0].SampleFormat.VideoChromaSubsampling := Ord(DXVA2_VideoChromaSubsampling_MPEG2);
        samples[0].SampleFormat.NominalRange := Ord(DXVA2_NominalRange_16_235);
        samples[0].SampleFormat.VideoTransferMatrix := EX_COLOR_INFO[g_ExColorInfo][0];
        samples[0].SampleFormat.VideoLighting := Ord(DXVA2_VideoLighting_dim);
        samples[0].SampleFormat.VideoPrimaries := Ord(DXVA2_VideoPrimaries_BT709);
        samples[0].SampleFormat.VideoTransferFunction := Ord(DXVA2_VideoTransFunc_709);
        samples[0].SampleFormat.SampleFormat := Ord(DXVA2_SampleProgressiveFrame);
        samples[0].SrcSurface := g_pMainStream;
        // DXVA2_VideoProcess_SubRects
        samples[0].SrcRect := g_SrcRect;
        // DXVA2_VideoProcess_StretchX, Y
        samples[0].DstRect := ScaleRectangle(g_DstRect, VIDEO_MAIN_RECT, client);
        // DXVA2_VideoProcess_PlanarAlpha
        samples[0].PlanarAlpha := DXVA2FloatToFixed(g_PlanarAlphaValue / $FF);
        // Initialize sub stream video sample.

        samples[1] := samples[0];
        // DXVA2_VideoProcess_SubStreamsExtended
        samples[1].SampleFormat := samples[0].SampleFormat;
        // DXVA2_VideoProcess_SubStreams
        samples[1].SampleFormat.SampleFormat := Ord(DXVA2_SampleSubStream);
        samples[1].SrcSurface := g_pSubStream;
        samples[1].SrcRect := VIDEO_SUB_RECT;
        samples[1].DstRect := ScaleRectangle(ssdest, VIDEO_MAIN_RECT, client);

        if (not UpdateSubStream()) then
        begin
            Result := False;
            Exit;
        end;

        if (g_TargetWidthPercent < 100) or (g_TargetHeightPercent < 100) then
        begin
            hr := g_pD3DD9.ColorFill(g_pD3DRT, nil, D3DCOLOR_XRGB(0, 0, 0));

            if (FAILED(hr)) then
            begin
                // DBGMSG((TEXT("ColorFill failed with error $%x.\n"), hr));
            end;
        end;

        hr := g_pDXVAVPD.VideoProcessBlt(g_pD3DRT, blt, samples, SUB_STREAM_COUNT + 1, lHandle);
        if (FAILED(hr)) then
        begin
            //DBGMSG((TEXT("VideoProcessBlt failed with error $%x.\n"), hr));
        end;

        // Re-enable DWM queuing if it is not enabled.
        EnableDwmQueuing();
        hr := g_pD3DD9.Present(nil, nil, 0, nil);
        if (FAILED(hr)) then
        begin
            //  DBGMSG((TEXT("Present failed with error $%x.\n"), hr));
        end;

        Result := True;
    end;



    procedure OnDestroy(hwnd: HWND);
    begin
        PostQuitMessage(0);
    end;



    procedure ResetParameter();
    begin
        case (g_VK_Fx) of
            VK_F1:
            begin
                g_PlanarAlphaValue := DEFAULT_PLANAR_ALPHA_VALUE;
                g_PixelAlphaValue := DEFAULT_PIXEL_ALPHA_VALUE;
                g_bUpdateSubStream := True;
            end;

            VK_F2, VK_F3:
            begin
                g_SrcRect := VIDEO_MAIN_RECT;
            end;

            VK_F4, VK_F5:
            begin
                g_DstRect := VIDEO_MAIN_RECT;
            end;

            VK_F6:
            begin
                g_BackgroundColor := 0;
                g_ExColorInfo := 0;
            end;

            VK_F7:
            begin
                g_ProcAmpValues[0] := g_ProcAmpRanges[0].DefaultValue;
                g_ProcAmpValues[1] := g_ProcAmpRanges[1].DefaultValue;
            end;

            VK_F8:
            begin
                g_ProcAmpValues[2] := g_ProcAmpRanges[2].DefaultValue;
                g_ProcAmpValues[3] := g_ProcAmpRanges[3].DefaultValue;
            end;

            VK_F9:
            begin
                g_TargetWidthPercent := 100;
                g_TargetHeightPercent := 100;
            end;

        end;
    end;



    function ValidateValueRange(const Value: TDXVA2_Fixed32; const steps: integer; const range: TDXVA2_ValueRange): TDXVA2_Fixed32;
    var
        f_value, f_max, f_min: single;
    begin
        f_value := DXVA2FixedToFloat(Value);
        f_max := DXVA2FixedToFloat(range.MaxValue);
        f_min := DXVA2FixedToFloat(range.MinValue);

        f_value := f_value + DXVA2FixedToFloat(range.StepSize) * steps;
        f_value := min(max(f_value, f_min), f_max);

        Result := DXVA2FloatToFixed(f_value);
    end;



    procedure IncrementParameter(vk: UINT);
    var
        rect, intersect: TRECT;
    begin
        case (g_VK_Fx) of
            VK_F1:
            begin
                if (vk = VK_UP) then
                begin
                    g_PlanarAlphaValue := min(g_PlanarAlphaValue + 8, $FF);
                end
                else
                begin
                    g_PixelAlphaValue := min(g_PixelAlphaValue + 8, $FF);
                    g_bUpdateSubStream := True;
                end;

            end;

            VK_F2:
            begin
                rect := g_SrcRect;
                if vk = VK_UP then
                    InflateRect(rect, 0, -8)
                else
                    InflateRect(rect, -8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (not IsRectEmpty(intersect)) then
                begin
                    g_SrcRect := intersect;
                end;

            end;

            VK_F3:
            begin
                rect := g_SrcRect;
                if (vk = VK_UP) then
                    OffsetRect(rect, 0, -8)
                else
                    OffsetRect(rect, 8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (EqualRect(rect, intersect)) then
                begin
                    g_SrcRect := rect;
                end;

            end;

            VK_F4:
            begin
                rect := g_DstRect;
                if (vk = VK_UP) then
                    InflateRect(rect, 0, 8)
                else
                    InflateRect(rect, 8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (not IsRectEmpty(intersect)) then
                begin
                    g_DstRect := intersect;
                end;

            end;

            VK_F5:
            begin
                rect := g_DstRect;
                if (vk = VK_UP) then
                    OffsetRect(rect, 0, -8)
                else
                    OffsetRect(rect, 8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (EqualRect(rect, intersect)) then
                begin
                    g_DstRect := rect;
                end;
            end;

            VK_F6:
            begin
                if (vk = VK_UP) then
                begin
                    Inc(g_ExColorInfo);
                    if (g_ExColorInfo >= length(EX_COLOR_INFO)) then
                    begin
                        g_ExColorInfo := 0;
                    end;
                end
                else
                begin
                    Inc(g_BackgroundColor);
                    if (g_BackgroundColor >= length(BACKGROUND_COLORS)) then
                    begin
                        g_BackgroundColor := 0;
                    end;
                end;
            end;

            VK_F7:
            begin
                if (vk = VK_UP) then
                    g_ProcAmpValues[0] := ValidateValueRange(g_ProcAmpValues[0], g_ProcAmpSteps[0], g_ProcAmpRanges[0])
                else
                    g_ProcAmpValues[1] := ValidateValueRange(g_ProcAmpValues[1], g_ProcAmpSteps[1], g_ProcAmpRanges[1]);
            end;

            VK_F8:
            begin
                if (vk = VK_UP) then
                    g_ProcAmpValues[2] := ValidateValueRange(g_ProcAmpValues[2], g_ProcAmpSteps[2], g_ProcAmpRanges[2])
                else
                    g_ProcAmpValues[3] := ValidateValueRange(g_ProcAmpValues[3], g_ProcAmpSteps[3], g_ProcAmpRanges[3]);
            end;

            VK_F9:
            begin
                if (vk = VK_UP) then
                    g_TargetHeightPercent := min(g_TargetHeightPercent + 4, 100)
                else
                    g_TargetWidthPercent := min(g_TargetWidthPercent + 4, 100);
            end;

        end;
    end;



    procedure DecrementParameter(vk: UINT);
    var
        rect, intersect: TRECT;
    begin
        case (g_VK_Fx) of
            VK_F1:
            begin
                if (vk = VK_DOWN) then
                begin
                    g_PlanarAlphaValue := max(g_PlanarAlphaValue - 8, 0);
                end
                else
                begin
                    g_PixelAlphaValue := max(g_PixelAlphaValue - 8, 0);
                    g_bUpdateSubStream := True;
                end;

            end;

            VK_F2:
            begin
                rect := g_SrcRect;
                if (vk = VK_DOWN) then
                    InflateRect(rect, 0, 8)
                else
                    InflateRect(rect, 8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (not IsRectEmpty(intersect)) then
                begin
                    g_SrcRect := intersect;
                end;
            end;

            VK_F3:
            begin
                rect := g_SrcRect;
                if vk = VK_DOWN then
                    OffsetRect(rect, 0, 8)
                else
                    OffsetRect(rect, -8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (EqualRect(rect, intersect)) then
                begin
                    g_SrcRect := rect;
                end;
            end;

            VK_F4:
            begin
                rect := g_DstRect;
                if (vk = VK_DOWN) then
                    InflateRect(rect, 0, -8)
                else
                    InflateRect(rect, -8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (not IsRectEmpty(intersect)) then
                begin
                    g_DstRect := intersect;
                end;
            end;

            VK_F5:
            begin
                rect := g_DstRect;
                if (vk = VK_DOWN) then
                    OffsetRect(rect, 0, 8)
                else
                    OffsetRect(rect, -8, 0);
                IntersectRect(intersect, rect, VIDEO_MAIN_RECT);
                if (EqualRect(rect, intersect)) then
                begin
                    g_DstRect := rect;
                end;
            end;

            VK_F6:
            begin
                if (vk = VK_DOWN) then
                begin
                    Dec(g_ExColorInfo);
                    if (g_ExColorInfo < 0) then
                    begin
                        g_ExColorInfo := length(EX_COLOR_INFO) - 1;
                    end;
                end
                else
                begin
                    Dec(g_BackgroundColor);
                    if (g_BackgroundColor < 0) then
                    begin
                        g_BackgroundColor := length(BACKGROUND_COLORS) - 1;
                    end;
                end;
            end;

            VK_F7:
            begin
                if (vk = VK_DOWN) then
                begin
                    g_ProcAmpValues[0] := ValidateValueRange(g_ProcAmpValues[0], g_ProcAmpSteps[0] * -1, g_ProcAmpRanges[0]);
                end
                else
                begin
                    g_ProcAmpValues[1] := ValidateValueRange(g_ProcAmpValues[1], g_ProcAmpSteps[1] * -1, g_ProcAmpRanges[1]);
                end;
            end;

            VK_F8:
            begin
                if (vk = VK_DOWN) then
                begin
                    g_ProcAmpValues[2] := ValidateValueRange(g_ProcAmpValues[2], g_ProcAmpSteps[2] * -1, g_ProcAmpRanges[2]);
                end
                else
                begin
                    g_ProcAmpValues[3] := ValidateValueRange(g_ProcAmpValues[3], g_ProcAmpSteps[3] * -1, g_ProcAmpRanges[3]);
                end;
            end;

            VK_F9:
            begin
                if (vk = VK_DOWN) then
                begin
                    g_TargetHeightPercent := max(g_TargetHeightPercent - 4, 4);
                end
                else
                begin
                    g_TargetWidthPercent := max(g_TargetWidthPercent - 4, 4);
                end;
            end;
        end;
    end;



    procedure OnKey(hwnd: HWND; vk: UINT; fDown: boolean; cRepeat: integer; flags: UINT);
    begin
        if (not fDown) then
        begin
            Exit;
        end;

        if (vk = VK_ESCAPE) then
        begin
            DestroyWindow(hwnd);
            Exit;
        end;

        if (g_pD3DD9 = nil) then
        begin
            Exit;
        end;

        case (vk) of
            VK_F1, VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8, VK_F9:
            begin
                g_VK_Fx := vk;
                g_bUpdateSubStream := True;
            end;

            VK_HOME:
                ResetParameter();

            VK_END:
                g_bDspFrameDrop := not g_bDspFrameDrop;

            VK_UP, VK_RIGHT:
                IncrementParameter(vk);

            VK_DOWN, VK_LEFT:
                DecrementParameter(vk);
        end;
    end;



    procedure OnPaint(hwnd: HWND);
    begin
        ValidateRect(hwnd, nil);
        ProcessVideo();
    end;



    procedure OnSize(hwnd: HWND; state: UINT; cx: integer; cy: integer);
    var
        rect: TRECT;
    begin
        if (g_pD3DD9 = nil) then
        begin
            Exit;
        end;

        GetClientRect(hwnd, rect);

        if (IsRectEmpty(rect)) then
        begin
            Exit;
        end;

        // Do not reset the device while the mode change is in progress.
        if (g_bInModeChange) then
        begin
            Exit;
        end;

        if (not ResetDevice()) then
        begin
            DestroyWindow(hwnd);
            Exit;
        end;

        InvalidateRect(hwnd, nil, False);
    end;



    function WindowProc(hwnd: HWND; uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
    begin

        case (uMsg) of
            WM_DESTROY:
            begin
                OnDestroy(hwnd);
                Result := 0;
            end;

            WM_KEYDOWN:
            begin
                OnKey(hwnd, wparam, True, LOWORD(lParam), hiword(lparam));
                Result := 0;
            end;
            WM_PAINT:
            begin
                OnPaint(hwnd);
                Result := 0;
            end;
            WM_SIZE:
            begin
                OnSize(hwnd, WParam, loword(lparam), hiword(lParam));
                Result := 0;
            end;
            else
              Result := DefWindowProc(hwnd, uMsg, wParam, lParam);
        end;
    end;



    function InitializeWindow(): boolean;
    var
        wc: WNDCLASS;
    begin
        zeroMemory(@wc, SizeOf(wc));

        wc.lpfnWndProc := @WindowProc;
        wc.hInstance := GetModuleHandle(0);
        wc.hCursor := LoadCursor(0, IDC_ARROW);
        wc.lpszClassName := PAnsiChar(CLASS_NAME);

        if (RegisterClass(wc) = 0) then
        begin
            //  DBGMSG((TEXT("RegisterClass failed with error %d.\n"), GetLastError()));
            Result := False;
            Exit;
        end;

        // Start in Window mode regardless of the initial mode.
        g_Hwnd := CreateWindow(PAnsiChar(CLASS_NAME), PAnsiChar(WINDOW_NAME), WS_OVERLAPPEDWINDOW, CW_USEDEFAULT,
            CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, GetModuleHandle(0), 0);

        if (g_Hwnd = 0) then
        begin
            // DBGMSG((TEXT("CreateWindow failed with error %d.\n"), GetLastError()));
            Result := False;
            Exit;
        end;

        ShowWindow(g_Hwnd, SW_SHOWDEFAULT);
        UpdateWindow(g_Hwnd);

        // Change the window from Window mode to Fullscreen mode.
        if (not g_bWindowed) then
        begin
            if (not ChangeFullscreenMode(True)) then
            begin
                // If failed, revert to Window mode.
                if (not ChangeFullscreenMode(False)) then
                begin
                    Result := False;
                    Exit;
                end;

                g_bWindowed := True;
            end;
        end;

        Result := True;
    end;



    function InitializeTimer(): boolean;
    var
        li: TLargeInteger;
    begin
        g_hTimer := CreateWaitableTimer(0, False, 0);

        if (g_hTimer = 0) then
        begin
            // DBGMSG((TEXT("CreateWaitableTimer failed with error %d.\n"), GetLastError()));
            Result := False;
            Exit;
        end;

        li := 0;

        if (not SetWaitableTimer(g_hTimer, li, VIDEO_MSPF, 0, 0, False)) then
        begin
            // DBGMSG((TEXT("SetWaitableTimer failed with error %d.\n"), GetLastError()));
            Result := False;
            Exit;
        end;

        g_bTimerSet := (timeBeginPeriod(1) = TIMERR_NOERROR);
        g_StartSysTime := timeGetTime();
        Result := True;
    end;



    procedure DestroyTimer();
    begin
        if (g_bTimerSet) then
        begin
            timeEndPeriod(1);
            g_bTimerSet := False;
        end;

        if (g_hTimer <> 0) then
        begin
            CloseHandle(g_hTimer);
            g_hTimer := 0;
        end;
    end;



    function PreTranslateMessage(const msg: TMSG): boolean;
    var
        rect: TRECT;
    begin
        // Only interested in Alt + Enter.
        if (msg.message <> WM_SYSKEYDOWN) or (msg.wParam <> VK_RETURN) then
        begin
            Result := False;
            Exit;
        end;

        if (g_pD3DD9 = nil) then
        begin
            Result := True;
            Exit;
        end;

        GetClientRect(msg.hwnd, &rect);

        if (IsRectEmpty(rect)) then
        begin
            Result := True;
            Exit;
        end;

        if (ResetDevice(True)) then
        begin
            Result := True;
            Exit;
        end;

        DestroyWindow(msg.hwnd);
        Result := True;
    end;



    function MessageLoop(): integer;
    var
        msg: TMSG;
    begin
        while (msg.message <> WM_QUIT) do
        begin
            if (PeekMessage(msg, 0, 0, 0, PM_REMOVE)) then
            begin
                if (PreTranslateMessage(msg)) then
                begin
                    continue;
                end;
                TranslateMessage(&msg);
                DispatchMessage(&msg);
                continue;
            end;

            // Wait until the timer expires or any message is posted.
            if (MsgWaitForMultipleObjects(1, g_hTimer, False, INFINITE, QS_ALLINPUT) = WAIT_OBJECT_0) then
            begin
                if (not ProcessVideo()) then
                begin
                    DestroyWindow(g_Hwnd);
                end;
            end;
        end;
        Result := integer(msg.wParam);
    end;



    function InitializeModule(): boolean;
    begin
        // Load these DLLs dynamically because these may not be available prior to Vista.

        g_hRgb9rastDLL := LoadLibrary('rgb9rast.dll');

        if (g_hRgb9rastDLL <> 0) then
        begin
            // DBGMSG((TEXT("LoadLibrary(rgb9rast.dll) failed with error %d.\n"), GetLastError()));
            // goto SKIP_RGB9RAST;

            g_pfnD3D9GetSWInfo := GetProcAddress(g_hRgb9rastDLL, 'D3D9GetSWInfo');

            if (g_pfnD3D9GetSWInfo = nil) then
            begin
                //   DBGMSG((TEXT("GetProcAddress(D3D9GetSWInfo) failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;
        end;

        // SKIP_RGB9RAST:
        g_hDwmApiDLL := LoadLibrary('dwmapi.dll');

        if (g_hDwmApiDLL <> 0) then
        begin
            // DBGMSG((TEXT("LoadLibrary(dwmapi.dll) failed with error %d.\n"), GetLastError()));
            // goto SKIP_DWMAPI;

            g_pfnDwmIsCompositionEnabled := GetProcAddress(g_hDwmApiDLL, 'DwmIsCompositionEnabled');

            if (g_pfnDwmIsCompositionEnabled = nil) then
            begin
                // DBGMSG((TEXT("GetProcAddress(DwmIsCompositionEnabled) failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;

            g_pfnDwmGetCompositionTimingInfo := GetProcAddress(g_hDwmApiDLL, 'DwmGetCompositionTimingInfo');

            if (g_pfnDwmGetCompositionTimingInfo = nil) then
            begin
                // DBGMSG((TEXT("GetProcAddress(DwmGetCompositionTimingInfo) failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;

            g_pfnDwmSetPresentParameters := GetProcAddress(g_hDwmApiDLL, 'DwmSetPresentParameters');

            if (g_pfnDwmSetPresentParameters = nil) then
            begin
                //  DBGMSG((TEXT("GetProcAddress(DwmSetPresentParameters) failed with error %d.\n"), GetLastError()));
                Result := False;
                Exit;
            end;
        end;

        // SKIP_DWMAPI:
        Result := True;
    end;



    function InitializeParameter(psz: PWideChar): boolean;
    begin
        Result := True;
    end;

begin

    RGB_WHITE := D3DCOLOR_XRGB($EB, $EB, $EB);
    RGB_RED := D3DCOLOR_XRGB($EB, $10, $10);
    RGB_YELLOW := D3DCOLOR_XRGB($EB, $EB, $10);
    RGB_GREEN := D3DCOLOR_XRGB($10, $EB, $10);
    RGB_CYAN := D3DCOLOR_XRGB($10, $EB, $EB);
    RGB_BLUE := D3DCOLOR_XRGB($10, $10, $EB);
    RGB_MAGENTA := D3DCOLOR_XRGB($EB, $10, $EB);
    RGB_BLACK := D3DCOLOR_XRGB($10, $10, $10);
    RGB_ORANGE := D3DCOLOR_XRGB($EB, $7E, $10);


    // 75%
    RGB_WHITE_75pc := D3DCOLOR_XRGB($B4, $B4, $B4);
    RGB_YELLOW_75pc := D3DCOLOR_XRGB($B4, $B4, $10);
    RGB_CYAN_75pc := D3DCOLOR_XRGB($10, $B4, $B4);
    RGB_GREEN_75pc := D3DCOLOR_XRGB($10, $B4, $10);
    RGB_MAGENTA_75pc := D3DCOLOR_XRGB($B4, $10, $B4);
    RGB_RED_75pc := D3DCOLOR_XRGB($B4, $10, $10);
    RGB_BLUE_75pc := D3DCOLOR_XRGB($10, $10, $B4);

    // -4% / +4%
    RGB_BLACK_n4pc := D3DCOLOR_XRGB($07, $07, $07);
    RGB_BLACK_p4pc := D3DCOLOR_XRGB($18, $18, $18);

    // -Inphase / +Quadrature
    RGB_I := D3DCOLOR_XRGB($00, $1D, $42);
    RGB_Q := D3DCOLOR_XRGB($2C, $00, $5C);

    VIDEO_SUB_FORMAT := D3DFORMAT('VUYA'); // AYUV
    VIDEO_SUB_FORMAT := byte('A') or (byte('Y') shl 8) or (byte('U') shl 16) or (byte('V') shl 24);
    // VIDEO_SUB_FORMAT := Byte('V') or (Byte('U') shl 8) or (Byte('Y') shl 16) or (Byte('A') shl 24);
    BACKGROUND_COLORS[0] := RGB_WHITE;
    BACKGROUND_COLORS[1] := RGB_RED;
    BACKGROUND_COLORS[2] := RGB_YELLOW;
    BACKGROUND_COLORS[3] := RGB_GREEN;
    BACKGROUND_COLORS[4] := RGB_CYAN;
    BACKGROUND_COLORS[5] := RGB_BLUE;
    BACKGROUND_COLORS[6] := RGB_MAGENTA;
    BACKGROUND_COLORS[7] := RGB_BLACK;


    if (InitializeModule() and InitializeParameter('') and InitializeWindow() and InitializeD3D9() and
        InitializeDXVA2() and InitializeTimer()) then
    begin
        MessageLoop();
    end;

    DestroyTimer();
    DestroyDXVA2();
    DestroyD3D9();
end.














































































































































