%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fitting_data, fitting_time_data] = load_fitting_data()

    fitting_data = load('pig_data_median.mat');
    fitting_data = fitting_data.median_pig_data;
    fitting_time_data = load('pig_time_data.mat');
    fitting_time_data = fitting_time_data.pig_time_data;

end

