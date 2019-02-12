program Y;

type TF = function (x: real): real;

var a, b, eps1, eps2, x1, x2, x3, I1, I2, I3, answer: real;



{================================}

function f1 (x: real): real;
begin
f1 := 3/((x-1)*(x-1) + 1);
end;

function f1p (x: real): real;
begin
f1p := -6*(x-1)/(((x-1)*(x-1) + 1)*((x-1)*(x-1) + 1));
end;

function f1pp (x: real): real;
begin
f1pp := 6*(3*x*x-6*x+2)/((x*x-2*x+2)*(x*x-2*x+2)*(x*x-2*x+2));
end;

{================================}

function f2 (x: real): real;
begin
f2 := sqrt(x+0.5);
end;

function f2p (x: real): real;
begin
f2p := 1/(2*sqrt(x+0.5));
end;

function f2pp (x: real): real;
begin
f2pp := 1/(4*sqrt(x+0.5)*sqrt(x+0.5)*sqrt(x+0.5));
end;

{================================}

function f3 (x: real): real;
begin
f3 := exp(-x);
end;

function f3p (x: real): real;
begin
f3p := -exp(-x);
end;

function f3pp (x: real): real;
begin
f3pp := exp(-x);
end;

{================================}

procedure root(f,g: TF; a, b, eps: real; var x: real); {деление отрезка}
var c: real;
begin
с := (a+b)/2;

while f(с)-g(с) < eps do begin
if (f(a)-g(a))*(f(c)-g(c))<0 then begin
b := c;
с := (a+b)/2;
end
else begin
a := c;
с := (a+b)/2;
end;
end;
x := c;
end;

function integral (f: TF; a, b, eps2: real): real;
var
n, i: integer;
h, I: real;
begin
{для деления метода прямоугольников}
I := 0;
n := 1000;
h := (b-a)/n;

for i := 0 to n do begin
I := I + h*f(a+(i+0.5)h);
end;

integral := I;

end;


{main}
begin

{примерные границы корней}
a := -0.25;
b := 4.0;


{погрешность}
eps1 := 0.001;
eps2 := 0.001;

{нахождение корней}
root(f1, f2, a, b, eps1, x1);
root(f2, f3, a, b, eps1, x2);
root(f1, f3, a, b, eps1, x3);

{площадь}
I1 := integral(f1, x3, x1, eps2);
I2 := integral(f2, x2, x1, eps2);
I3 := integral(f3, x3, x2, eps2);


{вывод результатов}

answer := I1 - I2 - I3;

writeln("Площадь =   ", answer);
writeln("Точки пересечения : ");
writeln("f1 и f2:     ", x1);
writeln("f1 и f3:     ", x3);
writeln("f3 и f2:     ", x2);



end.
