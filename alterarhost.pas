unit alterarhost;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, uprocessos, uglobal;

type

  { TFAltHost }

  TFAltHost = class(TForm)
    Button1: TButton;
    Button2: TButton;
    EditHost: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

   // constructor Create (form :TForm);
  private
       args: TStringList;
       althost: uprocessos.RunnableScripts;
       frameAnterior : TForm;
       //initial_windows : ugui.Tform1;
  public
    procedure SetframeAnterior(aux :Tform);
  end;

var
  FAltHost: TFAltHost;
  //initial_window : Tform1;

implementation
  //uses ugui;
{$R *.lfm}

{ TFAltHost }

procedure TFAltHost.Button1Click(Sender: TObject);
begin
  //initial_windows:=TForm1.Create(nil);
  //initial_windows.ShowModal;
  //a//nterior.Visible:=True;
  if (Self.frameAnterior <> nil )  then
        self.frameAnterior.Visible:= true;
  Self.Close;

end;

procedure TFAltHost.Button2Click(Sender: TObject);
begin
  if ( Self.EditHost.Text <> '' ) then begin
    self.args := TStringList.Create;
    self.args.Add(uglobal.PST_HOME +'/main-pst.sh');
    self.args.Add('--at_hostname');
    self.args.Add(Self.EditHost.Text);
    self.althost:= RunnableScripts.Create(self.args);
    self.althost.RunProcessAsPoliceKit();
  // self.althost.RunProcessAsRoot();
    self.args.Free;
    self.althost.Free;
    if (self.frameAnterior <> nil ) then
       self.frameAnterior.Visible:=true;
    Self.Close;
  end else
      ShowMessage('O host não pode ser vazio');

  //
end;

procedure TFAltHost.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   if (Self.frameAnterior <> nil )  then
        self.frameAnterior.Visible:= true;
end;

procedure TFAltHost.FormCreate(Sender: TObject);
begin

end;
   procedure TFAltHost.SetframeAnterior(aux :Tform);
   begin
     self.frameAnterior := aux;
     self.frameAnterior.Visible:=false;
   end;

end.

