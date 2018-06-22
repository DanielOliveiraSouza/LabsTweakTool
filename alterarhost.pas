unit alterarhost;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, uprocessos, uglobal;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    EditHost: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

   // constructor Create (form :TForm);
  private
       args: TStringList;
       althost: uprocessos.RunnableScripts;
       anterior : TForm;
       //initial_windows : ugui.Tform1;
  public
  end;

var
  Form5: TForm5;
  //initial_window : Tform1;

implementation
  //uses ugui;
{$R *.lfm}

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
begin
  //initial_windows:=TForm1.Create(nil);
  //initial_windows.ShowModal;
  //a//nterior.Visible:=True;
  Self.Close;

end;

procedure TForm5.Button2Click(Sender: TObject);
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
    Self.Close;
  end else
      ShowMessage('O host não pode ser vazio');

  //
end;

procedure TForm5.FormCreate(Sender: TObject);
begin

end;

end.

