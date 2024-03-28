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

model = @IGGlSS_func1_noSS;

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
init_cond_insulin = insulin_data(1);

glucose_data = fitting_data.glucose;
init_cond_glucose = glucose_data(1);

glucagon_data = fitting_data.glucagon;
init_cond_glucagon = glucagon_data(1);


% Time Span
tspan = insulin_time;

% Initial Conditions
init_cond = [1, init_cond_insulin , init_cond_glucose, init_cond_glucagon];

% Simulate calibration results
[~,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, startvals, fixed_param, scale), tspan, init_cond);

% Relabel Compartments to Easily Keep Track
B = Y(:,1);
I = Y(:,2);
G = Y(:,3);
GL = Y(:,4);

% Fit the data     
[~, ~, ~, res] = calculate_resids_penalty2(G, I, GL, ...
        glucose_data, insulin_data, glucagon_data);

if res < 0 
    disp(param_values)
    return
end

end


