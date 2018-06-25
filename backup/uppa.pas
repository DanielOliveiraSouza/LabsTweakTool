unit uppa;

	{$mode objfpc}{$H+}

	interface

	uses
	Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,uglobal,uprocessos;

	type

	{ TForm6 }

	TForm6 = class(TForm)
		Button1: TButton;
		Button2: TButton;
		Edit1: TEdit;
		Label1: TLabel;
		Label2: TLabel;
		procedure Button1Click(Sender: TObject);
		procedure Button2Click(Sender: TObject);
		procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
		procedure FormCreate(Sender: TObject);
		private
		args : TstringList;
		actAddPPa : RunnableScripts;
		frameAnterior : Tform;
		debug :TstringList;
		public
		procedure setFrameAnterior(ref : Tform);
		end;

		var
		Form6: TForm6;
		msg_str : string;
		global_cont : integer;

		implementation

		{$R *.lfm}

		{ TForm6 }

		procedure TForm6.Button2Click(Sender: TObject); // botão ok
		begin
			if (Self.Edit1.Text <> '' ) then 
			begin
				self.args := TStringList.Create;
				self.args.Add(uglobal.PST_HOME+ '/main-pst.sh');
				self.args.Add('--add_ppa');
				self.args.Add(Self.Edit1.Text);
				self.actAddPPa := RunnableScripts.Create(Self.args);
				//self.actAddPPa.RunProcessAsPoliceKit();
				Self.actAddPPa.RunProcessAsRoot();
				//Self.actAddPPa.RunProcess();
                                self.debug := actAddPPa.getStrError();
			//	Self.debug:=TStringList.Create;
			//	Self.debug.LoadFromFile('/tmp/pst.log');
				global_cont := 0;
				if ( Self.debug <> nil  ) then 
				begin
					if (Self.debug[0] <> uglobal.PST_STR_INIT_LOG ) then
					ShowMessage(Self.debug[0])
                                end;
			//var aux : StringList;
			          Self.args.Free;
				Self.actAddPPa.Free;
				if ( Self.frameAnterior <> nil ) then
				begin
					Self.frameAnterior.Visible:= true;
					Self.Close;
				end
			end else
				ShowMessage('PPA não pode ser vazio!');

		end;

		procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);  //fechar janela
		begin
			if ( Self.frameAnterior <> nil ) then    //habilita visibilidade da janela pai
				Self.frameAnterior.Visible:= true;
		end;

		procedure TForm6.FormCreate(Sender: TObject);
		begin

		end;

		procedure TForm6.Button1Click(Sender: TObject);
		begin
			if ( Self.frameAnterior <> nil ) then
				Self.frameAnterior.Visible:= true;
			Self.Close;
		end;

		procedure TForm6.setFrameAnterior(ref: Tform);
		begin
			Self.frameAnterior := ref;
			if ( Self.frameAnterior <> nil ) then
				Self.frameAnterior.Visible := false;
		end;

	end.

