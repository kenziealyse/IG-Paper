% CLEAR THE WORKSPACE
clear
clc
close all

% Add path
addpath('../Minimal Model');
addpath('../../Data');

% Specify model
func = @C;
model = @MinModel_func;

% Specify number of parameter sets to generate
num_sets = 6;

% Parameter Name
param_names = {'\gamma', 'h', 'n', 'P1', 'P2', 'P3'};

% Given parameter values
startval = setvalsMinMod();

% Paramter Values
gamma = startval(1);
h = startval(2);
n = startval(3);
P1 = startval(4);
P2 = startval(5);
P3 = startval(6);

parameter_matrix = [gamma h n P1 P2 P3]';

% Percents
pcts = [0.05 0.1 0.15 0.2];

% Generate Tornado Plot
for i = 1:length(pcts)
    TorPlot(parameter_matrix, param_names, pcts(i), func, model);
end
