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
    //writeln('TForm3.CheckRadio1Click event dispareted');
    if RadioGroup1.ItemIndex = 0  then  begin
       uglobal.flag_proxy:= true;
       Self.commandlinestring :='--ativa_proxy';
        //   writeln('args=',SELF.commandlinestring);
    end
    else begin
      uglobal.flag_proxy:= false;
      Self.commandlinestring :='--desat_proxy' ;
          //writeln('args=',SELF.commandlinestring);
    end;

  end;

procedure TForm3.FormCreate(Sender: TObject);
begin
end;

  procedure TForm3.StaticText1Click(Sender: TObject);
  begin

  end;

  procedure TForm3.CheckBox1Change(Sender: TObject);
  begin
   // writeln(Checkbox1.Checked);
  //  Self.RadioGroup1.ItemIndex:= -1;
    if CheckBox1.Checked =true
    then
       uglobal.flag_root:= true
    else
        uglobal.flag_root:= false;
  end;
  procedure TForm3.Button2Click(Sender: TObject);
  begin
    ///commandlinestring:= '';
    if ( Self.RadioGroup1.ItemIndex <> -1 )  then begin
        //  writeln(' From Tform3.Ok,flag root = ',uglobal.flag_root);
          args := TstringList.Create();
          //writeln('from bottuon2 cmd_line=',commandlinestring);
          args.Add('/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh');
          args.Add(commandlinestring);
          pst_call := RunnableScripts.Create(args);
          if ( uglobal.flag_root = false ) then
             pst_call.RunProcess()
          else begin
            //  pst_call.RunProcessAsPoliceKit();
                pst_call.RunProcessAsRoot();
             uglobal.flag_root:= false;
         end;
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

