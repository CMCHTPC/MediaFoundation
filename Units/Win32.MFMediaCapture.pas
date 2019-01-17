unit Win32.MFMediaCapture;

// Checked (and Updated) for SDK 10.0.17763.0 on 2018-12-04

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

interface

uses
    Windows, Classes, SysUtils,
    Win32.MFObjects;

const
    IID_IAdvancedMediaCaptureInitializationSettings: TGUID = '{3DE21209-8BA6-4f2a-A577-2819B56FF14D}';
    IID_IAdvancedMediaCaptureSettings: TGUID = '{24E0485F-A33E-4aa1-B564-6019B1D14F65}';
    IID_IAdvancedMediaCapture: TGUID = '{D0751585-D216-4344-B5BF-463B68F977BB}';

type

    IAdvancedMediaCaptureInitializationSettings = interface(IUnknown)
        ['{3DE21209-8BA6-4f2a-A577-2819B56FF14D}']
        function SetDirectxDeviceManager(Value: IMFDXGIDeviceManager): HResult; stdcall;
    end;


    IAdvancedMediaCaptureSettings = interface(IUnknown)
        ['{24E0485F-A33E-4aa1-B564-6019B1D14F65}']
        function GetDirectxDeviceManager(out Value: IMFDXGIDeviceManager): HResult; stdcall;
    end;


    IAdvancedMediaCapture = interface(IUnknown)
        ['{D0751585-D216-4344-B5BF-463B68F977BB}']
        function GetAdvancedMediaCaptureSettings(out Value: IAdvancedMediaCaptureSettings): HResult; stdcall;
    end;


implementation

end.
