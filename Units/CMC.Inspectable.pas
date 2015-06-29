//+-------------------------------------------------------------------------

//  Microsoft Windows
//  Copyright (c) Microsoft Corporation. All rights reserved.

//--------------------------------------------------------------------------

unit CMC.Inspectable;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    CMC.HString;

const
    IID_IInspectable: TGUID = '{AF86E2E0-B12D-4c6a-9C5A-D7AA65101E90}';

type

    IInspectable = interface;

    PIInspectable = ^IInspectable;


    TTrustLevel = (
        BaseTrust = 0,
        PartialTrust = (BaseTrust + 1),
        FullTrust = (PartialTrust + 1)
        );


    IInspectable = interface(IUnknown)
        ['{AF86E2E0-B12D-4c6a-9C5A-D7AA65101E90}']
        function GetIids(out iidCount: ULONG; out iids: PGUID): HResult; stdcall;
        function GetRuntimeClassName(out ClassName: HSTRING): HResult; stdcall;
        function GetTrustLevel(out trustLevel: TTrustLevel): HResult; stdcall;
    end;


implementation

end.










