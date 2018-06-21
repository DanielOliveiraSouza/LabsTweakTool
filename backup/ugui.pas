unit ugui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons,uproxy,uglobal,uprocessos,unetwork,unistall;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);


    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
  private




  public

  end;

var
  Form1: TForm1;
  Fnetwork : TForm3;
  FInstall :TForm4;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Image1Click(Sender: TObject);
begin
  //ShowMessage('Recurso a ser implementado');
  Fnetwork := TForm3.Create(nil) ;
  Fnetwork.ShowModal;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  //ShowMessage('Recurso a ser implementado');
  FInstall:= TForm4.Create(nil);
  FInstall.ShowModal;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  ShowMessage('Recurso a ser implementado');
end;



procedure TForm1.BitBtn1Click(Sender: TObject);
begin

end;



procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Label4Click(Sender: TObject);
begin

end;

end.

