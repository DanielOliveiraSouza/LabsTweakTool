unit ulistinstall.pas;

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
    procedure FormCreate(Sender: TObject);
  private
    frameAnterior : Tform;

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

procedure TForm7.setFrameAnterior(ref: Tform);
begin
  Self.frameAnterior := ref;
  if ( Self.frameAnterior <> nil ) then
     Self.frameAnterior.Visible:= false;
end;

end.

