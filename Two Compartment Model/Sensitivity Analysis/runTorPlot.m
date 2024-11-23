% CLEAR THE WORKSPACE
clear
clc
close all

% Add path
addpath('../../Data');

% Specify model
func = @myres;

% Parameter Name
param_names = {'k_1', 'k_2', 'k_3', '\delta_1', '\delta_2', '\delta_3', ...
    'n'};

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

% Specify percents
pcts = [0.05, 0.10, 0.15, 0.20];
% pcts = 0.05;

% Generate Tornado Plot
for i = 1:length(pcts)
    TorPlot(param_values, param_names, pcts(i), func);
end
