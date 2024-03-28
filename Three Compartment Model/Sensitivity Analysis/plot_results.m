% CLEAR THE WORKSPACE
clear
clc
close all

% Add data path
addpath('../../Data');

% Choose results to plot
results = load('Loglikelihood_Results.mat');

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();

% Save the data
insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
glucose_data = fitting_data.glucose;
glucose_time = time_data.glucose;
glucagon_data = fitting_data.glucagon;
glucagon_time = time_data.glucagon;

% Calculate the mean of data
insulin_mean = mean(insulin_data);
glucose_mean = mean(glucose_data);
glucagon_mean = mean(glucagon_data);

% Save the standard errors
std_err_insulin = [7.7335e-05 0.00020302 0.00021799 0.00024231 0.00033674 ...
   5.6691e-05 1.5811e-05 7.3459e-05 0.00014607 8.8759e-05 8.609e-05]';

std_err_glucose = [0.0014562 0.0022855 0.0015468 0.001946 0.0052787 ...
    0.0051817 0.0020822 0.0016887 0.002207 0.0021436 0.0020597]';

std_err_glucagon = [0.004845 0.0036697 0.0032412 0.002825 0.0025889 ...
    0.0054219 0.043229 0.022841 0.026024 0.028626 0.026243]';

% Save the standard deviations
std_insulin = [0.024483 0.064354 0.06892 0.076647 0.10641 0.017928 ...
        0.005 0.023151 0.046063 0.028079 0.027218]';

std_glucose = [0.46099 0.71836 0.48842 0.60968 1.6649 1.6373 0.65844 ...
      0.53434 0.69759 0.67928 0.65345]';

std_glucagon = [1.5281 1.1572 1.0208 0.88969 0.81905 1.704 13.677 ...
       7.2097 8.2096 9.0294 8.2919]';

% Calculate sigma squared and threshold
sigmasq = (mean([(std_insulin./insulin_data'); ...
    (std_err_glucose./glucose_data'); (std_err_glucagon./glucagon_data')])).^2;

variance = var([(std_insulin./insulin_data'); ...
    (std_err_glucose./glucose_data'); (std_err_glucagon./glucagon_data')])

std = std([(std_insulin./insulin_data'); ...
    (std_err_glucose./glucose_data'); (std_err_glucagon./glucagon_data')])

m = mean([(std_insulin./insulin_data'); ...
    (std_err_glucose./glucose_data'); (std_err_glucagon./glucagon_data')])

CV = std/m


threshold = sigmasq*chi2inv(0.95,12);


scale = results.information.scale;
index = find(scale == 1);
baseline_res = 0.97217;

% String of fixed parameters
fixed_param = {'k_1', 'k_2', 'k_3', 'k_4', 'delta_1', 'delta_2', ...
    'delta_3', 'delta_4', 'n', 'p', 'z', 'h', 'all'};

figure('units','normalized','outerposition', [0 0 1 1])
for i = 1:length(fixed_param) - 1
    field = fixed_param{i};
    subplot(4,3,i)
    plot(scale, results.information.(field).res, ':', 'Color', 'k', 'LineWidth', 1.2)
    hold on
    plot(1, baseline_res, '*', 'LineWidth', 2, 'Color', 'k')
    yline(baseline_res + threshold, '--', 'Color', 'r')
    ylim([0 20])
    yticks(1:5:20)
    xlim([0 10])
    xticks(0:1:10)
    if strcmpi(field(1), 'd')
        xlabel({['Fold Change in \', fixed_param{i}, ' Over Baseline']})
    else
        xlabel({['Fold Change in ', fixed_param{i}, ' Over Baseline']})
    end
    min_val(i) = min(results.information.(field).res);

end

min_val
minimum = min(min_val)
ind = find(min_val == minimum)
field = fixed_param{ind}


ind = find(results.information.(field).res == minimum)
est = results.information.(field).estimates(ind,:)'
scale(ind)