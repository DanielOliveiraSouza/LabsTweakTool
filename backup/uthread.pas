unit uthread;
interface
{$mode objfpc}{$H+}
uses
{$ifdef unix}
  cthreads,
  cmem, // the c memory manager is on some systems much faster for multi-threading
{$endif}
  Interfaces, // this includes the LCL widgetset
  Forms ;
type
    GUIThread = class (TThread)
      private
        str_status : string;
        flag_status :boolean;
        public
        construc

    end;

implementation

end.

