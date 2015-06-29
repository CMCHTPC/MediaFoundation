program SimplePlay;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {MFPlaySample},
  CMC.AMVideo in '..\..\Units\CMC.AMVideo.pas',
  CMC.DVDMedia in '..\..\Units\CMC.DVDMedia.pas',
  CMC.DXVA in '..\..\Units\CMC.DXVA.pas',
  CMC.DXVA2API in '..\..\Units\CMC.DXVA2API.pas',
  CMC.DXVA2SWDev in '..\..\Units\CMC.DXVA2SWDev.pas',
  CMC.DXVA2Trace in '..\..\Units\CMC.DXVA2Trace.pas',
  CMC.DXVA9Typ in '..\..\Units\CMC.DXVA9Typ.pas',
  CMC.DXVAHD in '..\..\Units\CMC.DXVAHD.pas',
  CMC.EVNTrace in '..\..\Units\CMC.EVNTrace.pas',
  CMC.EVR in '..\..\Units\CMC.EVR.pas',
  CMC.EVR9 in '..\..\Units\CMC.EVR9.pas',
  CMC.HString in '..\..\Units\CMC.HString.pas',
  CMC.Inspectable in '..\..\Units\CMC.Inspectable.pas',
  CMC.MediaObj in '..\..\Units\CMC.MediaObj.pas',
  CMC.MFAPI in '..\..\Units\CMC.MFAPI.pas',
  CMC.MFCaptureEngine in '..\..\Units\CMC.MFCaptureEngine.pas',
  CMC.MFIdl in '..\..\Units\CMC.MFIdl.pas',
  CMC.MFMediaCapture in '..\..\Units\CMC.MFMediaCapture.pas',
  CMC.MFMediaEngine in '..\..\Units\CMC.MFMediaEngine.pas',
  CMC.MFMP2DLNA in '..\..\Units\CMC.MFMP2DLNA.pas',
  CMC.MFObjects in '..\..\Units\CMC.MFObjects.pas',
  CMC.MFPlay in '..\..\Units\CMC.MFPlay.pas',
  CMC.MFReadWrite in '..\..\Units\CMC.MFReadWrite.pas',
  CMC.MFSharingEngine in '..\..\Units\CMC.MFSharingEngine.pas',
  CMC.MFTransform in '..\..\Units\CMC.MFTransform.pas',
  CMC.MMReg in '..\..\Units\CMC.MMReg.pas',
  CMC.WMContainer in '..\..\Units\CMC.WMContainer.pas',
  CMC.WTypes in '..\..\Units\CMC.WTypes.pas',
  DX12.DXGI in 'F:\DXNewLib\DelphiDX12\DX12.DXGI.pas',
  CMC.PropSys in '..\..\Units\CMC.PropSys.pas',
  CMC.KSMedia in '..\..\Units\CMC.KSMedia.pas',
  CMC.KS in '..\..\Units\CMC.KS.pas',
  CMC.MFError in '..\..\Units\CMC.MFError.pas',
  CMC.MMEAPI in '..\..\Units\CMC.MMEAPI.pas',
  CMC.MMSysCom in '..\..\Units\CMC.MMSysCom.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMFPlaySample, MFPlaySample);
  Application.Run;
end.
