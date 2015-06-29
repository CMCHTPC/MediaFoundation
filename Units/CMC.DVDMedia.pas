unit CMC.DVDMedia;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    CMC.AMVideo;

type
    TtagVIDEOINFOHEADER2 = record
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
            0: (dwControlFlags: DWORD;
                dwReserved2: DWORD;                          // must be 0; reject connection otherwise
                bmiHeader: TBITMAPINFOHEADER;);               // use AMCONTROL_* defines, use this from now on
            1: (dwReserved1: DWORD);                  // for backward compatiblity (was "must be 0";  connection rejected otherwise)



    end;

  TVIDEOINFOHEADER2 = TtagVIDEOINFOHEADER2;

  PVIDEOINFOHEADER2 = ^TVIDEOINFOHEADER2;


TtagMPEG2VIDEOINFO = record
        hdr:TVIDEOINFOHEADER2;
                   dwStartTimeCode:DWORD;        //  ?? not used for DVD ??
                   cbSequenceHeader:DWORD;       // is 0 for DVD (no sequence header)
                   dwProfile:DWORD;              // use enum MPEG2Profile
                   dwLevel:DWORD;                // use enum MPEG2Level
                   dwFlags:DWORD;                // use AMMPEG2_* defines.  Reject connection if undefined bits are not 0
                   dwSequenceHeader:PDWORD;    // DWORD instead of Byte for alignment purposes
                                                //   For MPEG-2, if a sequence_header is included, the sequence_extension
                                                //   should also be included
end;
TMPEG2VIDEOINFO = TtagMPEG2VIDEOINFO;

PMPEG2VIDEOINFO = ^TMPEG2VIDEOINFO;


implementation

end.
