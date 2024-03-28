% CLEAR THE WORKSPACE
clc
clear
close all

% Load and Save the Data
[fitting_data, time_data] = load_fitting_data();

insulin_data = fitting_data.insulin;
insulin_time = time_data.insulin;
init_cond_insulin = insulin_data(1);
insulindose = max(insulin_data) - init_cond_insulin;
dose_time = 0.01;

glucose_data = fitting_data.glucose;
init_cond_glucose = glucose_data(1);

glucagon_data = fitting_data.glucagon;
init_cond_glucagon = glucagon_data(1);

% Sepcify Mode
model = @OpenLoopModelwithInsulinDose;

% Set insulin half life
halflife = [10, 60, 120];
LineStyles = {'-', '--' , ':'};

% Save the figure?
saveyesno = 1;

% Set Best Fit Parameter Values
startval = setvals();

k1 = startval(1);
k2 = startval(2);
k3 = startval(3);
k4 = startval(4);
delta1 = startval(5);
delta2 = startval(6);
delta3 = startval(7);
delta4 =  startval(8);
n = startval(9);
p = startval(10);
z = startval(11);
h = startval(12);

param_values = [k1 k2 k3 k4 delta1 delta2 delta3 delta4 n p z h];

% Time Span
tspan = 0:.1:180;

% Initial Conditions
init_cond = [init_cond_glucose, init_cond_glucagon];

% Figure
f = figure();
f.Position(4) = 600;
f.Position(3) = 1100;

for i = 1:length(halflife)
    % Simulate calibration results
    [tspan,Y] = ode23s(@(t,Y) model(t,Y,param_values, @dosing_func, insulindose, dose_time, halflife(i)), tspan, init_cond);
    
    % Preallocate Space
    I = zeros(length(tspan), 1);
    
    for j = 1:length(tspan)
        I(j) = insulinPKModel(tspan(j), insulindose, dose_time, halflife(i));
    end
    
    % Relabel Compartments to Easily Keep Track
    G = Y(:,1);
    GL = Y(:,2);
    
    % Plot           
    subplot(1,3,1)
    plot(tspan, I, 'Color',  'k', 'LineWidth', 1.3, 'LineStyle', LineStyles{i})
    ylabel('Insulin, \mug/L', 'FontSize', 17)
    xlabel('Time, minutes', 'FontSize', 17)
    xlim([0 180])
    xticks(0:20:180)
    Legend{i} = ['Half life = ', num2str(halflife(i)), ' minutes'];
    legend(Legend, 'FontSize', 12)
    hold on
    
    subplot(1,3,2)
    plot(tspan, G, 'Color',  'k', 'LineWidth', 1.5, 'LineStyle', LineStyles{i})
    ylabel('Glucose, mmol/L', 'FontSize', 17)
    xlabel('Time, minutes', 'FontSize', 17)
    xlim([0 180])
    xticks(0:20:180)
    hold on
    
    subplot(1,3,3)
    plot(tspan, GL, 'Color', 'k', 'LineWidth', 1.5, 'LineStyle', LineStyles{i})
    ylabel('Glucagon, pmol/L', 'FontSize', 17)
    xlabel('Time, minutes', 'FontSize', 17)
    xlim([0 180])
    xticks(0:20:180)
    hold on
    
    
    % Save the figure as pdf
  
end

if saveyesno == 1
        set(gcf, 'Units', 'Inches');
        pos = get(gcf, 'Position');
        set(gcf, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)]);
        figurename = strcat('OpenLoopModelwithInsulinIVDoseDiffHalflives', '.pdf');
        saveas(gcf, figurename); % Save Figure in Folder
 end