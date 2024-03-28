%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DyDt = IGS_func(t, Y, params, U)

% Paramter Values
k1 = params(1);
k2 = params(2);
k3 = params(3);
delta1 = params(4);
delta2 = params(5);
delta3 = params(6);
n = params(7);

% Relabel Compartments to Easily Keep Track
I = Y(1);
G = Y(2);

% Dosing
U_val = U(t);

% ODE Equations
dIdt = k1*G^n/(k2 + G^n) - delta1*I;
dGdt = k3 - (delta2*I + delta3)*G + U_val;

%Output
DyDt = [dIdt; dGdt];

end