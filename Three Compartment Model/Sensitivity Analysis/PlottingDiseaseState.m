% CLEAR THE WORKSPACE
% clearvars -except est
clc
close all

% Add path
addpath('../../Data');

% Set Best Fit Parameter Values
startval = setvals();

k1 = startval(1);
k2 = startval(2);
k3 = startval(3);
k4 = startval(4);
delta1 = startval(5);
delta2 = 0.01; % Change this to test different disease states
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
[T,Y_disease] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,param_values, @dosing_func), tspan_to_save, init_cond);

% Relabel Compartments to Easily Keep Track
B_disease = Y_disease(:,1);
I_disease = Y_disease(:,2);
G_disease = Y_disease(:,3);
GL_disease = Y_disease(:,4);

% Run Simulation With Best Fit Parameters
delta2 = startval(6);
param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';

[~,Y_healthy] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,param_values, @dosing_func), tspan_to_save, init_cond);

% Relabel Compartments to Easily Keep Track
B_healthy = Y_healthy(:,1);
I_healthy = Y_healthy(:,2);
G_healthy = Y_healthy(:,3);
GL_healthy = Y_healthy(:,4);


% Plot Results
f = figure('Position', get(0, 'Screensize'));
f.Position(3) = 900;
f.Position(4) = 400;

% Adjust figure position and size
% set(gcf, 'Position', [100, 100, 800, 800]);

% Plot Insulin
subplot(1,3,1)
plot(T, I_healthy, 'Color', 'k', 'lineWidth', 1.3)
hold on
plot(T, I_disease, 'Color', "#D95319", 'lineWidth', 1.3)
xlim([0 180])
title('Insulin', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Insulin, \mug/L', 'FontSize', 17)

% Plot Glucose
subplot(1, 3, 2);
plot(T, G_healthy, 'Color', 'k', 'lineWidth', 1.3)
hold on
plot(T, G_disease, 'Color', "#D95319", 'lineWidth', 1.3)
xlim([0 180])
title('Glucose', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucose, mmol/L', 'FontSize', 17)
legend('Healthy, S = 0.17', 'Disease, S = 0.01', 'FontSize', 15)


% Plot Glucagon
subplot(1, 3, 3);
plot(T, GL_healthy, 'Color', 'k', 'lineWidth', 1.3)
hold on
plot(T, GL_disease, 'Color', "#D95319", 'lineWidth', 1.3)
xlim([0 180])
title('Glucagon', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucagon, pmol/L', 'FontSize', 17)




% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'IGGLSS_diseasestate.pdf';
saveas(gcf, figurename); % Save Figure in Folder
            