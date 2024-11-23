%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = myres_zeroInsulin(param_values, pig_number)

    if min(param_values) < 0
        disp(param_values)
        return
    end

    % Load and Save the Data
    load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/all_pig_data.mat');
    load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/pig_time_data.mat');
    
    insulin_data = pig_data.insulin_data(pig_number,:);
    insulin_time = pig_time_data.insulin;
    init_cond_insulin = insulin_data(1);
    
    glucose_data = pig_data.glucose_data(pig_number,:);
    init_cond_glucose = glucose_data(1);
    
    glucagon_data = pig_data.glucagon_data(pig_number,:);
    init_cond_glucagon = glucagon_data(1);

    % Time Span
    tspan = insulin_time;
    
    % Initial Conditions
    init_cond = [1, init_cond_insulin , init_cond_glucose, init_cond_glucagon];
    
    % Simulate calibration results
    [~,Y] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,param_values, @dosing_func, pig_number), tspan, init_cond);
    
    % Relabel Compartments to Easily Keep Track
    G = Y(:,3);
    GL = Y(:,4);

    index = find(insulin_data == 0)

    insulin_data(index) = [];
    insulin_time(index) = [];
    tspan = insulin_time;

    % Simulate calibration results
    [~,Y] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,param_values, @dosing_func, pig_number), tspan, init_cond);
    
    % Relabel Compartments to Easily Keep Track
    I = Y(:,2);

    %% Calculate Residual 
    if isrow(glucose_data) ~= isrow(G)
            glucose_data = glucose_data';
            insulin_data = insulin_data';
            glucagon_data = glucagon_data';
    end

    G = real(G);
    I = real(I);
    GL = real(GL);

%     for i = 1:length(insulin_data)
%        if insulin_data(i) < 10e-5
%            insulin_data(i) = 10e-5;
%        end
%    end

    % Calculate individual residuals
    blood_insulin_resid = sum(((I - insulin_data)./(mean(insulin_data))).^2);
    glucose_resid = sum(((G - glucose_data)./(mean(glucose_data))).^2);
    glucagon_resid = sum(((GL - glucagon_data)./(mean(glucagon_data))).^2);


    % Sum up the individual residuals
    res = blood_insulin_resid + ...
        glucose_resid + ...
        glucagon_resid;
    
        if res < 0 
            G
            scale
            return;
        end
    
        if res < 0 
            disp(param_values)
            return
        end

end


