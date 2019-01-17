unit Win32.AMAudio;
//------------------------------------------------------------------------------
// File: AMAudio.h

// Desc: Audio related definitions and interfaces for ActiveMovie.

// Copyright (c) 1992 - 2001, Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------------------------

{$mode delphi}

interface

uses
    Windows, Classes, SysUtils,
    Win32.DSound;

type
    // This is the interface the audio renderer supports to give the application
    // access to the direct sound object and buffers it is using, to allow the
    // application to use things like the 3D features of Direct Sound for the
    // soundtrack of a movie being played with Active Movie

    IAMDirectSound = interface(IUnknown)
        ['{546F4260-D53E-11cf-B3F0-00AA003761C5}']
        (* IAMDirectSound methods *)
        function GetDirectSoundInterface(out lplpds: PDIRECTSOUND): HResult; stdcall;
        function GetPrimaryBufferInterface(out lplpdsb: PDIRECTSOUNDBUFFER): HResult; stdcall;
        function GetSecondaryBufferInterface(out lplpdsb: PDIRECTSOUNDBUFFER): HResult; stdcall;
        function ReleaseDirectSoundInterface(lpds: PDIRECTSOUND): HResult; stdcall;
        function ReleasePrimaryBufferInterface(lpdsb: PDIRECTSOUNDBUFFER): HResult; stdcall;
        function ReleaseSecondaryBufferInterface(lpdsb: PDIRECTSOUNDBUFFER): HResult; stdcall;
        function SetFocusWindow(hwnd: HWND; bMixingOnOrOff: BOOL): HResult; stdcall;
        function GetFocusWindow(out hwnd: HWND; out bMixingOnOrOff: BOOL): HResult; stdcall;
    end;

    //  Validate WAVEFORMATEX block of length cb
function AMValidateAndFixWaveFormatEx(var  pwfx:TWAVEFORMATEX;  cb:DWORD):HRESULT;

implementation


//  Validate WAVEFORMATEX block of length cb
function AMValidateAndFixWaveFormatEx(var  pwfx:TWAVEFORMATEX;  cb:DWORD):HRESULT; inline;
begin
    (* ToDo
    if (cb < sizeof(TPCMWAVEFORMAT)) then begin
        result:= E_INVALIDARG;
		Exit;
    end;
    if (pwfx.wFormatTag <> WAVE_FORMAT_PCM) then begin
        if (cb < sizeof(TWAVEFORMATEX)) then begin
            result:= E_INVALIDARG;
			Exit;
        end;
        if (cb < sizeof(TWAVEFORMATEX) + pwfx.cbSize )then begin
            pwfx.cbSize = 0;
        end;
    end;

    // Sanity check
    if (pwfx.nAvgBytesPerSec > 10000000) or (pwfx.nAvgBytesPerSec = 0) then begin
        pwfx.nAvgBytesPerSec := 176400;
    end;

    if (pwfx.nChannels > 32) then begin
        pwfx.nChannels := 1;
    end;

    *)
    result:= S_OK;
end;

end.

