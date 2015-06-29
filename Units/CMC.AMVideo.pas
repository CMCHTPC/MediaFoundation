unit CMC.AMVideo;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}


interface

uses
    Windows, Classes, SysUtils;

type

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

    TtagVIDEOINFOHEADER = record

        rcSource: TRECT;          // The bit we really want to use
        rcTarget: TRECT;          // Where the video should go
        dwBitRate: DWORD;         // Approximate bit data rate
        dwBitErrorRate: DWORD;    // Bit error rate for this stream
        AvgTimePerFrame: TREFERENCE_TIME;   // Average time per frame (100ns units)

        bmiHeader: TBITMAPINFOHEADER;

    end;

   TVIDEOINFOHEADER = TtagVIDEOINFOHEADER;

   PVIDEOINFOHEADER = ^TVIDEOINFOHEADER;


// MPEG variant - includes a DWORD length followed by the
// video sequence header after the video header.
//
// The sequence header includes the sequence header start code and the
// quantization matrices associated with the first sequence header in the
// stream so is a maximum of 140 bytes long.

TtagMPEG1VIDEOINFO   = record

     hdr:TVIDEOINFOHEADER;                    // Compatible with VIDEOINFO
               dwStartTimeCode:DWORD;        // 25-bit Group of pictures time code
                                            // at start of data
               cbSequenceHeader:DWORD;       // Length in bytes of bSequenceHeader
                bSequenceHeader:PBYTE;     // Sequence header including
                                            // quantization matrices if any
end;
TMPEG1VIDEOINFO = TtagMPEG1VIDEOINFO;

PMPEG1VIDEOINFO = ^TMPEG1VIDEOINFO;


implementation

end.


