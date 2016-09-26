object frmActivity: TfrmActivity
  Left = 0
  Top = 0
  Width = 374
  Height = 121
  TabOrder = 0
  object pnlContent: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 121
    BevelOuter = bvNone
    TabOrder = 0
    object shpActivityTypeCircle: TShape
      Left = 8
      Top = 8
      Width = 105
      Height = 97
      Brush.Color = clBtnFace
      Shape = stCircle
    end
    object lblUsername: TLabel
      Left = 119
      Top = 32
      Width = 72
      Height = 17
      Caption = '@username'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object lblTitle: TLabel
      Left = 119
      Top = 8
      Width = 34
      Height = 25
      Caption = 'Title'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
    object lblRate: TLabel
      Left = 327
      Top = 56
      Width = 26
      Height = 17
      Alignment = taRightJustify
      Caption = 'Rate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblDuration: TLabel
      Left = 207
      Top = 56
      Width = 50
      Height = 17
      Alignment = taCenter
      Caption = 'Duration'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblDistance: TLabel
      Left = 119
      Top = 56
      Width = 49
      Height = 17
      Caption = 'Distance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblDateTime: TLabel
      Left = 303
      Top = 32
      Width = 55
      Height = 17
      Alignment = taRightJustify
      Caption = 'DateTime'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object imgActivityType: TImage
      Left = 32
      Top = 24
      Width = 65
      Height = 65
      Transparent = True
    end
  end
end
