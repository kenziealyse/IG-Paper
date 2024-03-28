function Ival = interpI3(t, AdjustedVector)

persistent I

if exist("I", "var") == 1
    I = load("I.mat");
    I = I.I;
end

Ival = interp1(AdjustedVector, I, t);

end
