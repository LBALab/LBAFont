object PrevForm: TPrevForm
  Left = 227
  Top = 105
  AutoScroll = False
  Caption = 'Preview'
  ClientHeight = 88
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    583
    88)
  PixelsPerInch = 96
  TextHeight = 13
  object btLockTop: TSpeedButton
    Left = 256
    Top = 66
    Width = 93
    Height = 22
    AllowAllUp = True
    Anchors = [akRight, akBottom]
    GroupIndex = 1
    Caption = 'Lock at &top'
    Layout = blGlyphTop
    Margin = 2
    Spacing = 0
    Transparent = False
    OnClick = btLockBtmClick
  end
  object btLockBtm: TSpeedButton
    Left = 349
    Top = 66
    Width = 92
    Height = 22
    AllowAllUp = True
    Anchors = [akRight, akBottom]
    GroupIndex = 1
    Caption = 'Lock at &bottom'
    Layout = blGlyphTop
    Margin = 2
    Spacing = 0
    Transparent = False
    OnClick = btLockBtmClick
  end
  object btClose: TSpeedButton
    Left = 526
    Top = 66
    Width = 57
    Height = 22
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    Layout = blGlyphTop
    Margin = 2
    Spacing = 0
    Transparent = False
    OnClick = btCloseClick
  end
  object btOptions: TSpeedButton
    Left = 450
    Top = 66
    Width = 67
    Height = 22
    AllowAllUp = True
    Anchors = [akRight, akBottom]
    GroupIndex = 2
    Caption = 'O&ptions'
    Layout = blGlyphTop
    Margin = 2
    Spacing = 0
    Transparent = False
    OnClick = btOptionsClick
  end
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 583
    Height = 64
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Constraints.MinHeight = 50
    Constraints.MinWidth = 10
    FullRepaint = False
    TabOrder = 0
    DesignSize = (
      583
      64)
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 583
      Height = 64
      Anchors = [akLeft, akRight, akBottom]
      BevelInner = bvLowered
      Constraints.MinHeight = 1
      Constraints.MinWidth = 1
      UseDockManager = False
      FullRepaint = False
      TabOrder = 0
      object Label2: TLabel
        Left = 208
        Top = 8
        Width = 56
        Height = 13
        Caption = 'Font colour:'
      end
      object Label3: TLabel
        Left = 392
        Top = 8
        Width = 93
        Height = 13
        Caption = 'Background colour:'
      end
      object cFont: TColorBox
        Left = 208
        Top = 24
        Width = 145
        Height = 22
        AutoDropDown = True
        NoneColorColor = clBtnFace
        Style = [cbStandardColors, cbExtendedColors, cbIncludeNone, cbPrettyNames]
        DropDownCount = 20
        ItemHeight = 16
        TabOrder = 0
        OnChange = pbPrevPaint
      end
      object cBack: TColorBox
        Left = 392
        Top = 24
        Width = 145
        Height = 22
        AutoDropDown = True
        NoneColorColor = clBtnFace
        Selected = clWhite
        Style = [cbStandardColors, cbExtendedColors, cbIncludeNone, cbPrettyNames]
        DropDownCount = 20
        ItemHeight = 16
        TabOrder = 1
        OnChange = pbPrevPaint
      end
      object cbRemSet: TCheckBox
        Left = 16
        Top = 8
        Width = 153
        Height = 17
        Caption = 'Remember settings'
        TabOrder = 2
      end
      object cbLbaStyle: TCheckBox
        Left = 16
        Top = 40
        Width = 121
        Height = 17
        Caption = 'LBA letter style'
        TabOrder = 3
        OnClick = pbPrevPaint
      end
      object cbOnTop: TCheckBox
        Left = 16
        Top = 24
        Width = 105
        Height = 17
        Caption = 'Stay on top'
        TabOrder = 4
        OnClick = cbOnTopClick
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 583
      Height = 64
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelInner = bvLowered
      BevelOuter = bvNone
      Constraints.MinHeight = 10
      Constraints.MinWidth = 10
      Ctl3D = True
      UseDockManager = False
      FullRepaint = False
      ParentCtl3D = False
      TabOrder = 1
      DesignSize = (
        583
        64)
      object pbPrev: TPaintBox
        Left = 1
        Top = 1
        Width = 580
        Height = 44
        Anchors = [akLeft, akTop, akRight, akBottom]
        Constraints.MinHeight = 10
        Constraints.MinWidth = 10
        OnPaint = pbPrevPaint
      end
      object Buffer1: TImage
        Left = 72
        Top = 8
        Width = 105
        Height = 41
        Visible = False
      end
      object Buffer2: TImage
        Left = 80
        Top = 16
        Width = 105
        Height = 41
        Visible = False
      end
      object sbHoriz: TScrollBar
        Left = 1
        Top = 46
        Width = 580
        Height = 16
        Anchors = [akLeft, akRight, akBottom]
        LargeChange = 20
        PageSize = 0
        SmallChange = 2
        TabOrder = 0
        OnChange = pbPrevPaint
      end
    end
  end
  object eText: TEdit
    Left = 0
    Top = 67
    Width = 249
    Height = 20
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    TabOrder = 1
    Text = 'Enter text here'
    OnChange = eTextChange
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 456
    Top = 8
  end
end
