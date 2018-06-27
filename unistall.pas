unit unistall;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls,uprocessos,uglobal,ulistinstall,process,math, Types;

type

  { TFInstall }

  TFInstall = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
   // procedure CheckBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RunProcAsAdmin();
  private
         args : TStringList;
         str_args : string;
         procInstall : uprocessos.RunnableScripts;
         //password : string ;
         frameAnterior : Tform;
         ref_strOut,ref_strErr : TStringList ; //= nil;


  public
    procedure SingletonArgs();
    procedure setFrameAnterior(ref :Tform) ;
    procedure insertArgs(type_str : integer );
  end;

var
  FInstall: TFInstall;
  FListInstall : Tform7;

implementation

{$R *.lfm}

{ TFInstall }
procedure TFInstall.SingletonArgs();
var
  cont : integer;
begin
  cont := 0;
     Self.args := TStringList.Create() ;
     Self.args.Add(uglobal.PST_HOME + '/main-pst.sh');
  while ( cont < Self.args.Count ) do
  begin
    writeln(self.args[cont]);
    cont := cont + 1;
  end;
 // Result := Self.args;

end;

procedure TFInstall.setFrameAnterior(ref: Tform);
begin
  self.frameAnterior := ref;
  self.frameAnterior.Visible:= false;
end;

procedure TFInstall.insertArgs(type_str : integer);
begin
  writeln(Self.str_args);
  if ( type_str =  4 ) then
       Self.args.AddStrings(Self.str_args.Split(' '))
       else
         Self.args.Add(str_args);
end;

procedure TFInstall.Button1Click(Sender: TObject);
begin
   if (Self.frameAnterior <> nil )  then
        self.frameAnterior.Visible:= true;
  Self.Close;
end;

procedure TFInstall.Button2Click(Sender: TObject);
var
    hprocess: TProcess;
    i ,exitCode,exitStatus : integer;
    debug : boolean;
    CharBuffer: array [0..511] of char;
 p, ReadCount: integer;
 strExt, strTemp: string;
begin
  //sleep(2000);
 progressBar1.Position:= 0;
  //ProgressBar1.Visible := true;
  ProgressBar1.Style:=pbstMarquee;
  memo1.Lines.Clear;
   writeln('progress_bar.visible=',ProgressBar1.Visible);

  //verificar se um item válido foi selecionado
  if ( Self.RadioGroup1.ItemIndex <> -1 ) then
  begin
      Self.args := TStringList.Create() ;
      Self.args.Add(uglobal.PST_HOME + '/main-pst.sh');
      //Self.args.Add(Self.str_args);
      insertArgs(Self.RadioGroup1.ItemIndex);
     //Self.procInstall := RunnableScripts.Create(Self.args);
    // RunProcAsAdmin();
     Self.ref_strOut:=TStringList.Create;
     self.ref_strErr := TStringList.Create;
         i := 0;
  writeln('Run as bridge root');
  DetectXTerm();  //função importante! Detecta o tipo de emulador de terminal
  hprocess := TProcess.Create(nil);

  hprocess.Executable := '/bin/bash';
  hprocess.Parameters.Add(uglobal.BRIDGE_ROOT); //caminho do script bridge
  hprocess.Parameters.Add('/bin/bash');
  while (i < (args.Count) ) do begin
    write(args[i] + ' ');
    hprocess.Parameters.Add(args[i]);
    i := i  + 1;
   end;
  writeln('');
   hprocess.Options := hProcess.Options + [ poUsePipes, poNoConsole];  // poNewConsole  é para terminais
   hprocess.Execute;         // Execute o comando
 exitCode:= hprocess.ExitCode;
   exitStatus:= hprocess.ExitStatus;
   while ( hprocess.Running ) or (hprocess.Output.NumBytesAvailable > 0)  do
   begin
      if ( ProgressBar1.Position < ProgressBar1.Max ) then
               ProgressBar1.Position:= ProgressBar1.Position + 25
            else
                ProgressBar1.Position:= 0;
      if  (hprocess.Output.NumBytesAvailable > 0 ) then // while (hprocess.Output.NumBytesAvailable > 0 ) do
       begin
        ReadCount := Min(512, hprocess.Output.NumBytesAvailable); //Read up to buffer, not more
            hprocess.Output.Read(CharBuffer, ReadCount);
            strTemp:= Copy(CharBuffer, 0, ReadCount);
            write(strTemp);
            Memo1.Lines.Add(strTemp);
            // progressbar1.Smooth:=true;

       end
   end;
         // progressbar1.Position:=ProgressBar1.Max;
          hprocess.Free;

         // ProgressBar1.Visible:=false;
         ProgressBar1.Style:=pbstNormal;
   end;
  if ( Self.frameAnterior <> nil ) then
   self.frameAnterior.Visible:=true;

  Self.Close;
//
end;

procedure TFInstall.CheckBox1Change(Sender: TObject);
begin
  if (Self.CheckBox1.Checked) then
   begin
     Memo1.Visible:= true;
     //ProgressBar1.Visible:= false;
   end
   else
   begin
     Memo1.Visible:= false;
     //ProgressBar1.Visible:= true;
   end;

end;


procedure TFInstall.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   if (Self.frameAnterior <> nil )  then
        self.frameAnterior.Visible:= true;
end;

procedure TFInstall.FormCreate(Sender: TObject);
begin
  Self.Memo1.Font.Color:= cllime;
 // Self.ProgressBar1.Visible:=false;
 //:=false;
end;

procedure TFInstall.Memo1Change(Sender: TObject);
begin

end;

procedure TFInstall.ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TFInstall.RadioGroup1Click(Sender: TObject);

begin
 // Self.SingletonArgs();
 // ProgressBar1.Position:= 0;
     case    self.RadioGroup1.ItemIndex  of
       0: Self.str_args:= '--t'; // Self.sargs.add('--i-t');
       1: Self.str_args := '--i-e';//Self.args.add('--i-e');
       2: Self.str_args := '--i-cg';//Self.args.add('--i-cg');
       3: Self.str_args:='--i-redes';//Self.args.add('--i-redes');
       4:
          begin
               Self.str_args:='--i-d';
               Self.str_args:= Self.str_args + ' ' + InputBox('Install','Entre com a lista de pacotes','oracle-java8-installer') ;

               //FListInstall := TForm7.Create();
              // FListInstall.setFrameAnterior(Self);
       //
         end;
     end
end;

procedure TFInstall.RunProcAsAdmin();
//RunProcessAsPoliceKit();
  var
      hprocess: TProcess;
      i ,exitCode,exitStatus : integer;
      debug : boolean;
      CharBuffer: array [0..511] of char;
   p, ReadCount: integer;
   strExt, strTemp: string;

  begin
     i := 0;

  writeln('Run as bridge root');
  DetectXTerm();  //função importante! Detecta o tipo de emulador de terminal
  hprocess := TProcess.Create(nil);
  hprocess.Executable := '/bin/bash';
  hprocess.Parameters.Add(uglobal.BRIDGE_ROOT); //caminho do script bridge
  hprocess.Parameters.Add('/bin/bash');
  while (i < (args.Count) ) do begin
    write(args[i] + ' ');
    hprocess.Parameters.Add(args[i]);
    i := i  + 1;
   end;
  writeln('');
   hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNoConsole];  // poNewConsole  é para terminais
   hprocess.Execute;         // Execute o comando
 exitCode:= hprocess.ExitCode;
   exitStatus:= hprocess.ExitStatus;
   while ( hprocess.Running ) do
   begin
     while (hprocess.Output.NumBytesAvailable > 0 ) do
     begin
      ReadCount := Min(512, hprocess.Output.NumBytesAvailable); //Read up to buffer, not more
          hprocess.Output.Read(CharBuffer, ReadCount);
          strTemp:= Copy(CharBuffer, 0, ReadCount);
          Memo1.Lines.Add(strTemp);
         { if ( ProgressBar1.Position < 100 ) then
             ProgressBar1.Position:= ProgressBar1.Position + 1
          else
           ProgressBar1.Position:=0;
           }
     end
   end;

   //Sleep(2000);
   hprocess.Free;

end;

end.
