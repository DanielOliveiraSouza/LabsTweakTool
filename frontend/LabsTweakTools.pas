program LabsTweakTools;

{$mode objfpc}{$H+}
uses
{$ifdef unix}
  cthreads,
  cmem, // the c memory manager is on some systems much faster for multi-threading
{$endif}
  Interfaces, // this includes the LCL widget, // this includes the LCL widgetset
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
  Application.CreateForm(TFprogress, Fprogress);
  Application.Run;
end.

