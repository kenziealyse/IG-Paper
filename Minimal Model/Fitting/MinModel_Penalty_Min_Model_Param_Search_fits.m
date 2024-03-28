%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Fit_Data_Information = MinModel_Penalty_Min_Model_Param_Search_fits(gamma, ...
    filename, num_of_params, num_of_sets, scales, param_names, ...
    model)

Param_values = randomize_param_values(num_of_params,num_of_sets, scales);

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();
[insulin_CI_data, glucose_CI_data, ~] = load_CI_Data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
init_cond_insulin = insulin_data(1);
lower_insulin = insulin_CI_data.insulin_CI_data.lower;
upper_insulin = insulin_CI_data.insulin_CI_data.upper;

glucose_data = fitting_data.glucose;
init_cond_glucose = glucose_data(1);
lower_glucose = glucose_CI_data.glucose_CI_data.lower;
upper_glucose = glucose_CI_data.glucose_CI_data.upper;

init_cond_X = 0;


lb = zeros(1, num_of_params);
tspan_to_save = 0:.01:insulin_time(end);
tspan = insulin_time;

pool = gcp('nocreate');
if isempty(pool)
    N = 6;
    parpool(N);
else
    % do nothing  
end


%% FOR LOOP FOR FITTING USING DIFFERENT GAMMAS

    % Pre Allocate Space
    param_values = zeros(num_of_sets, num_of_params);
    res = zeros(num_of_sets, 1);
    Glucose_values = zeros(length(tspan_to_save), num_of_sets);
    Insulin_values = zeros(length(tspan_to_save), num_of_sets);
    Glucagon_values = zeros(length(tspan_to_save), num_of_sets);
    Beta_cell_values = zeros(length(tspan_to_save), num_of_sets);
    message = strings([num_of_sets, 1]);
    func_iterations = zeros(num_of_sets, 1);
    func_count = zeros(num_of_sets, 1);
    algorithm = strings([num_of_sets, 1]);


        parfor (i = 1:num_of_sets)
  
            
            % Paramater Values Initial Guesses
            init_guess = Param_values(i, :);
          
            init_cond = [init_cond_insulin, init_cond_glucose, init_cond_X];

            % Fit the data     
            residual = @(params) IGS_penalty_myres(params, ...
                   tspan, init_cond, insulin_data, glucose_data, ...
                   lower_insulin, lower_glucose, ...
                   upper_insulin, upper_glucose, ...
                   gamma, model, @dosing_func);
            options = optimoptions('fmincon','Display','off');
            [estimates, res(i,1), exit_type(i, 1), output] = fmincon(residual, init_guess, [], [], [], [],...
                lb, [], [], options);

           
            
            %% Save the Information
        
            % Save the parameter estimates
            param_values(i,:) = estimates;
        
            % Save the algorithm information
            message{i, 1} = output.message;
            func_iterations(i, 1) = output.iterations;
            func_count(i, 1) = output.funcCount;
            algorithm{i, 1} = output.algorithm;
            
  
            % Simulate calibration results
            [~,Y] = ode23s(@(t,Y) model(t,Y,estimates, @dosing_func), tspan_to_save, init_cond);
            
            % Relabel to easily keep track of compartments
            I = Y(:,1);
            G = Y(:,2);
            X = Y(:,3);
        
            Glucose_values(:,i) = G;
            Insulin_values(:,i) = I;
            X_values(:,i) = X;
            Glucagon_values(:,i) = 0;
            Beta_cell_values(:,i) = 0; 

        
        end

    % Create Data Stucture
    Fit_Data_Information = struct();
    Fit_Data_Information.Overall_Resid = res;
    Fit_Data_Information.Parameter_Values = param_values;
    Fit_Data_Information.Glucose_Values = Glucose_values;
    Fit_Data_Information.X_Values = X_values;
    Fit_Data_Information.Insulin_Values = Insulin_values;
    Fit_Data_Information.Glucagon_Values = Glucagon_values;
    Fit_Data_Information.Beta_cell_Values = Beta_cell_values;
    Fit_Data_Information.Time_Span = tspan_to_save;
    Fit_Data_Information.Exit_Type = exit_type;
    Fit_Data_Information.Final_message = message;
    Fit_Data_Information.Func_iterations = func_iterations;
    Fit_Data_Information.Function_count = func_count;
    Fit_Data_Information.Algorithm_name = algorithm;
    Fit_Data_Information.Parameter_names = param_names;
    Fit_Data_Information.Num_of_sets = num_of_sets;
    Fit_Data_Information.Gamma = gamma;
    Fit_Data_Information.Parameter_scales = scales;

% Save Data Structure
save(['Simulation_Data/', filename], '-struct' ,'Fit_Data_Information');

end

