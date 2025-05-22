unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Math;

type

  { TFormCalculator }

  TFormCalculator = class(TForm)
    BtnEqual: TImage;        // 🟰 Равно — посчитать результат
    BtnSquare: TImage;       // ⬛ Возведение в квадрат (x²)
    BtnClearEntry: TImage;   // 🧽 Очистить текущее число (CE)
    BtnClearAll: TImage;     // 🧼 Полная очистка (всё стереть)
    BtnBackspace: TImage;    // 🔙 Удалить последний символ

    BtnAdd: TImage;          // ➕ Сложение
    BtnSubtract: TImage;     // ➖ Вычитание
    BtnMultiply: TImage;     // ✖ Умножение
    BtnDivide: TImage;       // ➗ Целочисленное деление (div)
    BtnMod: TImage;          // % Остаток от деления (mod)
    BtnGCD: TImage;          // 🤝 НОД (наибольший общий делитель)
    BtnLCM: TImage;          // 🔗 НОК (наименьшее общее кратное)

    Display: TEdit;
    background: TImage;


    Btn0: TImage;
    Btn1: TImage;
    Btn2: TImage;
    Btn3: TImage;
    Btn4: TImage;
    Btn5: TImage;
    Btn6: TImage;
    Btn7: TImage;
    Btn8: TImage;
    Btn9: TImage;

    procedure ImageDigitClick(Sender: TObject);
    procedure OperatorClick(Sender: TObject);
    procedure BtnEqualClick(Sender: TObject);
    procedure BtnClearEntryClick(Sender: TObject);
    procedure BtnClearAllClick(Sender: TObject);
    procedure BtnBackspaceClick(Sender: TObject);
    procedure BtnSquareClick(Sender: TObject);
    procedure BtnModClick(Sender: TObject);
    procedure BtnGCDClick(Sender: TObject);
    procedure BtnLCMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    Operand1, Operand2: Integer;
    CurrentOperator: String;
    OperatorClicked: Boolean;
  public
  end;

var
  FormCalculator: TFormCalculator;

function GCD(a, b: Integer): Integer;

implementation

{$R *.lfm}

function GCD(a, b: Integer): Integer;
begin
  while b <> 0 do
  begin
    Result := b;
    b := a mod b;
    a := Result;
  end;
  Result := a;
end;


procedure TFormCalculator.ImageDigitClick(Sender: TObject);
var
  digit: String;
begin
  if Sender = Btn0 then digit := '0'
  else if Sender = Btn1 then digit := '1'
  else if Sender = Btn2 then digit := '2'
  else if Sender = Btn3 then digit := '3'
  else if Sender = Btn4 then digit := '4'
  else if Sender = Btn5 then digit := '5'
  else if Sender = Btn6 then digit := '6'
  else if Sender = Btn7 then digit := '7'
  else if Sender = Btn8 then digit := '8'
  else if Sender = Btn9 then digit := '9'
  else Exit;

  if OperatorClicked then
  begin
    Display.Text := '';
    OperatorClicked := False;
  end;

  Display.Text := Display.Text + digit;
end;

procedure TFormCalculator.OperatorClick(Sender: TObject);
begin
  if (Sender = BtnSubtract) and (Display.Text = '') then
  begin
    Display.Text := '-';
    Exit;
  end;

  if Display.Text <> '' then
  begin
    try
      Operand1 := StrToInt(Display.Text);
      if Sender = BtnAdd then
        CurrentOperator := '+'
      else if Sender = BtnSubtract then
        CurrentOperator := '-'
      else if Sender = BtnMultiply then
        CurrentOperator := '*'
      else if Sender = BtnDivide then
        CurrentOperator := 'div'
      else
        Exit;
      OperatorClicked := True;
    except
      on E: Exception do
        ShowMessage('Неверное число');
    end;
  end;
end;

procedure TFormCalculator.BtnEqualClick(Sender: TObject);
begin
  if Display.Text <> '' then
  begin
    try
      Operand2 := StrToInt(Display.Text);
      case CurrentOperator of
        '+': Display.Text := IntToStr(Operand1 + Operand2);
        '-': Display.Text := IntToStr(Operand1 - Operand2);
        '*': Display.Text := IntToStr(Operand1 * Operand2);
        'div':
          begin
            if Operand2 = 0 then
            begin
              ShowMessage('Деление на ноль запрещено!');
              Exit;
            end;
            Display.Text := IntToStr(Operand1 div Operand2);
          end;
        'mod': Display.Text := IntToStr(Operand1 mod Operand2);
        'gcd': Display.Text := IntToStr(GCD(Operand1, Operand2));
        'lcm': Display.Text := IntToStr(LCM(Operand1, Operand2));
      end;
      OperatorClicked := True;
    except
      on E: Exception do
        ShowMessage('Ошибка вычисления');
    end;
  end;
end;

procedure TFormCalculator.BtnClearEntryClick(Sender: TObject);
begin
  Display.Clear;
end;

procedure TFormCalculator.BtnClearAllClick(Sender: TObject);
begin
  Display.Clear;
  Operand1 := 0;
  Operand2 := 0;
  CurrentOperator := '';
  OperatorClicked := False;
end;

procedure TFormCalculator.BtnBackspaceClick(Sender: TObject);
var
  s: String;
begin
  s := Display.Text;
  if Length(s) > 0 then
    Delete(s, Length(s), 1);
  Display.Text := s;
end;

procedure TFormCalculator.BtnSquareClick(Sender: TObject);
var
  num: Integer;
begin
  if Display.Text = '' then Exit;
  try
    num := StrToInt(Display.Text);
    Display.Text := IntToStr(Sqr(num));
  except
    on E: Exception do
      ShowMessage('Неверное число');
  end;
end;

procedure TFormCalculator.BtnModClick(Sender: TObject);
begin
  if Display.Text <> '' then
  begin
    Operand1 := StrToInt(Display.Text);
    CurrentOperator := 'mod';
    OperatorClicked := True;
  end;
end;

procedure TFormCalculator.BtnGCDClick(Sender: TObject);
begin
  if Display.Text <> '' then
  begin
    Operand1 := StrToInt(Display.Text);
    CurrentOperator := 'gcd';
    OperatorClicked := True;
  end;
end;

procedure TFormCalculator.BtnLCMClick(Sender: TObject);
begin
  if Display.Text <> '' then
  begin
    Operand1 := StrToInt(Display.Text);
    CurrentOperator := 'lcm';
    OperatorClicked := True;
  end;
end;

procedure TFormCalculator.FormCreate(Sender: TObject);
begin
  Operand1 := 0;
  Operand2 := 0;
  CurrentOperator := '';
  OperatorClicked := False;
  Display.Text := '';
  Scaled := False;
  BorderStyle := bsSingle;
end;

end.

