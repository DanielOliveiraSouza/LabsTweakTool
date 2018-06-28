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
      ref_proc: TProcess;
      args: TStringList;
      StrTemp:string;
    public
      Constructor Create(mymemo : tmemo;  cargs :TStringList); reintroduce;
      procedure Sincronize();
      procedure SinFim();
      procedure Execute; override;
    end;

  { TFInstall }

  type TFInstall = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
   // procedure CheckBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
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
  //flag_run : boolean = false;
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
    if ( flag_stop )  then;
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
              Self.Synchronize(@Self.Sincronize);  //aqui sincroniza o tmemo
             // Memo1.Lines.Add(strTemp);
              // progressbar1.Smooth:=true;

         end
     end;
     if (ref_proc.Running = false ) then
     begin
     flag_stop:= false;
     ref_proc.Free;
    // StrTemp:='fim de execução';
  // OnTerminate:=Self.Synchronize(@Self.Sincronize);
  Sleep(5000);
  exit;

    end
     End;
end;


constructor GUIThread.Create(mymemo: tmemo; cargs: TStringList);
begin
  inherited Create(True);
  Self.FreeOnTerminate := True;
  self.ref_outproc := mymemo;
  self.args :=cargs;
  self.StrTemp:='';
  ref_proc := TProcess.create(nil);
end;

procedure GUIThread.Sincronize();
begin
   Self.ref_outproc.Lines.Add(self.StrTemp);
end;

procedure GUIThread.SinFim();
begin
  ref_outproc.Lines.Add('fim de execução');
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
         MeuProcesso:= GUIThread.Create(memo1,args);

        /// Self.MeuProcesso.OnTerminate:= @ExecutarDepoisThead;
         MeuProcesso.FreeOnTerminate := True;
         Self.MeuProcesso.Start;
         if ( flag_stop = false ) then
           if ( self.frameAnterior <> nil ) then
             begin
                Sleep(500);
                ShowMessage('Terminou');
                frameAnterior.Visible:=true;
                self.close
         //Self.MeuProcesso.OnTerminate:= ExecutarDepoisThead;
         //if ( flag_run = false) then
             //Self.MeuProcesso.OnTerminate := MeuProcesso.syncronize();
             end;


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

procedure TFInstall.CheckBox1Change(Sender: TObject);
begin
 { if (Self.CheckBox1.Checked) then
   begin
     Memo1.Visible:= true;
     //ProgressBar1.Visible:= false;
   end
   else
   begin
     Memo1.Visible:= false;
     //ProgressBar1.Visible:= true;
   end;
   }

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
