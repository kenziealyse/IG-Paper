%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DyDt = MinModel_func(t, Y, params, U, startvals, varargin)

    % Check if varargin is not empty
    if ~isempty(varargin)
       fixed_param = varargin{1};
       scale = varargin{2};
    else
        % Default values
        fixed_param = 'all';
        scale = 0;

    end

%Paramter Values
switch fixed_param
    case 'gamma'
    gamma = scale*startvals(1);
    h = params(1);
    n = params(2);
    P1 = params(3);
    P2 = params(4);
    P3 = params(5);

    case 'h'
    gamma = params(1);
    h = scale*startvals(2);
    n = params(2);
    P1 = params(3);
    P2 = params(4);
    P3 = params(5);

    case 'n'
    gamma = params(1);
    h = params(2);
    n = scale*startvals(3);
    P1 = params(3);
    P2 = params(4);
    P3 = params(5);

    case 'P1'
    gamma = params(1);
    h = params(2);
    n = params(3);
    P1 = scale*startvals(4);
    P2 = params(4);
    P3 = params(5);

    case 'P2'
    gamma = params(1);
    h = params(2);
    n = params(3);
    P1 = params(4);
    P2 = scale*startvals(5);
    P3 = params(5);

    case 'P3'
    gamma = params(1);
    h = params(2);
    n = params(3);
    P1 = params(4);
    P2 = params(5);
    P3 = scale*startvals(6);

    case 'all'
    gamma = params(1);
    h = params(2);
    n = params(3);
    P1 = params(4);
    P2 = params(5);
    P3 = params(6);
end

% Relabel Compartments to Easily Keep Track
I = Y(1);
G = Y(2);
X = Y(3);

% Load the data
persistent fitting_data

if isempty(fitting_data)
     [fitting_data, ~] = load_fitting_data();
end

% Save Glucose Data
glucose_data = fitting_data.glucose;

% Set Intial Conditions
init_cond_glucose = glucose_data(1);

% Dosing
U_val = U(t);

% (G - h)+
k = max(0, G - h);

% ODE Equations
dIdt = gamma*k*t - n*I;
dGdt = U_val - (P1 + X)*G + P1*init_cond_glucose;
dXdt = P3*I - P2*X;

%Output
DyDt = [dIdt; dGdt; dXdt];

end