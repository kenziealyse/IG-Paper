%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function for glucose dosing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dose = dosing_func(t)

persistent fitting_data

if isempty(fitting_data)
    [fitting_data, ~] = load_fitting_data();
end

glucose_data = fitting_data.glucose;

    if  t == 0 || t > 1
        dose = 0;
    else
        dose = glucose_data(2) - glucose_data(1) + 1
    end

%     if  t < 5 || t > 6
%         dose = 0;
%     else
%         dose = glucose_data(2) - glucose_data(1) + 1;
%     end

end

