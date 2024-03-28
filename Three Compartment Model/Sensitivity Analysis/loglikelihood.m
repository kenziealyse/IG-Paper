% CLEAR THE WORKSPACE
clearvars
clc
close all

% Add path
addpath('../Model');
addpath('../../Data');

% Specifiy if you want to plot or save and the scale for parameters 
saveyesno = 1;
scale = 0:0.2:10;

% Given parameter values
startval = setvals();

k1 = startval(1);
k2 = startval(2);
k3 = startval(3);
k4 = startval(4);
delta1 = startval(5);
delta2 = startval(6);
delta3 = startval(7);
delta4 =  startval(8);
n = startval(9);
p = startval(10);
z = startval(11);
h = startval(12);

param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';

% Best Residual
best_res = 0.96976;

% String of fixed parameters
fixed_param = {'k_1', 'k_2', 'k_3', 'k_4', 'delta_1', 'delta_2', ...
    'delta_3', 'delta_4', 'n', 'p', 'z', 'h', 'all'};

% Index
index = find(scale == 1);

% Preallocate space
estimates = zeros(length(scale), length(param_values) - 1);
res = zeros(length(scale), 1);

for i = 1:length(fixed_param) - 1

    field = fixed_param{i};

switch fixed_param{i}

    
    case 'k_1'     
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [k2 k3 k4 delta1 delta2 delta3 delta4 n p z h];

            residual = @(param_values) C2(param_values, startval, fixed_param{1}, scale(j));
            options = optimoptions('fmincon','Display','off');
            [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                    lb, [], [], options);

        end
        % Save the best residual
        res(index) = best_res;
        % Save the algorithm information
        if saveyesno == 1
            information.(field).res = res;
            information.(field).estimates = estimates;
        end

      case 'k_2'       
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            
            param_values = [k1 k3 k4 delta1 delta2 delta3 delta4 n p z h]';
            lb = zeros(length(param_values), 1);
            init_guess = [k1 k3 k4 delta1 delta2 delta3 delta4 n p z h];

            residual = @(param_values) C2(param_values, startval, fixed_param{2}, scale(j));
            options = optimoptions('fmincon','Display','off');
            [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                    lb, [], [], options);
        end
        % Save the best residual
        res(index) = best_res;
        % Save the algorithm information
        if saveyesno == 1
            information.(field).res = res;
            information.(field).estimates = estimates;
        end

        case 'k_3'
            for j = 1:length(scale)
                param_values = [k1 k2 k4 delta1 delta2 delta3 delta4 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k4 delta1 delta2 delta3 delta4 n p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{3}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

        case 'k_4'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 delta1 delta2 delta3 delta4 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 delta1 delta2 delta3 delta4 n p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{4}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

    case 'delta_1'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta2 delta3 delta4 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta2 delta3 delta4 n p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{5}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

        case 'delta_2'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta3 delta4 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta3 delta4 n p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{6}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            endnformation.(field).estimates = estimates;
            end

         case 'delta_3'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta4 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta4 n p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{7}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

    case 'delta_4'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta3 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta3 n p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{8}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

        case 'n'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 p z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{9}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j, :), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);

               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

       case 'p'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n z h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{10}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);

            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

    case 'z'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p h];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{11}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

        case 'h'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z];
    
                residual = @(param_values) C2(param_values, startval, fixed_param{12}, scale(j));
                options = optimoptions('fmincon','Display','off');
                [estimates(j,:), res(j)] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);
    
               
            end
            % Save the best residual
            res(index) = best_res;
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
            end

     case 'all'
            for j = 1:length(scale)
                param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';
        
                lb = zeros(length(param_values), 1);
                init_guess = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h];
    
                residual = @(param_values) C2(param_values, startval);
                options = optimoptions('fmincon','Display','off');
                [estimates, res] = fmincon(residual, init_guess, [], [], [], [],...
                        lb, [], [], options);

               
            end
            % Save the algorithm information
            if saveyesno == 1
                information.(field).res = res;
                information.(field).estimates = estimates;
                starting_estimates = estimates;
                save('starting_estimates.mat', 'starting_estimates');
            end

end

    if saveyesno == 1
        information.start_vals = startval;
        information.scale = scale;
        save('Loglikelihood_Results.mat', 'information');
    end

end
          