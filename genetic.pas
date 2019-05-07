program genetic;

{
    ищем максимум
    Критерий останова: выполнение заданного числа итераций
    Турнирная селекция
    Одноточечное скрещивание
    Мутация реверс
}


const
    n = 10;         {Число особей}
    OSTANOV = 4000;  {Проходов до остановы}
    EXACT = 16384;  {Точность}
    v1 = 0.25;

type
    ArrF = array[1..n] of real;            {Значения функции}
    individ = array[1..n] of integer;      {Двоичная запись одного гена}
    population = array[1..n] of individ;   {Массив все генов}

var
    Pop: population;
    Rez: ArrF;
    T, Y: integer;


function F(x: real): real;
begin
    F := (x-2)*(x-2.5)*(x-3)*(x-3.5)*(1-exp(x-1.5))*ln(x+0.5);
end;


procedure dec2bin(x: real; var a: individ);
var i: integer;
begin

    case trunc(x) of

        1: begin a[1] := 0; a[2] := 1; end;
        2: begin a[1] := 1; a[2] := 0; end;
        3: begin a[1] := 1; a[2] := 1; end;
    end;
    x := x - trunc(x);
    for i := 3 to 10 do begin
        a[i] := trunc(2 * x);
        x := 2 * x - trunc(2 * x);
    end;
end;

function rand(x: real): boolean;
begin
  if x=0 then rand:=false else rand := random(maxint)/maxint < x;
end;

function pow(a : real; b : integer): real;
var p : real;
    i: integer;
begin
    p := 1;
    if b = 0 then pow := 1
    else if b > 0 then
        for i := 1 to b do begin
            p := p*a;
            pow := p;
        end
    else pow := 1/pow(a, -b);
end;



function bin2dec(a: individ): real;
var
    i: integer;
    x: real;
begin
    x := 2*a[1] + a[2];
    for i := 3 to n do
        x := x + a[i]*pow(2, 2-i);

    bin2dec := x;
end;


{Одноточечное скрещивание}
procedure crossbreeding(var A, B, C, D : individ);
var
    k : integer;
    i: integer;

begin
    randomize;
    k := random(n);
    for i:=1 to n do
        if i<=k then begin
            C[i] := A[i];
            D[i] := B[i];
        end
        else begin
            C[i] := B[i];
            D[i] := C[i];
        end;
    A:=C;
    B:=D;
end;



{Скрещивание}
procedure cross(var Pop: population; var rez: ArrF);
var i: integer;
begin
    for i:=1 to (n div 2) do
        crossbreeding(Pop[2*i], Pop[2*i-1],Pop[2*i+ n div 2], Pop[2*i - 1 + n div 2]);


end;



{Мутация реверс}
procedure mutation(var pop: population);
var i, j, k, c : integer;
begin
    for i:=1 to n do begin
        randomize;
        k := random(n-1);
        if rand(v1) then
        for j:= k to ((n+k) div 2) do begin

            c := pop[i][j];
            pop[i][j] := pop[i][n + k - j];
            pop[i][ n + k - j] := c;

        end;
    end;
end;



procedure Selection(var pop: population);
var
    i: integer;
begin

    for i := 1 to n div 2 do begin
        if f(bin2dec(pop[2*i-1]))<f(bin2dec(pop[2*i])) then
            pop[2*i-1] := pop[2*i];
        writeln(f(bin2dec(pop[i])):5:4);
    end;
    for i := 1 to 5 do
        pop[i] := pop[2*i-1];


end;





procedure INIT(var pop: population);
    var R : integer;
begin
    randomize;
    for R := 1 to n do begin
        dec2bin(4*random(maxint)/maxint, pop[R]);
    end;

end;




procedure Loop (var pop : population; var Rez : ArrF);
var i, w: integer;
begin
    for i:=1 to OSTANOV do begin
    {w:=1;
    for i := 2 to n do
        if F(bin2dec(pop[i]))>F(bin2dec(pop[w])) then
            w:=i;
    while f(bin2dec(pop[w]))<= 1.605 do begin
        w:=1;
        for i := 2 to n do
          if F(bin2dec(pop[i]))>F(bin2dec(pop[w])) then
              w:=i;}
        selection(pop);
        cross(pop, Rez);
        mutation(pop);
    end;
end;









begin
    {ответ по WolframAlpfa
    0.779822;
    writeln('==========================');
    writeln('Maximum по WolframAlpfa  :  ');
    writeln('x = ',ansX:5:5);
    writeln('y = ',f(ansX):5:5);
    writeln('==========================');}




    INIT(Pop);


    Loop(Pop, Rez);
    T:=1;
    for Y := 2 to n do
        if F(bin2dec(pop[Y]))>F(bin2dec(pop[T])) then
            T:=Y;

    writeln('x=',bin2dec(pop[T]):3:3,' y=',f(bin2dec(pop[T])):3:3);




end.
