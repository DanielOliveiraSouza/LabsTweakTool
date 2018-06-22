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
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);


    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
  private




  public

  end;

var
  Form1: TForm1;
  Fnetwork : TForm3;
  FInstall :TForm4;
  TesteProc : uprocessos.RunnableScripts;
  cargs: TstringList;



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
var
  args : TStringList;
begin
  //ShowMessage('Recurso a ser implementado');
  ShowMessage(uglobal.VERSION);

end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  TesteProc:=;
end;

procedure TForm1.Image5Click(Sender: TObject);
begin

end;

procedure TForm1.Image6Click(Sender: TObject);
begin

end;



procedure TForm1.BitBtn1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;



procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.Label3Click(Sender: TObject);
begin

end;

procedure TForm1.Label4Click(Sender: TObject);
begin

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

procedure TForm1.Label6Click(Sender: TObject);
begin

end;

procedure TForm1.Label7Click(Sender: TObject);
begin

end;

procedure TForm1.Label8Click(Sender: TObject);
begin

end;

procedure TForm1.Label9Click(Sender: TObject);
begin

end;

end.

