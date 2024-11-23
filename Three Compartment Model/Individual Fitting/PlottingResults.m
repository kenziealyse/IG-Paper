% CLEAR THE WORKSPACE
clc
clear
close all

% Load the data
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/all_pig_data.mat');
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/pig_time_data.mat');

%% Pig 2
pig_number = 2;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

subplot(4,3,1)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(4,3,2)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(4,3,3)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)



%% Pig 3
pig_number = 3;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

subplot(4,3,4)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(4,3,5)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(4,3,6)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)




%% Pig 4
pig_number = 4;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

subplot(4,3,7)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(4,3,8)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(4,3,9)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)



%% Pig 6
pig_number = 6;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

subplot(4,3,10)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
xlabel('Time, days', 'FontSize', 17)
ylabel('Insulin', 'FontSize', 15)


subplot(4,3,11)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
xlabel('Time, days', 'FontSize', 17)
ylabel('Glucose', 'FontSize', 15)


subplot(4,3,12)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
xlabel('Time, days', 'FontSize', 17)
ylabel('Glucagon', 'FontSize', 15)



%% Not nice pig data (missing last glucagon value)

%% Pig 8
pig_number = 8;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

figure(2)

subplot(3,3,1)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(3,3,2)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(3,3,3)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)



%% Pig 9
pig_number = 9;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

figure(2)

subplot(3,3,4)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(3,3,5)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(3,3,6)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)

%% Pig 10
pig_number = 10;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

figure(2)

subplot(3,3,7)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(3,3,8)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(3,3,9)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)



%% Insulin Zero

%% Pig 1
pig_number = 1;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

figure(3)

subplot(3,3,1)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(3,3,2)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(3,3,3)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)

%% Pig 5
pig_number = 5;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

subplot(3,3,4)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(3,3,5)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(3,3,6)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)

%% Pig 7
pig_number = 7;

load(['estimatesPig',num2str(pig_number), '.mat'])

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

subplot(3,3,7)
plot(tspan, I, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, insulin_data, 'o', 'Color', 'r')
ylabel('Insulin', 'FontSize', 15)


subplot(3,3,8)
plot(tspan, G, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucose_data, 'o', 'Color', 'r')
title(['Pig ', num2str(pig_number)], 'FontSize', 20)
ylabel('Glucose', 'FontSize', 15)


subplot(3,3,9)
plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.3)
hold on
plot(insulin_time, glucagon_data, 'o', 'Color', 'r')
ylabel('Glucagon', 'FontSize', 15)


