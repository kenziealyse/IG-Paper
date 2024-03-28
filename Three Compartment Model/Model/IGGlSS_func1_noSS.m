%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function DyDt = IGGlSS_func1_noSS(t, Y, params, U, startvals, varargin)

    % Check if varargin is not empty
    if ~isempty(varargin)
       fixed_param = varargin{1};
       scale = varargin{2};
    else
        % Default values
        fixed_param = 'none';
        scale = 0;

    end

%Paramter Values
switch fixed_param

    case 'k_1'
        k1 =  startvals(1).*scale;
        k2 = params(1);
        k3 = params(2);
        k4 = params(3);
        delta1 = params(4);
        delta2 = params(5);
        delta3 = params(6);
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'k_2'
        k1 =  params(1);
        k2 =  startvals(2).*scale;
        k3 = params(2);
        k4 = params(3);
        delta1 = params(4);
        delta2 = params(5);
        delta3 = params(6);
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'k_3'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  startvals(3).*scale;
        k4 = params(3);
        delta1 = params(4);
        delta2 = params(5);
        delta3 = params(6);
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'k_4'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  startvals(4).*scale;
        delta1 = params(4);
        delta2 = params(5);
        delta3 = params(6);
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'delta_1'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = startvals(5).*scale;
        delta2 = params(5);
        delta3 = params(6);
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'delta_2'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = startvals(6).*scale;
        delta3 = params(6);
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'delta_3'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = params(6);
        delta3 = startvals(7).*scale;
        delta4 = params(7);
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'delta_4'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = params(6);
        delta3 = params(7);
        delta4 = startvals(8).*scale;
        n = params(8);
        p = params(9);
        z = params(10);
        h = params(11);
    case 'n'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = params(6);
        delta3 = params(7);
        delta4 = params(8);
        n = startvals(9).*scale;
        p = params(9);
        z = params(10);
        h = params(11);
        
    case 'p'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = params(6);
        delta3 = params(7);
        delta4 = params(8);
        n = params(9);
        p = startvals(10).*scale;
        z = params(10);
        h = params(11);
        
    case 'z'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = params(6);
        delta3 = params(7);
        delta4 = params(8);
        n = params(9);
        p = params(10);
        z = startvals(11).*scale;
        h = params(11);
    case 'h'
        k1 =  params(1);
        k2 =  params(2);
        k3 =  params(3);
        k4 =  params(4);
        delta1 = params(5);
        delta2 = params(6);
        delta3 = params(7);
        delta4 = params(8);
        n = params(9);
        p = params(10);
        z = params(11);
        h = startvals(12).*scale;
    case 'none'
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

end

param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';
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

