program genetic;

const N = 10;

type
mas = array [1..n] of word;
arr = array [1..n] of double;

var
t: text;
pop: mas; {Population}
a: arr; {Chances to mix}
iter, bestRoot, count, num1, num2, exitNumber, i, number, mode, output, leave: word;
errorIndex: integer;
chance: double; {Chance to mutate}
input: string; {Answer of user}

function F(x: double): double;
begin
  F := (x-2)*(x-2.5)*(x-3)*(x-3.5)*(1-exp(x-1.5))*ln(x+0.5);
end;


function rand (var S : integer): integer;
begin
    randomize;
    rand := random(0, S);
end;



{Creating the first population}

procedure Init(var pop: mas; n: integer);
var i: integer;
begin
    for i := 1 to n do pop[i] := Random(65533) + 1;
end; 
