%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DyDt = ThreeCompartmentModel(t, Y, params, U)

k1 = params(1);
k2 = params(2);
k3 = params(3);
k4 = params(4);
delta1 = params(5);
delta2 = params(6);
delta3 = params(7);
delta4 = params(8);
n = params(9);
p = params(10);
z = params(11);
h = params(12);

% Relabel Compartments to Easily Keep Track
B = Y(1);
I = Y(2);
G = Y(3);
GL = Y(4);

Gb = max(0, G - h);
U_val = U(t);

% ODE Equations
dBdt = 0;
dIdt = k1*G^n/(k2^n + G^n) - delta1*I;
dGdt = k3*GL - (delta2*I + delta3)*G + U_val;
dGLdt = k4/(1 + (Gb)*z + I*p) - delta4*GL;

%Output
DyDt = [dBdt; dIdt; dGdt; dGLdt];

end

