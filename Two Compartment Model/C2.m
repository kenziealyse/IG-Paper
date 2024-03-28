%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = C2(param_values, startvals, varargin)

    % Check if varargin is not empty
    if ~isempty(varargin)
       fixed_param = varargin{1};
       scale = varargin{2};
    else
        % Default values
        fixed_param = 'none';
        scale = -1;
    end

if min(param_values) < 0
    disp(param_values)
    return
end

model = @IGS_func;

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
init_cond_insulin = insulin_data(1);

glucose_data = fitting_data.glucose;
init_cond_glucose = glucose_data(1);
% Time Span
tspan = insulin_time;

% Initial Conditions
init_cond = [init_cond_insulin , init_cond_glucose];

% Simulate calibration results
[~,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func), tspan, init_cond);

% Relabel Compartments to Easily Keep Track
I = Y(:,1);
G = Y(:,2);

% Fit the data     
res = CostFunction(G, I, ...
        glucose_data, insulin_data);
if res < 0 
    disp(param_values)
    return
end

end


