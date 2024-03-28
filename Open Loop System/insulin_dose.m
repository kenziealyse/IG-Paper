function insulin_dose = insulin_dose(t)

persistent fitting_data

if isempty(fitting_data)
    [fitting_data, ~] = load_fitting_data();
end

% if  t == 0 || t > 1
%     insulin_dose = 0;
% else 
%     insulin_data = fitting_data.insulin;
%     init_cond_insulin = insulin_data(1);
%     insulin_dose = max(insulin_data) - init_cond_insulin;
% end

if  t < 6  || t > 7.15
    insulin_dose = 0;
else 
    insulin_data = fitting_data.insulin;
    init_cond_insulin = insulin_data(1);
    insulin_dose = max(insulin_data) - init_cond_insulin;
end

end