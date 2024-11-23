# IG Paper
Author: Mackenzie Dalton
Date: 2/2024


Minimal Model Folder README:


***********************************************************************

Folder: Fitting 

Folder for fitting doing a parameters search to fit the min model against 
insulin and glucose data.


Code:

dosing_func.m: Function containing glucose dosing info

MinModel_func.m: Function containing min model equations

myres.m: Function to caluclate residual

PS_MinModel.m: Function to randomize initial conditions of parameters and 
then use this initial conditions to fit the data using fmincon 

runPS_MinModel_func.m: File to run the parameter search fits (the file you
want to run)

randomize_param_values.m: Function to randomize parameters



***********************************************************************

Folder: Sensitivity Analysis

Code:

dosing_func.m: Function containing glucose dosing info

MinModel_func.m: Function containing min model equations

myres.m: Function to caluclate residual

loglikelihood_minmod.m: Function to calculate log likelihood by fixing one 
parameter at a time and fitting the rest. This was exporatory and not 
inculuded in the final paper. 

plot_results.m: Plots the results of the loglikelihood exploration.

Plotting_Simulations.m: Plots the simulations results for the best fit
parameter set from the parameter search. 

runTorPlot.m: Runs and plots the tornado plots which increase and decreases 
parameter values to ensure we are at a minimum. 

setvalsMinMod: Sets the parameter values to the best fit parameter values
from the parameter search.

TorPlot: Tornado plot function (Not written by me, see code for credits).

