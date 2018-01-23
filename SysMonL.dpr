program SysMonL;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  SysUtils,
  Windows,
  Winsock,
  Classes,
  DB,
  ADODB,
  ActiveX,
  DateUtils, forms, System.SyncObjs,
  uTConsole in 'uTConsole.pas';

procedure LWrite(Text: String; Color: Word; BreakLine: Byte);
var
   tmpColor: Word;
   sbinfo: _CONSOLE_SCREEN_BUFFER_INFO;
begin
     GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), sbinfo);
     tmpColor:= sbinfo.wAttributes;
     SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), Color);
     if Boolean(BreakLine) then WriteLn(Text) else Write(Text);
     SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), tmpColor);
end;

Procedure Help;
begin
 LWrite('================================================',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('| System monitor for home     version   0.0.1  |',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('------------------------------------------------',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('| (\(\         Programmer: konvikkor           |',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('| ( o.o)       Email:konvikkor@mail.ru         |',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('| O_(``)(``)   Date create: 23.01.2018         |',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('|              Last Update: 00.00.0000         |',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('------------------------------------------------',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
 LWrite('EXIT ',FOREGROUND_GREEN or FOREGROUND_INTENSITY,0);
 Writeln('- Exit Programm');
 LWrite('HELP ',FOREGROUND_GREEN or FOREGROUND_INTENSITY,0);
 Writeln('- Command halper');
end;

Procedure ParsCommand(Command:String);
var i:Integer; s:String;
begin
 if (Pos('HELP',UpperCase(Command)) = 1)OR
    (Pos('?',UpperCase(Command)) = 1)  then Help;
end;

var
 Cnt:Cardinal;
 Buff: array [0..100] of char;
 ConsoleText: String;
 CSection:TCriticalSection;

begin
  try
  { TODO -oUser -cConsole Main : Insert code here}
  Application.Initialize;
  CSection:=TCriticalSection.Create;
  try

  finally
   Help;
   repeat
    Write('>');
    ReadConsole(GetStdHandle(STD_INPUT_HANDLE),@Buff,100,Cnt,nil);
    ConsoleText := String(Buff);
    ParsCommand(ConsoleText);
   until UpperCase(Copy(ConsoleText,1,4)) = 'EXIT';
  end;
  {LWrite('Server Thread.....Suspend',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);
  LWrite('Close All Socket....Complite',FOREGROUND_GREEN or FOREGROUND_INTENSITY,1);}
  FreeAndNil(CSection);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
