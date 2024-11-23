% CLEAR THE WORKSPACE
clc
clear
close all


% Define the list of .mat file names
file_names = {'estimatesPig1.mat', 'estimatesPig2.mat', 'estimatesPig3.mat', ...
    'estimatesPig4.mat', 'estimatesPig5.mat', 'estimatesPig6.mat', ...
    'estimatesPig7.mat', 'estimatesPig8.mat', 'estimatesPig9.mat', ...
    'estimatesPig10.mat'};
num_files = length(file_names);
load('starting_estimates.mat')

% Create a full-screen figure
figure('Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

% Initialize a cell array to hold parameter sets
param_data = cell(num_files, 1);

% Load parameter sets from each file
for i = 1:num_files
    data = load(file_names{i});
    param_data{i} = data.estimates; % Assuming the variable is named 'estimates'
end

% Concatenate parameter sets for each parameter
all_params = cat(1, param_data{:});

% Plot histograms for each parameter
num_params = size(all_params, 2); % Number of parameters (columns)

parameter_str = {'k_1', 'k_2', 'k_3', 'k_4', '\delta_1', '\delta_2', ...
    '\delta_3', '\delta_4', 'n', 'p', 'z', 'h'};

means = zeros(num_params, 2);

for param_idx = 1:num_params
    subplot(3, 4, param_idx); % Create a subplot for each parameter
    histogram(all_params(:, param_idx)); % PDF normalization
    hold on
    starting_value = starting_estimates(param_idx); % Get starting estimate for this parameter
    xline(starting_value, 'r', 'LineWidth', 2); % Add a red line at the starting estimate
    title(parameter_str(param_idx));
    xlabel('Value');
    ylabel('Frequency');
    % Set y-axis to whole numbers
    yticks(0:1:max(ylim)); % Adjust this range as necessary
    means(param_idx, 1) = round(mean(all_params(:, param_idx)), 2);
    means(param_idx, 2) = round(std(all_params(:, param_idx)), 2);
end

% Add a main title for the figure
% sgtitle('Histograms of Parameters'); % Title for the entire figure


% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = 'AllPigParamHisto.pdf';
saveas(gcf, figurename); % Save Figure in Folder