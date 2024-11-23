% CLEAR THE WORKSPACE
clc
clear
close all

% Load the data
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/all_pig_data.mat');
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/pig_time_data.mat');

pig_nums = 1:1:10;

% Create a full-screen figure
figure('Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

for i = 1:length(pig_nums)
    pig_number = pig_nums(i);
    
    load(['estimatesPig',num2str(pig_number), '.mat'])
    
    insulin_data = pig_data.insulin_data(pig_number,:);
    insulin_time = pig_time_data.insulin;
    init_cond_insulin = insulin_data(1);
    
    glucose_data = pig_data.glucose_data(pig_number,:);
    init_cond_glucose = glucose_data(1);
    
    glucagon_data = pig_data.glucagon_data(pig_number,:);
    init_cond_glucagon = glucagon_data(1);
    
    tspan = 0:.1:insulin_time(end);
    % Initial Conditions
    init_cond = [1, init_cond_insulin , init_cond_glucose, init_cond_glucagon];
    
    % Simulate calibration results
    [~,Y] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,estimates, @dosing_func, pig_number), tspan, init_cond);
    
    % Relabel to easily keep track of compartments
    B = Y(:,1);
    I = Y(:,2);
    G = Y(:,3);
    GL = Y(:,4);
     
    subplot(3, 10, i)
    plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
    hold on
    plot(insulin_time, insulin_data, 'o', 'Color', 'r')
    title(['Pig ', num2str(pig_number)], 'FontSize', 12)
    if pig_number == 1
        ylabel('Insulin, \mug/L', 'FontSize', 17);  % Label for the first column only
    end
      
    subplot(3, 10, i + 10)
    plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
    hold on
    plot(insulin_time, glucose_data, 'o', 'Color', 'r')
    if pig_number == 1
        ylabel('Glucose, mmol/L', 'FontSize', 17);  % Label for the first column only
    end
    
    
    subplot(3, 10, i + 20)
    plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
    hold on
    plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
    if pig_number == 1
        ylabel('Glucagon, pmol/L', 'FontSize', 17);  % Label for the first column only
    end

end

% Set the x-axis label for the middle bottom plot
xlabel(subplot(3, 10, 25), 'Time, minutes', 'FontSize', 20);  % Label for the middle bottom plot

    

% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'AllPigFits.pdf';
saveas(gcf, figurename); % Save Figure in Folder