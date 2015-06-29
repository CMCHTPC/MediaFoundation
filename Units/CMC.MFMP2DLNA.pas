unit CMC.MFMP2DLNA;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    CMC.MFObjects;

const
    IID_IMFDLNASinkInit: TGUID = '{0c012799-1b61-4c10-bda9-04445be5f561}';

const
    CLSID_MPEG2DLNASink: TGUID = '{fa5fe7c5-6a1d-4b11-b41f-f959d6c76500}';
    MF_MP2DLNA_USE_MMCSS: TGUID = '{54f3e2ee-a2a2-497d-9834-973afde521eb}';
    MF_MP2DLNA_VIDEO_BIT_RATE: TGUID = '{e88548de-73b4-42d7-9c75-adfa0a2a6e4c}';
    MF_MP2DLNA_AUDIO_BIT_RATE: TGUID = '{2d1c070e-2b5f-4ab3-a7e6-8d943ba8d00a}';
    MF_MP2DLNA_ENCODE_QUALITY: TGUID = '{b52379d7-1d46-4fb6-a317-a4a5f60959f8}';
    MF_MP2DLNA_STATISTICS: TGUID = '{75e488a3-d5ad-4898-85e0-bcce24a722d7}';


type
    IMFDLNASinkInit = interface(IUnknown)
        ['{0c012799-1b61-4c10-bda9-04445be5f561}']
        function Initialize(pByteStream: IMFByteStream; fPal: boolean): HResult; stdcall;
    end;


    TMFMPEG2DLNASINKSTATS = record
        cBytesWritten: DWORDLONG;
        fPAL: boolean;
        fccVideo: DWORD;
        dwVideoWidth: DWORD;
        dwVideoHeight: DWORD;
        cVideoFramesReceived: DWORDLONG;
        cVideoFramesEncoded: DWORDLONG;
        cVideoFramesSkipped: DWORDLONG;
        cBlackVideoFramesEncoded: DWORDLONG;
        cVideoFramesDuplicated: DWORDLONG;
        cAudioSamplesPerSec: DWORD;
        cAudioChannels: DWORD;
        cAudioBytesReceived: DWORDLONG;
        cAudioFramesEncoded: DWORDLONG;
    end;
    PMFMPEG2DLNASINKSTATS = ^TMFMPEG2DLNASINKSTATS;

implementation

end.





