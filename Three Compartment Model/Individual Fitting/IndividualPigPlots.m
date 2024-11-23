% CLEAR THE WORKSPACE
clc
clear
close all

load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/all_pig_data.mat');
load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/pig_time_data.mat');


insulin_data = pig_data.insulin_data;
glucose_data = pig_data.glucose_data;
glucagon_data = pig_data.glucagon_data;

[num_of_pigs, ~] = size(insulin_data);

insulin_time = pig_time_data.insulin;
glucose_time = pig_time_data.glucose;
glucagon_time = pig_time_data.glucagon;

figure('units','normalized','outerposition',[0 0 1 1])

for i = 1:num_of_pigs
    subplot(3,4,i)
    plot(insulin_time, insulin_data(i, :), '-o', 'lineWidth', 1.3)
    title(['Pig ', num2str(i)])
end

sgtitle('Insuin Plots', 'FontSize', 17)


figure('units','normalized','outerposition',[0 0 1 1])

for i = 1:num_of_pigs
    subplot(3,4,i)
    plot(glucose_time, glucose_data(i, :), '-o', 'lineWidth', 1.3)
    title(['Pig ', num2str(i)])
end

sgtitle('Glucose Plots', 'FontSize', 17)

figure('units','normalized','outerposition',[0 0 1 1])

for i = 1:num_of_pigs
    subplot(3,4,i)
    plot(glucagon_time, glucagon_data(i, :), '-o', 'lineWidth', 1.3)
    title(['Pig ', num2str(i)])
end

sgtitle('Glucagon Plots', 'FontSize', 17)


