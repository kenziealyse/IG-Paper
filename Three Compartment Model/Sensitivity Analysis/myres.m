%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = myres(param_values)

    if min(param_values) < 0
        disp(param_values)
        return
    end

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
    [~,Y] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,param_values, @dosing_func), tspan, init_cond);
    
    % Relabel Compartments to Easily Keep Track
    B = Y(:,1);
    I = Y(:,2);
    G = Y(:,3);
    GL = Y(:,4);


    %% Calculate Residual 
    if isrow(glucose_data) ~= isrow(G)
            glucose_data = glucose_data';
            insulin_data = insulin_data';
            glucagon_data = glucagon_data';
    end

    G = real(G);
    I = real(I);
    GL = real(GL);

    % Calculate individual residuals
    blood_insulin_resid = sum(((I - insulin_data)./(insulin_data)).^2);
    glucose_resid = sum(((G - glucose_data)./(glucose_data)).^2);
    glucagon_resid = sum(((GL - glucagon_data)./(glucagon_data)).^2);
    
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


