unit CMC.MMSysCom;

interface

{$IFDEF FPC}
{$MODE delphi}
{$ENDIF}

uses
    Windows, Classes;

const
    { ***************************************************************************

      String resource number bases (internal use)

      *************************************************************************** }

    MMSYSERR_BASE = 0;
    WAVERR_BASE = 32;
    MIDIERR_BASE = 64;
    TIMERR_BASE = 96;
    JOYERR_BASE = 160;
    MCIERR_BASE = 256;
    MIXERR_BASE = 1024;

    MCI_STRING_OFFSET = 512;
    MCI_VD_OFFSET = 1024;
    MCI_CD_OFFSET = 1088;
    MCI_WAVE_OFFSET = 1152;
    MCI_SEQ_OFFSET = 1216;

implementation

end.
