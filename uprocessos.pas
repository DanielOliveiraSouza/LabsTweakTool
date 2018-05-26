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
    writeln(args[i]);
    hprocess.Parameters.Add(args[i]);
    i := i  + 1;
   end;
   hprocess.Options := hProcess.Options + [poWaitOnExit, poUsePipes, poNewConsole];  //  Just what it says
   hprocess.Execute;         // Execute the command with parameters
 // end;

  streamout:= TStringList.Create();
  failout := TStringList.Create();
  streamout.LoadFromStream(hprocess.Output);
  streamout.SaveToFile('out.txt');
  failout.LoadFromStream(hprocess.Stderr);
  failout.SaveToFile('fail.txt');
  writeln(hprocess.ExitCode);
   Sleep(2000);
   hprocess.Free;
end;
constructor RunnableScripts.Create ( c_args : TStringList);
begin
  //proc := c_proc;
  args := c_args;
end;


end.

