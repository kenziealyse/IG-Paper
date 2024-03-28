%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DyDt = OpenLoopModel(t, Y, params, U, delta, interpfunc)

%Paramter Values
k3 = params(3);
k4 = params(4);
delta2 = params(6);
delta3 = params(7);
delta4 = params(8);
p = params(10);
z = params(11);
h = params(12);

% Relabel Compartments to Easily Keep Track
G = Y(1);
GL = Y(2);

Gb = max(0, G - h);
U_val = U(t);
I_val = interpfunc(t, delta);

% ODE Equations
dGdt = k3*GL - (delta2*I_val + delta3)*G + U_val;
dGLdt = k4/(1 + (Gb)*z + I_val*p) - delta4*GL;

%Output
DyDt = [dGdt; dGLdt];

end

