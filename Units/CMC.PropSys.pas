{ This is PropSys.h
   with declarations not in ActiveX.pas
}
unit CMC.PropSys;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,ActiveX;

const
    IID_INamedPropertyStore: TGUID = '{71604b0f-97b0-4764-8577-2f13e98a1422}';

type
    INamedPropertyStore = interface(IUnknown)
        ['{71604b0f-97b0-4764-8577-2f13e98a1422}']
        function GetNamedValue(pszName: LPCWSTR; out ppropvar: PROPVARIANT): HResult; stdcall;
        function SetNamedValue(pszName: LPCWSTR; const propvar: PROPVARIANT): HResult; stdcall;
        function GetNameCount(out pdwCount: DWORD): HResult; stdcall;
        function GetNameAt(iProp: DWORD; out pbstrName: POLESTR): HResult; stdcall;
    end;

implementation

end.








