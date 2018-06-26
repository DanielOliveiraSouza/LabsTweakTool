unit ulistinstall;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    function getListInstall(Sender: TObject) : string ;
  private
    frameAnterior : Tform;
    str_args : string;

  public
    procedure setFrameAnterior(ref : Tform ) ;

  end;

var
  Form7: TForm7;

implementation

{$R *.lfm}

{ TForm7 }

procedure TForm7.FormCreate(Sender: TObject);
begin

end;

function TForm7.getListInstall(Sender: TObject): string;
begin
  if (  Self.Edit1.Text <> nil )  then
     begin
     Result := ' ' + Self.Edit1.Text;
     end else
         ShowMessage('O campo não pode ser nulo');
end;

procedure TForm7.Button1Click(Sender: TObject);    //botão cancelar
begin
       if ( Self.frameAnterior <> nil ) then
          Self.frameAnterior.Visible:=true;
       Self.close;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
 // Self.str_args:= self;
end;

procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if ( Self.frameAnterior <> nil ) then
          Self.frameAnterior.Visible:=true;
end;

procedure TForm7.setFrameAnterior(ref: Tform);
begin
  Self.frameAnterior := ref;
  if ( Self.frameAnterior <> nil ) then
     Self.frameAnterior.Visible:= false;
end;

end.

