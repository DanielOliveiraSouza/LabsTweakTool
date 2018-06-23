unit uprocessos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process,uglobal;
type
    {Class RunnableScripts }
    RunnableScripts = Class
      private
        args:TStringList;



      public
         procedure RunProcess();
         procedure RunProcessAsRoot();
         procedure RunProcessAsPoliceKit();
         constructor Create (c_args:TStringList);



  end;


implementation
procedure   RunnableScripts.RunProcess();
var

    hprocess: TProcess;
    sPass : String;
    sParameters: String;
    streamout : TStringList;
    failout: TStringList;
    i : integer;

Begin
  i := 0;
  DetectXTerm();  //função importante! Detecta o tipo de emulador de terminal
  hprocess := TProcess.Create(nil);
  hprocess.Executable := '/bin/bash';
  if ( self.args <> nil ) then begin
    while (i < (args.Count) ) do begin
      write(args[i] + ' ');
      hprocess.Parameters.Add(args[i]);
      i := i  + 1;
     end;
    writeln('');
     hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  // poNewConsole  é para terminais
     hprocess.Execute;         // Execute o comando
   // end;

      streamout:= TStringList.Create();
      failout := TStringList.Create();
      streamout.LoadFromStream(hprocess.Output);
      streamout.SaveToFile('out.txt');
      failout.LoadFromStream(hprocess.Stderr);
      failout.SaveToFile('fail.txt');
    //writeln(hprocess.ExitCode);
     Sleep(2000);
     hprocess.Free;
  end else
      Writeln('args is null');
end;
constructor RunnableScripts.Create ( c_args : TStringList);
begin
  //proc := c_proc;
  args := c_args;
end;

 {
      Procedure para executar processos com o pkexec
      PoliceKit
 }
  procedure RunnableScripts.RunProcessAsPoliceKit();
  var
      hprocess: TProcess;
      i : integer;
  begin
    writeln('Running in root mode');
    i := 0;
    DetectXTerm();
    hprocess := TProcess.Create(nil);
    hprocess.Executable := 'pkexec'; //pkexec é o processo com super poderes
    hprocess.Parameters.Add('/bin/bash');
    if ( Self.args <> nil )  then begin  //verifica se args não é nulo
          while (i < (Self.args.Count) ) do begin
              hprocess.Parameters.Add(args[i]);    //adiciona cada um dos parametros de linha de comando
              i := i  + 1;
          end;
          hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];
          hprocess.Execute;

          hprocess.Free;
    end else
        WriteLn('from from runasRoot : args is null');

  end;



  {
        Procedimento para executar o processo em root
        usando uma bridge (ponte)
  }
  procedure RunnableScripts.RunProcessAsRoot();
var
      hprocess: TProcess;
    sPass : String;
    sParameters: String;
    streamout : TStringList;
    failout: TStringList;
    i : integer;
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
   hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  // poNewConsole  é para terminais
   hprocess.Execute;         // Execute o comando
  streamout:= TStringList.Create();
  failout := TStringList.Create();
  streamout.LoadFromStream(hprocess.Output);
  streamout.SaveToFile('out.txt');
  failout.LoadFromStream(hprocess.Stderr);
  failout.SaveToFile('fail.txt');
  //writeln(hprocess.ExitCode);
   Sleep(2000);
   hprocess.Free;
end;
end.

