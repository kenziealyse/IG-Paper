%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [insulin, glucose, glucagon] = load_CI_Data()

    insulin = load('insulin_CI_data.mat');
    glucose = load('glucose_CI_data.mat');
    glucagon = load('glucagon_CI_data.mat');

end

