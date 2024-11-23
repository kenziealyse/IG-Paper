function Ival = interpI4(t, pct)

persistent I tspan

if exist("I", "var") == 1
     I_temp = load("I.mat");
    I_temp = I_temp.I;
    I = zeros(length(I_temp),1);
    I(length(0:0.1:20) + 1:end) = I_temp(1:length(I) - length(0:0.1:20));
    tspan = 0:0.1:180;
end

AdjustedI = pct(2).*I;

Ival = interp1(tspan, AdjustedI, t);

end
