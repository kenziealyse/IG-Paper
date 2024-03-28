function [glucose_resid, blood_insulin_resid, res] = residual_func(G, I, ...
        glucose_measurements, insulin_measurements)

    if isrow(glucose_measurements) ~= isrow(G)
        glucose_measurements = glucose_measurements';
        insulin_measurements = insulin_measurements';
    end

    G = real(G);
    I = real(I);

    blood_insulin_resid = sum(((I - insulin_measurements)./(insulin_measurements)).^2);
    glucose_resid = sum(((G - glucose_measurements)./(glucose_measurements)).^2);

    res = glucose_resid + blood_insulin_resid;
    

     if res < 0 
        disp(G)
        scale;
        return;
    end



end