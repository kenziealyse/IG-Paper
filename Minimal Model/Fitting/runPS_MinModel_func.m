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

% Change path
addpath('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data')

% Parameters to Change 
num_of_sets = 5;
gamma_vals = 2;

% Set Scales
gamma_scale = 1;
h_scale = 5;
n_scale = 1;
P1_scale = 1;
P2_scale = 5;
P3_scale = 5;
mu_scale = 2;

% Set Parameter Values
num_of_params = 7;
scales = [gamma_scale, h_scale, n_scale, P1_scale, P2_scale, P3_scale, mu_scale];

filename = 'MinModPSRestuls.mat';

param_names = {'gamma'; 'h'; 'n'; 'P1'; 'P2'; 'P3'; '\mu'};

% Run Min_Model_Param_Search_fits
PS_MinModel(filename, num_of_params, num_of_sets, scales, param_names);

end_time = toc/60