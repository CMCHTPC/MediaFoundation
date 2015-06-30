(*=========================================================================*\

    Copyright (c) Microsoft Corporation.  All rights reserved.

    File: dwmapi.h

    Module Name: dwmapi

    Description: DWM API declarations

\*=========================================================================*)

unit CMC.DWMAPI;

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils,
    CMC.UXTheme;

const
    DWMAPI_DLL = 'Dwmapi.dll';


const
    // Blur behind data structures
    DWM_BB_ENABLE = $00000001;  // fEnable has been specified
    DWM_BB_BLURREGION = $00000002;  // hRgnBlur has been specified
    DWM_BB_TRANSITIONONMAXIMIZED = $00000004;  // fTransitionOnMaximized has been specified


    // Cloaked flags describing why a window is cloaked.
    DWM_CLOAKED_APP = $00000001;
    DWM_CLOAKED_SHELL = $00000002;
    DWM_CLOAKED_INHERITED = $00000004;


    DWM_TNP_RECTDESTINATION = $00000001;
    DWM_TNP_RECTSOURCE = $00000002;
    DWM_TNP_OPACITY = $00000004;
    DWM_TNP_VISIBLE = $00000008;
    DWM_TNP_SOURCECLIENTAREAONLY = $00000010;


    c_DwmMaxQueuedBuffers = 8;
    c_DwmMaxMonitors = 16;
    c_DwmMaxAdapters = 16;

    DWM_FRAME_DURATION_DEFAULT = -1;

    DWM_EC_DISABLECOMPOSITION = 0;
    DWM_EC_ENABLECOMPOSITION = 1;

    DWM_SIT_DISPLAYFRAME = $00000001;  // Display a window frame around the provided bitmap


type
{$A1}
{$Z1}
    //include <pshpack1.h>

    TDWM_BLURBEHIND = packed record
        dwFlags: DWORD;
        fEnable: boolean;
        hRgnBlur: HRGN;
        fTransitionOnMaximized: boolean;
    end;
    PDWM_BLURBEHIND = ^TDWM_BLURBEHIND;


    // Window attributes
    TDWMWINDOWATTRIBUTE = (
        DWMWA_NCRENDERING_ENABLED = 1,      // [get] Is non-client rendering enabled/disabled
        DWMWA_NCRENDERING_POLICY,           // [set] Non-client rendering policy
        DWMWA_TRANSITIONS_FORCEDISABLED,    // [set] Potentially enable/forcibly disable transitions
        DWMWA_ALLOW_NCPAINT,                // [set] Allow contents rendered in the non-client area to be visible on the DWM-drawn frame.
        DWMWA_CAPTION_BUTTON_BOUNDS,        // [get] Bounds of the caption button area in window-relative space.
        DWMWA_NONCLIENT_RTL_LAYOUT,         // [set] Is non-client content RTL mirrored
        DWMWA_FORCE_ICONIC_REPRESENTATION,  // [set] Force this window to display iconic thumbnails.
        DWMWA_FLIP3D_POLICY,                // [set] Designates how Flip3D will treat the window.
        DWMWA_EXTENDED_FRAME_BOUNDS,        // [get] Gets the extended frame bounds rectangle in screen space
        DWMWA_HAS_ICONIC_BITMAP,            // [set] Indicates an available bitmap when there is no better thumbnail representation.
        DWMWA_DISALLOW_PEEK,                // [set] Don't invoke Peek on the window.
        DWMWA_EXCLUDED_FROM_PEEK,           // [set] LivePreview exclusion information
        DWMWA_CLOAK,                        // [set] Cloak or uncloak the window
        DWMWA_CLOAKED,                      // [get] Gets the cloaked state of the window
        DWMWA_FREEZE_REPRESENTATION,        // [set] Force this window to freeze the thumbnail without live update
        DWMWA_LAST);

    // Non-client rendering policy attribute values
    TDWMNCRENDERINGPOLICY = (
        DWMNCRP_USEWINDOWSTYLE, // Enable/disable non-client rendering based on window style
        DWMNCRP_DISABLED,       // Disabled non-client rendering; window style is ignored
        DWMNCRP_ENABLED,        // Enabled non-client rendering; window style is ignored
        DWMNCRP_LAST);

    // Values designating how Flip3D treats a given window.
    TDWMFLIP3DWINDOWPOLICY = (
        DWMFLIP3D_DEFAULT,      // Hide or include the window in Flip3D based on window style and visibility.
        DWMFLIP3D_EXCLUDEBELOW, // Display the window under Flip3D and disabled.
        DWMFLIP3D_EXCLUDEABOVE, // Display the window above Flip3D and enabled.
        DWMFLIP3D_LAST);

    // Thumbnails
    THTHUMBNAIL = THANDLE;
    PHTHUMBNAIL = ^THTHUMBNAIL;


    TDWM_THUMBNAIL_PROPERTIES = packed record
        dwFlags: DWORD;
        rcDestination: TRECT;
        rcSource: TRECT;
        opacity: byte;
        fVisible: boolean;
        fSourceClientAreaOnly: boolean;
    end;
    PDWM_THUMBNAIL_PROPERTIES = ^TDWM_THUMBNAIL_PROPERTIES;


    // Video enabling apis

    TDWM_FRAME_COUNT = ULONGLONG;
    TQPC_TIME = ULONGLONG;

    TUNSIGNED_RATIO = packed record
        uiNumerator: UINT32;
        uiDenominator: UINT32;
    end;

    TDWM_TIMING_INFO = packed record
        cbSize: UINT32;

        // Data on DWM composition overall

        // Monitor refresh rate
        rateRefresh: TUNSIGNED_RATIO;

        // Actual period
        qpcRefreshPeriod: TQPC_TIME;

        // composition rate
        rateCompose: TUNSIGNED_RATIO;

        // QPC time at a VSync interupt
        qpcVBlank: TQPC_TIME;

        // DWM refresh count of the last vsync
        // DWM refresh count is a 64bit number where zero is
        // the first refresh the DWM woke up to process
        cRefresh: TDWM_FRAME_COUNT;

        // DX refresh count at the last Vsync Interupt
        // DX refresh count is a 32bit number with zero
        // being the first refresh after the card was initialized
        // DX increments a counter when ever a VSync ISR is processed
        // It is possible for DX to miss VSyncs

        // There is not a fixed mapping between DX and DWM refresh counts
        // because the DX will rollover and may miss VSync interupts
        cDXRefresh: UINT;

        // QPC time at a compose time.
        qpcCompose: TQPC_TIME;

        // Frame number that was composed at qpcCompose
        cFrame: TDWM_FRAME_COUNT;

        // The present number DX uses to identify renderer frames
        cDXPresent: UINT;

        // Refresh count of the frame that was composed at qpcCompose
        cRefreshFrame: TDWM_FRAME_COUNT;


        // DWM frame number that was last submitted
        cFrameSubmitted: TDWM_FRAME_COUNT;

        // DX Present number that was last submitted
        cDXPresentSubmitted: UINT;

        // DWM frame number that was last confirmed presented
        cFrameConfirmed: TDWM_FRAME_COUNT;

        // DX Present number that was last confirmed presented
        cDXPresentConfirmed: UINT;

        // The target refresh count of the last
        // frame confirmed completed by the GPU
        cRefreshConfirmed: TDWM_FRAME_COUNT;

        // DX refresh count when the frame was confirmed presented
        cDXRefreshConfirmed: UINT;

        // Number of frames the DWM presented late
        // AKA Glitches
        cFramesLate: TDWM_FRAME_COUNT;

        // the number of composition frames that
        // have been issued but not confirmed completed
        cFramesOutstanding: UINT;


        // Following fields are only relavent when an HWND is specified
        // Display frame


        // Last frame displayed
        cFrameDisplayed: TDWM_FRAME_COUNT;

        // QPC time of the composition pass when the frame was displayed
        qpcFrameDisplayed: TQPC_TIME;

        // Count of the VSync when the frame should have become visible
        cRefreshFrameDisplayed: TDWM_FRAME_COUNT;

        // Complete frames: DX has notified the DWM that the frame is done rendering

        // ID of the the last frame marked complete (starts at 0)
        cFrameComplete: TDWM_FRAME_COUNT;

        // QPC time when the last frame was marked complete
        qpcFrameComplete: TQPC_TIME;

        // Pending frames:
        // The application has been submitted to DX but not completed by the GPU

        // ID of the the last frame marked pending (starts at 0)
        cFramePending: TDWM_FRAME_COUNT;

        // QPC time when the last frame was marked pending
        qpcFramePending: TQPC_TIME;

        // number of unique frames displayed
        cFramesDisplayed: TDWM_FRAME_COUNT;

        // number of new completed frames that have been received
        cFramesComplete: TDWM_FRAME_COUNT;

        // number of new frames submitted to DX but not yet complete
        cFramesPending: TDWM_FRAME_COUNT;

        // number of frames available but not displayed, used or dropped
        cFramesAvailable: TDWM_FRAME_COUNT;

        // number of rendered frames that were never
        // displayed because composition occured too late
        cFramesDropped: TDWM_FRAME_COUNT;

        // number of times an old frame was composed
        // when a new frame should have been used
        // but was not available
        cFramesMissed: TDWM_FRAME_COUNT;

        // the refresh at which the next frame is
        // scheduled to be displayed
        cRefreshNextDisplayed: TDWM_FRAME_COUNT;

        // the refresh at which the next DX present is
        // scheduled to be displayed
        cRefreshNextPresented: TDWM_FRAME_COUNT;

        // The total number of refreshes worth of content
        // for this HWND that have been displayed by the DWM
        // since DwmSetPresentParameters was called
        cRefreshesDisplayed: TDWM_FRAME_COUNT;

        // The total number of refreshes worth of content
        // that have been presented by the application
        // since DwmSetPresentParameters was called
        cRefreshesPresented: TDWM_FRAME_COUNT;


        // The actual refresh # when content for this
        // window started to be displayed
        // it may be different than that requested
        // DwmSetPresentParameters
        cRefreshStarted: TDWM_FRAME_COUNT;

        // Total number of pixels DX redirected
        // to the DWM.
        // If Queueing is used the full buffer
        // is transfered on each present.
        // If not queuing it is possible only
        // a dirty region is updated
        cPixelsReceived: ULONGLONG;

        // Total number of pixels drawn.
        // Does not take into account if
        // if the window is only partial drawn
        // do to clipping or dirty rect management
        cPixelsDrawn: ULONGLONG;

        // The number of buffers in the flipchain
        // that are empty.   An application can
        // present that number of times and guarantee
        // it won't be blocked waiting for a buffer to
        // become empty to present to
        cBuffersEmpty: TDWM_FRAME_COUNT;

    end;

    TDWM_SOURCE_FRAME_SAMPLING = (
        // Use the first source frame that
        // includes the first refresh of the output frame
        DWM_SOURCE_FRAME_SAMPLING_POINT,

        // use the source frame that includes the most
        // refreshes of out the output frame
        // in case of multiple source frames with the
        // same coverage the last will be used
        DWM_SOURCE_FRAME_SAMPLING_COVERAGE,

        // Sentinel value
        DWM_SOURCE_FRAME_SAMPLING_LAST);


    TDWM_PRESENT_PARAMETERS = packed record
        cbSize: UINT32;
        fQueue: boolean;
        cRefreshStart: TDWM_FRAME_COUNT;
        cBuffer: UINT;
        fUseSourceRate: boolean;
        rateSource: TUNSIGNED_RATIO;
        cRefreshesPerFrame: UINT;
        eSampling: TDWM_SOURCE_FRAME_SAMPLING;
    end;


    TMilMatrix3x2D = packed record
        S_11: double;
        S_12: double;
        S_21: double;
        S_22: double;
        DX: double;
        DY: double;
    end;


    // Compatibility for Vista dwm api.
    TMIL_MATRIX3X2D = TMilMatrix3x2D;


    TGESTURE_TYPE = (
        GT_PEN_TAP = 0,
        GT_PEN_DOUBLETAP = 1,
        GT_PEN_RIGHTTAP = 2,
        GT_PEN_PRESSANDHOLD = 3,
        GT_PEN_PRESSANDHOLDABORT = 4,
        GT_TOUCH_TAP = 5,
        GT_TOUCH_DOUBLETAP = 6,
        GT_TOUCH_RIGHTTAP = 7,
        GT_TOUCH_PRESSANDHOLD = 8,
        GT_TOUCH_PRESSANDHOLDABORT = 9,
        GT_TOUCH_PRESSANDTAP = 10);


    TDWM_SHOWCONTACT = (
        DWMSC_DOWN = $00000001,
        DWMSC_UP = $00000002,
        DWMSC_DRAG = $00000004,
        DWMSC_HOLD = $00000008,
        DWMSC_PENBARREL = $00000010,

        DWMSC_NONE = $00000000,
        DWMSC_ALL = $FFFFFFFF);


    TDWMTRANSITION_OWNEDWINDOW_TARGET = (
        DWMTRANSITION_OWNEDWINDOW_NULL = -1,
        DWMTRANSITION_OWNEDWINDOW_REPOSITION = 0);


function DwmDefWindowProc(hWnd: HWND; msg: UINT; wParam: WPARAM; lParam: LPARAM; out plResult: LRESULT): boolean;
    stdcall; external DWMAPI_DLL;

function DwmEnableBlurBehindWindow(hWnd: HWND; const pBlurBehind: TDWM_BLURBEHIND): HResult; stdcall; external DWMAPI_DLL;


function DwmEnableComposition(uCompositionAction: UINT): HResult; stdcall; external DWMAPI_DLL;


function DwmEnableMMCSS(fEnableMMCSS: boolean): HResult; stdcall; external DWMAPI_DLL;

function DwmExtendFrameIntoClientArea(hWnd: HWND; const pMarInset: TMARGINS): HResult; stdcall; external DWMAPI_DLL;

function DwmGetColorizationColor(out pcrColorization: DWORD; out pfOpaqueBlend: boolean): HResult; stdcall; external DWMAPI_DLL;

function DwmGetCompositionTimingInfo(hwnd: HWND; out pTimingInfo: TDWM_TIMING_INFO): HResult; stdcall; external DWMAPI_DLL;


function DwmGetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; out pvAttribute: Pointer; cbAttribute: DWORD): HResult;
    stdcall; external DWMAPI_DLL;

function DwmIsCompositionEnabled(out pfEnabled: boolean): HResult; stdcall; external DWMAPI_DLL;

function DwmModifyPreviousDxFrameDuration(hwnd: HWND; cRefreshes: integer; fRelative: boolean): HResult; stdcall; external DWMAPI_DLL;

function DwmQueryThumbnailSourceSize(hThumbnail: THTHUMBNAIL; out pSize: TSIZE): HResult; stdcall; external DWMAPI_DLL;

function DwmRegisterThumbnail(hwndDestination: HWND; hwndSource: HWND; out phThumbnailId: THTHUMBNAIL): HResult;
    stdcall; external DWMAPI_DLL;

function DwmSetDxFrameDuration(hwnd: HWND; cRefreshes: integer): HResult; stdcall; external DWMAPI_DLL;

function DwmSetPresentParameters(hwnd: HWND; var pPresentParams: TDWM_PRESENT_PARAMETERS): HResult; stdcall; external DWMAPI_DLL;

function DwmSetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; pvAttribute: pointer; cbAttribute: DWORD): HResult;
    stdcall; external DWMAPI_DLL;

function DwmUnregisterThumbnail(hThumbnailId: THTHUMBNAIL): HResult; stdcall; external DWMAPI_DLL;

function DwmUpdateThumbnailProperties(hThumbnailId: THTHUMBNAIL; const ptnProperties: TDWM_THUMBNAIL_PROPERTIES): HResult;
    stdcall; external DWMAPI_DLL;


function DwmSetIconicThumbnail(hwnd: HWND; hbmp: HBITMAP; dwSITFlags: DWORD): HResult; stdcall; external DWMAPI_DLL;

function DwmSetIconicLivePreviewBitmap(hwnd: HWND; hbmp: HBITMAP; pptClient: PPOINT; dwSITFlags: DWORD): HResult;
    stdcall; external DWMAPI_DLL;

function DwmInvalidateIconicBitmaps(hwnd: HWND): HResult; stdcall; external DWMAPI_DLL;


function DwmAttachMilContent(hwnd: HWND): HResult; stdcall; external DWMAPI_DLL;

function DwmDetachMilContent(hwnd: HWND): HResult; stdcall; external DWMAPI_DLL;

function DwmFlush(): HResult; stdcall; external DWMAPI_DLL;


function DwmGetGraphicsStreamTransformHint(uIndex: UINT; out pTransform: TMilMatrix3x2D): HResult; stdcall; external DWMAPI_DLL;

function DwmGetGraphicsStreamClient(uIndex: UINT; out pClientUuid: TGUID //UUID
    ): HResult; stdcall; external DWMAPI_DLL;


function DwmGetTransportAttributes(out pfIsRemoting: boolean; out pfIsConnected: boolean; out pDwGeneration: DWORD): HResult;
    stdcall; external DWMAPI_DLL;


function DwmTransitionOwnedWindow(hwnd: HWND; target: TDWMTRANSITION_OWNEDWINDOW_TARGET): HResult; stdcall; external DWMAPI_DLL;


function DwmRenderGesture(gt: TGESTURE_TYPE; cContacts: UINT; const pdwPointerID: PDWORD; const pPoints: PPOINT): HResult;
    stdcall; external DWMAPI_DLL;

function DwmTetherContact(dwPointerID: DWORD; fEnable: boolean; ptTether: TPOINT): HResult; stdcall; external DWMAPI_DLL;


function DwmShowContact(dwPointerID: DWORD; eShowContact: TDWM_SHOWCONTACT): HResult; stdcall; external DWMAPI_DLL;

{$A4}
{$Z4}
//include <poppack.h>

implementation

end.
