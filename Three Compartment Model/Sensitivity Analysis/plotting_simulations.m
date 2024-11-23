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
delta2 = startval(6);
delta3 = startval(7);
delta4 =  startval(8);
n = startval(9);
p = startval(10);
z = startval(11);
h = startval(12);

param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h]';
best_residal = myres(param_values)

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
[T,Y] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,param_values, @dosing_func), tspan_to_save, init_cond);

% Relabel Compartments to Easily Keep Track
B = Y(:,1);
I = Y(:,2);
G = Y(:,3);
GL = Y(:,4);

% Plot Results
f = figure('Position', get(0, 'Screensize'));
f.Position(4) = 600;

% Adjust figure position and size
set(gcf, 'Position', [100, 100, 800, 800]);

% Plot Insulin
subplot(2,2,1)
plot(insulin_time, lower_insulin, 'Color', [.7 .7 .7])
hold on
plot(insulin_time, upper_insulin, 'Color', [.7 .7 .7])
patch('XData', [insulin_time fliplr(insulin_time)], ...
    'YData', [lower_insulin fliplr(upper_insulin)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(T, I, 'Color', 'k', 'lineWidth', 1.3)
plot(insulin_time, insulin_data, 'o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
title('Insulin', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Insulin, \mug/L', 'FontSize', 17)

% Plot Glucose
subplot(2, 2, 2);
plot(glucose_time, lower_glucose, 'Color', [.7 .7 .7])
hold on
plot(glucose_time, upper_glucose, 'Color', [.7 .7 .7])
patch('XData', [glucose_time fliplr(glucose_time)], ...
    'YData', [lower_glucose fliplr(upper_glucose)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(T, G, 'Color', 'k', 'lineWidth', 1.3)
plot(glucose_time, glucose_data, 'o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
title('Glucose', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucose, mmol/L', 'FontSize', 17)

% Plot Glucagon
subplot(2, 2, 3.5);
plot(glucagon_time, lower_glucagon, 'Color', [.7 .7 .7])
hold on
plot(glucagon_time, upper_glucagon, 'Color', [.7 .7 .7])
patch('XData', [glucagon_time fliplr(glucagon_time)], ...
    'YData', [lower_glucagon fliplr(upper_glucagon)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(T, GL, 'Color', 'k', 'lineWidth', 1.3)
plot(glucagon_time, glucagon_data, 'o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
title('Glucagon', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucagon, pmol/L', 'FontSize', 17)
legend('', '', '95% C.I.', 'Model Simulation','Data', 'FontSize', 17)




% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'IGGLSS_best_fit_POSTER.pdf';
saveas(gcf, figurename); % Save Figure in Folder
            