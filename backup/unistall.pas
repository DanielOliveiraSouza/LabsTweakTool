unit unistall;

{$mode objfpc}{$H+}

interface

uses
  Interfaces,Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, ComCtrls,uprocessos,uglobal,ulistinstall,process,math, Types;


type

 { GUIThread
 Referencia:
 http://edgarpavao.com/2017/08/07/multithreading-e-processamento-paralelo-no-delphi-ppl/
 }

 GUIThread = class (TThread)
  private
    str_msg: string ;
//    proc : RunnableScripts;

      ref_outproc : Tmemo;
      ref_progressbar : TProgressBar;
      ref_proc: TProcess;
      args: TStringList;
      StrTemp:string;
    public
      Constructor Create(mymemo : tmemo;  cargs :TStringList;loadbar:TProgressBar); reintroduce;
      procedure Sincronize();
      procedure SinFim();
      procedure Execute; override;
    end;

  { TFInstall }

  type TFInstall = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    ProgressBar1: TProgressBar;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
//    procedure CheckBox1Change(Sender: TObject);
   // procedure CheckBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
         args : TStringList;
         str_args : string;
         procInstall : RunnableScripts;
         //password : string ;
         frameAnterior : Tform;
         framePosterior : Tform;
         ref_strOut,ref_strErr : TStringList ; //= nil;
         MeuProcesso : GUIThread;


  public
    procedure setFrameAnterior(ref :Tform) ;
    procedure insertArgs(type_str : integer );
    procedure updateProgressBar();
    procedure ExecutarDepoisThead(Sender :TObject);

  end;
  { GUIThread }


var
  FInstall: TFInstall;
  //flag_stop : boolean = false;
  flag_stop: boolean = true;
  mthread :GUIThread;

 // FListInstall : Tform7;

implementation



{$R *.lfm}

{ GUIThread }

{procedure GUIThread.Execute;
begin
  while not Terminated do
  begin
       if (guiform.framePosterior.visible = false ) then
            guiform.framePosterior.Visible:=true;
      {  if (Self.guiform.ProgressBar1.Visible = false ) then begin
             self.guiform.ProgressBar1.Visible:= true;
             Self.guiform.updateProgressBar();
             //Synchronize(self.guiform.);
        end;
             sleep(120);
                  writeln('mythread: I am running!');
//                  Synchronize(@Self.guiform.Button2Click);
       }
       {if ( flag_stop = true ) then  begin
            // writeln('mythread: I am die');
            Self.guiform.Visible:=true;
            Self.guiform.framePosterior.Visible:=false;
             exit;
        end;
        }


  end;
end; }
         //procedimento para executar o processo em paralelo com  a GUI
procedure GUIThread.Execute;
var
  i ,exitCode,exitStatus, ReadCount : integer;
  debug : boolean;
  CharBuffer: array [0..511] of char;
begin
i:=0;
//   inherited;
  if ( flag_stop )  then;         //a thread cria um processo em grava o output em uma string
  begin
      ref_proc.Executable := '/bin/bash';
      ref_proc.Parameters.Add(uglobal.BRIDGE_ROOT); //caminho do script bridge
      ref_proc.Parameters.Add('/bin/bash');
      while (i < (args.Count) ) do begin
        write(args[i] + ' ');
        ref_proc.Parameters.Add(args[i]);
        i := i  + 1;
      end;
      writeln('');
      ref_proc.Options := ref_proc.Options + [ poUsePipes, poNoConsole];  // poNewConsole  é para terminais
      ref_proc.Execute;         // Execute o comando
      exitCode:= ref_proc.ExitCode;
      exitStatus:= ref_proc.ExitStatus;
      while ( ref_proc.Running ) or (ref_proc.Output.NumBytesAvailable > 0)  do
      begin
        if  (ref_proc.Output.NumBytesAvailable > 0 ) then // while (ref_proc.Output.NumBytesAvailable > 0 ) do
        begin
          ReadCount := Min(512, ref_proc.Output.NumBytesAvailable); //Read up to buffer, not more
          ref_proc.Output.Read(CharBuffer, ReadCount);
          strTemp:= Copy(CharBuffer, 0, ReadCount);
          //strTemp:= StrTemp.Replace(sLineBreak);
          write(strTemp);
          Sleep(2);
          Self.Synchronize(@Self.Sincronize);  // sincroniza com a thread principal o estado de memo
          // Memo1.Lines.Add(strTemp);
          // progressbar1.Smooth:=true;

        end
    end;
    if (ref_proc.Running = false ) then        //verifica se o processo acabou
    {e inicia os procedimentos para encerrar  a thread }
    begin
      ref_proc.Free; //
      // StrTemp:='fim de execução';
      // OnTerminate:=Self.Synchronize(@Self.Sincronize);
      StrTemp := '----------------------------------------------------' + sLineBreak +' ... ... ... ... ... Fim da execução ... ... ... ... ... ' + sLineBreak + '---------------------------------------------------';
      Self.Synchronize(@Self.SinFim);                 //sincroniza  a msg de fim de execução com a thread principal
      //Sleep(1000);
      //owMessage('Feito!');

       flag_stop:= false ;
       Self.Synchronize(@ref_outproc.Lines.Clear);  //sincroniza a limpeza do tmemo
        Sleep(1000);     //dorme 1 segundo para o usuário perceber que o progressbar1 parou
      FInstall.Close;
      exit;
    end
  End;
end;


constructor GUIThread.Create(mymemo: tmemo; cargs: TStringList;
  loadbar: TProgressBar);
begin
  inherited Create(True);
  Self.FreeOnTerminate := True;
  self.ref_outproc := mymemo;
  self.args :=cargs;
  self.StrTemp:='';
  self.ref_progressbar:= loadbar;
  ref_proc := TProcess.create(nil);
end;
  {
  Procedimento da thread sincronizada com thread principal para  atualizar o tipo de progress bar
  e atualizar o tmemo
  }
procedure GUIThread.Sincronize();
begin
   if ( self.ref_progressbar.Visible = false ) then
     self.ref_progressbar.Visible:= true;
     if ( self.ref_progressbar.Style = pbstNormal ) then
         self.ref_progressbar.Style := pbstMarquee;

   Self.ref_outproc.Lines.Add(self.StrTemp);
end;
{
Essa função faz a sincronização final, escreve a última linha no tmemo e muda o tipo de progress bar
}
procedure GUIThread.SinFim();
begin
  ref_outproc.Lines.Add(StrTemp);
  if ( self.ref_progressbar.Style = pbstMarquee ) then
         self.ref_progressbar.Style := pbstNormal;
  Sleep(1000);
end;





{ TFInstall }


procedure TFInstall.setFrameAnterior(ref: Tform);
begin
  self.frameAnterior := ref;
  self.frameAnterior.Visible:= false;
end;

procedure TFInstall.insertArgs(type_str : integer);
begin
  writeln(Self.str_args);
  if ( type_str =  4 ) then
      // aux := TStringList.Create;
       Self.args.AddStrings(Self.str_args.Split(' '))

       else
         Self.args.Add(str_args);
end;

procedure TFInstall.updateProgressBar();
begin
  //Self.ProgressBar1 := pbstMarquee;
end;



procedure TFInstall.Button1Click(Sender: TObject);
begin
   if (Self.frameAnterior <> nil )  then
        self.frameAnterior.Visible:= true;
  Self.Close;
end;

procedure TFInstall.Button2Click(Sender: TObject);
var
    hprocess: TProcess;
    i ,exitCode,exitStatus : integer;
    debug : boolean;
    CharBuffer: array [0..511] of char;
 p, ReadCount: integer;
 strExt, strTemp: string;
begin
  if ( Self.RadioGroup1.ItemIndex <> -1 ) then
       begin
       Self.Memo1.Lines.Clear;
         self.args := TStringList.Create();
          Self.args.Add(uglobal.PST_HOME + '/main-pst.sh');
         insertArgs(RadioGroup1.ItemIndex);
         MeuProcesso:= GUIThread.Create(memo1,args,ProgressBar1);

        /// Self.MeuProcesso.OnTerminate:= @ExecutarDepoisThead;
         MeuProcesso.FreeOnTerminate := True;
         Self.MeuProcesso.Start;
        //  Self.ExecutarDepoisThead(nil);
         if ( flag_stop = false ) then
           {if ( self.frameAnterior <> nil ) then
             begin
               // Sleep(500);
                //Self.ExecutarDepoisThead();
                //ShowMessage('Terminou');

               { frameAnterior.Visible:=true;
                flag_stop :=true;
                self.close}
         //Self.MeuProcesso.OnTerminate:= ExecutarDepoisThead;
         //if ( flag_stop = false) then
             //Self.MeuProcesso.OnTerminate := MeuProcesso.syncronize();
             end;
            }

        // Fprogress.setFrameAnterior(Self);
      //  self.procInstall := RunnableScripts.Create(Self.args);
        //mthread := GUIThread.Create(false,Self);
      // startThread(Self);
      { if ( not flag_stop )  then exit;
          flag_stop :=false;
           with GUIThread.Create(false,Self) do
           FreeOnTerminate:=true;

        self.procInstall.RunProcessAsRoot();
        stopThread(sELF);}
       // Self.procInstall := RunnableScripts.Create(Self.args);
       // Fprogress.Destroy;
       //
       // Fprogress := TFprogress.Create(Self);
       //  Fprogress.setRefprocInstall(self.procInstall);
       //  Fprogress.setFrameAnterior(Self);
       //  if ( procInstall <> nil )  then
       //  Fprogress.ShowModal
       //  else ShowMessage('procinstall is null');
       end;

  //sleep(2000);
// progressBar1.Position:= 0;
  //ProgressBar1.Visible := true;
  //ProgressBar1.Style:=pbstMarquee;
 // memo1.Lines.Clear;
 //  //writeln('progress_bar.visible=',ProgressBar1.Visible);
 //
 // //verificar se um item válido foi selecionado
 // if ( Self.RadioGroup1.ItemIndex <> -1 ) then
 // begin
 //     Self.args := TStringList.Create() ;
 //     Self.args.Add(uglobal.PST_HOME + '/main-pst.sh');
 //     //Self.args.Add(Self.str_args);
 //     insertArgs(Self.RadioGroup1.ItemIndex);
 //    //Self.procInstall := RunnableScripts.Create(Self.args);
 //   // RunProcAsAdmin();
 //    Self.ref_strOut:=TStringList.Create;
 //    self.ref_strErr := TStringList.Create;
 //        i := 0;
 // writeln('Run as bridge root');
 // DetectXTerm();  //função importante! Detecta o tipo de emulador de terminal
 // hprocess := TProcess.Create(nil);
 //
 // hprocess.Executable := '/bin/bash';
 // hprocess.Parameters.Add(uglobal.BRIDGE_ROOT); //caminho do script bridge
 // hprocess.Parameters.Add('/bin/bash');
 // while (i < (args.Count) ) do begin
 //   write(args[i] + ' ');
 //   hprocess.Parameters.Add(args[i]);
 //   i := i  + 1;
 //  end;
 // writeln('');
 //  hprocess.Options := hProcess.Options + [ poUsePipes, poNoConsole];  // poNewConsole  é para terminais
 //  hprocess.Execute;         // Execute o comando
 //exitCode:= hprocess.ExitCode;
 //  exitStatus:= hprocess.ExitStatus;
 //  while ( hprocess.Running ) or (hprocess.Output.NumBytesAvailable > 0)  do
 //  begin
 //     if  (hprocess.Output.NumBytesAvailable > 0 ) then // while (hprocess.Output.NumBytesAvailable > 0 ) do
 //      begin
 //       ReadCount := Min(512, hprocess.Output.NumBytesAvailable); //Read up to buffer, not more
 //           hprocess.Output.Read(CharBuffer, ReadCount);
 //           strTemp:= Copy(CharBuffer, 0, ReadCount);
 //           write(strTemp);
 //           ///Sleep(2);
 //           Memo1.Lines.Add(strTemp);
 //           // progressbar1.Smooth:=true;
 //
 //      end
 //  end;
 //  end;
 //
   //if ( Self.frameAnterior <> nil ) then
   //self.frameAnterior.Visible:=true;
  // Self.Close;

//
end;




procedure TFInstall.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   if (Self.frameAnterior <> nil )  then
        self.frameAnterior.Visible:= true;
end;

procedure TFInstall.FormCreate(Sender: TObject);
begin
  Self.Memo1.Font.Color:= cllime;
  Self.framePosterior := Fprogress;
 // Self.ProgressBar1.Visible:=false;
 //:=false;
end;

procedure TFInstall.Label1Click(Sender: TObject);
begin

end;

procedure TFInstall.Memo1Change(Sender: TObject);
begin

end;



procedure TFInstall.RadioGroup1Click(Sender: TObject);

begin
 // Self.SingletonArgs();
 // ProgressBar1.Position:= 0;
     case    self.RadioGroup1.ItemIndex  of
       0: Self.str_args:= '--t'; // Self.sargs.add('--i-t');
       1: Self.str_args := '--i-e';//Self.args.add('--i-e');
       2: Self.str_args := '--i-cg';//Self.args.add('--i-cg');
       3: Self.str_args:='--i-redes';//Self.args.add('--i-redes');
       4:
          begin
               Self.str_args:='--i-d';
               Self.str_args:= Self.str_args + ' ' + InputBox('Install','Entre com a lista de pacotes','oracle-java8-installer') ;

               //FListInstall := TForm7.Create();
              // FListInstall.setFrameAnterior(Self);
       //
         end;
     end
end;

procedure TFInstall.ExecutarDepoisThead(Sender: TObject);
begin
  MeuProcesso.Synchronize(@MeuProcesso.SinFim);

end;

end.
