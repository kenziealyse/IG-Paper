% CLEAR THE WORKSPACE
clc
clear
close all

% Set Best Fit Parameter Values
startval = setvals();
pig_number = 5;
				
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

init_guess = [k1, k2, k3, k4, delta1, delta2, delta3, delta4, n, p, z, h];

% Set parameter lower bounds to 0
lb = zeros(length(init_guess), 1);

% Fit the data     
residual = @(params) myres_zeroInsulin(params, pig_number);
options = optimoptions('fmincon','Display','off');
[estimates, res] = fmincon(residual, init_guess, [], [], [], [],...
    lb, [], [], options);

% Load and save the data
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/all_pig_data.mat');
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/pig_time_data.mat');


insulin_data = pig_data.insulin_data(pig_number,:);
insulin_time = pig_time_data.insulin;
init_cond_insulin = insulin_data(1);

glucose_data = pig_data.glucose_data(pig_number,:);
init_cond_glucose = glucose_data(1);

glucagon_data = pig_data.glucagon_data(pig_number,:);
init_cond_glucagon = glucagon_data(1);

tspan = 0:.1:insulin_time(end);

% Initial Conditions
init_cond = [1, init_cond_insulin , init_cond_glucose, init_cond_glucagon];

% Simulate calibration results
[~,Y] = ode23s(@(t,Y) ThreeCompartmentModel(t,Y,estimates, @dosing_func, pig_number), tspan, init_cond);

% Relabel to easily keep track of compartments
B = Y(:,1);
I = Y(:,2);
G = Y(:,3);
GL = Y(:,4);


figure(1)

subplot(1,3,1)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')


subplot(1,3,2)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')

subplot(1,3,3)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')

save(['estimatesPig',num2str(pig_number), '.mat'], 'estimates');