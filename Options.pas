//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// Options unit.
// Contains routines used for saving and reading program options.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, IniFiles, Registry;

type
  TOptForm = class(TForm)
    AO: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    EM: TCheckBox;
    StaticText1: TStaticText;
    SN: TCheckBox;
    SE: TCheckBox;
    cbAssociate: TCheckBox;
    procedure AOClick(Sender: TObject);
    procedure EMClick(Sender: TObject);
    procedure SEClick(Sender: TObject);
    procedure cbAssociateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OptForm: TOptForm;

procedure SetAssociation;
Procedure SaveOptions;
Procedure LoadOptions;

implementation

uses LBAFont1, Preview;

{$R *.dfm}

procedure TOptForm.AOClick(Sender: TObject);
begin
 PaintChars;
 Form1.CharPB.Repaint;
end;

procedure TOptForm.EMClick(Sender: TObject);
begin
 SE.Enabled:=EM.Checked;
 Form1.CharPB.Repaint;
end;

procedure TOptForm.SEClick(Sender: TObject);
begin
 Form1.CharPB.Repaint;
end;

procedure SetAssociation;
var Rejestr: TRegIniFile;
begin
 Rejestr:=TRegIniFile.Create('');
 Rejestr.RootKey:=HKEY_CLASSES_ROOT;
 If OptForm.cbAssociate.Checked then begin
  Rejestr.WriteString('.lfn','','LBA_font');
  Rejestr.WriteString('LBA_font','','LBA Font file');
  Rejestr.WriteString('LBA_font','Created by','LBA Font Editor');
  Rejestr.WriteString('LBA_font\DefaultIcon','',Application.ExeName+',1');
  Rejestr.WriteString('LBA_font\shell','','open');
  Rejestr.WriteString('LBA_font\shell\open\command','','"'+Application.ExeName+'" "%1"');
 end
 else begin
  If Rejestr.ReadString('LBA_font','Created by','')='LBA Font Editor'
  then begin
   Rejestr.EraseSection('.lfn');
   Rejestr.EraseSection('LBA_font');
  end;
 end;
 Rejestr.Destroy;
end;

Procedure SaveOptions;
var f: TIniFile;
begin
 f:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'LbaFont.ini');
 With f do begin
  WriteBool('General','ShowNumbers',OptForm.SN.Checked);
  WriteBool('General','Associate',OptForm.cbAssociate.Checked);
  WriteBool('Preview','RememberSet',PrevForm.cbRemSet.Checked);
  WriteBool('Preview','LbaStyle',PrevForm.cbLbaStyle.Checked);
  WriteInteger('Preview','FontColour',PrevForm.cFont.ItemIndex);
  WriteInteger('Preview','BackColour',PrevForm.cBack.ItemIndex);
  WriteBool('Preview','StayOnTop',PrevForm.cbOnTop.Checked);
 end;
 f.Destroy;
end;

Procedure LoadOptions;
var f: TIniFile;
begin
 f:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'LbaFont.ini');
 With f do begin
  OptForm.SN.Checked:=ReadBool('General','ShowNumbers',True);
  OptForm.cbAssociate.Checked:=ReadBool('General','Associate',False);
  PrevForm.cbRemSet.Checked:=ReadBool('Preview','RememberSet',False);
  If PrevForm.cbRemSet.Checked then begin
   PrevForm.cbLbaStyle.Checked:=ReadBool('Preview','LbaStyle',False);
   PrevForm.cFont.ItemIndex:=ReadInteger('Preview','FontColour',0);
   PrevForm.cBack.ItemIndex:=ReadInteger('Preview','BackColour',15);
   PrevForm.cbOnTop.Checked:=ReadBool('Preview','StayOnTop',False);
   PrevForm.cbOnTopClick(Form1);
  end;
 end;
 f.Destroy;
 SetAssociation;
end;

procedure TOptForm.cbAssociateClick(Sender: TObject);
begin
 SetAssociation;
end;

end.
