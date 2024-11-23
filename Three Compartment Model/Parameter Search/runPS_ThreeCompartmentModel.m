%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to run random parameter
% and fit function for the insulin,
% Glucose, Glucagon Saturation Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc

tic

% Number of Parameter Sets
num_of_sets = 10;

% Set Scales
k1_scale = 2;
k2_scale = 100;
k3_scale = 10;
k4_scale = 10;
delta1_scale = 1;
delta2_scale = 10;
delta3_scale = 2;
delta4_scale = 2;
n_scale = 10;
p_scale = 10;
z_scale = 10;
h_scale = 4;

param_names = {'k_1', 'k_2', '\delta_2', '\delta_3', '\delta_4', 'n', 'p', ...
    'z', 'h'};

% Set Parameter Values
num_of_params = 12;
scales = [k1_scale, k2_scale, k3_scale, k4_scale,...
     delta1_scale, delta2_scale, delta3_scale, delta4_scale, n_scale, p_scale, z_scale, h_scale];

% File name to save Results in Simulation_Data
filename = 'Results.mat';

% Run Three Compartment Parameter Search
ThreeCompartmentPS(filename, num_of_params, ...
    num_of_sets, scales, param_names);

end_time = (toc/60)/60