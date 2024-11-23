%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DyDt = MinModel_func(t, Y, params, U)

gamma = params(1);
h = params(2);
n = params(3);
P1 = params(4);
P2 = params(5);
P3 = params(6);


% Relabel Compartments to Easily Keep Track
I = Y(1);
G = Y(2);
X = Y(3);

% Dosing
U_val = U(t);

% Load and Save the Data
persistent init_cond_glucose

if isempty(init_cond_glucose)
    [fitting_data, ~] = load_fitting_data();
    glucose_data = fitting_data.glucose;
    init_cond_glucose = glucose_data(1);
end


% (G - h)+
k = max(0, G - h);

% ODE Equations
dIdt = gamma*k*t - n*I;
dGdt = U_val - (P1 + X)*G + P1*init_cond_glucose;
dXdt = P3*I - P2*X;

%Output
DyDt = [dIdt; dGdt; dXdt];

end