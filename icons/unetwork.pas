unit unetwork;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,uglobal,uprocessos,uproxy;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    RadioGroup1: TRadioGroup;
     procedure FormCreate(Sender: TObject);
     procedure RadioGroup1Click(Sender: TObject);
     procedure CheckBox1Change(Sender: TObject);
     procedure StaticText1Click(Sender: TObject);
     procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
  private
    commandlinestring:  String ;
    pst_call : uprocessos.RunnableScripts;
    args:  TstringList;

  public

  end;

var
  Form3: TForm3;
  FProxy: uproxy.TForm2;

implementation
procedure TForm3.RadioGroup1Click(Sender: TObject);
  begin
    if RadioGroup1.ItemIndex = 0  then  begin
       uglobal.flag_proxy:= true;
       if uglobal.flag_root = true
       then  begin
          commandlinestring:='--ativa_global_proxy';
       end
       else begin
           commandlinestring :='--ativa_proxy';

       end;
    end
    else begin
      uglobal.flag_proxy:= false;
     // commandlinestring := '--desat1'
      if uglobal.flag_root = true then
          commandlinestring:='--desat_global_proxy'
      else
          commandlinestring :='--desat_proxy' ;
    end;

  end;

procedure TForm3.FormCreate(Sender: TObject);
begin
     RadioGroup1.ItemIndex:=1;   //inicializa o form, como opção padrão desativar
end;

  procedure TForm3.StaticText1Click(Sender: TObject);
  begin

  end;

  procedure TForm3.CheckBox1Change(Sender: TObject);
  begin
    writeln(Checkbox1.Checked);
    if CheckBox1.Checked =true
    then
       uglobal.flag_root:= true
    else
        uglobal.flag_root:= false;
  end;
  procedure TForm3.Button2Click(Sender: TObject);
  begin
    ///commandlinestring:= '';
    writeln(uglobal.flag_root);
    args := TstringList.Create();
    writeln(commandlinestring);
    args.Add('/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh');
    args.Add(commandlinestring);
    pst_call := RunnableScripts.Create(args);
    if ( uglobal.flag_root = false ) then
       pst_call.RunProcess()
    else    begin
        pst_call.RunProcessAsPoliceKit();
    //end ;
   // ShowMessage('exit proxy setting');
  // Sleep(500);
       uglobal.flag_root:= false;
    end;

    Self.Close;
  end;

  procedure TForm3.Button1Click(Sender: TObject);
  begin
   // writeln('From form 3: dvançado');
    FProxy := TForm2.Create(nil);
    FProxy.ShowModal;

  end;


{$R *.lfm}

end.

