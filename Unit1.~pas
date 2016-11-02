unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    m: TLabel;
    p: TLabel;
    a: TLabel;
    b: TLabel;
    c: TLabel;
    d: TLabel;
    e: TLabel;
    x: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Edit2: TMaskEdit;
    Edit3: TMaskEdit;
    Edit4: TMaskEdit;
    Edit5: TMaskEdit;
    Edit6: TMaskEdit;
    Edit7: TMaskEdit;
    Edit8: TMaskEdit;
    Edit9: TMaskEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
Form1: TForm1;
numOutElemG:integer;
stepOutG:integer;
masgMax:integer;
implementation

{$R *.dfm}


//==============================================================================
//Проверка параметров анализируемой литеры
//==============================================================================
function CheckParam(adressString:string;iGraph:integer):boolean;
var
rez:boolean;
begin
  rez:=true;
  if ((ord(adressString[iGraph+1])>=48)and(ord(adressString[iGraph+1])<=57)) then
  begin
    if ((strToInt(adressString[iGraph+1])>8)or(strToInt(adressString[iGraph+1])<1))then
    begin
      rez:=false;
    end;
  end
  else
  begin
    rez:=false;
  end;
  if ((ord(adressString[iGraph+1])>=48)and(ord(adressString[iGraph+1])<=57)) then
  begin
    if strToInt(adressString[iGraph+2])>2 then
    begin
      rez:=false;
    end;
  end
  else
  begin
    rez:=false;
  end;
  result:=rez;
end;
//==============================================================================

//==============================================================================
//Анализатор адреса Орбиты
//==============================================================================
procedure AdressAnalyser(adressString:string);
var
//переданная информативность адреса
infStrInt:integer;
//Объявление для графиков
iGraph:integer;
flagM:boolean;
//переменная для хранения ASCII-кода символа
codAsciiGraph:integer;
stepKoef:integer;
//Множители для вычисления координат
Ma,Mb,Mc,Md,Me,Mx:integer; //Ma=N1-1;Mb=N2-1;Mc=N3-1; и т.д
//фазы для вычисления адреса
//Fa=8, если K=0; Fa=4, если K=1; Fa=2, если K=2; аналогично для других
Fa,Fb,Fc,Fd,Fe,Fx:integer;
//начально смещ. в массиве, зависит от П1 или П2
pBeginOffset:integer;
//numPoint:integer;
flagBegin:boolean;
stepOutGins:integer;
offset:integer;
numChOnISD:string;
numISD:string;
numBusThread:string;
adrBus:string;
numAdrInTable:string;
numAdrInBusPocket:string;
numAdrInBusPocket2:string;
//contactAdrFlag:boolean;


infNum:Integer;

isOkAdr:Boolean;
begin
  numChOnISD:='';
  numISD:='';
  numBusThread:='';
  adrBus:='';
  numAdrInTable:='';
  numAdrInBusPocket:='';
  numAdrInBusPocket2:='';
  stepOutGins:=1;
  offset:=0;
  pBeginOffset:=0;
  Fa:=0;Fb:=0;Fc:=0;Fd:=0;Fe:=0;Fx:=0;
  //numPoint:=0;
  flagM:=false;
  iGraph:=1;
  //stepKoef:=0;
  flagBegin:=false;
  //установка в 1 для сброса ошибки
  numOutElemG:=1;

  isOkAdr:=true;

  while iGraph <= length(adressString) do
  begin
    //первый символ должен быть обязательно М
    if adressString[iGraph] = 'M' then
    begin
      //М есть.
      flagM := true;
    end;

    if (
        (flagM)and
        ((adressString[iGraph + 1] = '1') and (adressString[iGraph + 2] = '6')or
         (adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '8')or
         (adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '4')or
         (adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '2')or
         (adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '1'))
       ) then
    begin

      if  ((adressString[iGraph + 1] = '1') and (adressString[iGraph + 2] = '6')) then
      begin
        //M16
        infNum:=0;
      end
      else if ((adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '8')) then
      begin
        //M08
        infNum:=1;
      end
      else if ((adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '4')) then
      begin
        //M04
        infNum:=2;
      end
      else if ((adressString[iGraph + 1] = '0') and (adressString[iGraph + 2] = '2')) then
      begin
        //M02
        infNum:=3;
      end
      else
      begin
        //M01
        infNum:=4;
      end;

      //M16
      if (adressString[iGraph + 1] = '1') and (adressString[iGraph + 2] = '6') then
      begin
        if ((adressString[iGraph + 3] = 'П') or (adressString[iGraph + 3] = 'п')) then
        begin
          if (adressString[iGraph + 4] = '1') then
          begin
            //задаем нач. смещение для выборки из массива
            pBeginOffset := 1;
            flagBegin := true;
          end;
          if (adressString[iGraph + 4] = '2') then
          begin
            //задаем нач. смещение для выборки из массива
            pBeginOffset := 2;
            flagBegin := true;
          end;
          iGraph := iGraph + 5;
          break;
        end
        else
        begin
          //halt;
          form1.Memo1.Lines.Add('Адрес не соответствует выбранной информативности');
          break;
        end;
      end
      //остальные
      else
      begin
        if ((adressString[iGraph + 3] = 'П') or (adressString[iGraph + 3] = 'п')) then
        begin
          flagBegin := false;
          break;
        end;
        //нач смещение
        pBeginOffset := 1;
        flagBegin := true;
        iGraph := iGraph + 3;
        break;
      end;
    end
    else
    begin
      break;
    end;
  end;

  if (flagBegin) then
  begin
    //обязательную часть проверили
    while (iGraph<=length(adressString)) do
    begin
      codAsciiGraph:=ord(adressString[iGraph]);
      // заполняем коэффициенты чтоб в конце посчитать номер и шаг.
      case codAsciiGraph of
        //Поиск А(а)
        65,97:
        begin
          //проверяем переданные параметры
          if not CheckParam(adressString,iGraph) then
          begin
            numOutElemG:=-1;
            break;
          end;
          Ma:=strToInt(adressString[iGraph+1]);

          case infNum of
            0:
            begin
              //M16
              if ((Ma<1)or(Ma>8)) then
              begin
                //ошибка разбора адреса. неверный адрес
                isOkAdr:=False;
                Break;
              end;
            end;
            1:
            begin
              //M08
              if ((Ma<1)or(Ma>8)) then
              begin
                //ошибка разбора адреса. неверный адрес
                isOkAdr:=False;
                Break;
              end;
            end;
            2:
            begin
              //M04
              if ((Ma<1)or(Ma>4)) then
              begin
                //ошибка разбора адреса. неверный адрес
                isOkAdr:=False;
                Break;
              end;
            end;
            3:
            begin
              //M02
              if ((Ma<1)or(Ma>2)) then
              begin
                //ошибка разбора адреса. неверный адрес
                isOkAdr:=False;
                Break;
              end;
            end;
            4:
            begin
              //M01
              if (Ma<>1) then
              begin
                //ошибка разбора адреса. неверный адрес
                isOkAdr:=False;
                Break;
              end;
            end;
          end;

          Ma :=Ma-1;


          stepKoef:=strToInt(adressString[iGraph+2]);

          case stepKoef of
            0:
            begin
              case infNum of
                0:
                begin
                  //M16
                  Fa := 8;
                end;
                1:
                begin
                  //M08
                  Fa := 8;
                end;
                2:
                begin
                  //M04
                  Fa := 4;
                end;
                3:
                begin
                  //M02
                  Fa := 2;
                end;
                4:
                begin
                  //M01
                  Fa := 1;
                end;
              end;
            end;
            1:
            begin
              case infNum of
                0:
                begin
                  //M16
                  Fa := 4;
                end;
                1:
                begin
                  //M08
                  Fa := 4;
                end;
                2:
                begin
                  //M04
                  Fa := 2;
                end;
                3:
                begin
                  //M02
                  Fa := 1;
                end;
                4:
                begin
                  //M01
                  Fa := 0;
                  //если Fa < 1 то такого адреса быть не может
                  isOkAdr:=False;
                  Break;
                end;
              end;
            end;
            2:
            begin
              case infNum of
                0:
                begin
                  //M16
                  Fa := 2;
                end;
                1:
                begin
                  //M08
                  Fa := 2;
                end;
                2:
                begin
                  //M04
                  Fa := 1;
                end;
                3:
                begin
                  //M02
                  Fa := 0;
                  //если Fa < 1 то такого адреса быть не может
                  //!! ошибка
                  isOkAdr:=False;
                  Break;
                end;
                4:
                begin
                  //M01
                  Fa := 0;
                  //если Fa < 1 то такого адреса быть не может
                  //!! ошибка
                  isOkAdr:=False;
                  Break;
                end;
              end;
            end;
          end;
          stepOutGins:=Fa;
          offset:=offset+Ma;
        end;
        //Поиск B(b)
        66,98:
        begin
          if not CheckParam(adressString,iGraph) then
          begin
            numOutElemG:=-1;
            break;
          end;
          Mb:=strToInt(adressString[iGraph+1]);

          if ((Mb<1)or(Mb>8)) then
          begin
            //ошибка разбора адреса. неверный адрес
            isOkAdr:=False;
            Break;
          end;
          Mb :=Mb-1;



          stepKoef:=strToInt(adressString[iGraph+2]);
          case stepKoef of
            0:
            begin
              Fb:=8;
            end;
            1:
            begin
              Fb:=4;
            end;
            2:
            begin
              Fb:=2;
            end;
          end;
          offset:=offset+Mb*stepOutGins;
          stepOutGins:=stepOutGins*Fb;
        end;
        //Поиск C(c)
        67,99:
        begin
          if not CheckParam(adressString,iGraph) then
          begin
            numOutElemG:=-1;
            break;
          end;
          Mc:=strToInt(adressString[iGraph+1]);

          if ((Mc<1)or(Mc>8)) then
          begin
            //ошибка разбора адреса. неверный адрес
            isOkAdr:=False;
            Break;
          end;
          Mc :=Mc-1;

          stepKoef:=strToInt(adressString[iGraph+2]);
          case stepKoef of
            0:
            begin
              Fc:=8;
            end;
            1:
            begin
              Fc:=4;
            end;
            2:
            begin
              Fc:=2;
            end;
          end;
          offset:=offset+Mc*stepOutGins;
          stepOutGins:=stepOutGins*Fc;
        end;
        //Поиск D(d)
        68,100:
        begin
          if not CheckParam(adressString,iGraph) then
          begin
            numOutElemG:=-1;
            break;
          end;
          Md:=strToInt(adressString[iGraph+1]);

          if ((Md<1)or(Md>8)) then
          begin
            //ошибка разбора адреса. неверный адрес
            isOkAdr:=False;
            Break;
          end;
          Md :=Md-1;


          stepKoef:=strToInt(adressString[iGraph+2]);
          case stepKoef of
            0:
            begin
              Fd:=8;
            end;
            1:
            begin
              Fd:=4;
            end;
            2:
            begin
              Fd:=2;
            end;
          end;
          offset:=offset+Md*stepOutGins;
          stepOutGins:=stepOutGins*Fd;
        end;
        //Поиск E(e)
        69,101:
        begin
          if not CheckParam(adressString,iGraph) then
          begin
            numOutElemG:=-1;
            break;
          end;
          Me:=strToInt(adressString[iGraph+1]);

          if ((Me<1)or(Me>8)) then
          begin
            //ошибка разбора адреса. неверный адрес
            isOkAdr:=False;
            Break;
          end;
         
          Me :=Me-1;
          stepKoef:=strToInt(adressString[iGraph+2]);
          case stepKoef of
            0:
            begin
              Fe:=8;
            end;
            1:
            begin
              Fe:=4;
            end;
            2:
            begin
              Fe:=2;
            end;
          end;
          offset:=offset+Me*stepOutGins;
          stepOutGins:=stepOutGins*Fe;
        end;
        //Поиск X(x)
        88,120:
        begin
          if not CheckParam(adressString,iGraph) then
          begin
            numOutElemG:=-1;
            break;
          end;
          Mx:=strToInt(adressString[iGraph+1]);
          if ((Mx<1)or(Mx>8)) then
          begin
            //ошибка разбора адреса. неверный адрес
            isOkAdr:=False;
            Break;
          end;
          Mx :=Mx-1;
          stepKoef:=strToInt(adressString[iGraph+2]);
          case stepKoef of
            0:
            begin
              Fx:=8;
            end;
            1:
            begin
              Fx:=4;
            end;
            2:
            begin
              Fx:=2;
            end;
          end;
          offset:=offset+Mx*stepOutGins;
          stepOutGins:=stepOutGins*Fx;
        end;
      end;
      iGraph:=iGraph+3;
    end;

    if (isOkAdr) then
    begin
      //проверяем была ли ошибка при анализе адреса
      if numOutElemG<>-1 then
      begin
        infStrInt := StrToInt(adressString[2] + adressString[3]);
        //N1={Ma+Mb*Fa+Mc*Fa*Fb+Md*Fa*Fb*Fc+Me*Fa*Fb*Fc*Fd+Mx*Fa*Fb*Fc*Fd*Fe}
        //выбираем правильный первый элемент в зависимости от инф разб. адреса
        //M16
        if infStrInt = 16 then
        begin
          numOutElemG := pBeginOffset + 2 * offset;
        end
        //остальные
        else
        begin
          numOutElemG := pBeginOffset + offset;
        end;
        //выставляем шаг для выборки след. точки в завис. от информативности адреса
        case infStrInt of
          16:
          begin
            stepOutG := 2 * stepOutGins; //T=Fa*Fb*Fc*Fd*Fe*Fx
          end;
          8:
          begin
            stepOutG := stepOutGins;
          end;
          4:
          begin
            stepOutG := stepOutGins;
            //stepOutG := round(stepOutGins / 2);
          end;
          2:
          begin
            stepOutG := stepOutGins;
            //stepOutG := round(stepOutGins / 4);
          end;
          1:
          begin
            stepOutG := stepOutGins;
            //stepOutG := round(stepOutGins / 8);
          end;
        end;
      end;
    end
    else
    begin
      numOutElemG:=-1;
    end;
  end
  else
  begin
    numOutElemG:=-1;
  end;
end;
//==============================================================================

//==============================================================================
//Процедура сбора адреса политерно в одну строку
//==============================================================================
function CollectADR:string;
var
str:string;
i:integer;
j:integer;
begin
  str:='';
  i:=1;
  j:=2;
  form1.Memo1.Clear;
  //M
  if form1.Edit2.Text<>'  ' then
  begin
    str:=str+form1.m.Caption+form1.Edit2.Text[i]+form1.Edit2.Text[j];
  end;
  //П
  if form1.Edit3.Text<>' ' then
  begin
    str:=str+form1.p.Caption+form1.Edit3.Text[i];
  end;
  //A
  if form1.Edit4.Text<>'  ' then
  begin
    str:=str+form1.a.Caption+form1.Edit4.Text[i]+form1.Edit4.Text[j];
  end;
  //B
  if form1.Edit5.Text<>'  ' then
  begin
    str:=str+form1.b.Caption+form1.Edit5.Text[i]+form1.Edit5.Text[j];
  end;
  //C
  if form1.Edit6.Text<>'  ' then
  begin
    str:=str+form1.c.Caption+form1.Edit6.Text[i]+form1.Edit6.Text[j];
  end;
  //D
  if form1.Edit7.Text<>'  ' then
  begin
    str:=str+form1.d.Caption+form1.Edit7.Text[i]+form1.Edit7.Text[j];
  end;
  //E
  if form1.Edit8.Text<>'  ' then
  begin
    str:=str+form1.e.Caption+form1.Edit8.Text[i]+form1.Edit8.Text[j];
  end;
  //X
  if form1.Edit9.Text<>'  ' then
  begin
    str:=str+form1.x.Caption+form1.Edit9.Text[i]+form1.Edit9.Text[j];
  end;
  result:=str;
end;
//==============================================================================

procedure TForm1.Button1Click(Sender: TObject);
const
OUTSTEP=10;
MAXGROUPINCIKL=32;
MAXCIKLINKADR=4;
var
i,j,m:integer;
str:string;
//номер группы
iGr:integer;
//первый вычесленный номер группы
iGrF:integer;
//номер цикла
iC:integer;
begin
  j:=0;
  str:=CollectADR;
  AdressAnalyser(str);
  form1.Memo1.Lines.Add(str);
  if numOutElemG<>-1 then
  begin
    //для нумерации с 0 переданный номер точки с 1 уменьшаем на 1
    i:=numOutElemG-1; {3173-1 проверочные данные. номер начальной точки}
     {stepOutG:=3072; проверочные данные. размер смещения от нач. точки}
    form1.Memo1.Lines.Add('Номера точек в кадре ОРБИТА'+form1.ComboBox1.Items[form1.ComboBox1.itemindex]);


    //производим вывод для 1 кадра 4 цикла по 32 группы
    //вычисляем номер первой группы
    iGr:=trunc((i+1)/masgMax);
    iGrF:=iGr;
    //вычисляем номер первого цикла
    iC:=trunc(iGr/MAXGROUPINCIKL);
    //вычисляем номер точки в первой группе
    i:=((i+1)-(iGr*masgMax))-1;
    inc(iGr);
    iGrF:=iGr;
    inc(iC);
    m:=i;

    if iC<=MAXCIKLINKADR then
    begin
      while iC<=MAXCIKLINKADR do
      begin
        if iGr<=MAXGROUPINCIKL then
        begin
          //ограничиваем вывод циклом(32гр.). Нумерация группы с 1.
          while iGr<=MAXGROUPINCIKL do
          begin
            i:=m;
            //вывод в пределах текущей группы
            while i<masgMax do
            begin
              inc(j);
              form1.Memo1.Lines.Add('Цикл №'+intToStr(iC)+' || '+'Группа №'+intToStr(iGr)+
              ' || '+'№слова при выводе:'+intToStr(j)+' || '+'№слова в группе:'+intToStr(i));
              i:=i+stepOutG;
            end;
            //j:=0;
            //переход на след. группу
            if stepOutG>masgMax then
            begin
              iGr:=iGr+(trunc(stepOutG/masgMax));
            end
            else
            begin
              inc(iGr);
            end;
          end;
          iC:=iC+trunc(iGr/MAXGROUPINCIKL);
          iGr:=iGrF;
        end
        else
        begin
          form1.Memo1.Lines.Add('Неверный адрес!');
          break;
        end;
      end;
    end
    else
    begin
      form1.Memo1.Lines.Add('Неверный адрес!');
    end;





    //если нет то выходит что он через группу.
    {if i>masgMax-1 then
    begin
      //вычисляем номер первой группы в которой будет лежать медленный параметр
      iGr:=trunc((i+1)/(masgMax));
      //вычисляем номер точки в первой группе медленного параметра
      i:=((i+1)-(iGr*masgMax))-1;
      //ограничиваем вывод кадром(32гр.). Нумерация группы с 1.
      while iGr<=MAXGROUPINCIKL do
      begin
        inc(j);
        form1.Memo1.Lines.Add('Группа №'+intToStr(iGr)+' '+intToStr(j)+' слово. '+intToStr(i));
        iGr:=iGr+(trunc(stepOutG/masgMax));
      end;
      //form1.Memo1.Lines.Add('В текущей группе значения нет'+'возможно он есть в следующих группах');
    end
    else
    begin
      //ограничиваем вывод группой
      while i<masgMax do
      begin
        inc(j);
        form1.Memo1.Lines.Add(intToStr(j)+' слово. '+intToStr(i));
        i:=i+stepOutG;
      end;
    end; }


  end
  else
  begin
    form1.Memo1.Lines.Add('Введен ошибочный адрес!');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  form1.Edit2.Enabled:=false;
  form1.Edit3.Enabled:=false;
  form1.Edit4.Enabled:=false;
  form1.Edit5.Enabled:=false;
  form1.Edit6.Enabled:=false;
  form1.Edit7.Enabled:=false;
  form1.Edit8.Enabled:=false;
  form1.Edit9.Enabled:=false;
  form1.Button1.Enabled:=false;
  form1.Memo1.Enabled:=false;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  //form1.Edit2.Enabled:=true;
  form1.Edit3.Enabled:=true;
  form1.Edit4.Enabled:=true;
  form1.Edit5.Enabled:=true;
  form1.Edit6.Enabled:=true;
  form1.Edit7.Enabled:=true;
  form1.Edit8.Enabled:=true;
  form1.Edit9.Enabled:=true;
  form1.Button1.Enabled:=true;
  form1.Memo1.Enabled:=true;
  //form1.Edit2.Text:='  ';
  form1.Edit3.Text:=' ';
  form1.Edit4.Text:='  ';
  form1.Edit5.Text:='  ';
  form1.Edit6.Text:='  ';
  form1.Edit7.Text:='  ';
  form1.Edit8.Text:='  ';
  form1.Edit9.Text:='  ';
  form1.Memo1.Clear;
  form1.Label1.Caption:=' ';
  case form1.ComboBox1.ItemIndex of
    //16
    0:
    begin
      masgMax:=2048;
      form1.Edit2.Text:='16';
    end;
    //08
    1:
    begin
      form1.Edit2.Text:='08';
      form1.Edit3.Enabled:=false;
      masgMax:=1024;
    end;
    //04
    2:
    begin
      form1.Edit2.Text:='04';
      form1.Edit3.Enabled:=false;
      masgMax:=512;
    end;
    //02
    3:
    begin
      form1.Edit2.Text:='02';
      form1.Edit3.Enabled:=false;
      masgMax:=256;
    end;
    //01
    4:
    begin
      form1.Edit2.Text:='01';
      form1.Edit3.Enabled:=false;
      masgMax:=128;
    end;
  end;
  form1.Label1.Caption:='Проверяемый адреc Орбита '+form1.ComboBox1.Items[form1.ComboBox1.itemindex];
end;

end.
