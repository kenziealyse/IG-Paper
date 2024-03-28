function Ival = interpI4(t, pct)

persistent I tspan

if exist("I", "var") == 1
    I = load("I.mat");
    I = I.I;
    tspan = 0:0.1:180;
end

Adjustedtspan = pct(1).*tspan;
AdjustedI = pct(2).*I;

Ival = interp1(Adjustedtspan, AdjustedI, t);

end
