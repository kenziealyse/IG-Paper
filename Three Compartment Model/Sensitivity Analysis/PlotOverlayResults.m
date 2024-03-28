% CLEAR THE WORKSPACE
clear
clc
close all

% Add path
addpath('../Model');
addpath('../../Data');

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

param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();
[insulin_CI_data, glucose_CI_data, glucagon_CI_data] = load_CI_Data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
init_cond_insulin = insulin_data(1);
lower_insulin = insulin_CI_data.insulin_CI_data.lower;
upper_insulin = insulin_CI_data.insulin_CI_data.upper;

glucose_data = fitting_data.glucose;
glucose_time = time_data.glucose;
init_cond_glucose = glucose_data(1);
lower_glucose = glucose_CI_data.glucose_CI_data.lower;
upper_glucose = glucose_CI_data.glucose_CI_data.upper;

glucagon_data = fitting_data.glucagon;
glucagon_time = time_data.glucagon;
init_cond_glucagon = glucagon_data(1);
lower_glucagon = glucagon_CI_data.glucagon_CI_data.lower;
upper_glucagon = glucagon_CI_data.glucagon_CI_data.upper;

% Set Initial Conditions and Time
init_cond = [1, init_cond_insulin , init_cond_glucose, init_cond_glucagon];
tspan_to_save = 0:.1:180;

% Run Simulation With Best Fit Parameters
[T,Y] = ode23s(@(t,Y) IGGlSS_func1_noSS(t,Y,param_values, @dosing_func), tspan_to_save, init_cond);

% Relabel Compartments to Easily Keep Track
B = Y(:,1);
I = Y(:,2);
G = Y(:,3);
GL = Y(:,4);

% Plot Results
f = figure('Position', get(0, 'Screensize'));
f.Position(4) = 600;

% Plot Insulin
subplot(1,2,1)
plot(T, I, 'Color', 'k', 'lineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r', 'lineWidth', 1.5, 'HandleVisibility', 'off')
xlim([0 180])
title('Insulin', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Insulin, \mug/L', 'FontSize', 17)

% Plot Glucose
subplot(1,2,2)
plot(T, G, 'Color', 'k', 'lineWidth', 1.3)
hold on
plot(glucose_time, glucose_data, 'o', 'Color', 'r', 'lineWidth', 1.5, 'HandleVisibility', 'off')
xlim([0 180])
title('Glucose', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucose, mmol/L', 'FontSize', 17)

%% Minimal Model Simulation

% Clear exisiting variables
clearvars t Y param_values startval
% Add needed paths
addpath('../../Minimal Model/Sensitivity Analysis');
addpath('../../Minimal Model/Minimal Model');

% Set parameter values
startval = setvalsMinMod();
% Given parameter values
gamma = startval(1);
h = startval(2);
n = startval(3);
P1 = startval(4);
P2 = startval(5);
P3 = startval(6);
mu = startval(7);
param_values = [gamma h n P1 P2 P3 mu]';

% Run simulation
init_cond = [init_cond_insulin , init_cond_glucose, 0];
tspan_to_save = 0:.1:180;
[t,Y] = ode23s(@(t,Y) MinModel_func(t, Y, param_values, @dosing_func, startval), tspan_to_save, init_cond);

% Relabel Compartments to Easily Keep Track
I = Y(:,1);
G = Y(:,2);
X = Y(:,3);

% Plot the Minimal Model
subplot(1,2,1)
plot(t, I, 'k','lineWidth', 2, 'LineStyle', ':')
xlim([0 180])
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Insulin, \mug/L', 'FontSize', 17)
title('Insulin', 'FontSize', 20)

subplot(1,2,2)
plot(t, G, 'k', 'lineWidth', 2, 'LineStyle', ':')
xlim([0 180])
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucose, mmol/L', 'FontSize', 17)
legend('Three Compartment Model Simulation', 'Minimal Model Simulation', 'FontSize', 17)
title('Glucose', 'FontSize', 20)


% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'Overlay_best_fit_Sim.pdf';
saveas(gcf, figurename); % Save Figure in Folder
            