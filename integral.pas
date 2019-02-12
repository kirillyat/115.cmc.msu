program Y;

type TF = function (x: real): real; 

var a, b, eps, x1, x2, x3: real;


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
	f1pp := 6*(3*x*x-6x+2)/((x*x-2*x+2)*(x*x-2*x+2)*(x*x-2*x+2));
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



 

begin

	{примерные границы корней}
	a := -0.25;
	b := 4.0;

	{погрешность}
	eps :=0.001;

	{нахождение корней}
	root(f1, f2, a, b, eps, x1);
	root(f2, f3, a, b, eps, x2);
	root(f1, f3, a, b, eps, x3);

	{площадь}

end.
