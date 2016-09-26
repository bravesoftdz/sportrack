object frmCommentFrame: TfrmCommentFrame
  Left = 0
  Top = 0
  Width = 377
  Height = 129
  TabOrder = 0
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 129
    BevelOuter = bvNone
    TabOrder = 0
    object lblComment: TLabel
      Left = 8
      Top = 8
      Width = 361
      Height = 73
      AutoSize = False
      Caption = 'lblComment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object lblUsername: TLabel
      Left = 249
      Top = 96
      Width = 72
      Height = 17
      Alignment = taRightJustify
      Caption = '@username'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object imgProfilePicture: TImage
      Left = 328
      Top = 88
      Width = 33
      Height = 33
      Stretch = True
    end
  end
end
