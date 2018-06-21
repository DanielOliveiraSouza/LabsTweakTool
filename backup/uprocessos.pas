unit uprocessos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Process;
type
    {Class RunnableScripts }
    RunnableScripts = Class
      private
        args:TStringList;



      public
         procedure RunProcess();
         procedure RunProcessAsRoot(password:string);
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
  DetectXTerm();
  hprocess := TProcess.Create(nil);
  hprocess.Executable := '/bin/bash';
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
        Procedimento para executar processo em root com sudo
  }
  procedure RunnableScripts.RunProcessAsRoot(password:string);
var
      hprocess: TProcess;
    sPass : String;
    sParameters: String;
    streamout : TStringList;
    failout: TStringList;
    i : integer;
begin
    i := 0;
  DetectXTerm();
  hprocess := TProcess.Create(nil);
  hprocess.Executable := 'sudo';
  hprocess.Parameters.Add('/bin/bash');
//writeln(args.Count);
  if ( Self.args <> nil )  then begin

    while (i < (Self.args.Count) ) do begin
      write(Self.args[i] + ' ');
      Writeln(args[i]);
      hprocess.Parameters.Add(args[i]);
      i := i  + 1;
     end;
    writeln('');
     hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  //  Just what it says
     // hprocess.Input.WriteBuffer(password[1],Length(password));
     hprocess.Execute;         // Execute the command with parameters

     writeln('Writing buffering password');


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
     end
  else
      WriteLn('from from runasRoot : args is null');
//end;
  end;
end.

