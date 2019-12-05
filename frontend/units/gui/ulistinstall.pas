unit ulistinstall;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls,uprocessos, Types;

type

  { TFprogress }

  TFprogress = class(TForm)
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
   // function getListInstall(Sender: TObject) : string ;
    procedure Label2Click(Sender: TObject);
    procedure ProgressBar1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    frameAnterior : Tform;
   // str_args : string;
    refprocInstall : RunnableScripts;

  public
    procedure setFrameAnterior(ref : Tform ) ;
    procedure setRefprocInstall(ref_proc : RunnableScripts);

  end;

var
  Fprogress: TFprogress;

implementation

{$R *.lfm}

{ TFprogress }

procedure TFprogress.FormCreate(Sender: TObject);
begin
     //ProgressBar1.Visible:= false;
  if ( Self.refprocInstall <> nil )  then  begin
     writeln('not is null new process');
     Self.refprocInstall.RunProcessAsRoot();
  end else writeln('is null process');
  if ( self.frameAnterior <> nil ) then
     Self.frameAnterior.Visible:= true;
  Self.Close;
end;

procedure TFprogress.Label2Click(Sender: TObject);
begin

end;

procedure TFprogress.ProgressBar1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TFprogress.Button1Click(Sender: TObject);    //botão cancelar
begin
       if ( Self.frameAnterior <> nil ) then
          Self.frameAnterior.Visible:=true;
       Self.close;
end;

procedure TFprogress.Button2Click(Sender: TObject);
begin
 if ( Self.refprocInstall <> nil )  then  begin
     writeln('not is null new process');
     Self.refprocInstall.RunProcessAsRoot();
  end else writeln('is null process');
  if ( self.frameAnterior <> nil ) then
     Self.frameAnterior.Visible:= true;
  Self.Close;
end;

procedure TFprogress.Edit1Change(Sender: TObject);
begin

end;

procedure TFprogress.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ( Self.frameAnterior <> nil ) then
          Self.frameAnterior.Visible:=true;
end;

procedure TFprogress.setFrameAnterior(ref: Tform);
begin
  Self.frameAnterior := ref;
  if ( Self.frameAnterior <> nil ) then
     Self.frameAnterior.Visible:= false;
end;

procedure TFprogress.setRefprocInstall(ref_proc: RunnableScripts);
begin
  Self.refprocInstall := ref_proc;
end;

end.

