function [low,high] = TorPlot(data, names, sensitivity, fh, model)
% TorPlot  A function for generating tornado plots. This program calculates
% a baseline value using the function handle provided, or defaulting to 
% summing the vector 'data'. Each element of 'data' is
% then changed by a certain sensitivity value and the elements in 'data'
% are calculated again, with only the current single element having been
% changed.
%
% Sensitivity plots are useful in assessing importance and weight in
% engineering systems. Preliminary assessments benefit from sensitivity
% analysis, mainly because they highlight the driving factors.
%   Copyright 2013 Richard C.J. McCulloch
%   $Revision.1 $  $Date: 27-Jun-2013 $

if isempty(data) 
    error(message('No data was passed to the function TorPlot')); 
end
    if nargin < 3, sensitivity=0.2; % if no sensitivity is given assume 20%
        if nargin < 2
            names = repmat(char(0),length(data),1);
        end
    end

% Initialize low and high matricies for speed
Objective_low = zeros(1,length(names));
Objective_high = zeros(1,length(names));
Objective_low_sum = zeros(1,length(names));
Objective_high_sum = zeros(1,length(names));
low = zeros(1,length(names));
high = zeros(1,length(names));

% Calculate the base change due to a single factor at a time
    for i = 1:length(names)
        Objective_low = data;
        Objective_high = data;
        Objective_low(i) = Objective_low(i)*(1 - sensitivity);
        Objective_high(i) = Objective_high(i)*(1 + sensitivity);
        Objective_low_sum(i) = fh(Objective_low, model);
        Objective_high_sum(i) = fh(Objective_high, model);
        low(i) = Objective_low_sum(i);
        high(i) = Objective_high_sum(i); 
        % The base value is where the y axis is centered
        Objective_base_value = fh(data, model);
    end

% Sort the values based on the lower change
% Sort the higher values and the names arrays
% using the same indices

[Objective_low_sum,ind] = sort(Objective_low_sum,'descend');
Objective_high_sum = Objective_high_sum(ind);
names_Objective = names(ind);

% Create a figure and plot the low and high horizontally

ynum = 1:1:length(names);
vals = [Objective_high_sum; Objective_low_sum];

figure()
f.Position(4) = 600;
b = barh(ynum, vals, 'BaseValue', Objective_base_value);
xmin = min([min(Objective_low_sum), min(Objective_high_sum)]);
xmax = max([max(Objective_low_sum),max(Objective_high_sum)]);
xlim([1 5])
xticks(1:0.5:5)
b(1).FaceColor = [0.8 0.8 0.8];
b(2).FaceColor = [0.6 0.6 0.6];
pct_change = sensitivity*100; 
legend([num2str(pct_change), '% increase'], [num2str(pct_change), '% decrease'], 'FontSize', 20)
if nargin > 1
    set(gca,'yticklabel',names, 'FontSize', 18)
    set(gca,'Ytick', ynum,'YTickLabel',[1:length(names)], 'FontSize', 18)
    set(gca,'yticklabel',names_Objective, 'FontSize', 18)
end
xlabel('Cost Function Value', 'FontSize', 25)

% Save the figure as pdf
set(gcf, 'Units', 'Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
figurename = strcat('Minmod', num2str(pct_change), '.pdf');
saveas(gcf, figurename); % Save Figure in Folder
