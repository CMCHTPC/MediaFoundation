//------------------------------------------------------------------------------
// File: DVDMedia.h

// Desc: Contains typedefs and defines necessary for user mode (ring 3) DVD
//       filters and applications.

//       This should be included in the DirectShow SDK for user mode filters.
//       The types defined here should be kept in synch with ksmedia.h WDM
//       DDK for kernel mode filters.

// Copyright (c) 1997 - 2001, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner
unit Win32.DVDMedia;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    Win32.AMVideo;

const
    AM_AC3_ALTERNATE_AUDIO_1 = 1;
    AM_AC3_ALTERNATE_AUDIO_2 = 2;
    AM_AC3_ALTERNATE_AUDIO_BOTH = 3;

    AM_AC3_SERVICE_MAIN_AUDIO = 0;
    AM_AC3_SERVICE_NO_DIALOG = 1;
    AM_AC3_SERVICE_VISUALLY_IMPAIRED = 2;
    AM_AC3_SERVICE_HEARING_IMPAIRED = 3;
    AM_AC3_SERVICE_DIALOG_ONLY = 4;
    AM_AC3_SERVICE_COMMENTARY = 5;
    AM_AC3_SERVICE_EMERGENCY_FLASH = 6;
    AM_AC3_SERVICE_VOICE_OVER = 7;

    // -----------------------------------------------------------------------
    // copy protection definitions
    // -----------------------------------------------------------------------

    // AM_UseNewCSSKey for the dwTypeSpecificFlags in IMediaSample2 to indicate
    // the exact point in a stream after which to start applying a new CSS key.
    // This is typically sent on an empty media sample just before attempting
    // to renegotiate a CSS key.
    AM_UseNewCSSKey = $1;

    AM_ReverseBlockStart = $2;
    AM_ReverseBlockEnd = $4;


    // CGMS Copy Protection Flags


    AM_DVD_CGMS_RESERVED_MASK = $00000078;

    AM_DVD_CGMS_COPY_PROTECT_MASK = $00000018;
    AM_DVD_CGMS_COPY_PERMITTED = $00000000;
    AM_DVD_CGMS_COPY_ONCE = $00000010;
    AM_DVD_CGMS_NO_COPY = $00000018;

    AM_DVD_COPYRIGHT_MASK = $00000040;
    AM_DVD_NOT_COPYRIGHTED = $00000000;
    AM_DVD_COPYRIGHTED = $00000040;

    AM_DVD_SECTOR_PROTECT_MASK = $00000020;
    AM_DVD_SECTOR_NOT_PROTECTED = $00000000;
    AM_DVD_SECTOR_PROTECTED = $00000020;



    AMINTERLACE_IsInterlaced = $00000001;  // if 0, other interlace bits are irrelevent
    AMINTERLACE_1FieldPerSample = $00000002;  // else 2 fields per media sample
    AMINTERLACE_Field1First = $00000004;  // else Field 2 is first;  top field in PAL is field 1, top field in NTSC is field 2?
    AMINTERLACE_UNUSED = $00000008;
    AMINTERLACE_FieldPatternMask = $00000030;  // use this mask with AMINTERLACE_FieldPat*
    AMINTERLACE_FieldPatField1Only = $00000000;  // stream never contains a Field2
    AMINTERLACE_FieldPatField2Only = $00000010;  // stream never contains a Field1
    AMINTERLACE_FieldPatBothRegular = $00000020;  // There will be a Field2 for every Field1 (required for Weave?)
    AMINTERLACE_FieldPatBothIrregular = $00000030;  // Random pattern of Field1s and Field2s
    AMINTERLACE_DisplayModeMask = $000000c0;
    AMINTERLACE_DisplayModeBobOnly = $00000000;
    AMINTERLACE_DisplayModeWeaveOnly = $00000040;
    AMINTERLACE_DisplayModeBobOrWeave = $00000080;

    AMCOPYPROTECT_RestrictDuplication = $00000001; // duplication of this stream should be restricted

    AMMPEG2_DoPanScan = $00000001; //if set, the MPEG-2 video decoder should crop output image
    //  based on pan-scan vectors in picture_display_extension
    //  and change the picture aspect ratio accordingly.
    AMMPEG2_DVDLine21Field1 = $00000002; //if set, the MPEG-2 decoder must be able to produce an output
    //  pin for DVD style closed caption data found in GOP layer of field 1
    AMMPEG2_DVDLine21Field2 = $00000004;  //if set, the MPEG-2 decoder must be able to produce an output
    //  pin for DVD style closed caption data found in GOP layer of field 2
    AMMPEG2_SourceIsLetterboxed = $00000008;  //if set, indicates that black bars have been encoded in the top
    //  and bottom of the video.
    AMMPEG2_FilmCameraMode = $00000010;  //if set, indicates "film mode" used for 625/50 content.  If cleared,
    //  indicates that "camera mode" was used.
    AMMPEG2_LetterboxAnalogOut = $00000020;  //if set and this stream is sent to an analog output, it should
    //  be letterboxed.  Streams sent to VGA should be letterboxed only by renderers.
    AMMPEG2_DSS_UserData = $00000040; //if set, the MPEG-2 decoder must process DSS style user data
    AMMPEG2_DVB_UserData = $00000080; //if set, the MPEG-2 decoder must process DVB style user data
    AMMPEG2_27MhzTimebase = $00000100; //if set, the PTS,DTS timestamps advance at 27MHz rather than 90KHz

    AMMPEG2_WidescreenAnalogOut = $00000200; //if set and this stream is sent to an analog output, it should
    //  be in widescreen format (4x3 content should be centered on a 16x9 output).
    //  Streams sent to VGA should be widescreened only by renderers.

    // PRESENT in dwReserved1 field in VIDEOINFOHEADER2
    AMCONTROL_USED = $00000001;// Used to test if these flags are supported.  Set and test for AcceptMediaType.
    // If rejected, then you cannot use the AMCONTROL flags (send 0 for dwReserved1)
    AMCONTROL_PAD_TO_4x3 = $00000002; // if set means display the image in a 4x3 area
    AMCONTROL_PAD_TO_16x9 = $00000004; // if set means display the image in a 16x9 area
    AMCONTROL_COLORINFO_PRESENT = $00000080; // if set, indicates DXVA color info is present in the upper (24) bits of the dwControlFlags


    //===================================================================================
    // flags for dwTypeSpecificFlags in AM_SAMPLE2_PROPERTIES which define type specific
    // data in IMediaSample2
    //===================================================================================

    AM_VIDEO_FLAG_FIELD_MASK = $0003; // use this mask to check whether the sample is field1 or field2 or frame
    AM_VIDEO_FLAG_INTERLEAVED_FRAME = $0000; // the sample is a frame (remember to use AM_VIDEO_FLAG_FIELD_MASK when using this)
    AM_VIDEO_FLAG_FIELD1 = $0001; // the sample is field1 (remember to use AM_VIDEO_FLAG_FIELD_MASK when using this)
    AM_VIDEO_FLAG_FIELD2 = $0002; // the sample is the field2 (remember to use AM_VIDEO_FLAG_FIELD_MASK when using this)
    AM_VIDEO_FLAG_FIELD1FIRST = $0004; // if set means display field1 first, else display field2 first.
    // this bit is irrelavant for 1FieldPerSample mode
    AM_VIDEO_FLAG_WEAVE = $0008; // if set use bob display mode else weave
    AM_VIDEO_FLAG_IPB_MASK = $0030; // use this mask to check whether the sample is I, P or B
    AM_VIDEO_FLAG_I_SAMPLE = $0000; // I Sample (remember to use AM_VIDEO_FLAG_IPB_MASK when using this)
    AM_VIDEO_FLAG_P_SAMPLE = $0010; // P Sample (remember to use AM_VIDEO_FLAG_IPB_MASK when using this)
    AM_VIDEO_FLAG_B_SAMPLE = $0020; // B Sample (remember to use AM_VIDEO_FLAG_IPB_MASK when using this)
    AM_VIDEO_FLAG_REPEAT_FIELD = $0040; // if set means display the field which has been displayed first again after displaying
// both fields first. This bit is irrelavant for 1FieldPerSample mode

type

    // -----------------------------------------------------------------------
    // AC-3 definition for the AM_KSPROPSETID_AC3 property set
    // -----------------------------------------------------------------------

    TAM_PROPERTY_AC3 = (
        AM_PROPERTY_AC3_ERROR_CONCEALMENT = 1,
        AM_PROPERTY_AC3_ALTERNATE_AUDIO = 2,
        AM_PROPERTY_AC3_DOWNMIX = 3,
        AM_PROPERTY_AC3_BIT_STREAM_MODE = 4,
        AM_PROPERTY_AC3_DIALOGUE_LEVEL = 5,
        AM_PROPERTY_AC3_LANGUAGE_CODE = 6,
        AM_PROPERTY_AC3_ROOM_TYPE = 7);

    TAM_AC3_ERROR_CONCEALMENT = record
        fRepeatPreviousBlock: longbool;
        fErrorInCurrentBlock: longbool;
    end;
    PAM_AC3_ERROR_CONCEALMENT = ^TAM_AC3_ERROR_CONCEALMENT;

    TAM_AC3_ALTERNATE_AUDIO = record
        fStereo: longbool;
        DualMode: ULONG;
    end;
    PAM_AC3_ALTERNATE_AUDIO = ^TAM_AC3_ALTERNATE_AUDIO;



    TAM_AC3_DOWNMIX = record
        fDownMix: longbool;
        fDolbySurround: longbool;
    end;
    PAM_AC3_DOWNMIX = ^TAM_AC3_DOWNMIX;

    TAM_AC3_BIT_STREAM_MODE = record
        BitStreamMode: LONG;
    end;
    PAM_AC3_BIT_STREAM_MODE = ^TAM_AC3_BIT_STREAM_MODE;



    TAM_AC3_DIALOGUE_LEVEL = record
        DialogueLevel: ULONG;
    end;
    PAM_AC3_DIALOGUE_LEVEL = ^TAM_AC3_DIALOGUE_LEVEL;

    TAM_AC3_ROOM_TYPE = record
        fLargeRoom: longbool;
    end;
    PAM_AC3_ROOM_TYPE = ^TAM_AC3_ROOM_TYPE;


    // -----------------------------------------------------------------------
    // subpicture definition for the AM_KSPROPSETID_DvdSubPic property set
    // -----------------------------------------------------------------------

    TAM_PROPERTY_DVDSUBPIC = (
        AM_PROPERTY_DVDSUBPIC_PALETTE = 0,
        AM_PROPERTY_DVDSUBPIC_HLI = 1,
        AM_PROPERTY_DVDSUBPIC_COMPOSIT_ON = 2  // TRUE for subpicture is displayed
        );

    TAM_DVD_YUV = record
        Reserved: UCHAR;
        Y: UCHAR;
        U: UCHAR;
        V: UCHAR;
    end;
    PAM_DVD_YUV = ^TAM_DVD_YUV;

    TAM_PROPERTY_SPPAL = record
        sppal: array [0..15] of TAM_DVD_YUV;
    end;
    PAM_PROPERTY_SPPAL = ^TAM_PROPERTY_SPPAL;


    { for bitpacked records }
    Unsigned_Bits4 = 0 .. (1 shl 4) - 1;

    TAM_COLCON = record
        emph1col: Unsigned_Bits4;
        emph2col: Unsigned_Bits4;
        backcol: Unsigned_Bits4;
        patcol: Unsigned_Bits4;
        emph1con: Unsigned_Bits4;
        emph2con: Unsigned_Bits4;
        backcon: Unsigned_Bits4;
        patcon: Unsigned_Bits4;
    end;
    PAM_COLCON = ^TAM_COLCON;

    TAM_PROPERTY_SPHLI = record
        HLISS: USHORT;
        Reserved: USHORT;
        StartPTM: ULONG;   // start presentation time in x/90000
        EndPTM: ULONG;     // end PTM in x/90000
        StartX: USHORT;
        StartY: USHORT;
        StopX: USHORT;
        StopY: USHORT;
        ColCon: TAM_COLCON;     // color contrast description (4 bytes as given in HLI)
    end;
    PAM_PROPERTY_SPHLI = ^TAM_PROPERTY_SPHLI;

    TAM_PROPERTY_COMPOSIT_ON = longbool;
    PAM_PROPERTY_COMPOSIT_ON = ^TAM_PROPERTY_COMPOSIT_ON;




    // -----------------------------------------------------------------------
    // copy protection definitions
    // -----------------------------------------------------------------------


    // AM_KSPROPSETID_CopyProt property set definitions

    TAM_PROPERTY_DVDCOPYPROT = (
        AM_PROPERTY_DVDCOPY_CHLG_KEY = $01,
        AM_PROPERTY_DVDCOPY_DVD_KEY1 = $02,
        AM_PROPERTY_DVDCOPY_DEC_KEY2 = $03,
        AM_PROPERTY_DVDCOPY_TITLE_KEY = $04,
        AM_PROPERTY_COPY_MACROVISION = $05,
        AM_PROPERTY_DVDCOPY_REGION = $06,
        AM_PROPERTY_DVDCOPY_SET_COPY_STATE = $07,
        AM_PROPERTY_COPY_ANALOG_COMPONENT = $08, // GetOnly property, return data is a longbool
        AM_PROPERTY_COPY_DIGITAL_CP = $09,
        AM_PROPERTY_COPY_DVD_SRM = $0a,
        AM_PROPERTY_DVDCOPY_SUPPORTS_NEW_KEYCOUNT = $0b,    // read only, longbool
        // gap
        AM_PROPERTY_DVDCOPY_DISC_KEY = $80);

    TAM_DIGITAL_CP = (
        AM_DIGITAL_CP_OFF = 0,
        AM_DIGITAL_CP_ON = 1,
        AM_DIGITAL_CP_DVD_COMPLIANT = 2);

    TAM_DVDCOPY_CHLGKEY = record
        ChlgKey: array [0..9] of byte;
        Reserved: array [0..1] of byte;
    end;
    PAM_DVDCOPY_CHLGKEY = TAM_DVDCOPY_CHLGKEY;

    TAM_DVDCOPY_BUSKEY = record
        BusKey: array [0..4] of byte;
        Reserved: array[0..0] of byte;
    end;
    PAM_DVDCOPY_BUSKEY = ^TAM_DVDCOPY_BUSKEY;

    TAM_DVDCOPY_DISCKEY = record
        DiscKey: array [0..2047] of byte;
    end;
    PAM_DVDCOPY_DISCKEY = ^TAM_DVDCOPY_DISCKEY;

    TAM_DVDCOPY_TITLEKEY = record
        KeyFlags: ULONG;
        Reserved1: array [0..1] of ULONG;
        TitleKey: array [0..5] of UCHAR;
        Reserved2: array [0..1] of UCHAR;
    end;
    PAM_DVDCOPY_TITLEKEY = ^TAM_DVDCOPY_TITLEKEY;

    TAM_COPY_MACROVISION = record
        MACROVISIONLevel: ULONG;
    end;
    PAM_COPY_MACROVISION = ^TAM_COPY_MACROVISION;

    TAM_DVDCOPY_SET_COPY_STATE = record
        DVDCopyState: ULONG;
    end;
    PAM_DVDCOPY_SET_COPY_STATE = ^TAM_DVDCOPY_SET_COPY_STATE;

    TAM_DVDCOPYSTATE = (
        AM_DVDCOPYSTATE_INITIALIZE = 0,
        AM_DVDCOPYSTATE_INITIALIZE_TITLE = 1,   // indicates we are starting a title
        // key copy protection sequence
        AM_DVDCOPYSTATE_AUTHENTICATION_NOT_REQUIRED = 2,
        AM_DVDCOPYSTATE_AUTHENTICATION_REQUIRED = 3,
        AM_DVDCOPYSTATE_DONE = 4);


    TAM_COPY_MACROVISION_LEVEL = (
        AM_MACROVISION_DISABLED = 0,
        AM_MACROVISION_LEVEL1 = 1,
        AM_MACROVISION_LEVEL2 = 2,
        AM_MACROVISION_LEVEL3 = 3);
    PAM_COPY_MACROVISION_LEVEL = ^TAM_COPY_MACROVISION_LEVEL;


    // CSS region stucture
    TDVD_REGION = record
        CopySystem: UCHAR;
        RegionData: UCHAR;
        SystemRegion: UCHAR;
        ResetCount: UCHAR;
    end;
    PDVD_REGION = TDVD_REGION;



    // -----------------------------------------------------------------------
    // video format blocks
    // -----------------------------------------------------------------------

    TAM_MPEG2Level = (
        AM_MPEG2Level_Low = 1,
        AM_MPEG2Level_Main = 2,
        AM_MPEG2Level_High1440 = 3,
        AM_MPEG2Level_High = 4);

    TAM_MPEG2Profile = (
        AM_MPEG2Profile_Simple = 1,
        AM_MPEG2Profile_Main = 2,
        AM_MPEG2Profile_SNRScalable = 3,
        AM_MPEG2Profile_SpatiallyScalable = 4,
        AM_MPEG2Profile_High = 5);

    TVIDEOINFOHEADER2 = record
        rcSource: TRECT;
        rcTarget: TRECT;
        dwBitRate: DWORD;
        dwBitErrorRate: DWORD;
        AvgTimePerFrame: TREFERENCE_TIME;
        dwInterlaceFlags: DWORD;   // use AMINTERLACE_* defines. Reject connection if undefined bits are not 0
        dwCopyProtectFlags: DWORD; // use AMCOPYPROTECT_* defines. Reject connection if undefined bits are not 0
        dwPictAspectRatioX: DWORD; // X dimension of picture aspect ratio, e.g. 16 for 16x9 display
        dwPictAspectRatioY: DWORD; // Y dimension of picture aspect ratio, e.g.  9 for 16x9 display
        case integer of
            0: (dwControlFlags: DWORD;              // use AMCONTROL_* defines, use this from now on
                dwReserved2: DWORD;        // must be 0; reject connection otherwise
                bmiHeader: TBITMAPINFOHEADER);
            1: (dwReserved1: DWORD);                  // for backward compatiblity (was "must be 0";  connection rejected otherwise)


    end;
    PVIDEOINFOHEADER2 = ^TVIDEOINFOHEADER2;

    tagVIDEOINFOHEADER2 = TVIDEOINFOHEADER2;

    TMPEG2VIDEOINFO = record
        hdr: TVIDEOINFOHEADER2;
        dwStartTimeCode: DWORD;        //  ?? not used for DVD ??
        cbSequenceHeader: DWORD;       // is 0 for DVD (no sequence header)
        dwProfile: DWORD;              // use enum MPEG2Profile
        dwLevel: DWORD;                // use enum MPEG2Level
        dwFlags: DWORD;                // use AMMPEG2_* defines.  Reject connection if undefined bits are not 0
        dwSequenceHeader: PDWORD;    // DWORD instead of Byte for alignment purposes
        //   For MPEG-2, if a sequence_header is included, the sequence_extension
        //   should also be included
    end;
    PMPEG2VIDEOINFO = ^TMPEG2VIDEOINFO;
    tagMPEG2VIDEOINFO = TMPEG2VIDEOINFO;



    // -----------------------------------------------------------------------
    // AM_KSPROPSETID_DvdKaraoke property set definitions
    // -----------------------------------------------------------------------

    TAM_DvdKaraokeData = record
        dwDownmix: DWORD;              // bitwise OR of AM_DvdKaraoke_Downmix flags
        dwSpeakerAssignment: DWORD;    // AM_DvdKaraoke_SpeakerAssignment
    end;
    tagAM_DvdKaraokeData = TAM_DvdKaraokeData;

    TAM_PROPERTY_DVDKARAOKE = (
        AM_PROPERTY_DVDKARAOKE_ENABLE = 0,  // longbool
        AM_PROPERTY_DVDKARAOKE_DATA = 1);

    // -----------------------------------------------------------------------
    // AM_KSPROPSETID_TSRateChange property set definitions for time stamp
    // rate changes.
    // -----------------------------------------------------------------------

    TAM_PROPERTY_TS_RATE_CHANGE = (
        AM_RATE_SimpleRateChange = 1,    // rw, use AM_SimpleRateChange
        AM_RATE_ExactRateChange = 2,    // rw, use AM_ExactRateChange
        AM_RATE_MaxFullDataRate = 3,    // r,  use AM_MaxFullDataRate
        AM_RATE_Step = 4,    // w,  use AM_Step
        AM_RATE_UseRateVersion = 5,       //  w, use WORD
        AM_RATE_QueryFullFrameRate = 6,      //  r, use AM_QueryRate
        AM_RATE_QueryLastRateSegPTS = 7,     //  r, use REFERENCE_TIME
        AM_RATE_CorrectTS = 8,    // w,  use LONG
        AM_RATE_ReverseMaxFullDataRate = 9,    // r,  use AM_MaxFullDataRate
        AM_RATE_ResetOnTimeDisc = 10,    // rw, use DWORD - indicates supports new 'timeline reset on time discontinuity' sample
        AM_RATE_QueryMapping = 11);


    // -------------------------------------------------------------------
    // AM_KSPROPSETID_DVD_RateChange property set definitions for new DVD
    // rate change scheme.
    // -------------------------------------------------------------------

    TAM_PROPERTY_DVD_RATE_CHANGE = (
        AM_RATE_ChangeRate = 1,    // w,  use AM_DVD_ChangeRate
        AM_RATE_FullDataRateMax = 2,    // r,  use AM_MaxFullDataRate
        AM_RATE_ReverseDecode = 3,    // r,  use LONG
        AM_RATE_DecoderPosition = 4,    // r,  use AM_DVD_DecoderPosition
        AM_RATE_DecoderVersion = 5     // r,  use LONG
        );


    TAM_SimpleRateChange = record
        // this is the simplest mechanism to set a time stamp rate change on
        // a filter (simplest for the person setting the rate change, harder
        // for the filter doing the rate change).
        StartTime: TREFERENCE_TIME;  //stream time at which to start this rate
        Rate: LONG;       //new rate * 10000 (decimal)
    end;


    TAM_QueryRate = record
        lMaxForwardFullFrame: LONG;          //  rate * 10000
        lMaxReverseFullFrame: LONG;          //  rate * 10000
    end;

    TAM_ExactRateChange = record
        OutputZeroTime: TREFERENCE_TIME; //input TS that maps to zero output TS
        Rate: LONG;       //new rate * 10000 (decimal)
    end;

    TAM_MaxFullDataRate = LONG; //rate * 10000 (decimal)

    TAM_Step = DWORD; // number of frame to step

    // New rate change property set, structs. enums etc.
    TAM_DVD_ChangeRate = record
        StartInTime: TREFERENCE_TIME;   // stream time (input) at which to start decoding at this rate
        StartOutTime: TREFERENCE_TIME;  // reference time (output) at which to start showing at this rate
        Rate: LONG;          // new rate * 10000 (decimal)
    end;

    TAM_DVD_DecoderPosition = LONGLONG;

    TDVD_PLAY_DIRECTION = (
        DVD_DIR_FORWARD = 0,
        DVD_DIR_BACKWARD = 1);

implementation



function SIZE_MPEG2VIDEOINFO(pv: TMPEG2VIDEOINFO): dword;
begin
    Result := integer(@TMPEG2VIDEOINFO(nil^).dwSequenceHeader) + pv.cbSequenceHeader;
end;



// do not use

function MPEG1_SEQUENCE_INFO(pv: TMPEG1VIDEOINFO): PByte;
begin
    Result := pv.bSequenceHeader;
end;


// use this macro instead, the previous only works for MPEG1VIDEOINFO structures
function MPEG2_SEQUENCE_INFO(pv: TMPEG2VIDEOINFO): PByte;
begin
    Result := PBYTE(pv.dwSequenceHeader);
end;


end.
