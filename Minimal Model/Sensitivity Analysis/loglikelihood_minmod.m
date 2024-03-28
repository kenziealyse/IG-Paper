% CLEAR THE WORKSPACE
% clearvars
clearvars -except estimates
clc
close all

% Add path
addpath('../Minimal Model');
addpath('../../Data');

% Specifiy if you want to plot or save and the scale for parameters 
plotyesno = 0;
saveyesno = 1;
scale = 0:0.01:20;
scale = 1;

% Given parameter values
startval = setvalsMinMod();

% Paramter Values
gamma = startval(1);
h = startval(2);
n = startval(3);
P1 = startval(4);
P2 = startval(5);
P3 = startval(6);

param_values = [gamma h n P1 P2 P3]';

best_res = 1.5067;

% String of fixed parameters
fixed_param = {'gamma', 'h', 'n', 'P1', 'P2', 'P3', 'all'};

% Index
index = find(scale == 1);

% Pre allocate space
estimates = zeros(length(scale), length(param_values) - 1);
res = zeros(length(scale), 1);

for i = length(fixed_param)%1:length(fixed_param) - 1

    field = fixed_param{i};

switch fixed_param{i}

    
    case 'gamma'    
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [h n P1 P2 P3]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [h n P1 P2 P3];

            residual = @(param_values) C(param_values, startval, fixed_param{1}, scale(j));
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
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [gamma n P1 P2 P3]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [gamma n P1 P2 P3];

            residual = @(param_values) C(param_values, startval, fixed_param{2}, scale(j));
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
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [gamma h P1 P2 P3]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [gamma h P1 P2 P3];

            residual = @(param_values) C(param_values, startval, fixed_param{3}, scale(j));
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


        case 'P1'    
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [gamma n h P2 P3]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [gamma n h P2 P3];

            residual = @(param_values) C(param_values, startval, fixed_param{4}, scale(j));
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

        case 'P2'    
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [gamma n h P1 P3]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [gamma n h P1 P3];

            residual = @(param_values) C(param_values, startval, fixed_param{5}, scale(j));
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

        case 'P3'    
        % For loop to fit for different parameter values
        for j = 1:length(scale)
            param_values = [gamma n h P1 P2]';
    
            lb = zeros(length(param_values), 1);
            init_guess = [gamma n h P1 P2];

            residual = @(param_values) C(param_values, startval, fixed_param{6}, scale(j));
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
                param_values = [gamma h n P1 P2 P3]';        
                lb = zeros(length(param_values), 1);
                init_guess = [gamma h n P1 P2 P3]';
    
                residual = @(param_values) C(param_values, startval, fixed_param{7}, scale(j));
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
          