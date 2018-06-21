unit unistall;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,uprocessos;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
         args : TStringList;
         str_args : string;
         procInstall : uprocessos.RunnableScripts;
         password : string ;

  public
    procedure SingletonArgs();
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }
procedure TForm4.SingletonArgs();
var
  cont : integer;
begin
  cont := 0;
     Self.args := TStringList.Create() ;
     Self.args.Add('/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh');
  while ( cont < Self.args.Count ) do
  begin
    writeln(self.args[cont]);
    cont := cont + 1;
  end;
 // Result := Self.args;

end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Self.args := TStringList.Create() ;
  Self.args.Add('/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh');
  Self.args.Add(Self.str_args);
  Self.procInstall := RunnableScripts.Create(Self.args);
 // Self.password :=   PasswordBox('password','Ente com  a senha de root');
 // Writeln(Self.password + 'endMsg unistall');
  //Self.procInstall.RunProcessAsRoot(Self.password);
  Self.procInstall.RunProcessAsPoliceKit();

end;

procedure TForm4.RadioGroup1Click(Sender: TObject);
begin
 // Self.SingletonArgs();
     case    self.RadioGroup1.ItemIndex  of
     0: Self.str_args:= '--t'; // Self.sargs.add('--i-t');
     1: Self.str_args := '--i-e';//Self.args.add('--i-e');
     2: Self.str_args := '--i-cg';//Self.args.add('--i-cg');
     3: Self.str_args:='--i-redes';//Self.args.add('--i-redes');
     end
end;
end.
