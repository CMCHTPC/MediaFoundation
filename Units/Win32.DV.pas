unit Win32.DV;
//------------------------------------------------------------------------------
// File: DV.h

// Desc: DV typedefs and defines.

// Copyright (c) 1997 - 2001, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------

// Updated to SDK 10.0.17763.0
// (c) Translation to Pascal by Norbert Sonnleitner


{$mode delphi}

interface

uses
    Classes, SysUtils;

const
    DV_DVSD_NTSC_FRAMESIZE = 120000;
    DV_DVSD_PAL_FRAMESIZE = 144000;

    DV_SMCHN = $0000e000;
    DV_AUDIOMODE = $00000f00;
    DV_AUDIOSMP = $38000000;

    DV_AUDIOQU = $07000000;
    DV_NTSCPAL = $00200000;
    DV_STYPE = $001f0000;


    //There are NTSC or PAL DV camcorders
    DV_NTSC = 0;
    DV_PAL = 1;
    //DV camcorder can output sd/hd/sl
    DV_SD = $00;
    DV_HD = $01;
    DV_SL = $02;
    //user can choice 12 bits or 16 bits audio from DV camcorder
    DV_CAP_AUD16Bits = $00;
    DV_CAP_AUD12Bits = $01;

    SIZE_DVINFO = $20;

type
    TDVAudInfo = record
        bAudStyle: array [0..1] of byte;
        //LSB 6 bits for starting DIF sequence number
        //MSB 2 bits: 0 for mon. 1: stereo in one 5/6 DIF sequences, 2: stereo audio in both 5/6 DIF sequences
        //example: $00: mon, audio in first 5/6 DIF sequence
        //                 $05: mon, audio in 2nd 5 DIF sequence
        //                 $15: stereo, audio only in 2nd 5 DIF sequence
        //                 $10: stereo, audio only in 1st 5/6 DIF sequence
        //                 $20: stereo, left ch in 1st 5/6 DIF sequence, right ch in 2nd 5/6 DIF sequence
        //                 $26: stereo, rightch in 1st 6 DIF sequence, left ch in 2nd 6 DIF sequence
        bAudQu: array[0..1] of byte;
        //qbits, only support 12, 16,

        bNumAudPin: byte;                     //how many pin(language)
        wAvgSamplesPerPinPerFrm: array [0..1] of word;
        //samples size for one audio pin in one frame(which has 10 or 12 DIF sequence)
        wBlkMode: word;                       //45 for NTSC, 54 for PAL
        wDIFMode: word;                       //5  for NTSC, 6 for PAL
        wBlkDiv: word;                        //15  for NTSC, 18 for PAL
    end;
    PDVAudInfo = ^TDVAudInfo;

implementation

end.
