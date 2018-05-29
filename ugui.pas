unit ugui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons,uproxy,uglobal,uprocessos;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
  private
    commandlinestring:  String ;
    pst_call : uprocessos.RunnableScripts;
    args:  TstringList;



  public

  end;

var
  Form1: TForm1;
  FProxy: uproxy.TForm2;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.RadioGroup1Click(Sender: TObject);
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

procedure TForm1.StaticText1Click(Sender: TObject);
begin

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  writeln(Checkbox1.Checked);
  if CheckBox1.Checked =true
  then
     uglobal.flag_root:= true
  else
      uglobal.flag_root:= false;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

procedure TForm1.Image3Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FProxy := TForm2.Create(nil);
  FProxy.ShowModal;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ///commandlinestring:= '';

  args := TstringList.Create();
  args.Add('/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh');
  args.Add(commandlinestring);
  pst_call := RunnableScripts.Create(args);
  pst_call.RunProcess();





end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Label4Click(Sender: TObject);
begin

end;

end.

