program genetic;

const N = 10;

type
    ArrF = array[1..n] of real; {Значения функции}
program genetic;

const
    N = 10; {Число особей}
    OSTANOV = 000; {Проходов до остановы}
    EXACT = 16384; {Точность}

type
    ArrF = array[1..n] of real; {Значения функции}
    individ = array[1..16] of integer; {Двоичная запись одного гена}
    population = array[1..n] of individ; {Массив все генов}

var
    i,j: integer;
    ansX, ansY: real;
    Pop: population;
    Rez: ArrF;


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
    for i := 3 to 16 do begin
        a[i] := trunc(2 * x);
        x := 2 * x - trunc(2 * x);
    end;
end;

function pow(a : real; b : integer): real;
var p : real;
begin
    p := 1;
    if b = 0 then pow := 1
    else if b > 0 then
        for i := 1 to b do begin
            p := p*a;
            pow := p;
        end
    else pow := 1/pow(a, -b)
end;

function bin2dec(a: individ): real;
var
    i: integer;
    x: real;
begin
    x := 2*a[1] + a[2];
    for i := 3 to 16 do
        x := x + a[i]*pow(2, 2-i);

    bin2dec := x;
end;


{Одноточечное скрещивание}
procedure crossbreeding(var A, B, C, D : individ);
var
    k : integer;

begin
    randomize;
    k := random(16);
    for i:=1 to 16 do
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
        crossbreeding(Pop[i], Pop[i+1],Pop[i + n div 2], Pop[i + 1 + n div 2]);

                                                                   {TODO}
end;



{Мутация реверс}
procedure mutation(var pop: population);
var i, j, k, c : integer;
begin
    for i:=1 to n do begin
        randomize;
        k := random(16);
        for j:= k to ((16+k) div 2) do begin
            c := pop[i, j];
            pop[i,j] := pop[i, 16 + k - j];
            pop[i, 16 + k - j] := c;
        end;
    end;
end;


{Sorting the population accroding to values of function in those points}
procedure Sorting(var a: ArrF; var pop: population);
var
    i, j : integer;
    b: individ;
    c : real;
begin
    for j := 1 to n - 1 do
        for i := 1 to n - j do
            if F(bin2dec(pop[i])/EXACT) < F(bin2dec(pop[i+1]) / EXACT) then begin
                c := a[i];
                b := pop[i];
                a[i] := a[i + 1];
                pop[i] := pop[i + 1];
                a[i + 1] := c; pop[i + 1] := b;
            end;
end;

procedure Selection(var pop: population);
var
    i: integer;
begin

    for i := 1 to n div 2 do begin
        if f(bin2dec(pop[2*i-1]))> f(bin2dec(pop[2*i])) then
            pop[i] := pop[2*i-1]
        else pop[i] := pop[2*i];
writeln(f(bin2dec(pop[2])):3:3);
    end;
end;





procedure INIT(var pop: population);
var i : integer;
begin
    randomize;
    for i := 1 to n do
        dec2bin(4*random(maxint)/maxint, pop[i]);
end;




procedure Loop (var pop : population; var Rez : ArrF);
begin
    for i:=1 to OSTANOV do begin

        selection(pop);
        cross(pop, rez);
        mutation(pop);
    end;
end;









begin
    {ответ по WolframAlpfa}
    ansX := 0.779822;
    writeln('==========================');
    writeln('Maximum по WolframAlpfa  :  ');
    writeln('x = ',ansX:5:5);
    writeln('y = ',f(ansX):5:5);
    writeln('==========================');




    INIT(Pop);
    Loop(Pop, Rez);


    for j := 2 to 16 do
        if f(bin2dec(pop[j]))>f(bin2dec(pop[i])) then i:=j;
    writeln('x=',bin2dec(pop[i]):3:3,' y=',f(bin2dec(pop[i])):3:3);

end.
    individ = array[1..16] of integer; {Двоичная запись одного гена}
    population = array[1..n] of individ; {Массив все генов}

var
    i,j: integer;
    x: real;
    a: individ;
    Pop: population;
    Rez: ArrF;

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
    for i := 3 to 16 do begin
        a[i] := trunc(2 * x);
        x := 2 * x - trunc(2 * x);
    end;
end;



function bin2dec(a: individ): real;
var
    i: integer;
    x: real;
begin
    x := 0;
    for i := 1 to 16 do
        x := x + step(2, -i + 2) * a[i];
    bin2dec := x;
end;


{Одноточечное скрещивание}
procedure crossbreeding(var A, B : individ);
var
    k : integer;
    C, D: individ;
begin
    randomize;
    k := rand(N);
    for i:=1 to 16 do
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

procedure cross(var Pop: population; var rez: ArrF);
var i: integer;
begin
    for i:=1 to (n div 2) do begin
        crossbreeding(Pop[2*i-1], Pop(2*i));
end;

{Мутация реверс}
procedure mutation(var pop: population);
var i, j, k, c: integer;
begin
    for i:=1 to n do begin
        randomize;
        k := random(16);
        for j:= k to 16-(k div 2) do begin
            c:=pop[i, j];
            pop[i,j]:= po[i, j];
            pop[i,j]:=c;
        end;
    end;
end;





procedure INIT (var pop : population);
var i : integer;
bedin
    randomize;
    for i := 1 to n do
        dec2bin(4*random(maxint)/maxint, pop[i]);
end;




procedure loop(var pop : population; var Rez : ArrF);
begin
    while () do begin
        selection(pop, rez);
        cross(pop, rez);
        mutation(pop);
    end;
end;









begin
    INIT(Pop);
    loop(Pop, Rez);
end.
