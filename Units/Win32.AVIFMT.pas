unit Win32.AVIFMT;

(****************************************************************************)
(*                                                                          *)
(*        AVIFMT.H - Include file for working with AVI files                *)
(*                                                                          *)
(*        Note: You must include WINDOWS.H and MMSYSTEM.H before            *)
(*        including this file.                                              *)
(*                                                                          *)
(*        Copyright (c) 1991-1998, Microsoft Corp.  All rights reserved.    *)
(*                                                                          *)
(*                                                                          *)
(****************************************************************************)

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils;

const
    _INC_AVIFMT = 100;    (* version number * 100 + revision *)

    formtypeAVI =
        Ord('A') or (Ord('V') shl 8) or (Ord('I') shl 16) or (Ord(' ') shl 24);
    formtypeAVIX = Ord('A') or (Ord('V') shl 8) or
        (Ord('I') shl 16) or (Ord('X') shl 24);
    listtypeAVIHEADER = Ord('h') or (Ord('d') shl 8) or
        (Ord('r') shl 16) or (Ord('l') shl 24);
    ckidAVIMAINHDR = Ord('a') or (Ord('v') shl 8) or
        (Ord('i') shl 16) or (Ord('h') shl 24);
    listtypeSTREAMHEADER =
        Ord('s') or (Ord('t') shl 8) or (Ord('r') shl 16) or (Ord('l') shl 24);
    ckidSTREAMHEADER = Ord('s') or (Ord('t') shl 8) or
        (Ord('r') shl 16) or (Ord('h') shl 24);
    ckidSTREAMFORMAT = Ord('s') or (Ord('t') shl 8) or
        (Ord('r') shl 16) or (Ord('f') shl 24);
    ckidSTREAMHANDLERDATA =
        Ord('s') or (Ord('t') shl 8) or (Ord('r') shl 16) or (Ord('d') shl 24);
    ckidSTREAMNAME = Ord('s') or (Ord('t') shl 8) or
        (Ord('r') shl 16) or (Ord('n') shl 24);

    listtypeAVIMOVIE = Ord('m') or (Ord('o') shl 8) or
        (Ord('v') shl 16) or (Ord('i') shl 24);
    listtypeAVIRECORD = Ord('r') or (Ord('e') shl 8) or
        (Ord('c') shl 16) or (Ord(' ') shl 24);

    ckidAVINEWINDEX = Ord('i') or (Ord('d') shl 8) or
        (Ord('x') shl 16) or (Ord('1') shl 24);

    (* Stream types for the <fccType> field of the stream header. *)
    streamtypeVIDEO = Ord('v') or (Ord('i') shl 8) or
        (Ord('d') shl 16) or (Ord('s') shl 24);
    streamtypeAUDIO = Ord('a') or (Ord('u') shl 8) or
        (Ord('d') shl 16) or (Ord('s') shl 24);
    streamtypeMIDI = Ord('m') or (Ord('i') shl 8) or
        (Ord('d') shl 16) or (Ord('s') shl 24);
    streamtypeTEXT = Ord('t') or (Ord('x') shl 8) or
        (Ord('t') shl 16) or (Ord('s') shl 24);



    (* Basic chunk types *)
    cktypeDIBbits = Ord('d') or (Ord('b') shl 8);
    cktypeDIBcompressed = Ord('d') or (Ord('c') shl 8);
    cktypePALchange = Ord('p') or (Ord('c') shl 8);
    cktypeWAVEbytes = Ord('w') or (Ord('b') shl 8);
    cktypeDVFrame = Ord('_') or (Ord('_') shl 8);

    (* Chunk id to use for extra chunks for padding. *)
    ckidAVIPADDING = Ord('J') or (Ord('U') shl 8) or
        (Ord('N') shl 16) or (Ord('K') shl 24);

    (* flags for use in <dwFlags> in AVIFileHdr *)
    AVIF_HASINDEX = $00000010;    // Index at end of file
    AVIF_MUSTUSEINDEX = $00000020;
    AVIF_ISINTERLEAVED = $00000100;
    AVIF_TRUSTCKTYPE = $00000800;    // Use CKType to find key frames
    AVIF_WASCAPTUREFILE = $00010000;
    AVIF_COPYRIGHTED = $00020000;

    (* The AVI File Header LIST chunk should be padded to this size *)
    AVI_HEADERSIZE = 2048;                    // size of AVI header list

    AVISF_DISABLED = $00000001;

    AVISF_VIDEO_PALCHANGES = $00010000;

    (* Flags for index *)
    AVIIF_LIST = $00000001; // chunk is a 'LIST'
    AVIIF_KEYFRAME = $00000010; // this frame is a key frame.
    AVIIF_FIRSTPART = $00000020; // this frame is the start of a partial frame.
    AVIIF_LASTPART = $00000040; // this frame is the end of a partial frame.
    AVIIF_MIDPART = (AVIIF_LASTPART or AVIIF_FIRSTPART);

    AVIIF_NOTIME = $00000100; // this frame doesn't take any time
    AVIIF_COMPUSE = $0FFF0000; // these bits are for compressor use

type

(* The following is a short description of the AVI file format.  Please
 * see the accompanying documentation for a full explanation.
 *
 * An AVI file is the following RIFF form:
 *
 *    RIFF('AVI'
 *          LIST('hdrl'
 *            avih(<MainAVIHeader>)
 *                  LIST ('strl'
 *                      strh(<Stream header>)
 *                      strf(<Stream format>)
 *                      ... additional header data
 *            LIST('movi'
 *            { LIST('rec'
 *                    SubChunk...
 *                 )
 *                | SubChunk } ....
 *            )
 *            [ <AVIIndex> ]
 *      )
 *
 *    The main file header specifies how many streams are present.  For
 *    each one, there must be a stream header chunk and a stream format
 *    chunk, enlosed in a 'strl' LIST chunk.  The 'strf' chunk contains
 *    type-specific format information; for a video stream, this should
 *    be a BITMAPINFO structure, including palette.  For an audio stream,
 *    this should be a WAVEFORMAT (or PCMWAVEFORMAT) structure.
 *
 *    The actual data is contained in subchunks within the 'movi' LIST
 *    chunk.  The first two characters of each data chunk are the
 *    stream number with which that data is associated.
 *
 *    Some defined chunk types:
 *           Video Streams:
 *                  ##db:    RGB DIB bits
 *                  ##dc:    RLE8 compressed DIB bits
 *                  ##pc:    Palette Change
 *
 *           Audio Streams:
 *                  ##wb:    waveform audio bytes
 *
 * The grouping into LIST 'rec' chunks implies only that the contents of
 *   the chunk should be read into memory at the same time.  This
 *   grouping is used for files specifically intended to be played from
 *   CD-ROM.
 *
 * The index chunk at the end of the file should contain one entry for
 *   each data chunk in the file.
 *
 * Limitations for the current software:
 *    Only one video stream and one audio stream are allowed.
 *    The streams must start at the beginning of the file.
 *
 *
 * To register codec types please obtain a copy of the Multimedia
 * Developer Registration Kit from:
 *
 *  Microsoft Corporation
 *  Multimedia Systems Group
 *  Product Marketing
 *  One Microsoft Way
 *  Redmond, WA 98052-6399
 *
 *)


    TWOCC = word;


    (* Main AVI File Header *)
    TMainAVIHeader = record
        dwMicroSecPerFrame: DWORD;    // frame display rate (or 0L)
        dwMaxBytesPerSec: DWORD;    // max. transfer rate
        dwPaddingGranularity: DWORD;    // pad to multiples of this
        // size; normally 2K.
        dwFlags: DWORD;        // the ever-present flags
        dwTotalFrames: DWORD;        // # frames in file
        dwInitialFrames: DWORD;
        dwStreams: DWORD;
        dwSuggestedBufferSize: DWORD;

        dwWidth: DWORD;
        dwHeight: DWORD;

        dwReserved: array[0..3] of DWORD;
    end;

    TFOURCC = DWORD;         (* a four character code *)

    (* Stream header *)

    TAVIStreamHeader = record
        fccType: TFOURCC;
        fccHandler: TFOURCC;
        dwFlags: DWORD;    (* Contains AVITF_* flags *)
        wPriority: word;
        wLanguage: word;
        dwInitialFrames: DWORD;
        dwScale: DWORD;
        dwRate: DWORD;    (* dwRate / dwScale == samples/second *)
        dwStart: DWORD;
        dwLength: DWORD; (* In units above... *)
        dwSuggestedBufferSize: DWORD;
        dwQuality: DWORD;
        dwSampleSize: DWORD;
        rcFrame: TRECT;
    end;



    TAVIINDEXENTRY = record
        ckid: DWORD;
        dwFlags: DWORD;
        dwChunkOffset: DWORD;        // Position of chunk
        dwChunkLength: DWORD;        // Length of chunk
    end;

    (*  Palette change chunk  Used in video streams. *)
    TAVIPALCHANGE = record
        bFirstEntry: byte;    (* first entry to change *)
        bNumEntries: byte;    (* # entries to change (0 if 256) *)
        wFlags: word;        (* Mostly to preserve alignment... *)
        peNew: PPALETTEENTRY;    (* New color specifications *)
    end;


implementation



function mmioFOURCC(ch0, ch1, ch2, ch3: byte): DWord;
begin
    Result := (ch0) or (ch1 shl 8) or (ch2 shl 16) or (ch3 shl 24);
end;

(* Macro to make a TWOCC out of two characters *)

function aviTWOCC(ch0, ch1: byte): word;
begin
    Result := (ch0) or (ch1 shl 8);
end;




(*
** Useful macros
**
** Warning: These are nasty macro, and MS C 6.0 compiles some of them
** incorrectly if optimizations are on.  Ack.
*)

(* Macro to get stream number out of a FOURCC ckid *)
function FromHex(n: byte): byte;
begin
    // #define FromHex(n)    (((n) >= 'A') ? ((n) + 10 - 'A') : ((n) - '0'))
    if (n >= Ord('A')) then
        Result := (n + 10 - Ord('A'))
    else
        Result := (n - Ord('0'));
end;



function StreamFromFOURCC(fcc: TFOURCC): byte;
begin
    // #define StreamFromFOURCC(fcc) ((WORD) ((FromHex(LOBYTE(LOWORD(fcc))) << 4) + (FromHex(HIBYTE(LOWORD(fcc))))))
    Result := FromHex(LOBYTE(LOWORD(fcc))) shl 4 +
        FromHex(HIBYTE(LOWORD(fcc)));
end;

(* Macro to get TWOCC chunk type out of a FOURCC ckid *)

function TWOCCFromFOURCC(fcc: TFOURCC): TWOCC;
begin
    Result := HIWORD(fcc);
end;

(* Macro to make a ckid for a chunk out of a TWOCC and a stream number from 0-255. *)

function ToHex(n: byte): byte;
begin
    // #define ToHex(n)    ((BYTE) (((n) > 9) ? ((n) - 10 + 'A') : ((n) + '0')))
    if (n > 9) then
        Result := (n - 10 + Ord('A'))
    else
        Result := (n + Ord('0'));
end;



function MAKEAVICKID(tcc, stream: byte): long;
begin
    Result := MAKELONG((ToHex(stream and $0f) shl 8) or
        (ToHex(stream and $f0) shr 4), tcc);
end;

end.
