%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to run random parameter
% and fit function for the insulin
% Glucose Saturation Model
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Clear the workspace
clc
clear
close all


tic

% Parameters to Change 
num_of_sets = 10;

% Set Scales
k1_scale = 600;
k2_scale = 50;
k3_scale = 1000;
delta2_scale = 1;
delta3_scale = 50;
delta4_scale = 50;
n_scale = 3;

% Set Parameter Values
num_of_params = 7;
scales = [k1_scale, k2_scale, k3_scale, delta2_scale, delta3_scale, delta4_scale, n_scale];

param_names = {'k_1', 'k_2', 'k_3', 'delta_2', 'delta_3', 'delta_4', 'n'};

% filename_strings = {'Fit_Data_Information_both_fit_IGS_delta3_only.mat'};

filename = 'PS_Results.mat';


% Run Min_Model_Param_Search_fits
TwoCompartmentPS(filename, num_of_params, ...
    num_of_sets, scales, param_names);

end_time = toc/60