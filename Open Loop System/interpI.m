function Ival = interpI(t, noisydata)

persistent tspan

if exist("tspan", "var") == 1
    tspan = 0:0.1:180;
end

Ival = interp1(tspan, noisydata, t);

end


