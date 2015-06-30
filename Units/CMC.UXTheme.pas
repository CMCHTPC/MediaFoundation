//---------------------------------------------------------------------------

// uxtheme.h - theming API header file.

// Copyright (c) Microsoft Corporation. All rights reserved.

//---------------------------------------------------------------------------
unit CMC.UXTheme;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils;

{$Z4}
{$A4}

const
    UXTheme_DLL = 'UxTheme.dll';


const
    MAX_THEMECOLOR = 64;
    MAX_THEMESIZE = 64;


    OTD_FORCE_RECT_SIZING = $00000001;         // make all parts size to rect
    OTD_NONCLIENT = $00000002;         // set if hTheme to be used for nonclient area
    OTD_VALIDBITS = (OTD_FORCE_RECT_SIZING or OTD_NONCLIENT);


    //------------------------------------------------------------------------
    //---- bits used in dwFlags of DTBGOPTS ----
    DTBG_CLIPRECT = $00000001; // rcClip has been specified
    DTBG_DRAWSOLID = $00000002;  // DEPRECATED: draw transparent/alpha images as solid
    DTBG_OMITBORDER = $00000004;  // don't draw border of part
    DTBG_OMITCONTENT = $00000008;  // don't draw content area of part
    DTBG_COMPUTINGREGION = $00000010; // TRUE if calling to compute region
    DTBG_MIRRORDC = $00000020;  // assume the hdc is mirrorred and
    // flip images as appropriate (currently
    // only supported for bgtype=imagefile)
    DTBG_NOMIRROR = $00000040;  // don't mirror the output, overrides everything else
    DTBG_VALIDBITS = (DTBG_CLIPRECT or DTBG_DRAWSOLID or DTBG_OMITBORDER or DTBG_OMITCONTENT or DTBG_COMPUTINGREGION or
        DTBG_MIRRORDC or DTBG_NOMIRROR);

    //---------------------------------------------------------------------------
    //----- DrawThemeText() flags ----
    DTT_GRAYED = $00000001;        // draw a grayed-out string (this is deprecated)
    DTT_FLAGS2VALIDBITS = (DTT_GRAYED);


    //-------------------------------------------------------------------------
    //----- HitTestThemeBackground, HitTestThemeBackgroundRegion flags ----

    //  Theme background segment hit test flag (default). possible return values are:
    //  HTCLIENT: hit test succeeded in the middle background segment
    //  HTTOP, HTLEFT, HTTOPLEFT, etc:  // hit test succeeded in the the respective theme background segment.
    HTTB_BACKGROUNDSEG = $00000000;
    //  Fixed border hit test option.  possible return values are:
    //  HTCLIENT: hit test succeeded in the middle background segment
    //  HTBORDER: hit test succeeded in any other background segment
    HTTB_FIXEDBORDER = $00000002;    // Return code may be either HTCLIENT or HTBORDER.
    //  Caption hit test option.  Possible return values are:
    //  HTCAPTION: hit test succeeded in the top, top left, or top right background segments
    //  HTNOWHERE or another return code, depending on absence or presence of accompanying flags, resp.
    HTTB_CAPTION = $00000004;
    //  Resizing border hit test flags.  Possible return values are:
    //  HTCLIENT: hit test succeeded in middle background segment
    //  HTTOP, HTTOPLEFT, HTLEFT, HTRIGHT, etc:    hit test succeeded in the respective system resizing zone
    //  HTBORDER: hit test failed in middle segment and resizing zones, but succeeded in a background border segment
    HTTB_RESIZINGBORDER_LEFT = $00000010;     // Hit test left resizing border,
    HTTB_RESIZINGBORDER_TOP = $00000020;     // Hit test top resizing border
    HTTB_RESIZINGBORDER_RIGHT = $00000040;     // Hit test right resizing border
    HTTB_RESIZINGBORDER_BOTTOM = $00000080;     // Hit test bottom resizing border
    HTTB_RESIZINGBORDER = (HTTB_RESIZINGBORDER_LEFT or HTTB_RESIZINGBORDER_TOP or HTTB_RESIZINGBORDER_RIGHT or HTTB_RESIZINGBORDER_BOTTOM);
    // Resizing border is specified as a template, not just window edges.
    // This option is mutually exclusive with HTTB_SYSTEMSIZINGWIDTH; HTTB_SIZINGTEMPLATE takes precedence
    HTTB_SIZINGTEMPLATE = $00000100;
    // Use system resizing border width rather than theme content margins.
    // This option is mutually exclusive with HTTB_SIZINGTEMPLATE, which takes precedence.
    HTTB_SYSTEMSIZINGMARGINS = $00000200;


    MAX_INTLIST_COUNT = 402;

    // MAX_INTLIST_COUNT  = 10; // for WinXP

    ETDT_DISABLE = $00000001;
    ETDT_ENABLE = $00000002;
    ETDT_USETABTEXTURE = $00000004;

    ETDT_ENABLETAB = (ETDT_ENABLE or ETDT_USETABTEXTURE);


    ETDT_USEAEROWIZARDTABTEXTURE = $00000008;

    ETDT_ENABLEAEROWIZARDTAB = (ETDT_ENABLE or ETDT_USEAEROWIZARDTABTEXTURE);

    ETDT_VALIDBITS = (ETDT_DISABLE or ETDT_ENABLE or ETDT_USETABTEXTURE or ETDT_USEAEROWIZARDTABTEXTURE);

    //---------------------------------------------------------------------------
    //---- flags to control theming within an app ----

    STAP_ALLOW_NONCLIENT = (1 shl 0);
    STAP_ALLOW_CONTROLS = (1 shl 1);
    STAP_ALLOW_WEBCONTENT = (1 shl 2);
    STAP_VALIDBITS = (STAP_ALLOW_NONCLIENT or STAP_ALLOW_CONTROLS or STAP_ALLOW_WEBCONTENT);

    SZ_THDOCPROP_DISPLAYNAME = 'DisplayName';
    SZ_THDOCPROP_CANONICALNAME = 'ThemeName';
    SZ_THDOCPROP_TOOLTIP = 'ToolTip';
    SZ_THDOCPROP_AUTHOR = 'author';

    GBF_DIRECT = $00000001;    // direct dereferencing.
    GBF_COPY = $00000002;    // create a copy of the bitmap
    GBF_VALIDBITS = (GBF_DIRECT or GBF_COPY);


    DTPB_WINDOWDC = $00000001;
    DTPB_USECTLCOLORSTATIC = $00000002;
    DTPB_USEERASEBKGND = $00000004;


    WTNCA_NODRAWCAPTION = $00000001;   // don't draw the window caption
    WTNCA_NODRAWICON = $00000002;   // don't draw the system icon
    WTNCA_NOSYSMENU = $00000004;   // don't expose the system menu icon functionality
    WTNCA_NOMIRRORHELP = $00000008;   // don't mirror the question mark, even in RTL layout
    WTNCA_VALIDBITS = (WTNCA_NODRAWCAPTION or WTNCA_NODRAWICON or WTNCA_NOSYSMENU or WTNCA_NOMIRRORHELP);


    //---- bits used in dwFlags of DTTOPTS ----
    DTT_TEXTCOLOR = (1 shl 0);     // crText has been specified
    DTT_BORDERCOLOR = (1 shl 1);     // crBorder has been specified
    DTT_SHADOWCOLOR = (1 shl 2);     // crShadow has been specified
    DTT_SHADOWTYPE = (1 shl 3);     // iTextShadowType has been specified
    DTT_SHADOWOFFSET = (1 shl 4);     // ptShadowOffset has been specified
    DTT_BORDERSIZE = (1 shl 5);     // iBorderSize has been specified
    DTT_FONTPROP = (1 shl 6);     // iFontPropId has been specified
    DTT_COLORPROP = (1 shl 7);     // iColorPropId has been specified
    DTT_STATEID = (1 shl 8);      // IStateId has been specified
    DTT_CALCRECT = (1 shl 9);    // Use pRect as and in/out parameter
    DTT_APPLYOVERLAY = (1 shl 10);    // fApplyOverlay has been specified
    DTT_GLOWSIZE = (1 shl 11);    // iGlowSize has been specified
    DTT_CALLBACK = (1 shl 12);    // pfnDrawTextCallback has been specified
    DTT_COMPOSITED = (1 shl 13);    // Draws text with antialiased alpha (needs a DIB section)
    DTT_VALIDBITS = (DTT_TEXTCOLOR or DTT_BORDERCOLOR or DTT_SHADOWCOLOR or DTT_SHADOWTYPE or DTT_SHADOWOFFSET or
        DTT_BORDERSIZE or DTT_FONTPROP or DTT_COLORPROP or DTT_STATEID or DTT_CALCRECT or DTT_APPLYOVERLAY or DTT_GLOWSIZE or DTT_COMPOSITED);


    BPPF_ERASE = $0001; // Empty the buffer during BeginBufferedPaint()
    BPPF_NOCLIP = $0002; // Don't apply the target DC's clip region to the double buffer
    BPPF_NONCLIENT = $0004; // Using a non-client DC


type
    PCRECT = ^TRECT;
    THTHEME = THANDLE;          // handle to a section of theme data for class


    //---------------------------------------------------------------------------
    //  Theme animation properties
    TTA_PROPERTY = (
        TAP_FLAGS,
        TAP_TRANSFORMCOUNT,
        TAP_STAGGERDELAY,
        TAP_STAGGERDELAYCAP,
        TAP_STAGGERDELAYFACTOR,
        TAP_ZORDER);

    //---------------------------------------------------------------------------
    //  when dwProperty is TAP_FLAGS, GetThemeAnimationProperty returns
    //  a combination of the following values
    TTA_PROPERTY_FLAG = (
        TAPF_NONE = $0,
        TAPF_HASSTAGGER = $1,
        TAPF_ISRTLAWARE = $2,
        TAPF_ALLOWCOLLECTION = $4,
        TAPF_HASBACKGROUND = $8,
        TAPF_HASPERSPECTIVE = $10);


    //---------------------------------------------------------------------------
    //  Theme animation transform types
    TTA_TRANSFORM_TYPE = (
        TATT_TRANSLATE_2D,
        TATT_SCALE_2D,
        TATT_OPACITY,
        TATT_CLIP);

    //---------------------------------------------------------------------------
    //  Theme animation transform flags
    TTA_TRANSFORM_FLAG = (
        TATF_NONE = $0,
        TATF_TARGETVALUES_USER = $1,
        TATF_HASINITIALVALUES = $2,
        TATF_HASORIGINVALUES = $4);


{$Z8}
{$A8}
    //include <pshpack8.h>
    TTA_TRANSFORM = record
        eTransformType: TTA_TRANSFORM_TYPE;
        dwTimingFunctionId: DWORD;
        dwStartTime: DWORD;              // in milliseconds
        dwDurationTime: DWORD;
        eFlags: TTA_TRANSFORM_FLAG;
    end;
    PTA_TRANSFORM = ^TTA_TRANSFORM;

    TTA_TRANSFORM_2D = record
        header: TTA_TRANSFORM;
        rX: single;
        rY: single;
        rInitialX: single;
        rInitialY: single;
        rOriginX: single;
        rOriginY: single;
    end;
    PTA_TRANSFORM_2D = ^TTA_TRANSFORM_2D;

    TTA_TRANSFORM_OPACITY = record
        header: TTA_TRANSFORM;
        rOpacity: single;
        rInitialOpacity: single;
    end;
    PTA_TRANSFORM_OPACITY = ^TTA_TRANSFORM_OPACITY;

    TTA_TRANSFORM_CLIP = record
        header: TTA_TRANSFORM;
        rLeft: single;
        rTop: single;
        rRight: single;
        rBottom: single;
        rInitialLeft: single;
        rInitialTop: single;
        rInitialRight: single;
        rInitialBottom: single;
    end;
    PTA_TRANSFORM_CLIP = ^TTA_TRANSFORM_CLIP;

{$Z4}
{$A4}
    //include <poppack.h>


    //---------------------------------------------------------------------------
    //  Timing function type
    TTA_TIMINGFUNCTION_TYPE = (
        TTFT_UNDEFINED,
        TTFT_CUBIC_BEZIER);

{$A8}
{$Z8}
    // include <pshpack8.h>
    TTA_TIMINGFUNCTION = record
        eTimingFunctionType: TTA_TIMINGFUNCTION_TYPE;
    end;
    PTA_TIMINGFUNCTION = ^TTA_TIMINGFUNCTION;

    TTA_CUBIC_BEZIER = record
        header: TTA_TIMINGFUNCTION;
        rX0: single;
        rY0: single;
        rX1: single;
        rY1: single;
    end;
    PTA_CUBIC_BEZIER = ^TTA_CUBIC_BEZIER;

{$A4}
{$Z4}
    //(include <poppack.h>


    TDTBGOPTS = record
        dwSize: DWORD;           // size of the struct
        dwFlags: DWORD;          // which options have been specified
        rcClip: TRECT;            // clipping rectangle
    end;
    PDTBGOPTS = ^TDTBGOPTS;

    TTHEMESIZE = (
        TS_MIN,             // minimum size
        TS_TRUE,            // size without stretching
        TS_DRAW             // size that theme mgr will use to draw part
        );


    TMARGINS = record
        cxLeftWidth: integer;      // width of left border that retains its size
        cxRightWidth: integer;     // width of right border that retains its size
        cyTopHeight: integer;      // height of top border that retains its size
        cyBottomHeight: integer;   // height of bottom border that retains its size
    end;
    PMARGINS = ^TMARGINS;


    TINTLIST = record
        iValueCount: integer;      // number of values in iValues
        iValues: array [0..MAX_INTLIST_COUNT - 1] of integer;
    end;
    PINTLIST = ^TINTLIST;


    TPROPERTYORIGIN = (
        PO_STATE,           // property was found in the state section
        PO_PART,            // property was found in the part section
        PO_CLASS,           // property was found in the class section
        PO_GLOBAL,          // property was found in [globals] section
        PO_NOTFOUND         // property was not found
        );

    PPROPERTYORIGIN = ^TPROPERTYORIGIN;

    TWINDOWTHEMEATTRIBUTETYPE = (
        WTA_NONCLIENT = 1);

    TWTA_OPTIONS = record
        dwFlags: DWORD;          // values for each style option specified in the bitmask
        dwMask: DWORD;           // bitmask for flags that are changing
        // valid options are: WTNCA_NODRAWCAPTION, WTNCA_NODRAWICON, WTNCA_NOSYSMENU
    end;
    PWTA_OPTIONS = ^TWTA_OPTIONS;

    // Callback function used by DrawThemeTextEx, instead of DrawText
    DTT_CALLBACK_PROC = function(hdc: HDC; var pszText: LPWSTR; cchText: integer; var prc: TRECT; dwFlags: UINT;
        lParam: LPARAM): integer; stdcall;

    TDTTOPTS = record
        dwSize: DWORD;              // size of the struct
        dwFlags: DWORD;             // which options have been specified
        crText: COLORREF;              // color to use for text fill
        crBorder: COLORREF;            // color to use for text outline
        crShadow: COLORREF;            // color to use for text shadow
        iTextShadowType: integer;     // TST_SINGLE or TST_CONTINUOUS
        ptShadowOffset: TPOINT;      // where shadow is drawn (relative to text)
        iBorderSize: integer;         // Border radius around text
        iFontPropId: integer;         // Font property to use for the text instead of TMT_FONT
        iColorPropId: integer;        // Color property to use for the text instead of TMT_TEXTCOLOR
        iStateId: integer;            // Alternate state id
        fApplyOverlay: boolean;       // Overlay text on top of any text effect?
        iGlowSize: integer;           // Glow radious around text
        pfnDrawTextCallback: DTT_CALLBACK_PROC; // Callback for DrawText
        lParam: LPARAM;              // Parameter for callback
    end;
    PDTTOPTS = ^TDTTOPTS;


    // HPAINTBUFFER
    THPAINTBUFFER = THANDLE;  // handle to a buffered paint context


    // BP_BUFFERFORMAT
    TBP_BUFFERFORMAT = (
        BPBF_COMPATIBLEBITMAP,    // Compatible bitmap
        BPBF_DIB,                 // Device-independent bitmap
        BPBF_TOPDOWNDIB,          // Top-down device-independent bitmap
        BPBF_TOPDOWNMONODIB,       // Top-down monochrome device-independent bitmap
        BPBF_COMPOSITED = BPBF_TOPDOWNDIB);


    // BP_ANIMATIONSTYLE
    TBP_ANIMATIONSTYLE = (
        BPAS_NONE,                // No animation
        BPAS_LINEAR,              // Linear fade animation
        BPAS_CUBIC,               // Cubic fade animation
        BPAS_SINE                 // Sinusoid fade animation
        );


    // BP_ANIMATIONPARAMS
    TBP_ANIMATIONPARAMS = record
        cbSize: DWORD;
        dwFlags: DWORD; // BPAF_ flags
        style: TBP_ANIMATIONSTYLE;
        dwDuration: DWORD;
    end;
    PBP_ANIMATIONPARAMS = ^TBP_ANIMATIONPARAMS;


    // BP_PAINTPARAMS
    TBP_PAINTPARAMS = record
        cbSize: DWORD;
        dwFlags: DWORD; // BPPF_ flags
        prcExclude: PRECT;
        pBlendFunction: PBLENDFUNCTION;
    end;
    PBP_PAINTPARAMS = ^TBP_PAINTPARAMS;


    THANIMATIONBUFFER = THANDLE;  // handle to a buffered paint animation


//---------------------------------------------------------------------------
// BeginPanningFeedback - Visual feedback init function related to pan gesture
//   - internally called by DefaultGestureHandler
//   - called by application

//  HWND hwnd - The handle to the Target window that will receive feedback

//---------------------------------------------------------------------------
function BeginPanningFeedback(hwnd: HWND): boolean; stdcall; external UXTheme_DLL;
//---------------------------------------------------------------------------
// UpdatePanningFeedback : Visual feedback function related to pan gesture
// Can Be called only after a BeginPanningFeedback call
//   - internally called by DefaultGestureHandler
//   - called by application

// HWND hwnd                 - The handle to the Target window that will receive feedback
//                             For the method to succeed this must be the same hwnd as provided in
//                             BeginPanningFeedback

// LONG lTotalOverpanOffsetX - The Total displacement that the window has moved in the horizontal direction
//                             since the end of scrollable region was reached. The API would move the window by the distance specified
//                             A maximum displacement of 30 pixels is allowed

// LONG lTotalOverpanOffsetY - The Total displacement that the window has moved in the horizontal direction
//                             since the end of scrollable
//                             region was reached. The API would move the window by the distance specified
//                             A maximum displacement of 30 pixels is allowed

// BOOL fInInertia           - Flag dictating whether the Application is handling a WM_GESTURE message with the
//                             GF_INERTIA FLAG set

//   Incremental calls to UpdatePanningFeedback should make sure they always pass
//   the sum of the increments and not just the increment themselves
//   Eg : If the initial displacement is 10 pixels and the next displacement 10 pixels
//        the second call would be with the parameter as 20 pixels as opposed to 10
//   Eg : UpdatePanningFeedback(hwnd, 10, 10, TRUE)

function UpdatePanningFeedback(hwnd: HWND; lTotalOverpanOffsetX: longint; lTotalOverpanOffsetY: longint; fInInertia: boolean): boolean;
    stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------

// EndPanningFeedback :Visual feedback reset function related to pan gesture
//   - internally called by DefaultGestureHandler
//   - called by application
//   Terminates any existing animation that was in process or set up by BeginPanningFeedback and UpdatePanningFeedback
//   The EndPanningFeedBack needs to be called Prior to calling any BeginPanningFeedBack if we have already
//   called a BeginPanningFeedBack followed by one/ more UpdatePanningFeedback calls

//  HWND hwnd         - The handle to the Target window that will receive feedback

//  BOOL fAnimateBack - Flag to indicate whether you wish the displaced window to move back
//                      to the original position via animation or a direct jump.
//                      Either ways the method will try to restore the moved window.
//                      The latter case exists for compatibility with legacy apps.

function EndPanningFeedback(hwnd: HWND; fAnimateBack: boolean): boolean; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  GetThemeAnimationProperty() - Retrieve a theme animation property based
//                                on the storybard id and the target id.

//                                Storyboard id and target id is defined in vsanimation.h

//                                Available properties are defined above,
//                                with prefix TAP_.

//  hTheme                      - Theme data handle (from OpenThemeData API)

//  iStoryboardId               - Animation storyboard identifier

//  iTargetId                   - Target surface identifier

//  eProperty                   - Property associated with the animation storyboard and target

//  pvProperty                  - Buffer to receive returned property value

//  cbSize                      - Byte size of a buffer pointed by pvProperty

//  pcbSizeOut                  - pointer to a DWORD buffer to receive the returned
//                                byte size

function GetThemeAnimationProperty(hTheme: THTHEME; iStoryboardId: integer; iTargetId: integer; eProperty: TTA_PROPERTY;
    out pvProperty: pointer; cbSize: DWORD; out pcbSizeOut: DWORD): HResult; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  GetThemeAnimationTransform()    - Retrieve an animation transform operation
//                                    based on storyboard id, target id and transform
//                                    index

//                                    Transform index is in the range of (0, dwTransformCount - 1).
//                                    dwTransformCount can be retrieved by calling
//                                    GetThemeAnimationProperty with TAP_TRANSFORMCOUNT

//  hTheme                          - Opened theme handle

//  iStoryboardId                   - A predefined storyboard identifier

//  iTargetId                       - A predefined target identifier

//  dwTransformIndex                - Zero-based index of a transform operation

//  pTransform                      - Pointer buffer to receive a transform structure

//  pcbSizeOut                      - pointer to a DWORD buffer to receive returned
//                                    byte-size of transform operation struct

function GetThemeAnimationTransform(hTheme: THTHEME; iStoryboardId: integer; iTargetId: integer; dwTransformIndex: DWORD;
    out pTransform: TTA_TRANSFORM; cbSize: DWORD; out pcbSizeOut: DWORD): HResult;
    stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  GetThemeTimingFunction          - Retrieve a predefined timing function based on
//                                    a timing function identifier

//  hTheme                          - Opened theme handle

//  iTimingFunctionId               - Timing function identifier

//  ppThemeTimingFunction           - Buffer to receive a pre-defined timing function pointer

//  pcbSizeOut                      - pointer to a DWORD buffer to receive byte-size of
//                                    the timing function struct

function GetThemeTimingFunction(hTheme: THTHEME; iTimingFunctionId: integer; out pTimingFunction: TTA_TIMINGFUNCTION;
    cbSize: DWORD; out pcbSizeOut: DWORD): HResult; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
// NOTE: PartId's and StateId's used in the theme API are defined in the
//       hdr file <vssym32.h> using the TM_PART and TM_STATE macros.  For
//       example, "TM_PART(BP, PUSHBUTTON)" defines the PartId "BP_PUSHBUTTON".

//---------------------------------------------------------------------------
//  OpenThemeData()     - Open the theme data for the specified HWND and
//                        semi-colon separated list of class names.

//                        OpenThemeData() will try each class name, one at
//                        a time, and use the first matching theme info
//                        found.  If a match is found, a theme handle
//                        to the data is returned.  If no match is found,
//                        a "NULL" handle is returned.

//                        When the window is destroyed or a WM_THEMECHANGED
//                        msg is received, "CloseThemeData()" should be
//                        called to close the theme handle.

//  hwnd                - window handle of the control/window to be themed

//  pszClassList        - class name (or list of names) to match to theme data
//                        section.  if the list contains more than one name,
//                        the names are tested one at a time for a match.
//                        If a match is found, OpenThemeData() returns a
//                        theme handle associated with the matching class.
//                        This param is a list (instead of just a single
//                        class name) to provide the class an opportunity
//                        to get the "best" match between the class and
//                        the current theme.  For example, a button might
//                        pass L"OkButton, Button" if its ID=ID_OK.  If
//                        the current theme has an entry for OkButton,
//                        that will be used.  Otherwise, we fall back on
//                        the normal Button entry.
//---------------------------------------------------------------------------
function OpenThemeData(hwnd: HWND; pszClassList: LPCWSTR): THTHEME; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  OpenThemeDataEx     - Open the theme data for the specified HWND and
//                        semi-colon separated list of class names.

//                        OpenThemeData() will try each class name, one at
//                        a time, and use the first matching theme info
//                        found.  If a match is found, a theme handle
//                        to the data is returned.  If no match is found,
//                        a "NULL" handle is returned.

//                        When the window is destroyed or a WM_THEMECHANGED
//                        msg is received, "CloseThemeData()" should be
//                        called to close the theme handle.

//  hwnd                - window handle of the control/window to be themed

//  pszClassList        - class name (or list of names) to match to theme data
//                        section.  if the list contains more than one name,
//                        the names are tested one at a time for a match.
//                        If a match is found, OpenThemeData() returns a
//                        theme handle associated with the matching class.
//                        This param is a list (instead of just a single
//                        class name) to provide the class an opportunity
//                        to get the "best" match between the class and
//                        the current theme.  For example, a button might
//                        pass L"OkButton, Button" if its ID=ID_OK.  If
//                        the current theme has an entry for OkButton,
//                        that will be used.  Otherwise, we fall back on
//                        the normal Button entry.

//  dwFlags              - allows certain overrides of std features
//                         (see OTD_XXX defines above)
//---------------------------------------------------------------------------
function OpenThemeDataEx(hwnd: HWND; pszClassList: LPCWSTR; dwFlags: DWORD): THTHEME; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  CloseThemeData()    - closes the theme data handle.  This should be done
//                        when the window being themed is destroyed or
//                        whenever a WM_THEMECHANGED msg is received
//                        (followed by an attempt to create a new Theme data
//                        handle).

//  hTheme              - open theme data handle (returned from prior call
//                        to OpenThemeData() API).
//---------------------------------------------------------------------------
function CloseThemeData(hTheme: THTHEME): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//    functions for basic drawing support
//---------------------------------------------------------------------------
// The following methods are the theme-aware drawing services.
// Controls/Windows are defined in drawable "parts" by their author: a
// parent part and 0 or more child parts.  Each of the parts can be
// described in "states" (ex: disabled, hot, pressed).
//---------------------------------------------------------------------------
// For the list of all themed classes and the definition of all
// parts and states, see the file "tmschmea.h".
//---------------------------------------------------------------------------
// Each of the below methods takes a "iPartId" param to specify the
// part and a "iStateId" to specify the state of the part.
// "iStateId=0" refers to the root part.  "iPartId" = "0" refers to
// the root class.
//-----------------------------------------------------------------------
// Note: draw operations are always scaled to fit (and not to exceed)
// the specified "Rect".
//-----------------------------------------------------------------------

//------------------------------------------------------------------------
//  DrawThemeBackground()
//                      - draws the theme-specified border and fill for
//                        the "iPartId" and "iStateId".  This could be
//                        based on a bitmap file, a border and fill, or
//                        other image description.

//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part) to draw
//  pRect               - defines the size/location of the part
//  pClipRect           - optional clipping rect (don't draw outside it)
//------------------------------------------------------------------------
function DrawThemeBackground(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pRect: PCRECT; pClipRect: PCRECT): HResult;
    stdcall; external UXTheme_DLL;


//------------------------------------------------------------------------
//  DrawThemeBackgroundEx()
//                      - draws the theme-specified border and fill for
//                        the "iPartId" and "iStateId".  This could be
//                        based on a bitmap file, a border and fill, or
//                        other image description.  NOTE: This will be
//                        merged back into DrawThemeBackground() after
//                        BETA 2.

//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part) to draw
//  pRect               - defines the size/location of the part
//  pOptions            - ptr to optional params
//------------------------------------------------------------------------
function DrawThemeBackgroundEx(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pRect: PCRECT;
    const pOptions: TDTBGOPTS): HResult; stdcall; external UXTheme_DLL;


//-------------------------------------------------------------------------
//  DrawThemeText()     - draws the text using the theme-specified
//                        color and font for the "iPartId" and
//                        "iStateId".

//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part) to draw
//  pszText             - actual text to draw
//  dwCharCount         - number of chars to draw (-1 for all)
//  dwTextFlags         - same as DrawText() "uFormat" param
//  dwTextFlags2        - additional drawing options
//  pRect               - defines the size/location of the part
//-------------------------------------------------------------------------
function DrawThemeText(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pszText: LPCWSTR; cchText: integer;
    dwTextFlags: DWORD; dwTextFlags2: DWORD; pRect: PCRECT): HResult; stdcall; external UXTheme_DLL;

//-------------------------------------------------------------------------
//  GetThemeBackgroundContentRect()
//                      - gets the size of the content for the theme-defined
//                        background.  This is usually the area inside
//                        the borders or Margins.

//      hTheme          - theme data handle
//      hdc             - (optional) device content to be used for drawing
//      iPartId         - part number to draw
//      iStateId        - state number (of the part) to draw
//      pBoundingRect   - the outer RECT of the part being drawn
//      pContentRect    - RECT to receive the content area
//-------------------------------------------------------------------------
function GetThemeBackgroundContentRect(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pBoundingRect: PCRECT;
    out pContentRect: TRECT): HResult; stdcall; external UXTheme_DLL;


//-------------------------------------------------------------------------
//  GetThemeBackgroundExtent() - calculates the size/location of the theme-
//                               specified background based on the
//                               "pContentRect".

//      hTheme          - theme data handle
//      hdc             - (optional) device content to be used for drawing
//      iPartId         - part number to draw
//      iStateId        - state number (of the part) to draw
//      pContentRect    - RECT that defines the content area
//      pBoundingRect   - RECT to receive the overall size/location of part
//-------------------------------------------------------------------------
function GetThemeBackgroundExtent(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pContentRect: PCRECT;
    out pExtentRect: TRECT): HResult; stdcall; external UXTheme_DLL;

//-------------------------------------------------------------------------
//  GetThemeBackgroundRegion()
//                      - computes the region for a regular or partially
//                        transparent theme-specified background that is
//                        bound by the specified "pRect".
//                        If the rectangle is empty, sets the HRGN to NULL
//                        and return S_FALSE.

//  hTheme              - theme data handle
//  hdc                 - optional HDC to draw into (DPI scaling)
//  iPartId             - part number to draw
//  iStateId            - state number (of the part)
//  pRect               - the RECT used to draw the part
//  pRegion             - receives handle to calculated region
//-------------------------------------------------------------------------
function GetThemeBackgroundRegion(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pRect: PCRECT;
    out pRegion: HRGN): HResult; stdcall; external UXTheme_DLL;


//-------------------------------------------------------------------------
//  GetThemePartSize() - returns the specified size of the theme part

//  hTheme              - theme data handle
//  hdc                 - HDC to select font into & measure against
//  iPartId             - part number to retrieve size for
//  iStateId            - state number (of the part)
//  prc                 - (optional) rect for part drawing destination
//  eSize               - the type of size to be retreived
//  psz                 - receives the specified size of the part
//-------------------------------------------------------------------------
function GetThemePartSize(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; prc: PCRECT; eSize: TTHEMESIZE;
    out psz: TSIZE): HResult; stdcall; external UXTheme_DLL;

//-------------------------------------------------------------------------
//  GetThemeTextExtent() - calculates the size/location of the specified
//                         text when rendered in the Theme Font.

//  hTheme              - theme data handle
//  hdc                 - HDC to select font & measure into
//  iPartId             - part number to draw
//  iStateId            - state number (of the part)
//  pszText             - the text to be measured
//  dwCharCount         - number of chars to draw (-1 for all)
//  dwTextFlags         - same as DrawText() "uFormat" param
//  pszBoundingRect     - optional: to control layout of text
//  pszExtentRect       - receives the RECT for text size/location
//-------------------------------------------------------------------------
function GetThemeTextExtent(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pszText: LPCWSTR;
    cchCharCount: integer; dwTextFlags: DWORD; pBoundingRect: PCRECT; out pExtentRect: TRECT): HResult;
    stdcall; external UXTheme_DLL;

//-------------------------------------------------------------------------
//  GetThemeTextMetrics()
//                      - returns info about the theme-specified font
//                        for the part/state passed in.

//  hTheme              - theme data handle
//  hdc                 - optional: HDC for screen context
//  iPartId             - part number to draw
//  iStateId            - state number (of the part)
//  ptm                 - receives the font info
//-------------------------------------------------------------------------
function GetThemeTextMetrics(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; out ptm: TTEXTMETRICW): HResult;
    stdcall; external UXTheme_DLL;


//-------------------------------------------------------------------------
//  HitTestThemeBackground()
//                      - returns a HitTestCode (a subset of the values
//                        returned by WM_NCHITTEST) for the point "ptTest"
//                        within the theme-specified background
//                        (bound by pRect).  "pRect" and "ptTest" should
//                        both be in the same coordinate system
//                        (client, screen, etc).

//      hTheme          - theme data handle
//      hdc             - HDC to draw into
//      iPartId         - part number to test against
//      iStateId        - state number (of the part)
//      pRect           - the RECT used to draw the part
//      hrgn            - optional region to use; must be in same coordinates as
//                      -    pRect and pTest.
//      ptTest          - the hit point to be tested
//      dwOptions       - HTTB_xxx constants
//      pwHitTestCode   - receives the returned hit test code - one of:

//                        HTNOWHERE, HTLEFT, HTTOPLEFT, HTBOTTOMLEFT,
//                        HTRIGHT, HTTOPRIGHT, HTBOTTOMRIGHT,
//                        HTTOP, HTBOTTOM, HTCLIENT
//-------------------------------------------------------------------------
function HitTestThemeBackground(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; dwOptions: DWORD;
    pRect: PCRECT; hrgn: HRGN; ptTest: TPOINT; out pwHitTestCode: word): HResult;
    stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  DrawThemeEdge()     - Similar to the DrawEdge() API, but uses part colors
//                        and is high-DPI aware
//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number of part
//  pDestRect           - the RECT used to draw the line(s)
//  uEdge               - Same as DrawEdge() API
//  uFlags              - Same as DrawEdge() API
//  pContentRect        - Receives the interior rect if (uFlags & BF_ADJUST)
//------------------------------------------------------------------------
function DrawThemeEdge(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pDestRect: PCRECT; uEdge: UINT;
    uFlags: UINT; out pContentRect: TRECT): HResult; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  DrawThemeIcon()     - draws an image within an imagelist based on
//                        a (possible) theme-defined effect.

//  hTheme              - theme data handle
//  hdc                 - HDC to draw into
//  iPartId             - part number to draw
//  iStateId            - state number of part
//  pRect               - the RECT to draw the image within
//  himl                - handle to IMAGELIST
//  iImageIndex         - index into IMAGELIST (which icon to draw)
//------------------------------------------------------------------------
function DrawThemeIcon(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pRect: PCRECT; himl: HIMAGELIST;
    iImageIndex: integer): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  IsThemePartDefined() - returns TRUE if the theme has defined parameters
//                         for the specified "iPartId" and "iStateId".

//  hTheme              - theme data handle
//  iPartId             - part number to find definition for
//  iStateId            - state number of part
//---------------------------------------------------------------------------
function IsThemePartDefined(hTheme: THTHEME; iPartId: integer; iStateId: integer): boolean; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  IsThemeBackgroundPartiallyTransparent()
//                      - returns TRUE if the theme specified background for
//                        the part/state has transparent pieces or
//                        alpha-blended pieces.

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//---------------------------------------------------------------------------
function IsThemeBackgroundPartiallyTransparent(hTheme: THTHEME; iPartId: integer; iStateId: integer): boolean;
    stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//    lower-level theme information services
//---------------------------------------------------------------------------
// The following methods are getter routines for each of the Theme Data types.
// Controls/Windows are defined in drawable "parts" by their author: a
// parent part and 0 or more child parts.  Each of the parts can be
// described in "states" (ex: disabled, hot, pressed).
//---------------------------------------------------------------------------
// Each of the below methods takes a "iPartId" param to specify the
// part and a "iStateId" to specify the state of the part.
// "iStateId=0" refers to the root part.  "iPartId" = "0" refers to
// the root class.
//-----------------------------------------------------------------------
// Each method also take a "iPropId" param because multiple instances of
// the same primitive type can be defined in the theme schema.
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
//  GetThemeColor()     - Get the value for the specified COLOR property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pColor              - receives the value of the property
//-----------------------------------------------------------------------
function GetThemeColor(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pColor: COLORREF): HResult;
    stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeMetric()    - Get the value for the specified metric/size
//                        property

//  hTheme              - theme data handle
//  hdc                 - (optional) hdc to be drawn into (DPI scaling)
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  piVal               - receives the value of the property
//-----------------------------------------------------------------------
function GetThemeMetric(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; iPropId: integer; out piVal: integer): HResult;
    stdcall; external UXTheme_DLL;


//-----------------------------------------------------------------------
//  GetThemeString()    - Get the value for the specified string property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pszBuff             - receives the string property value
//  cchMaxBuffChars     - max. number of chars allowed in pszBuff
//-----------------------------------------------------------------------
function GetThemeString(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pszBuff: LPWSTR;
    cchMaxBuffChars: integer): HResult; stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeBool()      - Get the value for the specified BOOL property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pfVal               - receives the value of the property
//-----------------------------------------------------------------------
function GetThemeBool(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pfVal: boolean): HResult;
    stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeInt()       - Get the value for the specified int property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  piVal               - receives the value of the property
//-----------------------------------------------------------------------
function GetThemeInt(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out piVal: integer): HResult;
    stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeEnumValue() - Get the value for the specified ENUM property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  piVal               - receives the value of the enum (cast to int*)
//-----------------------------------------------------------------------
function GetThemeEnumValue(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out piVal: integer): HResult;
    stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemePosition()  - Get the value for the specified position
//                        property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pPoint              - receives the value of the position property
//-----------------------------------------------------------------------
function GetThemePosition(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pPoint: TPOINT): HResult;
    stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeFont()      - Get the value for the specified font property

//  hTheme              - theme data handle
//  hdc                 - (optional) hdc to be drawn to (DPI scaling)
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pFont               - receives the value of the LOGFONT property
//                        (scaled for the current logical screen dpi)
//-----------------------------------------------------------------------
function GetThemeFont(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; iPropId: integer; out pFont: LOGFONTW): HResult;
    stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeRect()      - Get the value for the specified RECT property

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to get the value for
//  pRect               - receives the value of the RECT property
//-----------------------------------------------------------------------
function GetThemeRect(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pRect: TRECT): HResult;
    stdcall; external UXTheme_DLL;


//-----------------------------------------------------------------------
//  GetThemeMargins()   - Get the value for the specified MARGINS property

//      hTheme          - theme data handle
//      hdc             - (optional) hdc to be used for drawing
//      iPartId         - part number
//      iStateId        - state number of part
//      iPropId         - the property number to get the value for
//      prc             - RECT for area to be drawn into
//      pMargins        - receives the value of the MARGINS property
//-----------------------------------------------------------------------
function GetThemeMargins(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; iPropId: integer;
    prc: PCRECT; out pMargins: TMARGINS): HResult; stdcall; external UXTheme_DLL;


//-----------------------------------------------------------------------
//  GetThemeIntList()   - Get the value for the specified INTLIST struct

//      hTheme          - theme data handle
//      iPartId         - part number
//      iStateId        - state number of part
//      iPropId         - the property number to get the value for
//      pIntList        - receives the value of the INTLIST property
//-----------------------------------------------------------------------
function GetThemeIntList(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pIntList: TINTLIST): HResult;
    stdcall; external UXTheme_DLL;


//-----------------------------------------------------------------------
//  GetThemePropertyOrigin()
//                      - searches for the specified theme property
//                        and sets "pOrigin" to indicate where it was
//                        found (or not found)

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to search for
//  pOrigin             - receives the value of the property origin
//-----------------------------------------------------------------------
function GetThemePropertyOrigin(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pOrigin: TPROPERTYORIGIN): HResult;
    stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  SetWindowTheme()
//                      - redirects an existing Window to use a different
//                        section of the current theme information than its
//                        class normally asks for.

//  hwnd                - the handle of the window (cannot be NULL)

//  pszSubAppName       - app (group) name to use in place of the calling
//                        app's name.  If NULL; the actual calling app
//                        name will be used.

//  pszSubIdList        - semicolon separated list of class Id names to
//                        use in place of actual list passed by the
//                        window's class.  if NULL; the id list from the
//                        calling class is used.
//---------------------------------------------------------------------------
// The Theme Manager will remember the "pszSubAppName" and the
// "pszSubIdList" associations thru the lifetime of the window (even
// if themes are subsequently changed).  The window is sent a
// "WM_THEMECHANGED" msg at the end of this call; so that the new
// theme can be found and applied.
//---------------------------------------------------------------------------
// When "pszSubAppName" or "pszSubIdList" are NULL; the Theme Manager
// removes the previously remember association.  To turn off theme-ing for
// the specified window; you can pass an empty string (L"") so it
// won't match any section entries.
//---------------------------------------------------------------------------
function SetWindowTheme(hwnd: HWND; pszSubAppName: LPCWSTR; pszSubIdList: LPCWSTR): HResult; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  GetThemeFilename()  - Get the value for the specified FILENAME property.

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateId            - state number of part
//  iPropId             - the property number to search for
//  pszThemeFileName    - output buffer to receive the filename
//  cchMaxBuffChars     - the size of the return buffer; in chars
//---------------------------------------------------------------------------
function GetThemeFilename(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out pszThemeFileName: LPWSTR;
    cchMaxBuffChars: integer): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysColor()  - Get the value of the specified System color.

//  hTheme              - the theme data handle.  if non-NULL; will return
//                        color from [SysMetrics] section of theme.
//                        if NULL; will return the global system color.

//  iColorId            - the system color index defined in winuser.h
//---------------------------------------------------------------------------
function GetThemeSysColor(hTheme: THTHEME; iColorId: integer): COLORREF; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysColorBrush()
//                      - Get the brush for the specified System color.

//  hTheme              - the theme data handle.  if non-NULL; will return
//                        brush matching color from [SysMetrics] section of
//                        theme.  if NULL; will return the brush matching
//                        global system color.

//  iColorId            - the system color index defined in winuser.h
//---------------------------------------------------------------------------
function GetThemeSysColorBrush(hTheme: THTHEME; iColorId: integer): HBRUSH; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysBool()   - Get the boolean value of specified System metric.

//  hTheme              - the theme data handle.  if non-NULL; will return
//                        BOOL from [SysMetrics] section of theme.
//                        if NULL; will return the specified system boolean.

//  iBoolId             - the TMT_XXX BOOL number (first BOOL
//                        is TMT_FLATMENUS)
//---------------------------------------------------------------------------
function GetThemeSysBool(hTheme: THTHEME; iBoolId: integer): boolean; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysSize()   - Get the value of the specified System size metric.
//                        (scaled for the current logical screen dpi)

//  hTheme              - the theme data handle.  if non-NULL; will return
//                        size from [SysMetrics] section of theme.
//                        if NULL; will return the global system metric.

//  iSizeId             - the following values are supported when
//                        hTheme is non-NULL:

//                          SM_CXBORDER       (border width)
//                          SM_CXVSCROLL      (scrollbar width)
//                          SM_CYHSCROLL      (scrollbar height)
//                          SM_CXSIZE         (caption width)
//                          SM_CYSIZE         (caption height)
//                          SM_CXSMSIZE       (small caption width)
//                          SM_CYSMSIZE       (small caption height)
//                          SM_CXMENUSIZE     (menubar width)
//                          SM_CYMENUSIZE     (menubar height)
//                          SM_CXPADDEDBORDER (padded border width)

//                        when hTheme is NULL; iSizeId is passed directly
//                        to the GetSystemMetrics() function
//---------------------------------------------------------------------------
function GetThemeSysSize(hTheme: THTHEME; iSizeId: integer): integer; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysFont()   - Get the LOGFONT for the specified System font.

//  hTheme              - the theme data handle.  if non-NULL; will return
//                        font from [SysMetrics] section of theme.
//                        if NULL; will return the specified system font.

//  iFontId             - the TMT_XXX font number (first font
//                        is TMT_CAPTIONFONT)

//  plf                 - ptr to LOGFONT to receive the font value.
//                        (scaled for the current logical screen dpi)
//---------------------------------------------------------------------------
function GetThemeSysFont(hTheme: THTHEME; iFontId: integer; out plf: LOGFONTW): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysString() - Get the value of specified System string metric.

//  hTheme              - the theme data handle (required)

//  iStringId           - must be one of the following values:

//                          TMT_CSSNAME
//                          TMT_XMLNAME

//  pszStringBuff       - the buffer to receive the string value

//  cchMaxStringChars   - max. number of chars that pszStringBuff can hold
//---------------------------------------------------------------------------
function GetThemeSysString(hTheme: THTHEME; iStringId: integer; out pszStringBuff: LPWSTR; cchMaxStringChars: integer): HResult;
    stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetThemeSysInt() - Get the value of specified System int.

//  hTheme              - the theme data handle (required)

//  iIntId              - must be one of the following values:

//                          TMT_DPIX
//                          TMT_DPIY
//                          TMT_MINCOLORDEPTH

//  piValue             - ptr to int to receive value
//---------------------------------------------------------------------------
function GetThemeSysInt(hTheme: THTHEME; iIntId: integer; out piValue: integer): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  IsThemeActive()     - can be used to test if a system theme is active
//                        for the current user session.

//                        use the API "IsAppThemed()" to test if a theme is
//                        active for the calling process.
//---------------------------------------------------------------------------
function IsThemeActive(): boolean; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  IsAppThemed()       - returns TRUE if a theme is active and available to
//                        the current process
//---------------------------------------------------------------------------
function IsAppThemed(): boolean; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetWindowTheme()    - if window is themed; returns its most recent
//                          :THTHEME from OpenThemeData() - otherwise; returns
//                        NULL.

//      hwnd            - the window to get the   :THTHEME of
//---------------------------------------------------------------------------
function GetWindowTheme(hwnd: HWND): THTHEME; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  EnableThemeDialogTexture()

//  - Enables/disables dialog background theme.  This method can be used to
//    tailor dialog compatibility with child windows and controls that
//    may or may not coordinate the rendering of their client area backgrounds
//    with that of their parent dialog in a manner that supports seamless
//    background texturing.

//      hdlg         - the window handle of the target dialog
//      dwFlags      - ETDT_ENABLE to enable the theme-defined dialog background texturing;
//                     ETDT_DISABLE to disable background texturing;
//                     ETDT_ENABLETAB to enable the theme-defined background
//                          texturing using the Tab texture
//---------------------------------------------------------------------------
function EnableThemeDialogTexture(hwnd: HWND; dwFlags: DWORD): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  IsThemeDialogTextureEnabled()

//  - Reports whether the dialog supports background texturing.

//      hdlg         - the window handle of the target dialog
//---------------------------------------------------------------------------
function IsThemeDialogTextureEnabled(hwnd: HWND): boolean; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  GetThemeAppProperties()
//                      - returns the app property flags that control theming
//---------------------------------------------------------------------------
function GetThemeAppProperties(): DWORD; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  SetThemeAppProperties()
//                      - sets the flags that control theming within the app

//      dwFlags         - the flag values to be set
//---------------------------------------------------------------------------
procedure SetThemeAppProperties(dwFlags: DWORD); stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  GetCurrentThemeName()
//                      - Get the name of the current theme in-use.
//                        Optionally; return the ColorScheme name and the
//                        Size name of the theme.

//  pszThemeFileName    - receives the theme path & filename
//  cchMaxNameChars     - max chars allowed in pszNameBuff

//  pszColorBuff        - (optional) receives the canonical color scheme name
//                        (not the display name)
//  cchMaxColorChars    - max chars allowed in pszColorBuff

//  pszSizeBuff         - (optional) receives the canonical size name
//                        (not the display name)
//  cchMaxSizeChars     - max chars allowed in pszSizeBuff
//---------------------------------------------------------------------------
function GetCurrentThemeName(out pszThemeFileName: LPWSTR; cchMaxNameChars: integer; out pszColorBuff: LPWSTR;
    cchMaxColorChars: integer; out pszSizeBuff: LPWSTR; cchMaxSizeChars: integer): HResult; stdcall; external UXTheme_DLL;


function GetThemeDocumentationProperty(pszThemeName: LPCWSTR; pszPropertyName: LPCWSTR; out pszValueBuff: LPWSTR;
    cchMaxValChars: integer): HResult; stdcall; external UXTheme_DLL;

//---------------------------------------------------------------------------
//  Theme API Error Handling

//      All functions in the Theme API not returning an HRESULT (THEMEAPI_)
//      use the WIN32 function "SetLastError()" to record any call failures.

//      To retreive the error code of the last failure on the
//      current thread for these type of API's; use the WIN32 function
//      "GetLastError()".

//      All Theme API error codes (HRESULT's and GetLastError() values)
//      should be normal win32 errors which can be formatted into
//      strings using the Win32 API FormatMessage().
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// DrawThemeParentBackground()
//                      - used by partially-transparent or alpha-blended
//                        child controls to draw the part of their parent
//                        that they appear in front of.

//  hwnd                - handle of the child control

//  hdc                 - hdc of the child control

//  prc                 - (optional) rect that defines the area to be
//                        drawn (CHILD coordinates)
//---------------------------------------------------------------------------
function DrawThemeParentBackground(hwnd: HWND; hdc: HDC; const prc: TRECT): HResult; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
//  EnableTheming()     - enables or disables themeing for the current user
//                        in the current and future sessions.

//  fEnable             - if FALSE; disable theming & turn themes off.
//                      - if TRUE; enable themeing and; if user previously
//                        had a theme active; make it active now.
//---------------------------------------------------------------------------
function EnableTheming(fEnable: boolean): HResult; stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------
// DrawThemeParentBackgroundEx()
//                      - used by partially-transparent or alpha-blended
//                        child controls to draw the part of their parent
//                        that they appear in front of.
//                        Sends a WM_ERASEBKGND message followed by a WM_PRINTCLIENT.

//  hwnd                - handle of the child control

//  hdc                 - hdc of the child control

//  dwFlags             - if 0; only returns S_OK if the parent handled
//                        WM_PRINTCLIENT.
//                      - if DTPB_WINDOWDC is set; hdc is assumed to be a window DC;
//                        not a client DC.
//                      - if DTPB_USEERASEBKGND is set; the function will return S_OK
//                        without sending a WM_CTLCOLORSTATIC message if the parent
//                        actually painted on WM_ERASEBKGND.
//                      - if DTPB_CTLCOLORSTATIC is set; the function will send
//                        a WM_CTLCOLORSTATIC message to the parent and use the
//                        brush if one is provided; else COLOR_BTNFACE.

//  prc                 - (optional) rect that defines the area to be
//                        drawn (CHILD coordinates)

//  Return value        - S_OK if something was painted; S_FALSE if not.
//---------------------------------------------------------------------------
function DrawThemeParentBackgroundEx(hwnd: HWND; hdc: HDC; dwFlags: DWORD; const prc: TRECT): HResult;
    stdcall; external UXTheme_DLL;


function SetWindowThemeAttribute(hwnd: HWND; eAttribute: TWINDOWTHEMEATTRIBUTETYPE; pvAttribute: pointer; cbAttribute: DWORD): HResult;
    stdcall; external UXTheme_DLL;


//---------------------------------------------------------------------------

// DrawThemeTextEx

// Note: DrawThemeTextEx only exists on Windows Vista and higher; but the
// following declarations are provided to enable declaring its prototype when
// compiling for all platforms.


function DrawThemeTextEx(hTheme: THTHEME; hdc: HDC; iPartId: integer; iStateId: integer; pszText: LPCWSTR;
    cchText: integer; dwTextFlags: DWORD; var pRect: TRECT; const pOptions: TDTTOPTS): HResult;
    stdcall; external UXTheme_DLL;


//-----------------------------------------------------------------------
//  GetThemeStream() - Get the value for the specified STREAM property

//      hTheme      - theme data handle
//      iPartId     - part number
//      iStateId    - state number of part
//      iPropId     - the property number to get the value for
//      ppvStream   - if non-null receives the value of the STREAM property (not to be freed)
//      pcbStream   - if non-null receives the size of the STREAM property
//      hInst       - NULL when iPropId==TMT_STREAM; HINSTANCE of a loaded msstyles
//                    file when iPropId==TMT_DISKSTREAM (use GetCurrentThemeName
//                    and LoadLibraryEx(LOAD_LIBRARY_AS_DATAFILE)
//-----------------------------------------------------------------------
function GetThemeBitmap(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; dwFlags: ULONG;
    out phBitmap: HBITMAP): HResult; stdcall; external UXTheme_DLL;

//-----------------------------------------------------------------------
//  GetThemeStream() - Get the value for the specified STREAM property

//      hTheme      - theme data handle
//      iPartId     - part number
//      iStateId    - state number of part
//      iPropId     - the property number to get the value for
//      ppvStream   - if non-null receives the value of the STREAM property (not to be freed)
//      pcbStream   - if non-null receives the size of the STREAM property
//      hInst       - NULL when iPropId==TMT_STREAM; HINSTANCE of a loaded msstyles
//                    file when iPropId==TMT_DISKSTREAM (use GetCurrentThemeName
//                    and LoadLibraryEx(LOAD_LIBRARY_AS_DATAFILE)
//-----------------------------------------------------------------------
function GetThemeStream(hTheme: THTHEME; iPartId: integer; iStateId: integer; iPropId: integer; out ppvStream; out pcbStream: DWORD
    // ToDo    hInst:HINSTANCE
    ): HResult; stdcall; external UXTheme_DLL;


//------------------------------------------------------------------------
//  BufferedPaintInit() - Initialize the Buffered Paint API.
//                        Should be called prior to BeginBufferedPaint;
//                        and should have a matching BufferedPaintUnInit.
//------------------------------------------------------------------------
function BufferedPaintInit(): HResult; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  BufferedPaintUnInit() - Uninitialize the Buffered Paint API.
//                          Should be called once for each call to BufferedPaintInit;
//                          when calls to BeginBufferedPaint are no longer needed.
//------------------------------------------------------------------------
function BufferedPaintUnInit(): HResult; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  BeginBufferedPaint() - Begins a buffered paint operation.

//    hdcTarget          - Target DC on which the buffer will be painted
//    rcTarget           - Rectangle specifying the area of the target DC to paint to
//    dwFormat           - Format of the buffer (see BP_BUFFERFORMAT)
//    pPaintParams       - Paint operation parameters (see BP_PAINTPARAMS)
//    phBufferedPaint    - Pointer to receive handle to new buffered paint context
//------------------------------------------------------------------------


// ToDo
function BeginBufferedPaint(hdcTarget: HDC; const prcTarget: TRECT; dwFormat: TBP_BUFFERFORMAT; pPaintParams: PBP_PAINTPARAMS;
    out phdc: HDC): THPAINTBUFFER; stdcall; external UXTheme_DLL;


//------------------------------------------------------------------------
//  EndBufferedPaint() - Ends a buffered paint operation.

//    hBufferedPaint   - handle to buffered paint context
//    fUpdateTarget    - update target DC
//------------------------------------------------------------------------
function EndBufferedPaint(hBufferedPaint: THPAINTBUFFER; fUpdateTarget: boolean): HResult; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  GetBufferedPaintTargetRect() - Returns the target rectangle specified during BeginBufferedPaint

//    hBufferedPaint             - handle to buffered paint context
//    prc                        - pointer to receive target rectangle
//------------------------------------------------------------------------
function GetBufferedPaintTargetRect(hBufferedPaint: THPAINTBUFFER; out prc: TRECT): HResult; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  GetBufferedPaintTargetDC() - Returns the target DC specified during BeginBufferedPaint

//    hBufferedPaint           - handle to buffered paint context
//------------------------------------------------------------------------
function GetBufferedPaintTargetDC(hBufferedPaint: THPAINTBUFFER): HDC; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  GetBufferedPaintDC() - Returns the same paint DC returned by BeginBufferedPaint

//    hBufferedPaint     - handle to buffered paint context
//------------------------------------------------------------------------
function GetBufferedPaintDC(hBufferedPaint: THPAINTBUFFER): HDC; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  GetBufferedPaintBits() - Obtains a pointer to the buffer bitmap; if the buffer is a DIB

//    hBufferedPaint       - handle to buffered paint context
//    ppbBuffer            - pointer to receive pointer to buffer bitmap pixels
//    pcxRow               - pointer to receive width of buffer bitmap; in pixels;
//                           this value may not necessarily be equal to the buffer width
//------------------------------------------------------------------------
function GetBufferedPaintBits(hBufferedPaint: THPAINTBUFFER; out ppbBuffer: PRGBQUAD; out pcxRow: integer): HResult;
    stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  BufferedPaintClear() - Clears given rectangle to ARGB = {0; 0; 0; 0}

//    hBufferedPaint     - handle to buffered paint context
//    prc                - rectangle to clear; NULL specifies entire buffer
//------------------------------------------------------------------------
function BufferedPaintClear(hBufferedPaint: THPAINTBUFFER; const prc: TRECT): HResult; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  BufferedPaintSetAlpha() - Set alpha to given value in given rectangle

//    hBufferedPaint        - handle to buffered paint context
//    prc                   - rectangle to set alpha in; NULL specifies entire buffer
//    alpha                 - alpha value to set in the given rectangle
//------------------------------------------------------------------------
function BufferedPaintSetAlpha(hBufferedPaint: THPAINTBUFFER; const prc: TRECT; alpha: byte): HResult; stdcall; external UXTheme_DLL;


//------------------------------------------------------------------------
//  BufferedPaintStopAllAnimations() - Stop all buffer animations for the given window

//    hwnd                           - window on which to stop all animations
//------------------------------------------------------------------------
function BufferedPaintStopAllAnimations(hwnd: HWND): HResult; stdcall; external UXTheme_DLL;


function BeginBufferedAnimation(hwnd: HWND; hdcTarget: HDC; const prcTarget: TRECT; dwFormat: TBP_BUFFERFORMAT;
    pPaintParams: PBP_PAINTPARAMS; pAnimationParams: PBP_ANIMATIONPARAMS; out phdcFrom: HDC; out phdcTo: HDC): THANIMATIONBUFFER;
    stdcall; external UXTheme_DLL;

function EndBufferedAnimation(hbpAnimation: THANIMATIONBUFFER; fUpdateTarget: boolean): HResult; stdcall; external UXTheme_DLL;

function BufferedPaintRenderAnimation(hwnd: HWND; hdcTarget: HDC): boolean; stdcall; external UXTheme_DLL;

//----------------------------------------------------------------------------
// Tells if the DWM is running; and composition effects are possible for this
// process (themes are active).
// Roughly equivalent to "DwmIsCompositionEnabled() && IsAppthemed()"
//----------------------------------------------------------------------------
function IsCompositionActive(): boolean; stdcall; external UXTheme_DLL;

//------------------------------------------------------------------------
//  GetThemeTransitionDuration()
//                      - Gets the duration for the specified transition

//  hTheme              - theme data handle
//  iPartId             - part number
//  iStateIdFrom        - starting state number of part
//  iStateIdTo          - ending state number of part
//  iPropId             - property id
//  pdwDuration         - receives the transition duration
//------------------------------------------------------------------------
function GetThemeTransitionDuration(hTheme: THTHEME; iPartId: integer; iStateIdFrom: integer; iStateIdTo: integer;
    iPropId: integer; out pdwDuration: DWORD): HResult; stdcall; external UXTheme_DLL;


implementation

{ Helper function}

function SetWindowThemeNonClientAttributes(hwnd: HWND; dwMask: DWORD; dwAttributes: DWORD): HRESULT; inline;
var
    wta: TWTA_OPTIONS;
begin
    wta.dwFlags := dwAttributes;
    wta.dwMask := dwMask;
    Result := SetWindowThemeAttribute(hwnd, WTA_NONCLIENT, @wta, sizeof(wta));
end;

// Macro for setting the buffer to opaque (alpha = 255)

function BufferedPaintMakeOpaque(hBufferedPaint: THPAINTBUFFER; const prc: TRECT): HResult;
begin
    Result := BufferedPaintSetAlpha(hBufferedPaint, prc, 255);
end;


end.
