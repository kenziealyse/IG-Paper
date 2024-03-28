% CLEAR THE WORKSPACE
clear
clc
close all
startvals = setvalsMinMod();

% Add data path
addpath('../Minimal Model');
addpath('../../Data');

% Given parameter values
gamma = startvals(1);
h = startvals(2);
n = startvals(3);
P1 = startvals(4);
P2 = startvals(5);
P3 = startvals(6);

param_values = [gamma h n P1 P2 P3]';

res1 = C(param_values, startvals)


% Simulate calibration results

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();
[insulin_CI_data, glucose_CI_data, ~] = load_CI_Data();

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

% Initial Conditions
init_cond = [init_cond_insulin , init_cond_glucose, 0];
tspan_to_save = 0:.1:180;
[t,Y] = ode23s(@(t,Y) MinModel_func(t, Y, param_values, @dosing_func, startvals), tspan_to_save, init_cond);

% Relabel Compartments to Easily Keep Track
I = Y(:,1);
G = Y(:,2);
X = Y(:,3);

f = figure();
f.Position(4) = 600;
f.Position(3) = 1000;

subplot(1,2,1)
plot(insulin_time, lower_insulin, 'Color', [.7 .7 .7])
hold on
plot(insulin_time, upper_insulin, 'Color', [.7 .7 .7])
patch('XData', [insulin_time fliplr(insulin_time)], ...
    'YData', [lower_insulin fliplr(upper_insulin)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(t, I, 'k','lineWidth', 1.3)
plot(t, X, 'k', 'LineStyle', '--','lineWidth', 1.3)
plot(insulin_time, insulin_data, 'o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Insulin, \mug/L', 'FontSize', 17)
title('Insulin', 'FontSize', 20)
legend('', '', '95% C.I.', 'Model Simulation', 'Remote Insulin', 'Data', 'FontSize', 17)



subplot(1,2,2)
plot(glucose_time, lower_glucose, 'Color', [.7 .7 .7])
hold on
plot(glucose_time, upper_glucose, 'Color', [.7 .7 .7])
patch('XData', [glucose_time fliplr(glucose_time)], ...
    'YData', [lower_glucose fliplr(upper_glucose)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(t, G, 'k', 'lineWidth', 1.3)
plot(glucose_time, glucose_data, 'o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucose, mmol/L', 'FontSize', 17)
title('Glucose', 'FontSize', 20)


% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'MinModBestFit.pdf';
saveas(gcf, figurename); % Save Figure in Folder