//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// Preview unit.
// Contains preview routines.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Preview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls;

type
  TPrevForm = class(TForm)
    btLockTop: TSpeedButton;
    btLockBtm: TSpeedButton;
    btClose: TSpeedButton;
    btOptions: TSpeedButton;
    Timer1: TTimer;
    PanelMain: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    cFont: TColorBox;
    cBack: TColorBox;
    cbRemSet: TCheckBox;
    cbLbaStyle: TCheckBox;
    cbOnTop: TCheckBox;
    Panel1: TPanel;
    pbPrev: TPaintBox;
    Buffer1: TImage;
    Buffer2: TImage;
    sbHoriz: TScrollBar;
    eText: TEdit;
    procedure btCloseClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbPrevPaint(Sender: TObject);
    procedure btOptionsClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btLockBtmClick(Sender: TObject);
    procedure cbOnTopClick(Sender: TObject);
    procedure eTextChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const CharCount: Integer = 256;

var
  PrevForm: TPrevForm;

  ImgBuffer: TImage;
  
procedure PaintPreview;

implementation

{$R *.dfm}

uses FControl, LBAFont1;

procedure Wait(Time: Integer);
begin
 PrevForm.Timer1.Interval:=Time;
 PrevForm.Timer1.Enabled:=True;
 repeat
  Application.ProcessMessages;
 until not PrevForm.Timer1.Enabled;
end;

Procedure PaintChar(Code: Byte; x, y: Integer; Colour: TColor);
var a, b, c, e: Integer;
begin
 ImgBuffer.Canvas.Pen.Color:=Colour;
 With LFont.LChar[Code] do
  For a:=0 to Height-1 do begin
   c:=0;
   e:=x+OffsetX;
   For b:=0 to Data[a].LCount-1 do begin
    If c=1 then begin
     ImgBuffer.Canvas.MoveTo(e,a+y+OffsetY);
     ImgBuffer.Canvas.LineTo(e+Data[a].Lines[b],a+y+OffsetY);
     c:=0;
    end
    else c:=1;
    Inc(e,Data[a].Lines[b]);
   end;
  end;
end;

procedure UpdateImage;
begin
 With PrevForm do begin
  pbPrev.Canvas.CopyRect(Rect(0,0,pbPrev.Width,pbPrev.Height),
   ImgBuffer.Canvas,Rect(0,0,ImgBuffer.Width,ImgBuffer.Height));
  If ImgBuffer.Name='Buffer1' then ImgBuffer:=Buffer2
  else ImgBuffer:=Buffer1;
 end;
end;

procedure PaintPreview;
var a, b: Integer;
    c: byte;
begin
 If (CurrentFile='') or not PrevForm.Visible then Exit;
 With PrevForm do begin
  ImgBuffer.Canvas.Brush.Color:=cBack.Selected;
  ImgBuffer.Canvas.FillRect(Rect(0,0,ImgBuffer.Width,ImgBuffer.Height));
  b:=2-sbHoriz.Position;
  for a:=1 to Length(PrevForm.eText.Text) do begin
   c:=Ord(PrevForm.eText.Text[a]);
   If ((b+LFont.LChar[c].Width>=-2) and (b<=pbPrev.Width))
   and (c<>32) and (c<>13) and (c<>10) then begin
    if cbLbaStyle.Checked then
     PaintChar(c,b+2,6,clBlack);
    PaintChar(c,b,2,cFont.Selected);
   end;
   If (c=32) or (c=13) or (c=10) then Inc(b,15) else Inc(b,LFont.LChar[c].Width+2);
  end;
  If b+2+sbHoriz.Position>pbPrev.Width then begin
   sbHoriz.Max:=b+2+sbHoriz.Position;
   sbHoriz.PageSize:=pbPrev.Width;
   sbHoriz.Enabled:=True;
  end
  else begin
   sbHoriz.Enabled:=False;
   sbHoriz.Position:=0;
  end;
 end;
 UpdateImage;
end;

procedure TPrevForm.btCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TPrevForm.FormResize(Sender: TObject);
begin
 Buffer1.Width:=pbPrev.Width;
 Buffer1.Height:=pbPrev.Height;
 Buffer1.Picture.Bitmap.Width:=pbPrev.Width;
 Buffer1.Picture.Bitmap.Height:=pbPrev.Height;
 Buffer2.Width:=pbPrev.Width;
 Buffer2.Height:=pbPrev.Height;
 Buffer2.Picture.Bitmap.Width:=pbPrev.Width;
 Buffer2.Picture.Bitmap.Height:=pbPrev.Height;
 PaintPreview;
end;

procedure TPrevForm.FormCreate(Sender: TObject);
begin
 ImgBuffer:=Buffer1;
 //PrevForm.DoubleBuffered:=True;
 Panel1.DoubleBuffered:=True;
end;

procedure TPrevForm.pbPrevPaint(Sender: TObject);
begin
 PaintPreview;
end;

procedure TPrevForm.btOptionsClick(Sender: TObject);
var a: Integer;
begin
 btOptions.Enabled:=False;
 If btOptions.Down then begin
  for a:=0 to 8 do begin
   Panel2.Top:=PanelMain.Height-a*8;
   Panel1.Top:=-a*8;
   Panel1.Refresh;
   Panel2.Refresh;
  end;
 end
 else begin
  for a:=8 downto 0 do begin
   Panel2.Top:=PanelMain.Height-a*8;
   Panel1.Top:=-a*8;
   Panel1.Refresh;
   Panel2.Refresh;
  end;
 end;
 btOptions.Enabled:=True;
end;

procedure TPrevForm.Timer1Timer(Sender: TObject);
begin
 Timer1.Enabled:=False;
end;

procedure TPrevForm.btLockBtmClick(Sender: TObject);
begin
 If btLockTop.Down or btLockBtm.Down then begin
  PrevForm.Width:=PrevForm.ClientWidth;
  PrevForm.Height:=PrevForm.ClientHeight;
  PrevForm.BorderStyle:=bsNone;
  Form1.Realign;
 end
 else begin
  PrevForm.BorderStyle:=bsSizeable;
  PrevForm.ClientWidth:=PrevForm.Width;
  PrevForm.ClientHeight:=PrevForm.Height;
 end;
end;

procedure TPrevForm.cbOnTopClick(Sender: TObject);
begin
 If cbOnTop.Checked then PrevForm.FormStyle:=fsStayOnTop
 else PrevForm.FormStyle:=fsNormal;
end;

procedure TPrevForm.eTextChange(Sender: TObject);
begin
 PaintPreview;
end;

end.
