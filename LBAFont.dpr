//******************************************************************************
// LBA Font Editor - editing lfn (font) files from Little Big Adventure 1 & 2
//
// This is the main program file.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
//
// This source code is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This source code is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License (License.txt) for more details.
//******************************************************************************

program LBAFont;

uses
  Forms,
  SysUtils,
  LBAFont1 in 'LBAFont1.pas' {Form1},
  Editor in 'Editor.pas' {EdForm},
  HelpForm in 'HelpForm.pas' {HelpF},
  FControl in 'FControl.pas',
  Options in 'Options.pas' {OptForm},
  Preview in 'Preview.pas' {PrevForm},
  CompMods in '..\libs\CompMods.pas';

{$R *.RES}
{$R Icon.res}
{$R Cursor.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TEdForm, EdForm);
  Application.CreateForm(THelpF, HelpF);
  Application.CreateForm(TOptForm, OptForm);
  Application.CreateForm(TPrevForm, PrevForm);
  Form1.OpDlg.InitialDir:=ExtractFilePath(Application.ExeName);
  Form1.SvDlg.InitialDir:=ExtractFilePath(Application.ExeName);

  LoadOptions;

  If ParamCount>0 then
   If FileExists(ParamStr(1)) then
    OpenFile(ParamStr(1));

  UpdateComponents;
  Application.Run;
end.
