unit uprocessos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process,uglobal;
type
    {Class RunnableScripts }

    { RunnableScripts }

    RunnableScripts = Class
      private
        args:TStringList;
        exitCode : integer;   //code exit program
        exitStatus : integer; // signal of system kill process, segmentation fault ...
        strError : TStringList;
        strOut: TStringList;





      public
         procedure RunProcess();
         procedure RunProcessAsRoot();
         procedure RunProcessAsRootNoConsele();
         procedure RunProcessAsPoliceKit();
         function getExitCode() : integer;
         function getExitStatus():integer;
         function getStrError(): TStringList ;
         constructor Create (c_args:TStringList);



  end;


implementation
procedure   RunnableScripts.RunProcess();
var

    hprocess: TProcess;
    i : integer;

Begin
  i := 0;
  DetectXTerm();  //função importante! Detecta o tipo de emulador de terminal
  try   //tente executar o processo

    hprocess := TProcess.Create(nil);
    hprocess.Executable := '/bin/bash';
    if ( self.args <> nil ) then begin
      while (i < (args.Count) ) do
      begin
        write(args[i] + ' ');
        hprocess.Parameters.Add(args[i]);
        i := i  + 1;
      end;
      writeln('');
      writeln('Exit CODE = ',hprocess.ExitCode,'EXIT_STATUS = ',hprocess.ExitStatus);
      hprocess.Options:= hprocess.Options + [poWaitOnExit,poUsePipes,poNoConsole];
      // hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  // poNewConsole  é para terminais
      hprocess.Execute;         // Execute o comando
      Self.exitCode:= hprocess.ExitCode;
      Self.exitStatus:= hprocess.ExitStatus;
      Self.strError := TStringList.Create;
      Self.strError.LoadFromStream(hprocess.Stderr);
      Self.strError.SaveToFile('err.txt');
      Self.strOut := TStringList.Create;
      Self.strOut.LoadFromStream(hprocess.Output);
      Self.strOut.SaveToFile('out.txt');
      writeln('Exit CODE = ',hprocess.ExitCode,'EXIT_STATUS = ',hprocess.ExitStatus);
       //Sleep(2000);
    end else
        Writeln('args is null');
  finally
    hprocess.Free;
  end;
end;
constructor RunnableScripts.Create ( c_args : TStringList);
begin
  //proc := c_proc;
  Self.args := c_args;
  Self.exitCode:= -1;
  Self.exitStatus:= -1;
  Self.strError:= nil
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
          hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNoConsole];
         // hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];
          hprocess.Execute;

          Self.exitCode:= hprocess.ExitCode;
          Self.exitStatus:= hprocess.ExitStatus;
          Self.strError := TStringList.Create;
          Self.strError.LoadFromStream(hprocess.Stderr);
          Self.strError.SaveToFile('err.txt');
          Self.strOut := TStringList.Create;
          Self.strOut.LoadFromStream(hprocess.Output);
          Self.strOut.SaveToFile('out.txt');
          hprocess.Free;
    end else
        WriteLn('from from runasRoot : args is null');

  end;

  function RunnableScripts.getExitCode(): integer;
  begin
    Result:= Self.exitCode;
  end;

  function RunnableScripts.getExitStatus(): integer;
  begin
    Result := Self.exitStatus;
  end;

  function RunnableScripts.getStrError(): TStringList;
  begin
    Result:= Self.strError;
  end;




  {
        Procedimento para executar o processo em root
        usando uma bridge (ponte)
  }
  procedure RunnableScripts.RunProcessAsRoot();
var
      hprocess: TProcess;
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
   if ( hprocess.Running = false ) then
      writeln('Terminei de executar');
   Self.exitCode:= hprocess.ExitCode;
   Self.exitStatus:= hprocess.ExitStatus;
  Self.strError := TStringList.Create;
  Self.strError.LoadFromStream(hprocess.Stderr);
  Self.strError.SaveToFile('err.txt');
  Self.strOut := TStringList.Create;
  Self.strOut.LoadFromStream(hprocess.Output);
  Self.strOut.SaveToFile('out.txt');
   hprocess.Free;
end;

  procedure RunnableScripts.RunProcessAsRootNoConsele();
 var
      hprocess: TProcess;
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
   hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNoConsole];  // poNewConsole  é para terminais
   hprocess.Execute;         // Execute o comando
   if ( hprocess.Running = false ) then
      writeln('Terminei de executar');
   Self.exitCode:= hprocess.ExitCode;
   Self.exitStatus:= hprocess.ExitStatus;
  //writeln(hprocess.ExitCode);
  //Self.str_error:= hprocess.Stderr.;
    Self.strError := TStringList.Create;
      Self.strError.LoadFromStream(hprocess.Stderr);
      Self.strError.SaveToFile('err.txt');
      Self.strOut := TStringList.Create;
      Self.strOut.LoadFromStream(hprocess.Output);
      Self.strOut.SaveToFile('out.txt');
   //Sleep(2000);
   hprocess.Free;
end;

end.

