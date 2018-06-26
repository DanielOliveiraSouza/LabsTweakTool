unit ugui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterIni, IDEWindowIntf, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, DbCtrls, uproxy,
  uglobal, uprocessos, unetwork, unistall, alterarhost, uppa,ulistinstall;

type

  { TFMain }

  TFMain = class(TForm)
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
    procedure DBText1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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
    procedure TaskDialog1ButtonClicked(Sender: TObject;
      AModalResult: TModalResult; var ACanClose: Boolean);
  private




  public
    //procedure initPSTErrorMsg();


  end;

var
  FMain: TFMain;
  //Fnetwork : TForm3;
//  FInstall :TForm4;
  TesteProc : uprocessos.RunnableScripts;
  cargs: TstringList;
 // FAltHost : TForm5;
 // FramePPA : TForm6;



implementation

{$R *.lfm}

{ TFMain }

procedure TFMain.Image1Click(Sender: TObject);
begin
  //ShowMessage('Recurso a ser implementado');
 // Fnetwork := TForm3.Create(Application) ;
 //FMain.Visible:= false;
 Fnetwork.setFrameAnterior(Self);
 Fnetwork.ShowModal;
  //Fnetwork.ShowModal;
end;

procedure TFMain.Image2Click(Sender: TObject);
begin
  //ShowMessage('Recurso a ser implementado');
 // FInstall:= TForm4.Create(nil);
  FInstall.setFrameAnterior(Self);
  FInstall.ShowModal;
end;

procedure TFMain.Image3Click(Sender: TObject);
var
  args : TStringList;
begin
  //ShowMessage('Recurso a ser implementado');
  ShowMessage(uglobal.VERSION);

end;

procedure TFMain.Image4Click(Sender: TObject);
begin
  //cargs := TStringList.Create;
  //cargs.Add('try.sh');
  //TesteProc:= RunnableScripts.Create(cargs);
  //TesteProc.RunProcess();
  //FAltHost := TForm5.Create(nil);
  FAltHost.SetframeAnterior(Self);
  //Self.Visible:=false;
//  Self.Show = false;
  FAltHost.ShowModal;
end;

procedure TFMain.Image5Click(Sender: TObject);
begin
  //código do ppa
 // FramePPA := TForm6.Create(nil);
  FramePPA.setFrameAnterior(Self);
  FramePPA.ShowModal;
end;

procedure TFMain.Image6Click(Sender: TObject);
var
  proc : RunnableScripts;
  strteste : string;
begin
 cargs:= TStringList.Create;
 cargs.Add('/tmp/install-java.sh');
 proc := RunnableScripts.Create(cargs);
 proc.RunProcessAsRoot();
// proc.RunProcessAsRootNoConsle();

end;



procedure TFMain.BitBtn1Click(Sender: TObject);
begin

end;

procedure TFMain.DBText1Click(Sender: TObject);
begin

end;

procedure TFMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TFMain.FormCreate(Sender: TObject);
begin

end;



procedure TFMain.Label2Click(Sender: TObject);
begin

end;

procedure TFMain.Label3Click(Sender: TObject);
begin

end;

procedure TFMain.Label4Click(Sender: TObject);
begin

end;

procedure TFMain.Label5Click(Sender: TObject);
begin

end;

procedure TFMain.Label6Click(Sender: TObject);
begin

end;

procedure TFMain.Label7Click(Sender: TObject);
begin

end;

procedure TFMain.Label8Click(Sender: TObject);
begin

end;

procedure TFMain.Label9Click(Sender: TObject);
begin

end;

procedure TFMain.TaskDialog1ButtonClicked(Sender: TObject;
  AModalResult: TModalResult; var ACanClose: Boolean);
begin

end;




end.

