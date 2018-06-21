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
   hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  //  Just what it says
   hprocess.Execute;         // Execute the command with parameters
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
 {
      Procedure para executar processos com o pkexec
      PoliceKit
 }
procedure RunnableScripts.RunProcessAsPoliceKit();
var
      hprocess: TProcess;
    //sPass : String;
    //sParameters: String;
    //streamout : TStringList;
   // failout: TStringList;
    i : integer;
begin
    i := 0;
  DetectXTerm();
  hprocess := TProcess.Create(nil);
  hprocess.Executable := 'pkexec';
 //hprocess.Parameters.Add('env DISPLAY=:0');
 //hprocess.Parameters.Add('XAUTHORITY=/home/danny/.Xauthority');
  hprocess.Parameters.Add('/bin/bash');
 // Sleep(2000);
//writeln(args.Count);
  if ( Self.args <> nil )  then begin
        while (i < (Self.args.Count) ) do begin
        // write(Self.args[i] + ' ');
        // Writeln(args[i]);
        hprocess.Parameters.Add(args[i]);
        i := i  + 1;
        end;
        // writeln('');
        hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  //  Just what it says
        // hprocess.Input.WriteBuffer(password[1],Length(password));
        hprocess.Execute;         // Execute the command with parameters

        //writeln('Writing buffering password');


        // end;

        // streamout:= TStringList.Create();
        //failout := TStringList.Create();
        //streamout.LoadFromStream(hprocess.Output);
        //streamout.SaveToFile('out.txt');
        //failout.LoadFromStream(hprocess.Stderr);
        //failout.SaveToFile('fail.txt');
        //writeln(hprocess.ExitCode);
        // Sleep(5000);
        hprocess.Free;
  end else
      WriteLn('from from runasRoot : args is null');
//end;
  end;
end.

