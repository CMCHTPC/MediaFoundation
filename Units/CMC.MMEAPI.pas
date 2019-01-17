(********************************************************************************
*                                                                               *
* mmeapi.h -- ApiSet Contract for api-ms-win-mm-mme-l1-1-0                      *
*                                                                               *
* Copyright (c) Microsoft Corporation. All rights reserved.                     *
*                                                                               *
********************************************************************************)
unit CMC.MMEAPI;

interface

{$IFDEF FPC}
{$MODE delphi}
{$ENDIF}

uses
    Windows, Classes,
    Win32.MMSysCom;

const
    winmm_dll = 'WinMM.dll';

const
    { ***************************************************************************

      Waveform audio support

      *************************************************************************** }

    { waveform audio error return values }
    WAVERR_BADFORMAT = (WAVERR_BASE + 0); { unsupported wave format }
    WAVERR_STILLPLAYING = (WAVERR_BASE + 1); { still something playing }
    WAVERR_UNPREPARED = (WAVERR_BASE + 2); { header not prepared }
    WAVERR_SYNC = (WAVERR_BASE + 3); { device is synchronous }
    WAVERR_LASTERROR = (WAVERR_BASE + 3); { last error in range }

    (* device ID for wave device mapper *)
    WAVE_MAPPER = UINT(-1);

    (* flags for dwFlags parameter in waveOutOpen() and waveInOpen() *)
    WAVE_FORMAT_QUERY = $0001;
    WAVE_ALLOWSYNC = $0002;

    WAVE_MAPPED = $0004;
    WAVE_FORMAT_DIRECT = $0008;
    WAVE_FORMAT_DIRECT_QUERY = (WAVE_FORMAT_QUERY or WAVE_FORMAT_DIRECT);
    WAVE_MAPPED_DEFAULT_COMMUNICATION_DEVICE = $0010;

    (* flags for dwFlags field of WAVEHDR *)
    WHDR_DONE = $00000001;  (* done bit *)
    WHDR_PREPARED = $00000002;  (* set if this header has been prepared *)
    WHDR_BEGINLOOP = $00000004; (* loop start block *)
    WHDR_ENDLOOP = $00000008; (* loop end block *)
    WHDR_INQUEUE = $00000010; (* reserved for driver *)

    (* flags for dwSupport field of WAVEOUTCAPS *)
    WAVECAPS_PITCH = $0001;   (* supports pitch control *)
    WAVECAPS_PLAYBACKRATE = $0002;   (* supports playback rate control *)
    WAVECAPS_VOLUME = $0004;   (* supports volume control *)
    WAVECAPS_LRVOLUME = $0008;   (* separate left-right volume control *)
    WAVECAPS_SYNC = $0010;
    WAVECAPS_SAMPLEACCURATE = $0020;


    (* defines for dwFormat field of WAVEINCAPS and WAVEOUTCAPS *)
    WAVE_INVALIDFORMAT = $00000000;      (* invalid format *)
    WAVE_FORMAT_1M08 = $00000001;      (* 11.025 kHz, Mono,   8-bit  *)
    WAVE_FORMAT_1S08 = $00000002;      (* 11.025 kHz, Stereo, 8-bit  *)
    WAVE_FORMAT_1M16 = $00000004;      (* 11.025 kHz, Mono,   16-bit *)
    WAVE_FORMAT_1S16 = $00000008;      (* 11.025 kHz, Stereo, 16-bit *)
    WAVE_FORMAT_2M08 = $00000010;      (* 22.05  kHz, Mono,   8-bit  *)
    WAVE_FORMAT_2S08 = $00000020;      (* 22.05  kHz, Stereo, 8-bit  *)
    WAVE_FORMAT_2M16 = $00000040;      (* 22.05  kHz, Mono,   16-bit *)
    WAVE_FORMAT_2S16 = $00000080;      (* 22.05  kHz, Stereo, 16-bit *)
    WAVE_FORMAT_4M08 = $00000100;      (* 44.1   kHz, Mono,   8-bit  *)
    WAVE_FORMAT_4S08 = $00000200;      (* 44.1   kHz, Stereo, 8-bit  *)
    WAVE_FORMAT_4M16 = $00000400;      (* 44.1   kHz, Mono,   16-bit *)
    WAVE_FORMAT_4S16 = $00000800;      (* 44.1   kHz, Stereo, 16-bit *)

    WAVE_FORMAT_44M08 = $00000100;     (* 44.1   kHz, Mono,   8-bit  *)
    WAVE_FORMAT_44S08 = $00000200;      (* 44.1   kHz, Stereo, 8-bit  *)
    WAVE_FORMAT_44M16 = $00000400;     (* 44.1   kHz, Mono,   16-bit *)
    WAVE_FORMAT_44S16 = $00000800;     (* 44.1   kHz, Stereo, 16-bit *)
    WAVE_FORMAT_48M08 = $00001000;     (* 48     kHz, Mono,   8-bit  *)
    WAVE_FORMAT_48S08 = $00002000;     (* 48     kHz, Stereo, 8-bit  *)
    WAVE_FORMAT_48M16 = $00004000;     (* 48     kHz, Mono,   16-bit *)
    WAVE_FORMAT_48S16 = $00008000;     (* 48     kHz, Stereo, 16-bit *)
    WAVE_FORMAT_96M08 = $00010000;     (* 96     kHz, Mono,   8-bit  *)
    WAVE_FORMAT_96S08 = $00020000;     (* 96     kHz, Stereo, 8-bit  *)
    WAVE_FORMAT_96M16 = $00040000;     (* 96     kHz, Mono,   16-bit *)
    WAVE_FORMAT_96S16 = $00080000;     (* 96     kHz, Stereo, 16-bit *)


    // xxx
    { MIXERCONTROL.fdwControl }
    MIXERCONTROL_CONTROLF_UNIFORM = $00000001;
    MIXERCONTROL_CONTROLF_MULTIPLE = $00000002;
    MIXERCONTROL_CONTROLF_DISABLED = $80000000;


    { MIXERCONTROL_CONTROLTYPE_xxx building block defines }
    MIXERCONTROL_CT_CLASS_MASK = $F0000000;
    MIXERCONTROL_CT_CLASS_CUSTOM = $00000000;
    MIXERCONTROL_CT_CLASS_METER = $10000000;
    MIXERCONTROL_CT_CLASS_SWITCH = $20000000;
    MIXERCONTROL_CT_CLASS_NUMBER = $30000000;
    MIXERCONTROL_CT_CLASS_SLIDER = $40000000;
    MIXERCONTROL_CT_CLASS_FADER = $50000000;
    MIXERCONTROL_CT_CLASS_TIME = $60000000;
    MIXERCONTROL_CT_CLASS_LIST = $70000000;

    MIXERCONTROL_CT_SUBCLASS_MASK = $0F000000;

    MIXERCONTROL_CT_SC_SWITCH_BOOLEAN = $00000000;
    MIXERCONTROL_CT_SC_SWITCH_BUTTON = $01000000;

    MIXERCONTROL_CT_SC_METER_POLLED = $00000000;

    MIXERCONTROL_CT_SC_TIME_MICROSECS = $00000000;
    MIXERCONTROL_CT_SC_TIME_MILLISECS = $01000000;

    MIXERCONTROL_CT_SC_LIST_SINGLE = $00000000;
    MIXERCONTROL_CT_SC_LIST_MULTIPLE = $01000000;

    MIXERCONTROL_CT_UNITS_MASK = $00FF0000;
    MIXERCONTROL_CT_UNITS_CUSTOM = $00000000;
    MIXERCONTROL_CT_UNITS_BOOLEAN = $00010000;
    MIXERCONTROL_CT_UNITS_SIGNED = $00020000;
    MIXERCONTROL_CT_UNITS_UNSIGNED = $00030000;
    MIXERCONTROL_CT_UNITS_DECIBELS = $00040000; { in 10ths }
    MIXERCONTROL_CT_UNITS_PERCENT = $00050000; { in 10ths }


    { Commonly used control types for specifying MIXERCONTROL.dwControlType }
    MIXERCONTROL_CONTROLTYPE_CUSTOM = (MIXERCONTROL_CT_CLASS_CUSTOM or MIXERCONTROL_CT_UNITS_CUSTOM);
    MIXERCONTROL_CONTROLTYPE_BOOLEANMETER =
        (MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED or MIXERCONTROL_CT_UNITS_BOOLEAN);
    MIXERCONTROL_CONTROLTYPE_SIGNEDMETER =
        (MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED or MIXERCONTROL_CT_UNITS_SIGNED);
    MIXERCONTROL_CONTROLTYPE_PEAKMETER = (MIXERCONTROL_CONTROLTYPE_SIGNEDMETER + 1);
    MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER =
        (MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED or MIXERCONTROL_CT_UNITS_UNSIGNED);
    MIXERCONTROL_CONTROLTYPE_BOOLEAN =
        (MIXERCONTROL_CT_CLASS_SWITCH or MIXERCONTROL_CT_SC_SWITCH_BOOLEAN or MIXERCONTROL_CT_UNITS_BOOLEAN);
    MIXERCONTROL_CONTROLTYPE_ONOFF = (MIXERCONTROL_CONTROLTYPE_BOOLEAN + 1);
    MIXERCONTROL_CONTROLTYPE_MUTE = (MIXERCONTROL_CONTROLTYPE_BOOLEAN + 2);
    MIXERCONTROL_CONTROLTYPE_MONO = (MIXERCONTROL_CONTROLTYPE_BOOLEAN + 3);
    MIXERCONTROL_CONTROLTYPE_LOUDNESS = (MIXERCONTROL_CONTROLTYPE_BOOLEAN + 4);
    MIXERCONTROL_CONTROLTYPE_STEREOENH = (MIXERCONTROL_CONTROLTYPE_BOOLEAN + 5);
    MIXERCONTROL_CONTROLTYPE_BASS_BOOST = (MIXERCONTROL_CONTROLTYPE_BOOLEAN + $00002277);
    MIXERCONTROL_CONTROLTYPE_BUTTON = (MIXERCONTROL_CT_CLASS_SWITCH or MIXERCONTROL_CT_SC_SWITCH_BUTTON or
        MIXERCONTROL_CT_UNITS_BOOLEAN);
    MIXERCONTROL_CONTROLTYPE_DECIBELS = (MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_DECIBELS);
    MIXERCONTROL_CONTROLTYPE_SIGNED = (MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_SIGNED);
    MIXERCONTROL_CONTROLTYPE_UNSIGNED = (MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_UNSIGNED);
    MIXERCONTROL_CONTROLTYPE_PERCENT = (MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_PERCENT);
    MIXERCONTROL_CONTROLTYPE_SLIDER = (MIXERCONTROL_CT_CLASS_SLIDER or MIXERCONTROL_CT_UNITS_SIGNED);
    MIXERCONTROL_CONTROLTYPE_PAN = (MIXERCONTROL_CONTROLTYPE_SLIDER + 1);
    MIXERCONTROL_CONTROLTYPE_QSOUNDPAN = (MIXERCONTROL_CONTROLTYPE_SLIDER + 2);
    MIXERCONTROL_CONTROLTYPE_FADER = (MIXERCONTROL_CT_CLASS_FADER or MIXERCONTROL_CT_UNITS_UNSIGNED);
    MIXERCONTROL_CONTROLTYPE_VOLUME = (MIXERCONTROL_CONTROLTYPE_FADER + 1);
    MIXERCONTROL_CONTROLTYPE_BASS = (MIXERCONTROL_CONTROLTYPE_FADER + 2);
    MIXERCONTROL_CONTROLTYPE_TREBLE = (MIXERCONTROL_CONTROLTYPE_FADER + 3);
    MIXERCONTROL_CONTROLTYPE_EQUALIZER = (MIXERCONTROL_CONTROLTYPE_FADER + 4);
    MIXERCONTROL_CONTROLTYPE_SINGLESELECT =
        (MIXERCONTROL_CT_CLASS_LIST or MIXERCONTROL_CT_SC_LIST_SINGLE or MIXERCONTROL_CT_UNITS_BOOLEAN);
    MIXERCONTROL_CONTROLTYPE_MUX = (MIXERCONTROL_CONTROLTYPE_SINGLESELECT + 1);
    MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT =
        (MIXERCONTROL_CT_CLASS_LIST or MIXERCONTROL_CT_SC_LIST_MULTIPLE or MIXERCONTROL_CT_UNITS_BOOLEAN);
    MIXERCONTROL_CONTROLTYPE_MIXER = (MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT + 1);
    MIXERCONTROL_CONTROLTYPE_MICROTIME =
        (MIXERCONTROL_CT_CLASS_TIME or MIXERCONTROL_CT_SC_TIME_MICROSECS or MIXERCONTROL_CT_UNITS_UNSIGNED);
    MIXERCONTROL_CONTROLTYPE_MILLITIME =
        (MIXERCONTROL_CT_CLASS_TIME or MIXERCONTROL_CT_SC_TIME_MILLISECS or MIXERCONTROL_CT_UNITS_UNSIGNED);


    MIXER_GETLINECONTROLSF_ALL = $00000000;
    MIXER_GETLINECONTROLSF_ONEBYID = $00000001;
    MIXER_GETLINECONTROLSF_ONEBYTYPE = $00000002;

    MIXER_GETLINECONTROLSF_QUERYMASK = $0000000F;


    MIXER_GETCONTROLDETAILSF_VALUE = $00000000;
    MIXER_GETCONTROLDETAILSF_LISTTEXT = $00000001;

    MIXER_GETCONTROLDETAILSF_QUERYMASK = $0000000F;

    MIXER_SETCONTROLDETAILSF_VALUE = $00000000;
    MIXER_SETCONTROLDETAILSF_CUSTOM = $00000001;

    MIXER_SETCONTROLDETAILSF_QUERYMASK = $0000000F;

    (****************************************************************************

                            MIDI audio support

****************************************************************************)

    (* MIDI error return values *)
    MIDIERR_UNPREPARED = (MIDIERR_BASE + 0);   (* header not prepared *)
    MIDIERR_STILLPLAYING = (MIDIERR_BASE + 1);   (* still something playing *)
    MIDIERR_NOMAP = (MIDIERR_BASE + 2);   (* no configured instruments *)
    MIDIERR_NOTREADY = (MIDIERR_BASE + 3);   (* hardware is still busy *)
    MIDIERR_NODEVICE = (MIDIERR_BASE + 4);   (* port no longer connected *)
    MIDIERR_INVALIDSETUP = (MIDIERR_BASE + 5);   (* invalid MIF *)
    MIDIERR_BADOPENMODE = (MIDIERR_BASE + 6);   (* operation unsupported w/ open mode *)
    MIDIERR_DONT_CONTINUE = (MIDIERR_BASE + 7);   (* thru device 'eating' a message *)
    MIDIERR_LASTERROR = (MIDIERR_BASE + 7);   (* last error in range *)

    MIDIPATCHSIZE = 128;


    (* device ID for MIDI mapper *)
    MIDIMAPPER = UINT(-1);
    MIDI_MAPPER = UINT(-1);

    //{$IF  (WINVER >= $0400)}
    (* flags for dwFlags parm of midiInOpen() *)
    MIDI_IO_STATUS = $00000020;
    //{$ENDIF} (* WINVER >= $0400 *)

    (* flags for wFlags parm of midiOutCachePatches(), midiOutCacheDrumPatches() *)
    MIDI_CACHE_ALL = 1;
    MIDI_CACHE_BESTFIT = 2;
    MIDI_CACHE_QUERY = 3;
    MIDI_UNCACHE = 4;

    (* flags for wTechnology field of MIDIOUTCAPS structure *)
    MOD_MIDIPORT = 1;  (* output port *)
    MOD_SYNTH = 2;  (* generic internal synth *)
    MOD_SQSYNTH = 3;  (* square wave internal synth *)
    MOD_FMSYNTH = 4;  (* FM internal synth *)
    MOD_MAPPER = 5;  (* MIDI mapper *)
    MOD_WAVETABLE = 6;  (* hardware wavetable synth *)
    MOD_SWSYNTH = 7;  (* software synth *)

    (* flags for dwSupport field of MIDIOUTCAPS structure *)
    MIDICAPS_VOLUME = $0001;  (* supports volume control *)
    MIDICAPS_LRVOLUME = $0002;  (* separate left-right volume control *)
    MIDICAPS_CACHE = $0004;
    //{$IF  (WINVER >= $0400)}
    MIDICAPS_STREAM = $0008;  (* driver supports midiStreamOut directly *)
    // {$ENDIF} (* WINVER >= $0400 *)

    (* flags for dwFlags field of MIDIHDR structure *)
    MHDR_DONE = $00000001;       (* done bit *)
    MHDR_PREPARED = $00000002;       (* set if header prepared *)
    MHDR_INQUEUE = $00000004;       (* reserved for driver *)
    MHDR_ISSTRM = $00000008;       (* Buffer is stream buffer *)
//{$IF (WINVER >= $0400)}
    (* *)
    (* Type codes which go in the high byte of the event DWORD of a stream buffer *)
    (* *)
    (* Type codes 00-7F contain parameters within the low 24 bits *)
    (* Type codes 80-FF contain a length of their parameter in the low 24 *)
    (* bits, followed by their parameter data in the buffer. The event *)
    (* DWORD contains the exact byte length; the parm data itself must be *)
    (* padded to be an even multiple of 4 bytes long. *)
    (* *)

    MEVT_F_SHORT = $00000000;
    MEVT_F_LONG = $80000000;
    MEVT_F_CALLBACK = $40000000;

    MEVT_SHORTMSG = byte($00);    (* parm = shortmsg for midiOutShortMsg *)
    MEVT_TEMPO = byte($01);    (* parm = new tempo in microsec/qn     *)
    MEVT_NOP = byte($02);    (* parm = unused; does nothing         *)

    (* $04-$7F reserved *)

    MEVT_LONGMSG = byte($80);    (* parm = bytes to send verbatim       *)
    MEVT_COMMENT = byte($82);    (* parm = comment data                 *)
    MEVT_VERSION = byte($84);    (* parm = MIDISTRMBUFFVER struct       *)

    (* $81-$FF reserved *)

    MIDISTRM_ERROR = (-2);

    (* *)
    (* Structures and defines for midiStreamProperty *)
    (* *)
    MIDIPROP_SET = $80000000;
    MIDIPROP_GET = $40000000;

    (* These are intentionally both non-zero so the app cannot accidentally *)
    (* leave the operation off and happen to appear to work due to default *)
    (* action. *)

    MIDIPROP_TIMEDIV = $00000001;
    MIDIPROP_TEMPO = $00000002;

    // {$ENDIF} (* WINVER >= $0400 *)


(****************************************************************************

                        Auxiliary audio support

****************************************************************************)
    (* device ID for aux device mapper *)
    AUX_MAPPER = UINT(-1);

    (* flags for wTechnology field in AUXCAPS structure *)
    AUXCAPS_CDAUDIO = 1;       (* audio from internal CD-ROM drive *)
    AUXCAPS_AUXIN = 2;       (* audio from auxiliary input jacks *)

    (* flags for dwSupport field in AUXCAPS structure *)
    AUXCAPS_VOLUME = $0001;  (* supports volume control *)
    AUXCAPS_LRVOLUME = $0002;  (* separate left-right volume control *)


    (****************************************************************************

                            Mixer Support

****************************************************************************)

    MIXER_SHORT_NAME_CHARS = 16;
    MIXER_LONG_NAME_CHARS = 64;

    (* *)
    (*  MMRESULT error return values specific to the mixer API *)
    (* *)
    (* *)
    MIXERR_INVALLINE = (MIXERR_BASE + 0);
    MIXERR_INVALCONTROL = (MIXERR_BASE + 1);
    MIXERR_INVALVALUE = (MIXERR_BASE + 2);
    MIXERR_LASTERROR = (MIXERR_BASE + 2);

    MIXER_OBJECTF_HANDLE = $80000000;
    MIXER_OBJECTF_MIXER = $00000000;
    MIXER_OBJECTF_HMIXER = (MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIXER);
    MIXER_OBJECTF_WAVEOUT = $10000000;
    MIXER_OBJECTF_HWAVEOUT = (MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_WAVEOUT);
    MIXER_OBJECTF_WAVEIN = $20000000;
    MIXER_OBJECTF_HWAVEIN = (MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_WAVEIN);
    MIXER_OBJECTF_MIDIOUT = $30000000;
    MIXER_OBJECTF_HMIDIOUT = (MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIDIOUT);
    MIXER_OBJECTF_MIDIIN = $40000000;
    MIXER_OBJECTF_HMIDIIN = (MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIDIIN);
    MIXER_OBJECTF_AUX = $50000000;

    (* *)
    (*  MIXERLINE.fdwLine *)
    (* *)
    (* *)
    MIXERLINE_LINEF_ACTIVE = $00000001;
    MIXERLINE_LINEF_DISCONNECTED = $00008000;
    MIXERLINE_LINEF_SOURCE = $80000000;

    (* *)
    (*  MIXERLINE.dwComponentType *)
    (* *)
    (*  component types for destinations and sources *)
    (* *)
    (* *)
    MIXERLINE_COMPONENTTYPE_DST_FIRST = $00000000;
    MIXERLINE_COMPONENTTYPE_DST_UNDEFINED = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 0);
    MIXERLINE_COMPONENTTYPE_DST_DIGITAL = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 1);
    MIXERLINE_COMPONENTTYPE_DST_LINE = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 2);
    MIXERLINE_COMPONENTTYPE_DST_MONITOR = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 3);
    MIXERLINE_COMPONENTTYPE_DST_SPEAKERS = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 4);
    MIXERLINE_COMPONENTTYPE_DST_HEADPHONES = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 5);
    MIXERLINE_COMPONENTTYPE_DST_TELEPHONE = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 6);
    MIXERLINE_COMPONENTTYPE_DST_WAVEIN = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 7);
    MIXERLINE_COMPONENTTYPE_DST_VOICEIN = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 8);
    MIXERLINE_COMPONENTTYPE_DST_LAST = (MIXERLINE_COMPONENTTYPE_DST_FIRST + 8);

    MIXERLINE_COMPONENTTYPE_SRC_FIRST = $00001000;
    MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 0);
    MIXERLINE_COMPONENTTYPE_SRC_DIGITAL = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 1);
    MIXERLINE_COMPONENTTYPE_SRC_LINE = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 2);
    MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 3);
    MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 4);
    MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 5);
    MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 6);
    MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 7);
    MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 8);
    MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 9);
    MIXERLINE_COMPONENTTYPE_SRC_ANALOG = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 10);
    MIXERLINE_COMPONENTTYPE_SRC_LAST = (MIXERLINE_COMPONENTTYPE_SRC_FIRST + 10);

    (* *)
    (*  MIXERLINE.Target.dwType *)
    (* *)
    (* *)
    MIXERLINE_TARGETTYPE_UNDEFINED = 0;
    MIXERLINE_TARGETTYPE_WAVEOUT = 1;
    MIXERLINE_TARGETTYPE_WAVEIN = 2;
    MIXERLINE_TARGETTYPE_MIDIOUT = 3;
    MIXERLINE_TARGETTYPE_MIDIIN = 4;
    MIXERLINE_TARGETTYPE_AUX = 5;

    MIXER_GETLINEINFOF_DESTINATION = $00000000;
    MIXER_GETLINEINFOF_SOURCE = $00000001;
    MIXER_GETLINEINFOF_LINEID = $00000002;
    MIXER_GETLINEINFOF_COMPONENTTYPE = $00000003;
    MIXER_GETLINEINFOF_TARGETTYPE = $00000004;

    MIXER_GETLINEINFOF_QUERYMASK = $0000000F;

type

    (* wave data block header *)
    PWAVEHDR = ^TWAVEHDR;

    TWAVEHDR = record
        lpData: LPSTR;                 (* pointer to locked data buffer *)
        dwBufferLength: DWORD;         (* length of data buffer *)
        dwBytesRecorded: DWORD;        (* used for input only *)
        dwUser: DWORD_PTR;                 (* for client's use *)
        dwFlags: DWORD;                (* assorted flags (see defines) *)
        dwLoops: DWORD;                (* loop control counter *)
        lpNext: PWAVEHDR;     (* reserved for driver *)
        reserved: DWORD_PTR;               (* reserved for driver *)
    end;




    (* waveform output device capabilities structure *)

    TWAVEOUTCAPSA = record
        wMid: word;                  (* manufacturer ID *)
        wPid: word;                  (* product ID *)
        vDriverVersion: TMMVERSION;      (* version of the driver *)
        szPname: array[0..MAXPNAMELEN - 1] of ANSICHAR;  (* product name (NULL terminated string) *)
        dwFormats: DWORD;             (* formats supported *)
        wChannels: word;             (* number of sources supported *)
        wReserved1: word;            (* packing *)
        dwSupport: DWORD;             (* functionality supported by driver *)
    end;
    PWAVEOUTCAPSA = ^TWAVEOUTCAPSA;

    TWAVEOUTCAPSW = record
        wMid: word;                  (* manufacturer ID *)
        wPid: word;                  (* product ID *)
        vDriverVersion: TMMVERSION;      (* version of the driver *)
        szPname: array[0..MAXPNAMELEN - 1] of WCHAR;  (* product name (NULL terminated string) *)
        dwFormats: DWORD;             (* formats supported *)
        wChannels: word;             (* number of sources supported *)
        wReserved1: word;            (* packing *)
        dwSupport: DWORD;             (* functionality supported by driver *)
    end;
    PWAVEOUTCAPSW = ^TWAVEOUTCAPSW;

(* waveform audio function prototypes *)
function waveOutGetNumDevs(): UINT; stdcall; external winmm_dll;

implementation

end.
