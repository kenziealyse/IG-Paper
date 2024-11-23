function res = CostFunction(G, I, ...
        glucose_measurements, insulin_measurements)

    if isrow(glucose_measurements) ~= isrow(G)
        glucose_measurements = glucose_measurements';
        insulin_measurements = insulin_measurements';
    end

    G = real(G);
    I = real(I);

    glucose_resid = sum(((G - glucose_measurements)./(glucose_measurements)).^2);
    blood_insulin_resid = sum(((I - insulin_measurements)./(insulin_measurements)).^2);

    res = glucose_resid + blood_insulin_resid;

    RSS = sum((I - insulin_measurements).^2) + sum((G - glucose_measurements).^2);
    TSS = sum((I - mean(insulin_measurements)).^2) + sum((G - mean(glucose_measurements)).^2);
    Rsquared = 1 - (RSS/TSS);
    datapoints = 2*length(insulin_measurements);
    independentvars = 7;
    AdjustedRSquared = 1 - ((1-Rsquared)*(datapoints - 1)/(datapoints - independentvars - 1))


     if res < 0 
        disp(G)
        scale;
        return;
    end



end