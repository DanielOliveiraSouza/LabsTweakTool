program proxytweaktoll;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, ugui, uproxy, uglobal, uprocessos, unetwork, unistall, alterarhost,
  uppa, ulistinstall;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFProxy, FProxy);
  Application.CreateForm(TFnetwork, Fnetwork);
  Application.CreateForm(TFInstall, FInstall);
  Application.CreateForm(TFAltHost, FAltHost);
  Application.CreateForm(TFramePPA, FramePPA);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.

