% CLEAR THE WORKSPACE
% clearvars -except est
clc
close all

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();
[insulin_CI_data, glucose_CI_data, glucagon_CI_data] = load_CI_Data();
all_pig_data = load('all_pig_data.mat');
all_pig_data = all_pig_data.pig_data;

all_insulin_data = all_pig_data.insulin_data;
insulin_mean = fitting_data.insulin;
insulin_time = time_data.insulin;
lower_insulin = insulin_CI_data.insulin_CI_data.lower;
upper_insulin = insulin_CI_data.insulin_CI_data.upper;

all_glucose_data = all_pig_data.glucose_data;
glucose_mean = fitting_data.glucose;
glucose_time = time_data.glucose;
lower_glucose = glucose_CI_data.glucose_CI_data.lower;
upper_glucose = glucose_CI_data.glucose_CI_data.upper;

all_glucagon_data = all_pig_data.glucagon_data;
glucagon_mean = fitting_data.glucagon;
glucagon_time = time_data.glucagon;
lower_glucagon = glucagon_CI_data.glucagon_CI_data.lower;
upper_glucagon = glucagon_CI_data.glucagon_CI_data.upper;

% Plot Results
f = figure('Position', get(0, 'Screensize'));
f.Position(4) = 600;

% Plot Insulin
subplot(1,3,1)
plot(insulin_time, lower_insulin, 'Color', [.7 .7 .7])
hold on
plot(insulin_time, upper_insulin, 'Color', [.7 .7 .7])
patch('XData', [insulin_time fliplr(insulin_time)], ...
    'YData', [lower_insulin fliplr(upper_insulin)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(insulin_time, all_insulin_data, '-o', 'Color', [0.5 0.5 0.5], 'lineWidth', 0.7, 'HandleVisibility', 'off')
plot(insulin_time, insulin_mean, '-o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
title('Insulin', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Insulin, \mug/L', 'FontSize', 17)

% Plot Glucose
subplot(1,3,2)
plot(glucose_time, lower_glucose, 'Color', [.7 .7 .7])
hold on
plot(glucose_time, upper_glucose, 'Color', [.7 .7 .7])
patch('XData', [glucose_time fliplr(glucose_time)], ...
    'YData', [lower_glucose fliplr(upper_glucose)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(glucose_time, all_glucose_data, '-o', 'Color', [0.5 0.5 0.5], 'lineWidth', 0.7, 'HandleVisibility', 'off')
plot(glucose_time, glucose_mean, '-o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
title('Glucose', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucose, mmol/L', 'FontSize', 17)

% Plot Glucagon
subplot(1,3,3)
plot(glucagon_time, lower_glucagon, 'Color', [.7 .7 .7])
hold on
plot(glucagon_time, upper_glucagon, 'Color', [.7 .7 .7])
patch('XData', [glucagon_time fliplr(glucagon_time)], ...
    'YData', [lower_glucagon fliplr(upper_glucagon)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
hold on
plot(glucagon_time, all_glucagon_data, '-o', 'Color', [0.5 0.5 0.5], 'lineWidth', 0.7, 'HandleVisibility', 'off')
plot(glucagon_time, glucagon_mean, '-o', 'Color', 'r', 'lineWidth', 1.5)
xlim([0 180])
title('Glucagon', 'FontSize', 20)
xlabel('Time, minutes', 'FontSize', 17)
ylabel('Glucagon, pmol/L', 'FontSize', 17)
legend('', '', '95% C.I.', 'Median', 'FontSize', 17)

% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'DataPlot.pdf';
saveas(gcf, figurename); % Save Figure in Folder
            