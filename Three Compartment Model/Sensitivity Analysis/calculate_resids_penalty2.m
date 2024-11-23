function [glucose_resid, blood_insulin_resid, glucagon_resid, res] = calculate_resids_penalty2(G, I, GL, ...
        glucose_measurements, insulin_measurements, glucagon_measurements)

    if isrow(glucose_measurements) ~= isrow(G)
        glucose_measurements = glucose_measurements';
        insulin_measurements = insulin_measurements';
        glucagon_measurements = glucagon_measurements';
    end

    G = real(G);
    I = real(I);
    GL = real(GL);

% Calculate individual residuals
blood_insulin_resid = sum(((I - insulin_measurements)./(insulin_measurements)).^2);
glucose_resid = sum(((G - glucose_measurements)./(glucose_measurements)).^2);
glucagon_resid = sum(((GL - glucagon_measurements)./(glucagon_measurements)).^2);

RSS = sum((I - insulin_measurements).^2) + sum((G - glucose_measurements).^2) + sum((GL - glucagon_measurements).^2);
TSS = sum((I - mean(insulin_measurements)).^2) + sum((G - mean(glucose_measurements)).^2) + sum((GL - mean(glucagon_measurements)).^2);


Rsquared = 1 - (RSS/TSS);
datapoints = 3*length(insulin_measurements);
independentvars = 12;
AdjustedRSquared = 1 - ((1-Rsquared)*(datapoints - 1)/(datapoints - independentvars - 1));

% Sum up the individual residuals
res = blood_insulin_resid + ...
    glucose_resid + ...
    glucagon_resid;

    if res < 0 
        G
        scale
        return;
    end


end