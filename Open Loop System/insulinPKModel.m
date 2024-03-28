function C = insulinPKModel(t, insulindose, dose_time, halflife)

% Set Parameter Values
k = log(2)/halflife;

% ODE equation
if t >= dose_time
    C = insulindose.*(exp(-k.*t));
else
    C = 0;
end


end