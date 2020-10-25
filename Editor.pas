//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// Editor unit.
// Contains editor window and editing routines.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Editor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, ExtCtrls, Buttons, ClipBrd, Math, ActnList;

type
  TEdForm = class(TForm)
    Label2: TLabel;
    WidSE: TSpinEdit;
    Label3: TLabel;
    HeiSE: TSpinEdit;
    Label4: TLabel;
    SOfXSE: TSpinEdit;
    Label5: TLabel;
    SOfYSE: TSpinEdit;
    PenBtn: TSpeedButton;
    ClrBtn: TButton;
    FillBtn: TButton;
    SelectBtn: TSpeedButton;
    Panel1: TPanel;
    EditPB: TPaintBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CopyBtn: TBitBtn;
    PasteBtn: TBitBtn;
    Bevel1: TBevel;
    PreviewPB: TPaintBox;
    PrevBuffer: TImage;
    UndoBtn: TBitBtn;
    RedoBtn: TBitBtn;
    ActionList1: TActionList;
    aUndo: TAction;
    aRedo: TAction;
    aCopy: TAction;
    aPaste: TAction;
    procedure FormShow(Sender: TObject);
    procedure SizeChange(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditPBPaint(Sender: TObject);
    procedure ClrBtnClick(Sender: TObject);
    procedure FillBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure PasteBtnClick(Sender: TObject);
    procedure PenBtnClick(Sender: TObject);
    procedure SelectBtnClick(Sender: TObject);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PreviewPBPaint(Sender: TObject);
    procedure OffsetChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UndoBtnClick(Sender: TObject);
    procedure RedoBtnClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

  TField = array[0..49,0..49] of TColor;

const
  crPen = 20;
  MaxUndo = 30;

var
  EdForm: TEdForm;
  Drawing: Boolean = False;
  MDragging: Boolean = False;
  MBtn: TMouseButton;
  SelStart, SelEnd: TPoint;
  LastSt, LastEnd: TPoint;
  DragPos: Tpoint;
  Selected: Boolean = False;
  BuffArray: array[1..2] of TField;
  UndoArray: array[1..MaxUndo] of TField;
  RedoImage: TField;
  LastUndoState: Integer = 0;
  FirstRedo: Integer = 0;

Procedure ClearField(var Target: TField; Preview: Boolean = False);
procedure PaintPreview;

implementation

{$R *.DFM}

uses LBAFont1;

procedure SetUndo;
var a: Integer;
begin
 If LastUndoState<MaxUndo then
  Inc(LastUndoState)
 else
  for a:=1 to MaxUndo-1 do
   UndoArray[a]:=UndoArray[a+1];
 UndoArray[LastUndoState]:=CharArray;
 EdForm.aRedo.Enabled:=False;
 EdForm.aUndo.Enabled:=True;
end;

Procedure SetPos;
begin
 With EdForm do begin
  EditPB.Left:=(Panel1.Width-EditPB.Width) div 2;
  EditPB.Top:=(Panel1.Height-EditPB.Height) div 2;
 end;
end;

Procedure ClearField(var Target: TField; Preview: Boolean = False);
var a, b: Integer;
begin
 For b:=0 to 49 do
  For a:=0 to 49 do
   Target[a,b]:=clWhite;
 If Preview then PaintPreview;
end;

Procedure EnSelect;
begin
 EdForm.aCopy.Enabled:=True;
 Selected:=True;
end;

Procedure DisSelect;
begin
 EdForm.aCopy.Enabled:=False;
 Selected:=False;
end;

Function Less(V1,V2: Integer): Integer;
begin
 If V1<V2 then Result:=V1
 else Result:=V2;
end;

Function Larger(V1,V2: Integer): Integer;
begin
 If V1>V2 then Result:=V1
 else Result:=V2;
end;

Procedure DisplayPoint(X, Y: Integer);
begin
 EdForm.EditPB.Canvas.Brush.Style:=bsSolid;
 EdForm.EditPB.Canvas.Brush.Color:=CharArray[X,Y];
 EdForm.EditPB.Canvas.Pen.Color:=CharArray[X,Y];
 EdForm.EditPB.Canvas.Rectangle(X*7+1,Y*7+1,X*7+7,Y*7+7);
end;

Procedure DrawPoint(X, Y: Integer; K: TColor);
begin
 If (X>=0) and (X<=49) and (Y>=0) and (Y<=49) then begin
  CharArray[X,Y]:=K;
  DisplayPoint(X, Y);
  PaintPreview;
 end; 
end;

Procedure DisplayRegion(x1,y1,x2,y2: Integer);
var a,b: Integer;
begin
 For b:=Larger(y1,0) to Less(y2,49) do
  For a:=Larger(x1,0) to Less(x2,49) do
   DisplayPoint(a,b);
 PaintPreview;
end;

Procedure NormalizeSelection;
var a: Integer;
begin
 If SelStart.x>SelEnd.x then begin
  a:=SelEnd.x;
  SelEnd.x:=SelStart.x;
  SelStart.x:=a;
 end;
 If SelStart.y>SelEnd.y then begin
  a:=SelEnd.y;
  SelEnd.y:=SelStart.y;
  SelStart.y:=a;
 end;
end;

Procedure DrawSelection(TL, BR: TPoint; K: TColor);
begin
 EdForm.EditPB.Canvas.Pen.Color:=K;
 EdForm.EditPB.Canvas.Brush.Style:=bsClear;
 If (TL.X<=BR.X) and (TL.Y<=BR.Y) then
  EdForm.EditPB.Canvas.Rectangle(TL.X*7,TL.Y*7,BR.X*7+8,BR.Y*7+8);
 If (TL.X>BR.X) and (TL.Y<=BR.Y) then
  EdForm.EditPB.Canvas.Rectangle(TL.X*7+8,TL.Y*7,BR.X*7,BR.Y*7+8);
 If (TL.X<=BR.X) and (TL.Y>BR.Y) then
  EdForm.EditPB.Canvas.Rectangle(TL.X*7,TL.Y*7+8,BR.X*7+8,BR.Y*7);
 If (TL.X>BR.X) and (TL.Y>BR.Y) then
  EdForm.EditPB.Canvas.Rectangle(TL.X*7+8,TL.Y*7+8,BR.X*7,BR.Y*7);
end;

Procedure WriteField(var Target: TField; const x, y: Integer; Value: TColor);
begin
 If (x>=0) and (y>=0) and (x<=49) and (y<=49) then
  Target[x,y]:=Value;
end;

Function ReadField(Target: TField; x, y: Integer): TColor;
begin
 If (x>=0) and (y>=0) and (x<=49) and (y<=49) then
  Result:=Target[x,y]
 else
  Result:=clWhite;
end;   

Procedure CopyToBuff(x1,y1,x2,y2,BuffNo: Integer);
var a, b: Integer;
begin
 For b:=y1 to y2 do
  For a:=x1 to x2 do
   WriteField(BuffArray[BuffNo],a-x1,b-y1,ReadField(CharArray,a,b));
end;

Procedure PasteFromBuff(x1,y1,x2,y2,BuffNo: Integer);
var a, b: Integer;
begin
 For b:=y1 to y2 do
  For a:=x1 to x2 do
   WriteField(CharArray,a,b,ReadField(BuffArray[BuffNo],a-x1,b-y1));
end;

procedure TEdForm.FormShow(Sender: TObject);
begin
 WidSE.Value:=CharBuff.Width;
 HeiSE.Value:=CharBuff.Height;
 SOfXSE.Value:=CharBuff.OffsetX;
 SOfYSE.Value:=CharBuff.OffsetY;
 EditPB.Width:=WidSE.Value*7+1;
 EditPB.Height:=HeiSE.Value*7+1;
 SetPos;
 DisSelect;
 PenBtn.Down:=True;
 PenBtnClick(self);
 LastUndoState:=0;
 aUndo.Enabled:=False;
 aRedo.Enabled:=False;
end;

procedure TEdForm.SizeChange(Sender: TObject);
var a, b: integer;
begin
 If TryStrToInt(WidSE.Text,a) and TryStrToInt(HeiSE.Text,b)
 and (a>=0) and (a<=50) and (b>=0) and (b<=50) then begin
  If (Sender as TSpinEdit).Name='WidSE' then EditPB.Width:=a*7+1
  else EditPB.Height:=b*7+1;
  BitBtn1.Enabled := True;
  SetPos;
 end
 else BitBtn1.Enabled := False;
end;

Procedure MoveInit;
begin
 PasteFromBuff(SelStart.x,SelStart.y,SelEnd.x,SelEnd.y,2);
 DrawSelection(SelStart,SelEnd,clBtnFace);
 LastSt:=SelStart;
 LastEnd:=SelEnd;
end;

Procedure MoveEnd;
begin
 DrawSelection(SelStart,SelEnd,clRed);
 CopyToBuff(SelStart.x,SelStart.y,SelEnd.x,SelEnd.y,2);
 PasteFromBuff(SelStart.x,SelStart.y,SelEnd.x,SelEnd.y,1);
 DisplayRegion(LastSt.x,LastSt.y,LastEnd.x,LastEnd.y);
 DisplayRegion(SelStart.x,SelStart.y,SelEnd.x,SelEnd.y);
end;

procedure TEdForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var a, b: Integer;
begin
 a:=(X div 7);
 b:=(Y div 7);
 If Selected then begin
  If (((a>=SelStart.X) and (a<=SelEnd.X)) or ((a<=SelStart.X) and (a>=SelEnd.X))) and
     (((b>=SelStart.Y) and (b<=SelEnd.Y)) or ((b<=SelStart.Y) and (b>=SelEnd.Y)))
  then begin
   SetUndo;
   MDragging:=True;
   If (GetKeyState(VK_CONTROL) and -128)<>0 then
    CopyToBuff(SelStart.x,SelStart.y,SelEnd.x,SelEnd.y,2);
   DragPos:=Point(a,b);
   Exit;
  end;
  DrawSelection(SelStart,SelEnd,clBtnFace);
 end;
 Drawing:=True;
 If PenBtn.Down then begin
  SetUndo;
  MBtn:=Button;
  DrawPoint(a,b,IfThen(MBtn=mbLeft,clBlack,clWhite));
 end
 else begin
  SelStart:=Point(a,b);
  SelEnd:=SelStart;
 end;
end;

procedure TEdForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var a, b, va, vb: Integer;
begin
 a:=(X div 7);
 b:=(Y div 7);
 If (((a>=SelStart.X) and (a<=SelEnd.X)) or ((a<=SelStart.X) and (a>=SelEnd.X))) and
  (((b>=SelStart.Y) and (b<=SelEnd.Y)) or ((b<=SelStart.Y) and (b>=SelEnd.Y)))
  and (not Drawing) and Selected then Screen.Cursor:=crSizeAll
 else if PenBtn.Down then Screen.Cursor:=crPen
 else Screen.Cursor:=crArrow;
 If MDragging then begin
  MoveInit;
  va:=a-DragPos.x;
  vb:=b-DragPos.y;
  Inc(SelStart.x,va);
  Inc(SelEnd.x,va);
  Inc(SelStart.y,vb);
  Inc(SelEnd.y,vb);
  DragPos:=Point(a,b);
  MoveEnd;
 end;
 If Drawing then begin
  If PenBtn.Down then
   DrawPoint(a,b,IfThen(MBtn=mbLeft,clBlack,clWhite))
  else begin
   DrawSelection(SelStart,SelEnd,clBtnFace);
   SelEnd:=Point(a,b);
   If (SelStart.x<>SelEnd.x) or (SelStart.y<>SelEnd.y) then begin
    DrawSelection(SelStart,SelEnd,clRed);
    EnSelect;
   end
   else DisSelect;
  end;
 end;
end;

procedure TEdForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Drawing then Drawing:=False;
 If (SelStart.x=SelEnd.x) and (SelStart.y=SelEnd.y) then DisSelect;
 NormalizeSelection;
 if MDragging then MDragging:=False
 else begin
  ClearField(BuffArray[2]);
  CopyToBuff(SelStart.x,SelStart.y,SelEnd.x,SelEnd.y,1);
 end;
end;

procedure TEdForm.EditPBPaint(Sender: TObject);
begin
 DisplayRegion(0,0,WidSE.Value-1,HeiSE.Value-1);
 If Selected then DrawSelection(SelStart,SelEnd,clRed);
end;

procedure TEdForm.ClrBtnClick(Sender: TObject);
begin
 SetUndo;
 ClearField(CharArray,True);
 DisSelect;
 EditPB.Repaint;
end;

procedure TEdForm.FillBtnClick(Sender: TObject);
var a, b: Integer;
begin
 SetUndo;
 For b:=0 to 49 do
  For a:=0 to 49 do
   CharArray[a,b]:=clBlack;
 DisSelect;
 EditPB.Repaint;
end;

procedure TEdForm.CopyBtnClick(Sender: TObject);
var a, b: Integer;
    Buffer: TBitmap;
begin
 Buffer:=TBitmap.Create;
 Buffer.Height:=SelEnd.y-SelStart.y+1;
 Buffer.Width:=SelEnd.x-SelStart.x+1;
 For b:=SelStart.y to SelEnd.y do
  For a:=SelStart.x to SelEnd.x do
   Buffer.Canvas.Pixels[a-SelStart.x,b-SelStart.y]:=CharArray[a,b];
 ClipBoard.Assign(Buffer);
 Buffer.Free;
end;

procedure TEdForm.PasteBtnClick(Sender: TObject);
var a, b: Integer;
    Buffer: TBitmap;
begin
 If ClipBoard.HasFormat(CF_BITMAP) then begin
  SetUndo;
  SelectBtn.Down:=True;
  SelectBtnClick(Self);
  Buffer:=TBitmap.Create;
  Buffer.Assign(Clipboard);
  DrawSelection(SelStart,SelEnd,clSilver);
  DisSelect;
  SelStart:=Point(0,0);
  SelEnd:=Point(Less(Buffer.Width-1,49),Less(Buffer.Height-1,49));
  CopyToBuff(0,0,SelEnd.x,SelEnd.y,2);
  For b:=0 to SelEnd.y do
   For a:=0 to SelEnd.x do
    If Buffer.Canvas.Pixels[a,b]=clWhite then BuffArray[1,a,b]:=clWhite
    else BuffArray[1,a,b]:=clBlack;
  Buffer.Free;
  PasteFromBuff(0,0,SelEnd.x,SelEnd.y,1);
  EnSelect;
  EditPB.Repaint;
 end
 else
  MessageBox(EdForm.Handle,'Clipboard is empty or contains non-bitmap content.','Error',MB_OK+MB_ICONERROR);
end;

procedure TEdForm.PenBtnClick(Sender: TObject);
begin
 DrawSelection(SelStart,SelEnd,clSilver);
 DisSelect;
end;

procedure TEdForm.SelectBtnClick(Sender: TObject);
begin
 DrawSelection(SelStart,SelEnd,clSilver);
 DisSelect;
end;

procedure TEdForm.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 Screen.Cursor:=crArrow;
end;

procedure PaintPreview;
var a, b: Integer;
begin
 With EdForm.PrevBuffer do begin
  Canvas.Brush.Color:=clWhite;
  Canvas.FillRect(Bounds(0,0,Width,Height));
  For a:=0 to EdForm.WidSE.Value-1 do
   For b:=0 to EdForm.HeiSE.Value-1 do
    Canvas.Pixels[a+EdForm.SOfXSE.Value,b+EdForm.SOfYSE.Value]:=CharArray[a,b];
  EdForm.PreviewPB.Canvas.CopyRect(Rect(0,0,EdForm.PreviewPB.Width,EdForm.PreviewPB.Height),Canvas,Rect(0,0,Width,Height));
 end;
end;

procedure TEdForm.PreviewPBPaint(Sender: TObject);
begin
 PaintPreview;
end;

procedure TEdForm.OffsetChange(Sender: TObject);
var Src: TSpinEdit;
begin
 Src:=(Sender as TSpinEdit);
 If Src.Text='' then Src.Text:='0';
 If Src.Value<0 then Src.Value:=0;
 If Src.Value>50 then Src.Value:=50;
 PaintPreview;
end;

procedure TEdForm.FormCreate(Sender: TObject);
begin
 Screen.Cursors[crPen]:=LoadCursor(hInstance,'PEN');
end;

procedure TEdForm.UndoBtnClick(Sender: TObject);
begin
 If not RedoBtn.Enabled then begin
  RedoImage:=CharArray;
  FirstRedo:=LastUndoState;
 end;
 CharArray:=UndoArray[LastUndoState];
 If LastUndoState>0 then
  Dec(LastUndoState);
 If LastUndoState<1 then aUndo.Enabled:=False;
 aRedo.Enabled:=True;
 DisSelect;
 EditPB.Repaint;
end;

procedure TEdForm.RedoBtnClick(Sender: TObject);
begin
 Inc(LastUndoState);
 If LastUndoState<FirstRedo then
  CharArray:=UndoArray[LastUndoState+1]
 else begin
  CharArray:=RedoImage;
  aRedo.Enabled:=False;
 end;
 aUndo.Enabled:=True;
 DisSelect;
 EditPB.Repaint;
end;

end.
