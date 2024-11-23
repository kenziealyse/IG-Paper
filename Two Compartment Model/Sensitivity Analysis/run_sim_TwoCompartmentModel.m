% CLEAR THE WORKSPACE
clear 
clc
close all

% Add path
addpath('../../Data');

% Load the data
[fitting_data, time_data] = load_fitting_data();
[insulin_CI_data, glucose_CI_data, glucagon_CI_data] = load_CI_Data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
lower_insulin = insulin_CI_data.insulin_CI_data.lower;
upper_insulin = insulin_CI_data.insulin_CI_data.upper;

glucose_data = fitting_data.glucose;
glucose_time = time_data.glucose;
lower_glucose = glucose_CI_data.glucose_CI_data.lower;
upper_glucose = glucose_CI_data.glucose_CI_data.upper;

glucagon_data = fitting_data.glucagon;
glucagon_time = time_data.glucagon;
lower_glucagon = glucagon_CI_data.glucagon_CI_data.lower;
upper_glucagon = glucagon_CI_data.glucagon_CI_data.upper;


% Set Intial Conditions
init_cond_insulin = insulin_data(1);
init_cond_glucose = glucose_data(1);
init_cond_glucagon = glucagon_data(1);

% Set Best Fit Parameter Values
startval = setvals();

% Paramter Values
k1 = startval(1);
k2 = startval(2);
k3 = startval(3);
delta1 = startval(4);
delta2 = startval(5);
delta3 = startval(6);
n = startval(7);

param_values = [k1 k2 k3 delta1 delta2 delta3 n]';

% Set Initial Conditions and Time
init_cond = [init_cond_insulin , init_cond_glucose];
tspan = 0:.1:180;

lb = zeros(length(param_values), 1);
init_guess = [k1 k2 k3 delta1 delta2 delta3 n]';

residual = @(param_values) myres(param_values);
options = optimoptions('fmincon','Display','off');
[estimates, res] = fmincon(residual, init_guess, [], [], [], [],...
        lb, [], [], options);

disp(res)
starting_estimates = estimates;
save('starting_estimates.mat', 'starting_estimates');

% Run Simulation With Best Fit Parameters
[T,Y] = ode23s(@(t,Y) TwoCompartmentModel(t,Y,estimates, @dosing_func), tspan, init_cond);

% Relabel to easily keep track of compartments
I = Y(:,1);
G = Y(:,2);

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
plot(insulin_time, insulin_data, 'o', 'lineWidth', 3, 'Color', 'r')
plot(tspan, I, 'Color', 'k', LineWidth=1.5)
title('Insulin', 'FontSize', 17)
xlabel('Minutes',  'FontSize', 17)
ylabel('Plasma Insulin',  'FontSize', 17)
legend('', '', '95% C.I.', 'Median', 'Simulation', fontsize=17)
xlim([0 180])


subplot(1,2,2)
plot(glucose_time, lower_glucose, 'Color', [.7 .7 .7])
hold on
plot(glucose_time, upper_glucose, 'Color', [.7 .7 .7])
patch('XData', [glucose_time fliplr(glucose_time)], ...
    'YData', [lower_glucose fliplr(upper_glucose)], 'FaceColor', [.7 .7 .7], ...
    'EdgeColor', [.7 .7 .7])
alpha(0.3)
plot(glucose_time, glucose_data, 'o', 'lineWidth', 3, 'Color', 'r')
plot(tspan, G, 'Color', 'k', LineWidth=1.5)
title('Glucose', 'FontSize', 17)
xlabel('Minutes',  'FontSize', 17)
ylabel('Plasma Glucose',  'FontSize', 17)
legend('', '', '95% C.I.', 'Median', 'Simulation', fontsize=17)
xlim([0 180])

% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'IGSModelBestFit.pdf';
saveas(gcf, figurename); % Save Figure in Folder