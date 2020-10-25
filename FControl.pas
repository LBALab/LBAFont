//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// FControl unit.
// Contains file opening/saving routines.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit FControl;

interface

Uses Dialogs, Windows, SysUtils, Forms, Controls;

type
  TCharImage = Record
   Height, Width: Byte;
   OffsetX, OffsetY: Byte;
   Data: array of Record
    LCount: Byte;
    Lines: array of Byte;
   end;
  end;

const CharCount: Integer = 256;

var
  LFont: Record
   FileLen: DWord;
   CharOffset: array[0..255] of DWord;
   LChar: array[0..255] of TCharImage;
  end;

  CurrentFile: String;

procedure OpenFile(path: String);
procedure SaveFile(path: String);
Procedure CheckFileSave;

implementation

uses LBAFont1, Preview;

procedure OpenFile(path: String);
var f: File;
var a, b, c: Integer;
begin
 AssignFile(f,path);
 Reset(f,1);
 With LFont do begin
  For a:=0 to 255 do
   BlockRead(f,CharOffset[a],4);
  BlockRead(f,FileLen,4);
  For a:=0 to 255 do begin
   BlockRead(f,LChar[a].Width,1);
   BlockRead(f,LChar[a].Height,1);
   BlockRead(f,LChar[a].OffsetX,1);
   BlockRead(f,LChar[a].OffsetY,1);
   SetLength(LChar[a].Data,LChar[a].Height);
   For b:=0 to LChar[a].Height-1 do begin
    BlockRead(f,LChar[a].Data[b].LCount,1);
    SetLength(LChar[a].Data[b].Lines,LChar[a].Data[b].LCount);
    For c:=0 to LChar[a].Data[b].LCount-1 do
     BlockRead(f,LChar[a].Data[b].Lines[c],1);
   end;
  end;
  CloseFile(f);
  Form1.CharScr.Max:=1600;
  Form1.CharScr.PageSize:=Form1.CharPB.Height+1;
  Form1.CharScr.Position:=0;
  Form1.CharScr.Enabled:=True;
  Form1.aEdit.Enabled:=True;
  Form1.CharPB.Visible:=True;
  PaintChars;
  ShowChars(0);
  UpdatePanels;
 end;
 Form1.Label1.Hide;
 Form1.Caption:='LBA Font Editor - '+ExtractFileName(Path);
 Form1.aSave.Enabled:=True;
 Form1.aSaveAs.Enabled:=True;
 Form1.aReload.Enabled:=True;
 Form1.aPreview.Enabled:=True;
 Form1.Panel1.Visible:=False;
 PaintPreview;
 CurrentFile:=Path;
 Beep;
end;

Procedure CalcOffsets;
var a, b: Byte;
    Off: DWord;
begin
 Off:=1028;
 For a:=0 to 255 do begin
  LFont.CharOffset[a]:=Off;
  Inc(Off,4);
  For b:=0 to Length(LFont.LChar[a].Data)-1 do
   Inc(Off,LFont.LChar[a].Data[b].LCount+1);
 end;
 LFont.FileLen:=Off;
end;

procedure SaveFile(path: String);
var a, b, c: Integer;
    F1: File;
begin
 Screen.Cursor:=crHourGlass;
 CalcOffsets;
 AssignFile(F1,path);
 Rewrite(F1,1);
 With LFont do begin
  For a:=0 to 255 do
   BlockWrite(F1,CharOffset[a],4);
  BlockWrite(F1,FileLen,4);
  For a:=0 to 255 do begin
   BlockWrite(F1,LChar[a].Width,1);
   BlockWrite(F1,LChar[a].Height,1);
   BlockWrite(F1,LChar[a].OffsetX,1);
   BlockWrite(F1,LChar[a].OffsetY,1);
   For b:=0 to LChar[a].Height-1 do begin
    BlockWrite(F1,LChar[a].Data[b].LCount,1);
    For c:=0 to LChar[a].Data[b].LCount-1 do
     BlockWrite(F1,LChar[a].Data[b].Lines[c],1);
   end;
  end;
  CloseFile(F1);
 end;
 Screen.Cursor:=crArrow;
 Form1.label1.Hide;
 Form1.Caption:='LBA Font Editor - '+ExtractFileName(Path);
 CurrentFile:=Path;
 Beep;
end;

Procedure CheckFileSave;
begin
 If Form1.Label1.Visible then
  Case MessageBox(Form1.Handle,'The file has been modified. Do you want to save changes?','LBA Font Editor',MB_ICONQUESTION+MB_YESNOCANCEL)
  of
   IDYES:Form1.aSave.Execute;
   IDCANCEL:Abort;
  end;
end;

end.
