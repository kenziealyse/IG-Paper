%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for glucose dosing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dose = dosing_func(t, pig_number)

persistent fitting_data

if isempty(fitting_data)
    fitting_data = load('/Users/kenzdalt/Documents/MATLAB/IG Paper/Data/all_pig_data.mat');
end

glucose_data = fitting_data.pig_data.glucose_data(pig_number, :);

    if  t == 0 || t > 1
        dose = 0;
    else
        dose = glucose_data(2) - glucose_data(1) + 1;
    end

end

