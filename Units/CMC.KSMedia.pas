{ CMC.KSMedia and CMC.KS are not completed at the momenten, only as needed for CMC.MFAPI }
unit CMC.KSMedia;

interface

uses
    Windows, CMC.KS;
{$Z4}
{$A4}

const
    WAVE_FORMAT_EXTENSIBLE = $FFFE;

type
    TKSMULTIPLE_DATA_PROP = record
        _Property: TKSPROPERTY;
        MultipleItem: TKSMULTIPLE_ITEM;
    end;

    PKSMULTIPLE_DATA_PROP = ^TKSMULTIPLE_DATA_PROP;

    KSINTERFACE_MEDIA = (KSINTERFACE_MEDIA_MUSIC, // Reserved for system use
        KSINTERFACE_MEDIA_WAVE_BUFFERED, // Reserved for system use
        KSINTERFACE_MEDIA_WAVE_QUEUED);
{$Z1}
{$A1}
    // include <pshpack1.h>

    // Convenient wrapper structure for the case in which the WaveFormatEx is
    // known not to contain extra data.
    TKSDATAFORMAT_WAVEFORMATEX = packed record
        DataFormat: TKSDATAFORMAT;
        WAVEFORMATEX: TWAVEFORMATEX;
    end;

    PKSDATAFORMAT_WAVEFORMATEX = ^TKSDATAFORMAT_WAVEFORMATEX;

    TWAVEFORMATEXTENSIBLE = packed record
        Format: TWAVEFORMATEX;
        Samples: record case Integer of 0: (wValidBitsPerSample: WORD); (* bits of precision *)
        1: (wSamplesPerBlock: WORD); (* valid if wBitsPerSample==0 *)
        2: (wReserved: WORD) (* If neither applies, set to zero. *)
        end;

        dwChannelMask: DWORD; (* which channels are *)
        (* present in stream *)
        SubFormat: TGUID;
    end;

    PWAVEFORMATEXTENSIBLE = ^TWAVEFORMATEXTENSIBLE;

    TWAVEFORMATEXTENSIBLE_IEC61937 = packed record
        FormatExt: TWAVEFORMATEXTENSIBLE; (* Format of encoded data as it is *)
        (* intended to be streamed over the link *)
        dwEncodedSamplesPerSec: DWORD; (* Sampling rate of the post-decode audio. *)
        dwEncodedChannelCount: DWORD; (* Channel count of the post-decode audio. *)
        dwAverageBytesPerSec: DWORD; (* Byte rate of the content, can be 0. *)
    end;

    PWAVEFORMATEXTENSIBLE_IEC61937 = ^TWAVEFORMATEXTENSIBLE_IEC61937;

    // Convenient wrapper structure for the case in which the WaveFormatExt is
    // known not to contain extra data.
    TKSDATAFORMAT_WAVEFORMATEXTENSIBLE = packed record
        DataFormat: TKSDATAFORMAT;
        WaveFormatExt: TWAVEFORMATEXTENSIBLE;
    end;

    PKSDATAFORMAT_WAVEFORMATEXTENSIBLE = ^TKSDATAFORMAT_WAVEFORMATEXTENSIBLE;

    // DirectSound buffer description
    TKSDSOUND_BUFFERDESC = packed record
        Flags: ULONG;
        Control: ULONG;
        WAVEFORMATEX: TWAVEFORMATEX;
    end;

    PKSDSOUND_BUFFERDESC = ^TKSDSOUND_BUFFERDESC;

    // DirectSound format
    TKSDATAFORMAT_DSOUND = packed record
        DataFormat: TKSDATAFORMAT;
        BufferDesc: TKSDSOUND_BUFFERDESC;
    end;

    PKSDATAFORMAT_DSOUND = ^TKSDATAFORMAT_DSOUND;

    // include <poppack.h>
{$A4}
{$Z4}
    TREFERENCE_TIME = LONGLONG;

    TtagKS_BITMAPINFOHEADER = record
        biSize: DWORD;
        biWidth: LONGINT;
        biHeight: LONGINT;
        biPlanes: WORD;
        biBitCount: WORD;
        biCompression: DWORD;
        biSizeImage: DWORD;
        biXPelsPerMeter: LONGINT;
        biYPelsPerMeter: LONGINT;
        biClrUsed: DWORD;
        biClrImportant: DWORD;
    end;

    TKS_BITMAPINFOHEADER = ^TtagKS_BITMAPINFOHEADER;
    PKS_BITMAPINFOHEADER = ^TKS_BITMAPINFOHEADER;

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

    TtagKS_VIDEOINFOHEADER = record
        rcSource: TRECT; // The bit we really want to use
        rcTarget: TRECT; // Where the video should go
        dwBitRate: DWORD; // Approximate bit data rate
        dwBitErrorRate: DWORD; // Bit error rate for this stream
        AvgTimePerFrame: TREFERENCE_TIME; // Average time per frame (100ns units)
        bmiHeader: TKS_BITMAPINFOHEADER;
    end;

    TKS_VIDEOINFOHEADER = TtagKS_VIDEOINFOHEADER;
    PKS_VIDEOINFOHEADER = ^TKS_VIDEOINFOHEADER;

    TtagKS_VIDEOINFOHEADER2 = record
        rcSource: TRECT;
        rcTarget: TRECT;
        dwBitRate: DWORD;
        dwBitErrorRate: DWORD;
        AvgTimePerFrame: TREFERENCE_TIME;
        dwInterlaceFlags: DWORD; // use AMINTERLACE_* defines. Reject connection if undefined bits are not 0
        dwCopyProtectFlags: DWORD; // use KS_COPYPROTECT_* defines. Reject connection if undefined bits are not 0
        dwPictAspectRatioX: DWORD; // X dimension of picture aspect ratio, e.g. 16 for 16x9 display
        dwPictAspectRatioY: DWORD; // Y dimension of picture aspect ratio, e.g.  9 for 16x9 display
        case Integer of
            0:
                (dwControlFlags: DWORD; // use KS_AMCONTROL_* defines, use this from now on
                    dwReserved2: DWORD; // must be 0; reject connection otherwise
                    bmiHeader: TKS_BITMAPINFOHEADER);
            1:
                (dwReserved1: DWORD); // for backward compatiblity (was "must be 0";  connection rejected otherwise)

    end;

    TKS_VIDEOINFOHEADER2 = TtagKS_VIDEOINFOHEADER2;
    PKS_VIDEOINFOHEADER2 = ^TKS_VIDEOINFOHEADER2;

implementation

end.
