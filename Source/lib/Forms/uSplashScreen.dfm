object frmSplashScreen: TfrmSplashScreen
  Left = 445
  Top = 208
  BorderStyle = bsNone
  Caption = 'SporTrack'
  ClientHeight = 295
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormCreate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object aniAnimation: TAnimate
    Left = 0
    Top = 0
    Width = 411
    Height = 295
    StopFrame = 60
  end
  object pnlEmail: TPanel
    Left = 8
    Top = 270
    Width = 393
    Height = 27
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'Email Address: ivan.gideonson@gmail.com'
    Color = 15963681
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object pnlCredit: TPanel
    Left = 8
    Top = 254
    Width = 393
    Height = 21
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = 'Created by: Ivan Kahl'
    Color = 15963681
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
