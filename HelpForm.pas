//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// HelpForm unit.
// Contains help window and clickable link routines.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit HelpForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Tabnotbk, ShellApi, OleCtrls;

type
  THelpF = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    AdresLabel: TLabel;
    Panel3: TPanel;
    Memo1: TMemo;
    Panel4: TPanel;
    Memo2: TMemo;
    Panel5: TPanel;
    Memo3: TMemo;
    HpLabel: TLabel;
    Label4: TLabel;
    procedure AdresLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AdresLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HpLabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure HpLabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HelpF: THelpF;

implementation

uses LBAFont1;

{$R *.DFM}

procedure THelpF.AdresLabelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 AdresLabel.Font.Color:=clYellow;
 AdresLabel.Repaint;
 ShellExecute(Handle,'open','mailto:zink@poczta.onet.pl',nil,nil,SW_SHOWNORMAL);
end;

procedure THelpF.AdresLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 AdresLabel.Font.Color:=clBlue;
end;

procedure THelpF.HpLabelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 HpLabel.Font.Color:=clYellow;
 HpLabel.Repaint;
 ShellExecute(Handle,'open','www.emeraldmoon.prv.pl',nil,nil,SW_SHOWNORMAL);
end;

procedure THelpF.HpLabelMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 HpLabel.Font.Color:=clBlue;
end;

procedure THelpF.FormCreate(Sender: TObject);
begin
 Label3.Caption:='Version: '+VerNum;
end;

end.
