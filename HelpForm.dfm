object HelpF: THelpF
  Left = 226
  Top = 107
  AutoSize = True
  BorderStyle = bsSingle
  Caption = 'LBA Font Editor help'
  ClientHeight = 441
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000008880000000000000000000000000000FBBB8000000000000000000
    000000000FBBB8000000000000000000000000000FBBB8000000000000000000
    0000000000FFF000000000000000000000000000008880000000000000000000
    000000000FBBB8000000000000000000000000000FBBB8000000000000000000
    000000000FBBB80000000000000000000000000000FBBB800000000000000000
    0000000000FBBB80000000000000000000000000000FBBB80000000000000000
    000000000000FBBB80000000000000000000000000000FBBB800000000000000
    0000088800000FBBB8000000000000000000FBBB800000FBBB80000000000000
    0000FBBB800000FBBB800000000000000000FBBB800000FBBB80000000000000
    00000FBBB80008BBBB8000000000000000000FBBBB888BBBB800000000000000
    000000FBBBBBBBBB80000000000000000000000FFBBBBB800000000000000000
    000000000FFFFF00000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC7FFFFFF83FFFFFF8
    3FFFFFF83FFFFFFC7FFFFFFC7FFFFFF83FFFFFF83FFFFFF83FFFFFFC1FFFFFFC
    1FFFFFFE0FFFFFFF07FFFFFF83FFFF8F83FFFF07C1FFFF07C1FFFF07C1FFFF83
    81FFFF8003FFFFC007FFFFE01FFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object TabbedNotebook1: TTabbedNotebook
    Left = 0
    Top = 0
    Width = 529
    Height = 441
    TabFont.Charset = DEFAULT_CHARSET
    TabFont.Color = clBtnText
    TabFont.Height = -13
    TabFont.Name = 'MS Sans Serif'
    TabFont.Style = []
    TabOrder = 0
    object TTabPage
      Left = 4
      Top = 27
      Caption = 'About'
      object Panel1: TPanel
        Left = 8
        Top = 8
        Width = 505
        Height = 393
        BevelInner = bvLowered
        TabOrder = 0
        object Panel2: TPanel
          Left = 8
          Top = 8
          Width = 489
          Height = 377
          BevelOuter = bvLowered
          TabOrder = 0
          object Label1: TLabel
            Left = 120
            Top = 44
            Width = 249
            Height = 20
            Alignment = taCenter
            AutoSize = False
            Caption = 'LBA Font Editor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -17
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 125
            Top = 76
            Width = 238
            Height = 16
            Caption = 'Font editor for Little Big Adventure series'
          end
          object Label3: TLabel
            Left = 120
            Top = 100
            Width = 249
            Height = 16
            Alignment = taCenter
            AutoSize = False
            Caption = 'Version: XXX'
          end
          object Label5: TLabel
            Left = 194
            Top = 124
            Width = 100
            Height = 16
            Caption = 'Copyright '#169' Zink.'
            WordWrap = True
          end
          object Label6: TLabel
            Left = 163
            Top = 148
            Width = 163
            Height = 16
            Caption = 'e-mail: zink@poczta.onet.pl'
          end
          object Label7: TLabel
            Left = 208
            Top = 248
            Width = 72
            Height = 16
            Caption = 'Homepage:'
          end
          object Label8: TLabel
            Left = 72
            Top = 300
            Width = 344
            Height = 32
            Alignment = taCenter
            Caption = 
              'If you find any bugs or have suggestion about this program'#13'(or a' +
              'bout anything ;)), please e-mail me at:'
          end
          object AdresLabel: TLabel
            Left = 182
            Top = 332
            Width = 126
            Height = 16
            Cursor = crHandPoint
            Caption = ' zink@poczta.onet.pl '
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            OnMouseDown = AdresLabelMouseDown
            OnMouseUp = AdresLabelMouseUp
          end
          object HpLabel: TLabel
            Left = 167
            Top = 264
            Width = 156
            Height = 16
            Cursor = crHandPoint
            Caption = ' www.emeraldmoon.prv.pl '
            Color = clSilver
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Transparent = True
            OnMouseDown = HpLabelMouseDown
            OnMouseUp = HpLabelMouseUp
          end
          object Label4: TLabel
            Left = 40
            Top = 184
            Width = 409
            Height = 49
            Alignment = taCenter
            AutoSize = False
            Caption = 
              'LBA Font Editor comes with ABSOLUTELY NO WARRANTY; for details s' +
              'ee License.txt. This is free software, and you are welcome to re' +
              'distribute it under certain conditions; see License.txt for deta' +
              'ils.'
            WordWrap = True
          end
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 27
      Caption = 'What is this ?'
      object Panel3: TPanel
        Left = 8
        Top = 8
        Width = 505
        Height = 393
        BevelInner = bvLowered
        TabOrder = 0
        object Memo1: TMemo
          Left = 8
          Top = 8
          Width = 489
          Height = 377
          Color = clBtnHighlight
          Lines.Strings = (
            
              ' Did you ever think the font in LBA to be somewhat... ugly? OK..' +
              '. not ugly... but not '
            'beautiful also. Did you ever wish to change it? Now you can...'
            ''
            
              ' With this program you can edit the font file that is used in Li' +
              'ttle Big Adventure 1 '
            '& 2 games.'
            
              ' To make the program usable, you must first get LBA Package Edit' +
              'or from '
            
              'http://www.emeraldmoon.prv.pl or any other hqr decompression pro' +
              'gram, which '
            'is necessary to extract the file which contains the font.'
            ' ')
          ReadOnly = True
          TabOrder = 0
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 27
      Caption = 'File information'
      object Panel4: TPanel
        Left = 8
        Top = 8
        Width = 505
        Height = 393
        BevelInner = bvLowered
        TabOrder = 0
        object Memo2: TMemo
          Left = 8
          Top = 8
          Width = 489
          Height = 377
          Color = clBtnHighlight
          Lines.Strings = (
            
              'The first 1024 bytes are offsets of 256 characters (4 bytes per ' +
              'char). '
            ' The offset #256 is the length of entire file. '
            ''
            ' The next data contains character maps. '
            '  First 4 bytes of each one are in turn: '
            '   - char width'
            '   - char height'
            '   - on-screen offset X'
            '   - on-screen offset Y.'
            
              '  The next one byte says how many sub-lines contains one line of' +
              ' the image.'
            
              '  The next two bytes describes the lengths of these sub-lines. T' +
              'hey starts from '
            
              'non-visible one. Sum of their lengths must equal the character w' +
              'idth.'
            
              '   Example: line of image (= - transparent, X - non-transparent)' +
              ': '
            'XXX==XXXXXXX=XXX. '
            '    The line contains 6 sub-lines (first is zero length). '
            '    Bytes of this line should be (from fifth one):'
            '     #06 - the line has 6 sub-lines'
            
              '     #00 - first sub-line is 0 length because each line must beg' +
              'in from transparent '
            'one,'
            '     #03 - second sub-line is 3 lenght'
            '     #02 - ...and so on...'
            '     #07'
            '     #01'
            '     #03 '
            
              '  The next byte describes the length of the next line. Amount of' +
              ' char lines must fit '
            'the char height.'
            
              '  After last line the next char map begins (width, height, etc.)' +
              '. And so on to the '
            'map of the last character.')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object TTabPage
      Left = 4
      Top = 27
      Caption = 'Editing font file'
      object Panel5: TPanel
        Left = 8
        Top = 8
        Width = 505
        Height = 393
        BevelInner = bvLowered
        TabOrder = 0
        object Memo3: TMemo
          Left = 8
          Top = 8
          Width = 489
          Height = 377
          Color = clBtnHighlight
          Lines.Strings = (
            
              ' First of all: you must have the original font file from LBA. Yo' +
              'u can unpack it (with '
            
              'Package Editor or any other hqr decompression program) from file' +
              ' named '
            
              '"ress.hqr" (in your LBA directory). In this file there are some ' +
              'files (pallettes, '
            
              'images, etc.), font file is the second one. You must unpack the ' +
              'second file to any '
            'directory you wish.'
            ''
            ' Next:'
            ''
            
              '1. Open extracted file - click the button with folder picture on' +
              ' it, or drag your '
            
              'extracted file into program'#39's window, or drag your file onto pro' +
              'gram'#39's icon.'
            
              '2. Select character you want ot edit. Double click on it or clic' +
              'k the button with "A" '
            'letter and an arrow.'
            
              '3. You can set some properties of edited character like width, h' +
              'eight and screen '
            
              'offset. Screen offset says how many pixels the char is moved fro' +
              'm its start point '
            
              '(if the char has screen offset X = 2 and screen offset Y = 3, it' +
              ' will appear as if it '
            
              'would have three blank lines above it and two blank lines before' +
              ' it. If you still '
            
              'don'#39't understand how screen offset works, try to compare some ch' +
              'aracters (for '
            'example "A" and "a").'
            '4. You can use drawing tools:'
            '   Pen - you can draw anything.'
            
              '   Selection - select a region of char image and move it to anot' +
              'her place.'
            
              '   Copy - click this button to copy selected region of image to ' +
              'Windows'#39' '
            'clipboard.'
            
              '   Paste - paste a bitmap from clipboard. If bitmap in the clipb' +
              'oard has more '
            
              'colours than 2 it will be converted to black and white (without ' +
              'dithering): white '
            'pixels will remain white, other pixels will become black.'
            '   Clear - entire image becomes white.'
            '   Fill - entire image becomes black.'
            
              '5. After editing click save - if you want to save your modificat' +
              'ions to that '
            
              'character, or cancel - returm to main program without saving. On' +
              'ly '
            
              'currently edited character is saved, opened file isn'#39't modified ' +
              'until you save '
            'entire file.'
            
              '6. If you want to save charset to a font file click the button w' +
              'ith diskette picture in '
            'the main program window.'
            ''
            
              ' Next you have to repack file "ress.hqr" with changed font file ' +
              'using LBA '
            'Package Editor or any other hqr decompression program.'
            ''
            ' If you use LBA Package Editor:'
            
              '  You have to open the "ress.hqr" file from either LBA 1 or 2, r' +
              'eplace the second '
            
              'entry with your font file, and compile it into another "ress.hqr' +
              '" file.')
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
  end
end
