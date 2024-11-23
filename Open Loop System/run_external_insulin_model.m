% CLEAR THE WORKSPACE
close all
clear
clc

% Add path
addpath('../Data');

%% Things to change
delta = 2;
saveyesno = 1;
testcase = 'timeshift';   % 'randomnoise'
                             % 'peakdecrease'
                             % 'timeshift'
                             % 'timeandpeak'

%% Do not change                             
% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
init_cond_insulin = insulin_data(1);

glucose_data = fitting_data.glucose;
init_cond_glucose = glucose_data(1);

glucagon_data = fitting_data.glucagon;
init_cond_glucagon = glucagon_data(1);

% Sepcify Mode
model = @OpenLoopModel;

% Add noise
I = load("I.mat");
I = I.I;

% Set Best Fit Parameter Values
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

param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h];

% Time Span
tspan = 0:.1:180;

% Initial Conditions
init_cond = [init_cond_glucose, init_cond_glucagon];

for i = 1:length(delta)
    switch testcase
    
        case 'randomnoise'
            interpfunc = @interpI;
            Adjustedvector = delta(i).* I.*randn(size(I));
            Adjustedvector = I + Adjustedvector;
    
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, Adjustedvector, interpfunc), tspan, init_cond);
    
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot           
            f = figure();
            f.Position(4) = 600;
            f.Position(3) = 1100;
            subplot(1,3,1)
            plot(tspan, Adjustedvector, 'Color',  [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Insulin, \mug/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,2)
            plot(tspan, G, 'Color',  [.6 .6 .6], 'LineWidth', 1.5)
            ylabel('Glucose, mmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,3)
            plot(tspan, GL, 'Color',  [.6 .6 .6], 'LineWidth', 1.5)
            ylabel('Glucagon, pmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, I, interpfunc), tspan, init_cond);
            
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
             % Plot
            subplot(1,3,1)
            plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Insulin', 'FontSize', 20)
            subplot(1,3,2)
            plot(tspan, G, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucose', 'FontSize', 20)
            subplot(1,3,3)
            plot(tspan, GL, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucagon', 'FontSize', 20)
            legend('Adjusted Data', 'Original Data', 'FontSize', 17) 
    
    
    
        case 'peakdecrease'
    
            interpfunc = @interpI2;
            Adjustedvector = I.*delta(i);
    
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, Adjustedvector, interpfunc), tspan, init_cond);
    
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot
            f = figure();
            f.Position(4) = 400;
            f.Position(3) = 1100;
            subplot(1,3,1)
            plot(tspan, Adjustedvector, 'Color', [.6 .6 .6], 'LineWidth', 1.5)
            ylabel('Insulin, \mug/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
  
            hold on
            
            subplot(1,3,2)
            plot(tspan, G, 'Color', [.6 .6 .6], 'LineWidth', 1.5)
            ylabel('Glucose, mmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,3)
            plot(tspan, GL, 'Color', [.6 .6 .6], 'LineWidth', 1.5)
            ylabel('Glucagon, pmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, I, @interpI), tspan, init_cond);
            
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot
            subplot(1,3,1)
            plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Insulin', 'FontSize', 20)
            legend('Reduced Insulin Profile', 'Original Insulin Profile', 'FontSize', 17, 'Location', 'best')
            subplot(1,3,2)
            plot(tspan, G, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucose', 'FontSize', 20)
            subplot(1,3,3)
            plot(tspan, GL, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucagon', 'FontSize', 20)
            
    
    
        case 'timeshift'
           
            interpfunc = @interpI3; 
            Adjustedvector = tspan;
    
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, Adjustedvector, interpfunc), tspan, init_cond);
    
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot
            f = figure();
            f.Position(4) = 400;
            f.Position(3) = 1100;
            subplot(1,3,1)
            I_adjusted = zeros(length(I),1);
            I_adjusted(length(0:0.1:20) + 1:end) = I(1:length(I) - length(0:0.1:20));
            plot(tspan, I_adjusted, 'Color', [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Insulin, \mug/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,2)
            plot(tspan, G, 'Color', [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Glucose, mmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,3)
            plot(tspan, GL, 'Color', [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Glucagon, pmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, I, @interpI), tspan, init_cond);
            
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot
            subplot(1,3,1)
            plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Insulin', 'FontSize', 20)
            legend('Delayed Insulin Profile', 'Original Insulin Profile', 'FontSize', 17, 'Location', 'best')     
            subplot(1,3,2)
            plot(tspan, G, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucose', 'FontSize', 20)
            subplot(1,3,3)
            plot(tspan, GL, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucagon', 'FontSize', 20)  

    case 'timeandpeak'

            interpfunc = @interpI4; 
            Adjustedvector = [2 0.5];
            delta = Adjustedvector;
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, Adjustedvector, interpfunc), tspan, init_cond);
    
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot
            f = figure();
            f.Position(4) = 600;
            f.Position(3) = 1100;
            subplot(1,3,1)
            I_adjusted = zeros(length(I),1);
            I_adjusted(length(0:0.1:20) + 1:end) = I(1:length(I) - length(0:0.1:20));
            plot(tspan, I_adjusted.*Adjustedvector(2), 'Color', [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Insulin, \mug/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,2)
            plot(tspan, G, 'Color', [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Glucose, mmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            subplot(1,3,3)
            plot(tspan, GL, 'Color', [.6 .6 .6], 'LineWidth', 1.3)
            ylabel('Glucagon, pmol/L', 'FontSize', 17)
            xlabel('Time, minutes', 'FontSize', 17)
            xlim([0 180])
            xticks(0:20:180)
            hold on
            
            % Simulate calibration results
            [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, I, @interpI), tspan, init_cond);
            
            % Relabel Compartments to Easily Keep Track
            G = Y(:,1);
            GL = Y(:,2);
            
            % Plot
            subplot(1,3,1)
            plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Insulin', 'FontSize', 20)
            legend('Delayed and Reduced \newline Insulin Profile', 'Original Insulin Profile', 'FontSize', 17, 'Location', 'best')
            subplot(1,3,2)
            plot(tspan, G, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucose', 'FontSize', 20)
            subplot(1,3,3)
            plot(tspan, GL, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', '--')
            title('Glucagon', 'FontSize', 20) 
    end
    
  
    % Save the figure as pdf
    if saveyesno == 1
        set(gcf, 'Units', 'Inches');
        pos = get(gcf, 'Position');
        set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
        figurename = strcat('OpenLoopModel', testcase, num2str(delta), '.pdf');
        saveas(gcf, figurename); % Save Figure in Folder
    end

end