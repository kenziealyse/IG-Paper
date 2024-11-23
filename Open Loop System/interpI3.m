function Ival = interpI3(t, AdjustedVector)

persistent I

if exist("I", "var") == 1
    I_temp = load("I.mat");
    I_temp = I_temp.I;
    I = zeros(length(I_temp),1);
    I(length(0:0.1:20) + 1:end) = I_temp(1:length(I) - length(0:0.1:20));
end

Ival = interp1(AdjustedVector, I, t);

end
