unit uproxy;
{
Configura o arquivo  INIT_PST.sh com as informações fornecidas em parametros
	Para configurar um proxy que não necessita de autenticação, digite:
	--set_proxy IP_SERVIDOR PORTA --use_login 0

	Exemplo:
	bash main-pst.sh --set_proxy 10.0.16.1 3128 --use_login 0

	Para usar um proxy autenticado a sintaxe é :
	--set_proxy IP_SERVIDOR PORTA --use_login 1 USUARIO SENHA

	Exemplo:
	bash main-pst.sh 10.0.16.1 3128 --use_login 1 aluno alunoufmt
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, synhighlighterunixshellscript, Forms, Controls,
  Graphics, Dialogs, StdCtrls, Process, Menus, Buttons, ExtCtrls, uglobal,
  uprocessos, Math;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;

  //  memo1 : TMemo;
    //memo2: TMemo ;

    //: TMemo;
   // memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure TaskDialog1ButtonClicked(Sender: TObject;
      AModalResult: TModalResult; var ACanClose: Boolean);
    procedure ToggleBox1Change(Sender: TObject);
    procedure runProcess();
    function runProces1(path: String):String ;
   // procedure setFlagProxy(value: boolean);
  private
        // FlagProxy : boolean;
    proxyconfig : uprocessos.RunnableScripts;
    cont: integer;
    args: TStringList;
  public


  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.Label1Click(Sender: TObject);
begin

end;

procedure TForm2.CheckBox1Change(Sender: TObject);
begin
      if (Self.CheckBox1.Checked) then  begin//se o proxy é autenticado
               Self.Edit3.ReadOnly:=false;
               Self.Edit4.ReadOnly:=false;
               uglobal.flag_auth_proxy:= true;

      end
      else begin        //caso o proxy não seja autenticado
           Self.Edit3.ReadOnly:=true;
           Self.Edit4.ReadOnly:=true;
           uglobal.flag_auth_proxy:=false;
      end ;

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
     Self.cont := 0;
     args.Add(Self.Edit1.Text);
     args.Add(Self.Edit2.Text);
     if ( uglobal.flag_auth_proxy = true) then begin
              Self.args.Add('--use_login');
              self.args.Add('1');
              self.args.Add(self.Edit3.Text);
              self.args.Add(self.Edit4.Text);
     end else begin
                self.args.Add('--use_login');
                self.args.Add('0');
     end;
     //args.SaveToFile();
    // proxyconfig.Create(args);
     while  cont < Self.args.Count do begin
                write(self.args[cont] + ' ');
                cont := cont  + 1;
     end;
     writeln('');
     writeln('From uproxy: Executando em modo teste, configurações ainda não escritas');
     Self.Close();

    // proxyconfig.RunProcess();
  //self.runProcess();
  //self.runProces1('/home/danny/scripts/helena');

end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
      //verificar se a string é um IP ou HOST
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  //Verificar se a string é um numero

end;

procedure TForm2.Edit3Change(Sender: TObject);
begin
  // este é o campo de usuário, só preenche ele se o proxy for autneticado
end;

procedure TForm2.Edit4Change(Sender: TObject);
begin
  //Este é o campo de password do proxy autenticado
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
      //ao inicializar , bloquear os campos de usuário e senha
      Self.Edit3.ReadOnly:=true;
      Self.Edit4.ReadOnly:=true;
      Self.args := TStringList.Create();
      Self.args.Add('/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh');
      Self.args.Add('--set_proxy');

end;

procedure TForm2.Label2Click(Sender: TObject);
begin

end;

procedure TForm2.Label3Click(Sender: TObject);
begin

end;

procedure TForm2.Memo2Change(Sender: TObject);
begin

end;

procedure TForm2.TaskDialog1ButtonClicked(Sender: TObject;
  AModalResult: TModalResult; var ACanClose: Boolean);
begin

end;

procedure TForm2.ToggleBox1Change(Sender: TObject);
begin

end;
 Procedure TForm2.runProcess();
var

    hprocess: TProcess;
    sPass : String;
    sParameters: String;
    streamout : TStringList;
    failout: TStringList;
   // scripts : uprocessos.

Begin
     {
     DetectXTerm();
      //XTermProgram:='xterm';

      //sPass :=  '~/scripts/pst/ver-2.0-rc10/';
      //sPass := '~/scripts/pst/ver-2.0-rc10/main-pst.sh';
      sPass := '~/scripts/helena.sh';
//     Spass := 'declare;read';    ,
    //sPass :='/home/danny/Dev/IDES/Lazarus/ProxyTweakTool/try';
      //sPass := '/home/danny/scripts/helena.sh';



      //sPass := '/home/danny/scripts/pst/ver-2.0-rc10/main-pst.sh';
     // sPass :='-';
  //   sPass :='';
   hprocess := TProcess.Create(nil);
   hprocess.Executable := '/bin/bash';
  // hprocess.Parameters.Add('-c') ;
  //hprocess.Parameters.Add(QuotedStr(sPass));
   //hprocess.Parameters.Add( sPass);
//hprocess.Input.Write(sPass,Length(sPass));
// hprocess.Parameters.add('>');
 //hprocess.Parameters.Add('/home/danny/exit.txt');
 //hprocess.CommandLine:= 'ls > /home/danny/exit.txt';
// hprocess.Parameters.Add(' -c echo kkk');
  { hprocess.Parameters.add('-c');
   hprocess.Parameters.Add('echo');
   hprocess.Parameters.Add('kIKYO');
 //hprocess.Parameters.Add('Kikyou');

   }

    //https://www.freepascal.org/docs-html/fcl/process/detectxterm.html
   {if  uglobal.flag_proxy = true   then  begin
       writeln('Ativando proxy');
       hprocess.Parameters.Add('--ativa_proxy')
 //      hprocess.Parameters.Add('declare');
   end
   else begin
        writeln('Desativando proxy');
       hprocess.Parameters.Add('--desat_proxy');
   end;
    }
   hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  //  Just what it says
   hprocess.Execute;         // Execute the command with parameters
//   hprocess.);
  //Memo2.Lines.Add('hello world');
  streamout:= TStringList.Create();
  failout := TStringList.Create();
  streamout.LoadFromStream(hprocess.Output);
  streamout.SaveToFile('out.txt');
  failout.LoadFromStream(hprocess.Stderr);
  failout.SaveToFile('fail.txt');
   Memo2.Lines.LoadFromStream(hprocess.Output); // Output from command issued from above
   //Memo2.Lines.Add('hello world');
   ;
   //Memo1.Lines.LoadFromStream(hProcess.Stderr);  // Reported errors if any
   writeln(hprocess.ExitCode);
   Sleep(2000);
   hprocess.Free;                                                      // Finally we free created instance
   }
 end;
function  TForm2.runProces1(path:string ): String ;
 var
   Proc: TProcess;
   CharBuffer: array [0..511] of char;
   p, ReadCount: integer;
   strExt, strTemp: string;
begin
     DetectXTerm();
     Result:='';
    if path = '' then Exit;
    strExt:= '';
    {$IFDEF WINDOWS}
    strExt:= '.bat';
    {$ENDIF}
    try

      Proc := TProcess.Create(nil);
      Proc.Options :=  Proc.Options + [poWaitOnExit,poUsePipes,poNewConsole];
      //Proc.Options:= Proc.Options + [poWaitOnExit];
     // Proc.Parameters.Add('-v');
     // Proc.Executable:= path + 'bin' + pathDelim + 'gradle'+strExt;
     Proc.Executable:= 'bash';
     Proc.Parameters.Add(path);
      Proc.Execute();
      while (Proc.Running) or (Proc.Output.NumBytesAvailable > 0) or
        (Proc.Stderr.NumBytesAvailable > 0) do
      begin
        // read stdout and write to our stdout
         writeln('Running ...');
        while Proc.Output.NumBytesAvailable > 0 do
        begin

          ReadCount := Min(512, Proc.Output.NumBytesAvailable); //Read up to buffer, not more
          Proc.Output.Read(CharBuffer, ReadCount);
          strTemp:= Copy(CharBuffer, 0, ReadCount);
          if Pos('Gradle', strTemp) > 0 then
          begin
             Result:= Trim(strTemp);
             break;
          end;
        end;
        {
        // read stderr and write to our stderr
        while Proc.Stderr.NumBytesAvailable > 0 do
        begin
          ReadCount := Min(512, Proc.Stderr.NumBytesAvailable); //Read up to buffer, not more
          Proc.Stderr.Read(CharBuffer, ReadCount);
          Lines2.Append(Copy(CharBuffer, 0, ReadCount));
        end;
        }
        application.ProcessMessages;
        //Sleep(200);
      end;
      writeln(proc.ExitCode);
      ExitCode := Proc.ExitStatus;
    finally
      Proc.Free;

      if Result <> '' then
      begin
        p:= Pos(' ', Result);  //Gradle 3.3
        Result:= Copy(Result, p+1, MaxInt); //3.3
        //IDEMessagesWindow.AddCustomMessage(mluVerbose, 'Success!! Found Gradle version: ' + Result);
      end
      else
        //IDEMessagesWindow.AddCustomMessage(mluVerbose, 'Sorry... Fail to find Gradle version from Gradle path ...');}
        writeln('erro');

    end;
end;


end.

