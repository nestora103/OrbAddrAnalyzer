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
//�������� ���������� ������������� ������
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
//���������� ������ ������
//==============================================================================
procedure AdressAnalyser(adressString:string);
var
//���������� ��������������� ������
infStrInt:integer;
//���������� ��� ��������
iGraph:integer;
flagM:boolean;
//���������� ��� �������� ASCII-���� �������
codAsciiGraph:integer;
stepKoef:integer;
//��������� ��� ���������� ���������
Ma,Mb,Mc,Md,Me,Mx:integer; //Ma=N1-1;Mb=N2-1;Mc=N3-1; � �.�
//���� ��� ���������� ������
//Fa=8, ���� K=0; Fa=4, ���� K=1; Fa=2, ���� K=2; ���������� ��� ������
Fa,Fb,Fc,Fd,Fe,Fx:integer;
//�������� ����. � �������, ������� �� �1 ��� �2
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
  //��������� � 1 ��� ������ ������
  numOutElemG:=1;

  isOkAdr:=true;

  while iGraph <= length(adressString) do
  begin
    //������ ������ ������ ���� ����������� �
    if adressString[iGraph] = 'M' then
    begin
      //� ����.
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
        if ((adressString[iGraph + 3] = '�') or (adressString[iGraph + 3] = '�')) then
        begin
          if (adressString[iGraph + 4] = '1') then
          begin
            //������ ���. �������� ��� ������� �� �������
            pBeginOffset := 1;
            flagBegin := true;
          end;
          if (adressString[iGraph + 4] = '2') then
          begin
            //������ ���. �������� ��� ������� �� �������
            pBeginOffset := 2;
            flagBegin := true;
          end;
          iGraph := iGraph + 5;
          break;
        end
        else
        begin
          //halt;
          form1.Memo1.Lines.Add('����� �� ������������� ��������� ���������������');
          break;
        end;
      end
      //���������
      else
      begin
        if ((adressString[iGraph + 3] = '�') or (adressString[iGraph + 3] = '�')) then
        begin
          flagBegin := false;
          break;
        end;
        //��� ��������
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
    //������������ ����� ���������
    while (iGraph<=length(adressString)) do
    begin
      codAsciiGraph:=ord(adressString[iGraph]);
      // ��������� ������������ ���� � ����� ��������� ����� � ���.
      case codAsciiGraph of
        //����� �(�)
        65,97:
        begin
          //��������� ���������� ���������
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
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            1:
            begin
              //M08
              if ((Ma<1)or(Ma>8)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            2:
            begin
              //M04
              if ((Ma<1)or(Ma>4)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            3:
            begin
              //M02
              if ((Ma<1)or(Ma>2)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            4:
            begin
              //M01
              if (Ma<>1) then
              begin
                //������ ������� ������. �������� �����
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
                  //���� Fa < 1 �� ������ ������ ���� �� �����
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
                  //���� Fa < 1 �� ������ ������ ���� �� �����
                  //!! ������
                  isOkAdr:=False;
                  Break;
                end;
                4:
                begin
                  //M01
                  Fa := 0;
                  //���� Fa < 1 �� ������ ������ ���� �� �����
                  //!! ������
                  isOkAdr:=False;
                  Break;
                end;
              end;
            end;
          end;
          stepOutGins:=Fa;
          offset:=offset+Ma;
        end;
        //����� B(b)
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
            //������ ������� ������. �������� �����
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
        //����� C(c)
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
            //������ ������� ������. �������� �����
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
        //����� D(d)
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
            //������ ������� ������. �������� �����
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
        //����� E(e)
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
            //������ ������� ������. �������� �����
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
        //����� X(x)
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
            //������ ������� ������. �������� �����
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
      //��������� ���� �� ������ ��� ������� ������
      if numOutElemG<>-1 then
      begin
        infStrInt := StrToInt(adressString[2] + adressString[3]);
        //N1={Ma+Mb*Fa+Mc*Fa*Fb+Md*Fa*Fb*Fc+Me*Fa*Fb*Fc*Fd+Mx*Fa*Fb*Fc*Fd*Fe}
        //�������� ���������� ������ ������� � ����������� �� ��� ����. ������
        //M16
        if infStrInt = 16 then
        begin
          numOutElemG := pBeginOffset + 2 * offset;
        end
        //���������
        else
        begin
          numOutElemG := pBeginOffset + offset;
        end;
        //���������� ��� ��� ������� ����. ����� � �����. �� ��������������� ������
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
//��������� ����� ������ ��������� � ���� ������
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
  //�
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
//����� ������
iGr:integer;
//������ ����������� ����� ������
iGrF:integer;
//����� �����
iC:integer;
begin
  j:=0;
  str:=CollectADR;
  AdressAnalyser(str);
  form1.Memo1.Lines.Add(str);
  if numOutElemG<>-1 then
  begin
    //��� ��������� � 0 ���������� ����� ����� � 1 ��������� �� 1
    i:=numOutElemG-1; {3173-1 ����������� ������. ����� ��������� �����}
     {stepOutG:=3072; ����������� ������. ������ �������� �� ���. �����}
    form1.Memo1.Lines.Add('������ ����� � ����� ������'+form1.ComboBox1.Items[form1.ComboBox1.itemindex]);


    //���������� ����� ��� 1 ����� 4 ����� �� 32 ������
    //��������� ����� ������ ������
    iGr:=trunc((i+1)/masgMax);
    iGrF:=iGr;
    //��������� ����� ������� �����
    iC:=trunc(iGr/MAXGROUPINCIKL);
    //��������� ����� ����� � ������ ������
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
          //������������ ����� ������(32��.). ��������� ������ � 1.
          while iGr<=MAXGROUPINCIKL do
          begin
            i:=m;
            //����� � �������� ������� ������
            while i<masgMax do
            begin
              inc(j);
              form1.Memo1.Lines.Add('���� �'+intToStr(iC)+' || '+'������ �'+intToStr(iGr)+
              ' || '+'������ ��� ������:'+intToStr(j)+' || '+'������ � ������:'+intToStr(i));
              i:=i+stepOutG;
            end;
            //j:=0;
            //������� �� ����. ������
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
          form1.Memo1.Lines.Add('�������� �����!');
          break;
        end;
      end;
    end
    else
    begin
      form1.Memo1.Lines.Add('�������� �����!');
    end;





    //���� ��� �� ������� ��� �� ����� ������.
    {if i>masgMax-1 then
    begin
      //��������� ����� ������ ������ � ������� ����� ������ ��������� ��������
      iGr:=trunc((i+1)/(masgMax));
      //��������� ����� ����� � ������ ������ ���������� ���������
      i:=((i+1)-(iGr*masgMax))-1;
      //������������ ����� ������(32��.). ��������� ������ � 1.
      while iGr<=MAXGROUPINCIKL do
      begin
        inc(j);
        form1.Memo1.Lines.Add('������ �'+intToStr(iGr)+' '+intToStr(j)+' �����. '+intToStr(i));
        iGr:=iGr+(trunc(stepOutG/masgMax));
      end;
      //form1.Memo1.Lines.Add('� ������� ������ �������� ���'+'�������� �� ���� � ��������� �������');
    end
    else
    begin
      //������������ ����� �������
      while i<masgMax do
      begin
        inc(j);
        form1.Memo1.Lines.Add(intToStr(j)+' �����. '+intToStr(i));
        i:=i+stepOutG;
      end;
    end; }


  end
  else
  begin
    form1.Memo1.Lines.Add('������ ��������� �����!');
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
  form1.Label1.Caption:='����������� ����c ������ '+form1.ComboBox1.Items[form1.ComboBox1.itemindex];
end;

end.
