%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to run random parameter
% and fit function for the insulin,
% Glucose, Glucagon Saturation Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc

tic
% Parameters
num_of_sets = 1000;
gamma_vals = [1, 2, 3, 4];

% Set Scales
k1_scale = 2;
k2_scale = 100;
delta2_scale = 10;
delta3_scale = 2;
delta4_scale = 2;
n_scale = 10;
p_scale = 10;
z_scale = 10;
h_scale = 4;

model = @IGGlSS_func1;

param_names = {'k_1', 'k_2', '\delta_2', '\delta_3', '\delta_4', 'n', 'p', ...
    'z', 'h'};

% Set Parameter Values
num_of_params = 9;
scales = [k1_scale, k2_scale, ...
     delta2_scale, delta3_scale, delta4_scale, n_scale, p_scale, z_scale, h_scale];

filename_strings = {'Glucose_fit_IGGlSS1_logfit_endSS_diffinGdose_median_data.mat',...
    'Insulin_fit_IGGlSS1_logfit_endSS_diffinGdose_median_data.mat', ...
    'Glucagon_fit_IGGlSS1_logfit_endSS_diffinGdose_median_data.mat', ...
    'All_fit_IGGlSS1_logfit_endSS_diffinGdose_median_data.mat'};

% Run Min_Model_Param_Search_fits
Fit_Data_Information1 = Min_Model_Param_Search_fits(gamma_vals, ...
    filename_strings, num_of_params, num_of_sets, scales, param_names, model);

end_time = (toc/60)/60