//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// LBAFont1 unit.
// Main program unit. Contains all main window events.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit LBAFont1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, ExtCtrls, ComCtrls, Buttons, FControl, Editor, ShellApi,
  ActnList, ImgList, ToolWin, XPMenu;

type
  TForm1 = class(TForm)
    OpDlg: TOpenDialog;
    Bevel1: TBevel;
    CharPB: TPaintBox;
    SvDlg: TSaveDialog;
    Status: TStatusBar;
    CharScr: TScrollBar;
    BuffPB: TImage;
    ImageList1: TImageList;
    OptBtn: TButton;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Panel1: TPanel;
    Label2: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    ToolBar2: TToolBar;
    ActionList: TActionList;
    aOpen: TAction;
    aSave: TAction;
    aSaveAs: TAction;
    aReload: TAction;
    aEdit: TAction;
    aPreview: TAction;
    aHelp: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure CharPBPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CharScrChange(Sender: TObject);
    procedure CharPBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CharPBDblClick(Sender: TObject);
    procedure OptBtnClick(Sender: TObject);
    procedure FormConstrainedResize(Sender: TObject; var MinWidth,
      MinHeight, MaxWidth, MaxHeight: Integer);
    procedure CharPBMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aOpenExecute(Sender: TObject);
    procedure aSaveExecute(Sender: TObject);
    procedure aSaveAsExecute(Sender: TObject);
    procedure aReloadExecute(Sender: TObject);
    procedure aEditExecute(Sender: TObject);
    procedure aHelpExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aPreviewExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure WMDropFiles(hDrop : THandle; hWindow : HWnd);
  public
    { Public declarations }
  end;

const VerNum = '2.03+';

var
  Form1: TForm1;
  CharBuff: TCharImage;
  CharArray: TField;
  Selected: Integer = 0;
  LEMC: TPoint;
  ClearCur: Boolean;

Procedure UpdatePanels;
Procedure CharToBitmap;
Procedure BitmapToChar;
Procedure PaintChars;
Procedure ShowChars(Pos: Integer);

implementation

uses HelpForm, Options, Preview;

{$R *.DFM}

Procedure UpdatePanels;
begin
 Form1.Status.Panels[0].Text:='Char: '+IntToStr(Selected);
 Form1.Status.Panels[1].Text:='Offset: '+IntToStr(LFont.CharOffset[Selected]);
 Form1.Status.Panels[2].Text:='File size: '+IntToStr(LFont.FileLen);
end;

Procedure CharToBitmap;
var a, b, c, d, e: Integer;
begin
 ClearField(CharArray,True);
 EdForm.WidSE.Value:=CharBuff.Width;
 EdForm.HeiSE.Value:=CharBuff.Height;
 For b:=1 to CharBuff.Height do begin
  e:=0;
  c:=0;
  For a:=0 to CharBuff.Data[b-1].LCount-1 do begin
   If c=1 then begin
    For d:=0 to CharBuff.Data[b-1].Lines[a]-1 do
     CharArray[e+d,b-1]:=clBlack;
    e:=e+CharBuff.Data[b-1].Lines[a];
    c:=0;
   end
   else begin
    For d:=0 to CharBuff.Data[b-1].Lines[a]-1 do
     CharArray[e+d,b-1]:=clWhite;
    e:=e+CharBuff.Data[b-1].Lines[a];
    c:=1;
   end;
  end;
 end;
end;

Procedure BitmapToChar;
var a, b, c: Integer;
begin
 With CharBuff do begin
  Width:=EdForm.WidSE.Value;
  Height:=EdForm.HeiSE.Value;
  OffsetX:=EdForm.SOfXSE.Value;
  OffsetY:=EdForm.SOfYSE.Value;
  SetLength(Data,Height);
  For a:=0 to Height-1 do begin
   Data[a].LCount:=1;
   SetLength(Data[a].Lines,1);
   Data[a].Lines[Data[a].LCount-1]:=0;
   c:=0;
   For b:=0 to Width-1 do
    Repeat
     If c=0 then begin
      If CharArray[b,a]=clWhite then
       Inc(Data[a].Lines[Data[a].LCount-1])
      else begin
       Inc(Data[a].LCount);
       SetLength(Data[a].Lines,Data[a].LCount);
       Data[a].Lines[Data[a].LCount-1]:=0;
       c:=1;
      end;
     end else
      If CharArray[b,a]=clBlack then
       Inc(Data[a].Lines[Data[a].LCount-1])
      else begin
       Inc(Data[a].LCount);
       SetLength(Data[a].Lines,Data[a].LCount);
       Data[a].Lines[Data[a].LCount-1]:=0;
       c:=0;
      end;
    Until Data[a].Lines[Data[a].LCount-1]<>0;
  end;
 end;
end;

Procedure DrawChar(NR, X, Y: Integer; Target: TCanvas);
var a, b, c, d, e: Integer;
begin
 With LFont.LChar[NR] do begin
  For a:=0 to Height-1 do begin
   c:=0;
   e:=X+(OffsetX*Byte(OptForm.AO.Checked));
   For b:=0 to Data[a].LCount-1 do
    If c=1 then begin
     For d:=0 to Data[a].Lines[b]-1 do
      Target.Pixels[d+e,a+Y+(OffsetY*Byte(OptFOrm.AO.Checked))]:=clBlack;
     Inc(e,Data[a].Lines[b]);
     c:=0;
    end
    else begin
     Inc(e,Data[a].Lines[b]);
     c:=1;
    end;
  end;
 end;
end;

Procedure PaintChar(Nr, x, y: Integer; Target: TCanvas; Selected: Boolean);
begin
 If Selected then
  Target.Brush.Color:=clSkyBlue
 else
  Target.Brush.Color:=clWhite;
 Target.FillRect(Bounds(x,y,49,49));
 DrawChar(Nr,x,y,Target);
 If OptForm.SN.Checked then
  Target.TextOut(x+48-Target.TextWidth(IntToStr(Nr)),y+34,IntToStr(Nr));
 Target.Brush.Color:=clWhite;
end;

Procedure PaintChars;
var a, b: Integer;
begin
 With Form1 do begin
  BuffPB.Width:=400;
  BuffPB.Height:=1600;
  BuffPB.Canvas.Brush.Color:=clWhite;
  BuffPB.Canvas.Pen.Color:=clWhite;
  BuffPB.Canvas.Rectangle(0,0,BuffPB.Width,BuffPB.Height);
  BuffPB.Canvas.Pen.Color:=clBtnFace;
  For a:=0 to 8 do begin
   BuffPB.Canvas.MoveTo(a*50,0);
   BuffPB.Canvas.LineTo(a*50,1600);
  end;
  For a:=0 to 33 do begin
   BuffPB.Canvas.MoveTo(0,a*50);
   BuffPB.Canvas.LineTo(400,a*50);
  end;
  For b:=0 to 31 do
   For a:=0 to 7 do
    PaintChar(b*8+a,a*50+1,b*50+1,BuffPB.Canvas,b*8+a=Selected);
 end;
end;

Procedure ShowChars(Pos: Integer);
begin
 With Form1 do
  CharPB.Canvas.CopyRect(Rect(0,0,400,CharPB.Height),
   BuffPB.Canvas,Bounds(0,Pos,400,CharPB.Height));
 ClearCur:=False;
end;

procedure TForm1.CharPBPaint(Sender: TObject);
begin
 ShowChars(CharScr.Position);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 CharPB.Canvas.Brush.Style:=bsSolid;
 DragAcceptFiles(Form1.Handle,True);
 Application.OnMessage:=AppMessage;
 Label4.Caption:='Version: '+VerNum;
end;

procedure TForm1.WMDropFiles(hDrop : THandle; hWindow : HWnd);
var
  TotalNumberOfFiles, nFileLength: Integer;
  pszFileName: PChar;
  DropPoint: TPoint;
begin
  //liczba zrzuconych plików
  TotalNumberOfFiles:=DragQueryFile(hDrop,$FFFFFFFF,nil,0);
  If TotalNumberOfFiles=1 then begin
   nFileLength:=DragQueryFile(hDrop,0,Nil,0)+1;
   GetMem(pszFileName,nFileLength);
   DragQueryFile(hDrop,0,pszFileName,nFileLength);
   DragQueryPoint(hDrop,DropPoint);
   //pszFileName - nazwa upuszczonego pliku
   //tutaj robimy coœ z nazw¹ pliku
   try    //¿eby wykona³o siê FreeMem je¿eli bêdzie b³¹d
    CheckFileSave;
    If FileExists(pszFileName) then
     OpenFile(pszFileName)
    else
     Beep;
   except
   end;

   FreeMem(pszFileName,nFileLength);
  end
  else
   MessageBox(handle,'You can''t open more then one file at the same time','LBA Font Editor',MB_ICONERROR+MB_OK);

  DragFinish(hDrop);
end; //sprawdzamy co zosta³o przeci¹gniête i obs³ugujemy to

procedure TForm1.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
   WM_DROPFILES: WMDropFiles(Msg.wParam, Msg.hWnd);
  end;
end;

procedure TForm1.CharScrChange(Sender: TObject);
begin
 ShowChars(CharScr.Position);
end;

procedure TForm1.CharPBMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 PaintChar(Selected,(Selected mod 8)*50+1,(Selected div 8)*50+1,BuffPB.Canvas,False);
 Selected:=((Y+CharScr.Position) div 50)*8+(X div 50);
 PaintChar(Selected,(Selected mod 8)*50+1,(Selected div 8)*50+1,BuffPB.Canvas,True);
 //PaintChars;
 ShowChars(CharScr.Position);
 UpdatePanels;
end;

procedure TForm1.CharPBDblClick(Sender: TObject);
begin
 aEdit.Execute;
end;

procedure TForm1.OptBtnClick(Sender: TObject);
var a: Integer;
begin
 If OptForm.Tag=1 then begin
  AnimateWindow(OptForm.Handle,100,aw_hor_negative+aw_hide+aw_slide);
  OptBtn.Caption:='Options >';
  OptForm.Tag:=0;
 end
 else begin
  OptForm.Left:=Form1.Left+Form1.Width;
  OptForm.Top:=Form1.Top;
  AnimateWindow(OptForm.Handle,100,aw_hor_positive+aw_slide);
  OptForm.Visible:=True;
  OptBtn.Caption:='< Options';
  OptForm.Tag:=1;
 end;
end;

procedure TForm1.FormConstrainedResize(Sender: TObject; var MinWidth,
  MinHeight, MaxWidth, MaxHeight: Integer);
begin
 OptForm.Left:=Form1.Left+Form1.Width;
 OptForm.Top:=Form1.Top;
 If PrevForm.btLockTop.Down then PrevForm.Top:=Form1.Top-PrevForm.Height;
 If PrevForm.btLockBtm.Down then PrevForm.Top:=Form1.Top+Form1.Height;
 If PrevForm.btLockTop.Down or PrevForm.btLockBtm.Down then
  PrevForm.Left:=Form1.Left+(Form1.Width-PrevForm.Width) div 2;
end;

procedure TForm1.CharPBMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var a: Integer;
begin
 If OptForm.EM.Checked then begin
  CharPB.Canvas.Pen.Mode:=pmNotXor;
  If ClearCur then begin
   CharPB.Canvas.MoveTo(LEMC.X,0);
   CharPB.Canvas.LineTo(LEMC.X,CharPB.Height);
   If OptForm.SE.Checked then
    For a:=0 to CharPB.Height div 50 do begin
     CharPB.Canvas.MoveTo(0,(LEMC.Y mod 50)+a*50);
     CharPB.Canvas.LineTo(CharPB.Width,(LEMC.Y mod 50)+a*50);
    end
   else begin
    CharPB.Canvas.MoveTo(0,LEMC.Y);
    CharPB.Canvas.LineTo(CharPB.Width,LEMC.Y);
   end;
  end;
  CharPB.Canvas.MoveTo(X,0);
  CharPB.Canvas.LineTo(X,CharPB.Height);
  If OptForm.SE.Checked then
   For a:=0 to CharPB.Height div 50 do begin
    CharPB.Canvas.MoveTo(0,(Y mod 50)+a*50);
    CharPB.Canvas.LineTo(CharPB.Width,(Y mod 50)+a*50);
   end
  else begin
   CharPB.Canvas.MoveTo(0,Y);
  CharPB.Canvas.LineTo(CharPB.Width,Y);
  end;
  LEMC:=Point(X,Y);
  ClearCur:=True;
 end; 
end;

procedure TForm1.aOpenExecute(Sender: TObject);
begin
 If OpDlg.Execute then begin
  CheckFileSave;
  OpenFile(OpDlg.FileName);
 end;
end;

procedure TForm1.aSaveExecute(Sender: TObject);
begin
 SaveFile(CurrentFile);
end;

procedure TForm1.aSaveAsExecute(Sender: TObject);
begin
 If SvDlg.Execute then SaveFile(SvDlg.FileName);
end;

procedure TForm1.aReloadExecute(Sender: TObject);
begin
 If FileExists(CurrentFile) then begin
  CheckFileSave;
  OpenFile(CurrentFile);
 end;
end;

procedure TForm1.aEditExecute(Sender: TObject);
begin
 CharBuff:=LFont.LChar[Selected];
 CharToBitmap;
 EdForm.Caption:=Format('Character editor - char #%d',[Selected]);
 If EdForm.ShowModal=mrOK then begin
  BitmapToChar;
  LFont.LChar[Selected]:=CharBuff;
  PaintChars;
  CharPB.Repaint;
  PaintPreview;
  Label1.Show;
 end;
end;

procedure TForm1.aHelpExecute(Sender: TObject);
begin
 HelpF.Show;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CheckFileSave;
 SaveOptions;
end;

procedure TForm1.aPreviewExecute(Sender: TObject);
begin
 PrevForm.Show;
end;

end.
