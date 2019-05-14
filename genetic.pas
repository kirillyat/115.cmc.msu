program genetic;

{
    ищем максимум
    Критерий останова: выполнение заданного числа итераций
    Турнирная селекция
    Одноточечное скрещивание
    Мутация реверс
}


const
      n=10; {Число особей}
      s=16;
      esp=1/16384; {Точность}
      maxim=1.6054; {Максимальное значение}

type
    mb=array [1..n,1..s] of byte; {Двоичная запись чисел}
    mi=array[1..n] of real; {Обычный массив чисел}

var
    x, nx, y:mi;
    x2,nx2:mb;
    i, k, j:integer;
    e, z:real;


function f(x: real): real;
begin
    f:= (x-2)*(x-2.5)*(x-3)*(x-3.5)*(1-exp(x-1.5))*ln(x+0.5);
end;


{Ввод изначального массива}
procedure INIT(var a:mi);
    var i : integer;
begin
    for i:=1 to n do
	  a[i]:=random(maxint)/8192;
end;


{Турнирная Селекция}
procedure selection(x: mi; var nx: mi);
var
    i, s, l: integer;
begin
    for i := 1 to n do
    begin
	    s:=random(n)+1;
	    l:=random(n)+1;
            if f(x[s]) < f(x[l]) then
		nx[i]:=x[l]
	    else
		nx[i]:=x[s]
    end;
end;

{Перевод из 10 в 2}
procedure dec2bin(nx: mi; var x2:mb);
var i, j:integer;
    c:real;
begin
    for i:=1 to n do
	begin
		case trunc(nx[i]) of
			0:begin x2[i,1]:=0; x2[i,2]:=0 end;
			1:begin x2[i,1]:=0; x2[i,2]:=1 end;
			2:begin x2[i,1]:=1; x2[i,2]:=0 end;
			3:begin x2[i,1]:=1; x2[i,2]:=1 end;
		end;
		c := nx[i] - trunc(nx[i]);
		for j:=3 to s do
		begin
			c:=c*2;
			x2[i,j] := trunc(c);
			c := c - trunc(c);
		end;
	end;
end;


{Одноточечное скрещивание}
procedure cross(x2:mb;var xn2:mb);
var i,j,k:integer;
begin
	for i:=1 to 5 do
	begin
		k:=random(16)+1;
		for j:=1 to k do
		begin
			xn2[2*i-1,j]:=x2[2*i-1,j];
			xn2[2*i,j]:=x2[2*i,j];
		end;
		for j:=k+1 to s do
		begin
			xn2[2*i-1,j]:=x2[2*i,j];
			xn2[2*i,j]:=x2[2*i-1,j];
		end;
	end;
end;


{Мутация реверс}
procedure mutation(var nx2:mb);
var i, j, k, c : integer;
begin
    for i:=1 to n do begin
        k := random(s)+1;
          for j:=1 to ((s-k) div 2) do begin
              c := nx2[i,j+k-1];
              nx2[i,j+k-1] := nx2[i,s-j+1];
              nx2[i,s-j+1]:= c;
        end;
    end;
end;


{Перевод из 2 в 10}
procedure bin2dec(nx2:mb; var x:mi);
var
    i,j:integer;
    k:real;
begin
	for i:=1 to 10 do
	begin
		x[i]:=nx2[i,1]*2+nx2[i,2];
		k:=0.5;
		for j:=3 to s do
		begin
			x[i]:=x[i]+nx2[i,j]*k;
			k:=k*0.5;
		end;
	end;
end;


{Значение функции при данных иксах}
procedure value(a:mi;var b:mi);
var i:integer;
begin
	for i:=1 to n do
		b[i]:=f(a[i]);
end;


{максимум из y}
function max(a:mi;var k:integer):real;
var m:real;
    i:integer;
begin
	m:=a[1];
	k:=1;
	for i:=2 to n do
		if m<a[i] then
		begin
			m:=a[i];
			k:=i;
		end;
	max:=m;
end;


begin

    {
      Ответ
      x:= 0.779822;
      y:= 1.605418;
    }
    writeln('Введите количество итераций (>=0):');
    readln(i);
    randomize;
    INIT(x);
    value(x,y);
    e:=max(y,k);
    z:=x[k];
    while i<>0 do
    begin
	selection(x,nx);
	dec2bin(nx,x2);
	cross(x2,nx2);
	mutation(nx2);
	bin2dec(nx2,x);
	value(x,y);
	if max(y,j)>e then
	begin
	     e:=max(y,j);
	     z:=x[j];
	end;
	dec(i);
    end;
    writeln('x=', z:3:6,' y=',e:3:6);



end.
