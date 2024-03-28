% CLEAR THE WORKSPACE
clear
clc
close all

% Add path
addpath('../Model');
addpath('../../Data');

% Specify model
func = @C2;
model = @IGGlSS_func1_noSS;

% Specify number of parameter sets to generate
num_sets = 12;

% Parameter Name
param_names = {'k_1', 'k_2', 'k_3', 'k_4', '\delta_1', '\delta_2', '\delta_3', ...
    '\delta_4', 'n', 'p', 'z', 'h'};

% Given parameter values
startval = setvals();

k1 = startval(1);
k2 = startval(2);
k3 = startval(3);
k4 = startval(4);
delta1 = startval(5);
delta2 = startval(6);
delta3 = startval(7);
delta4 =  startval(8);
n = startval(9);
p = startval(10);
z = startval(11);
h = startval(12);

parameter_matrix = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h];

% Specify percents
pcts = [0.05, 0.1, 0.15, 0.2];

% Generate Tornado Plot
for i = 1:length(pcts)
    TorPlot(parameter_matrix, param_names, pcts(i), func, model);
end
