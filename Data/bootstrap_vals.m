% Clear the Workspace
clear
clc
close all

% Number of Samples
num_of_samples = 1000*4;
savedata = 0; % 1 to save data

% Save the original data
tspan = [0 2 5 10 20 30 45 60 90 120 180];

pig_time_data = struct();

pig_time_data.glucose = tspan();
pig_time_data.insulin = tspan();
pig_time_data.glucagon = tspan();

glucose_data = [5.3 19.7 17 13.9 8.7 4.9 2.9 3.7 3.9 3.9 4.1;
    5 19.5 16.8 13 7 2.8 3.5 4.4 5 4.6 4.7;
    6.1 18 16 11.6 5.1 2.4 3.4 4.9 5.9 5.7 5.5;
    5.8 19.4 15.9 13.3 5.3 2.2 4.4 5.1 5 5 4.9;
    5.4 18.9 17.4 12.9 5.9 2.4 3.5 4.2 4 4.4 4.5;
    5.8 19.4 16.6 13.2 9 6 4.4 5.3 6 6.2 6.2;
    6.3 18.2 16.5 13.6 9.5 6.5 5.3 4.7 5 4.7 4.9;
    5.2 20.1 16.9 12.4 4.4 1.5 4.1 5.4 5.3 5.3 5.4;
    6.3 20.1 17.2 13.2 6.3 2.7 3.7 5.2 5.7 5.8 6;
    6.2 20.1 17.3 13.3 6.5 2.8 3.4 5.3 5.7 5.5 5.8];

insulin_data = [0.01 0.41 0.41 0.57 0.47 0.08 0.02 0.01 0.00 0.01 0.01;
    0.01 0.43 0.46 0.71 0.32 0.08 0.02 0.01 0.06 0.03 0.02;
    0.02 0.36 0.39 0.53 0.16 0.05 0.02 0.02 0.16 0.02 0.04;
    0.05 0.43 0.53 0.65 0.16 0.05 0.02 0.07 0.01 0.02 0.08;
    0.00 0.42 0.49 0.52 0.25 0.05 0.01 0.00 0.00 0.00 0.01;
    0.07 0.56 0.54 0.62 0.41 0.10 0.02 0.06 0.06 0.10 0.08;
    0.01 0.30 0.38 0.49 0.33 0.07 0.01 0.00 0.00 0.01 0.02;
    0.02 0.36 0.32 0.61 0.16 0.04 0.01 0.03 0.02 0.04 0.05;
    0.04 0.43 0.49 0.73 0.24 0.05 0.01 0.01 0.03 0.06 0.04;
    0.07 0.39 0.39 0.55 0.17 0.06 0.01 0.01 0.04 0.02 0.08];

glucagon_data = [10.9 5.9 2.6 1.2 1.1 1.8 6.5 32.7 35.0 36.2 32.0;
    5.8 2.1 1.8 1.5 1.7 4.9 46.2 14.3 5.9 5.5 8.8;
    7.0 4.2 2.0 1.3 3.3 4.8 12.9 12.4 9.9 9.0 14.4;
    9.0 4.9 3.0 2.7 2.3 2.7 5.4 6.8 12.4 14.8 16.9;
    5.7 2.4 0.8 0.6 1.2 4.8 31.9 17.6 11.2 8.1 9.6;
    8.7 5.3 4.4 3.5 3.0 8.3 17.9 13.1 7.0 5.8 7.9;
    7.9 3.0 1.3 2.0 1.8 5.7 13.0 11.0 6.6 7.0 5.9;
    6.6 3.8 1.4 0.6 0.7 3.2 21.7 11.6 11.1 10.9  NaN;
    8.3 3.7 2.6 1.8 1.8 4.9 37.1 16.5 13.0 19.4 NaN;
    6.8 4.2 3.3 2.6 2.8 3.7 4.1 5.0 5.0 5.8 NaN];

pig_data = struct();

pig_data.glucose_data = glucose_data;
pig_data.insulin_data = insulin_data;
pig_data.glucagon_data = glucagon_data;


% Pre Allocate Space
glucose_meds = zeros(num_of_samples, length(tspan));
insulin_meds = zeros(num_of_samples, length(tspan));
glucagon_meds = zeros(num_of_samples, length(tspan));

orig_med_glucose = median(glucose_data, 1);
orig_med_insulin = median(insulin_data, 1);
orig_med_glucagon = nanmedian(glucagon_data, 1);

median_pig_data = struct();

median_pig_data.glucose = orig_med_glucose;
median_pig_data.insulin = orig_med_insulin;
median_pig_data.glucagon = orig_med_glucagon;


% glucose_all = zeros(num_of_samples*10, length(tspan));
% insulin_all = zeros(num_of_samples*10, length(tspan));
% glucagon_all = zeros(num_of_samples*10, length(tspan));

glucose_all = [];
insulin_all = [];
glucagon_all = [];

parfor i = 1:num_of_samples

    glucose_bootstrap = datasample(glucose_data,10,1,'Replace',true);
    glucose_meds(i,:) = median(glucose_bootstrap, 1);
    glucose_all = [glucose_all; glucose_bootstrap]; 
    
    insulin_bootstrap = datasample(insulin_data,10,1,'Replace',true);
    insulin_meds(i,:) = median(insulin_bootstrap, 1);
    insulin_all = [insulin_all; insulin_bootstrap]; 
    
    glucagon_bootstrap = datasample(glucagon_data,10,1,'Replace',true);
    glucagon_meds(i,:) = nanmedian(glucagon_bootstrap, 1);
    glucagon_all = [glucagon_all; glucagon_bootstrap]; 

end

std_err_insulin = (std(insulin_all, 0, 1)./sqrt(num_of_samples))';
std_err_glucose = (std(glucose_all, 0, 1)./sqrt(num_of_samples))';
std_err_glucagon = (nanstd(glucagon_all, 0, 1)./sqrt(num_of_samples))';

std_insulin = std(insulin_all)';
std_glucose = std(glucose_all)';
std_glucagon = nanstd(glucagon_all)';

var_insulin = var(insulin_all)';
var_glucose = var(glucose_all)';
var_glucagon = nanvar(glucagon_all)';

glucose_all_median = median(glucose_all, 1);
insulin_all_median = median(insulin_all, 1);
glucagon_all_median = nanmedian(glucagon_all, 1);


lower_insulin = prctile(insulin_meds, 2.5);
upper_insulin = prctile(insulin_meds, 97.5);

lower_glucose = prctile(glucose_meds, 2.5);
upper_glucose = prctile(glucose_meds, 97.5);

lower_glucagon = prctile(glucagon_meds, 2.5);
upper_glucagon = prctile(glucagon_meds, 97.5);

% Save the Data
glucose_CI_data = struct();
insulin_CI_data = struct();
glucagon_CI_data = struct();

glucose_CI_data.lower = lower_glucose;
glucose_CI_data.upper = upper_glucose;

insulin_CI_data.lower = lower_insulin;
insulin_CI_data.upper = upper_insulin;

glucagon_CI_data.lower = lower_glucagon;
glucagon_CI_data.upper = upper_glucagon;


% Specify the filename for the .mat file
glucose_filename = 'glucose_CI_data.mat';
insulin_filename = 'insulin_CI_data.mat';
glucagon_filename = 'glucagon_CI_data.mat';
all_data_filename = 'all_pig_data.mat';
median_data_filename = 'pig_data_median.mat';
pig_time_data_filename = 'pig_time_data.mat';


% Save the matrix to the .mat file
if savedata == 1
save(glucose_filename, 'glucose_CI_data');
save(insulin_filename, 'insulin_CI_data');
save(glucagon_filename, 'glucagon_CI_data');
save(median_data_filename, 'median_pig_data');
save(all_data_filename, 'pig_data');
save(pig_time_data_filename , 'pig_time_data')
else 
    % Do nothing
end


