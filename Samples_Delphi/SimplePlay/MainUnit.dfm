object MFPlaySample: TMFPlaySample
  Left = 0
  Top = 0
  Caption = 'MFPlay Sample Application'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 440
    Top = 192
    object File1: TMenuItem
      Caption = 'File'
      object menuOpen: TMenuItem
        Caption = 'Open'
        OnClick = menuOpenClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object menuExit: TMenuItem
        Caption = 'Exit'
        OnClick = menuExitClick
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 320
    Top = 120
  end
end
