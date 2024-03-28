%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to run random parameter
% and fit function for the insulin
% Glucose Saturation Model
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc

tic

% Parameters to Change 
num_of_sets = 5000;
gamma_vals = 2;

% Set Scales
gamma_scale = 1;
h_scale = 5;
n_scale = 1;
P1_scale = 1;
P2_scale = 5;
P3_scale = 5;
mu_scale = 2;


% Set Model
model = @MinModel_func;

% Set Parameter Values
num_of_params = 7;
scales = [gamma_scale, h_scale, n_scale, P1_scale, P2_scale, P3_scale, mu_scale];

filename_strings = 'Fit_Data_Information_both_fit_MinModel2.mat';

param_names = {'gamma'; 'h'; 'n'; 'P1'; 'P2'; 'P3'; '\mu'};

% Run Min_Model_Param_Search_fits
MinModel_Penalty_Min_Model_Param_Search_fits(gamma_vals, ...
    filename_strings, num_of_params, num_of_sets, scales, param_names, model);

end_time = toc/60