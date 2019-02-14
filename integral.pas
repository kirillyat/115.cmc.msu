program Y;

var  eps1, eps2, x1, x2, x3, I1, I2, I3, answer: real;

type TF = function (x: real): real;

{$F+}
function f1(x: real): real;
begin
f1 := 3/((x-1)*(x-1) + 1);
end;

function f2(x: real): real;
begin
f2 := sqrt(x+0.5);
end;

function f3(x: real): real;
begin
f3 := exp(-x);
end;

{================================}

procedure root(f,g : TF; a, b, eps: real; var x: real); {деление отрезка}
var
c: real;
begin
c := (a+b)/2;
while abs(f(c)-g(c)) >= eps do begin

    if (f(a)-g(a))*(f(c)-g(c))<0 then b := c
    else a := c;
    c := (a+b)/2;
end;

x := c;
end;

function maxi(a, b:real):real;
begin
    if a>b then maxi:=a
    else maxi:=b;
end;


function integral (f: TF; a, b, eps: real): real;
var
n, k, t: integer;
h, I: real;
begin
{для деления метода симпсона}

n := 1000; {зависит от eps2 и четное}
h := (b-a)/n;
I := h*(f(a)+f(b))/3;

for k := 1 to n-1 do begin

t:=2;
if k mod 2 = 1 then t := t+2;
I := I + h*(t*f(a+k*h))/3;
end;



integral := I;

end;
{main}
begin

{погрешность}
eps1 := 0.000000001;
eps2 := 0.001;

{нахождение корней}
root(@f1, @f2, -0.3, 2.5, eps1, x1);
root(@f2, @f3, -0.3, 2.5, eps1, x2);
root(@f1, @f3, -0.3, 2.5, eps1, x3);

{площади}
I1 := integral(@f1, x1+x3-maxi(x1, x3), maxi(x1, x3), eps2);
I2 := integral(@f2, x2+x1-maxi(x2, x1), maxi(x2, x1), eps2);
I3 := integral(@f3, x3+x2-maxi(x3,x2), maxi(x2, x3), eps2);


{подсчет и вывод результатов}

answer := 2*maxi(maxi(abs(I1), abs(I2)), abs(I3)) -abs(I1) - abs(I2) - abs(I3);

writeln('Площадь =   ', abs(answer):4:5);
writeln('Точки пересечения : ');
writeln('f1 и f2:     ', x1:4:5);
writeln('f1 и f3:     ', x3:4:5);
writeln('f3 и f2:     ', x2:4:5);



end.


