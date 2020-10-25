object OptForm: TOptForm
  Tag = 999
  Left = 653
  Top = 105
  BorderStyle = bsNone
  Caption = 'OptForm'
  ClientHeight = 161
  ClientWidth = 192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  DesignSize = (
    192
    161)
  PixelsPerInch = 96
  TextHeight = 16
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 192
    Height = 161
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = bsRaised
  end
  object Bevel2: TBevel
    Left = 7
    Top = 32
    Width = 177
    Height = 9
    Shape = bsTopLine
  end
  object AO: TCheckBox
    Left = 7
    Top = 40
    Width = 177
    Height = 17
    Hint = 'Make the character screen offsets affect displayed characters'
    Caption = 'Respect screen offsets'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 0
    OnClick = AOClick
  end
  object EM: TCheckBox
    Left = 7
    Top = 64
    Width = 169
    Height = 17
    Hint = 'Expands mouse cursor with vertical and horizontal lines'
    Caption = 'Expand mouse cursor'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = EMClick
  end
  object StaticText1: TStaticText
    Left = 55
    Top = 8
    Width = 78
    Height = 24
    Caption = 'OPTIONS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object SN: TCheckBox
    Left = 7
    Top = 112
    Width = 177
    Height = 17
    Caption = 'Show char numbers'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = AOClick
  end
  object SE: TCheckBox
    Left = 23
    Top = 88
    Width = 113
    Height = 17
    Caption = 'Super expand'
    Enabled = False
    TabOrder = 4
    OnClick = SEClick
  end
  object cbAssociate: TCheckBox
    Left = 7
    Top = 136
    Width = 180
    Height = 17
    Caption = 'Assoc. with font files (*.lfn)'
    TabOrder = 5
    OnClick = cbAssociateClick
  end
end
