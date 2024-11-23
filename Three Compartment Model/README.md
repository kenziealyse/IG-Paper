# IG Paper
Author: Mackenzie Dalton
Date: 2/2024


Three Compartment Model Folder README:

***********************************************************************

Folder: Individual Fitting

Code:

dosing_func.m: Function containing glucose dosing info

IndividualPigPlots.m: Function to plot the individual pig data

myres.m: Residual function for the "nice" pig data (no missing values or 
values that are equal to zero)

myres_shortGlucagon.m: Residual function for pigs missing glucagon data

myres_zeroInsulin.m: Residual function for pigs with insulin values equal 
to zero

ParameterHistograms.m: Plots distributions of best fit parameter values
from fitting to indivudal pigs

PlottingResults.m: Plots the best model fits for each pig against data from
each pig wiht each figure grouping pigs with "nice" data, missing data, and 
values of insulin equal to 0

PlottingResults2.m: Plots all best model fits for each pig against data
from each pig on one plot

setvals.m: Sets the parameter values to the best fit parameter values
from the parameter search.

ThreeCompartment_Fit.m: Fitting pigs with 'nice' data

ThreeCompartment_Fit_ShortGlucagon.m: Fitting for pigs with missing glucagon
data

ThreeCompartment_Fit_ZeroInsulin.m: Fitting for pigs with values of insulin
equal to zero

ThreeCompartmentModel: Function with IGG ODE model

***********************************************************************

Folder: Parameter Search

Code:

dosing_func.m: Function containing glucose dosing info

myres.m: Function to caluclate residual

randomize_param_values.m: Function to randomize parameters

runPS_ThreeCompartmentModel.m: File to run the parameter search fits (the file you
want to run)

ThreeCompartmentModel: Function with IGG ODE model

ThreeCompartmentPS.m: Function to randomize initial conditions of parameters and 
then use this initial conditions to fit the data using fmincon 

***********************************************************************

Folder: Sensitivity Analysis

Code:

dosing_func.m: Function containing glucose dosing info

loglikelihood.m: Function to calculate log likelihood by fixing one 
parameter at a time and fitting the rest. This was exporatory and not 
inculuded in the final paper. 

myres.m: Function to caluclate residual

plot_results.m: Plots results of log likelihood exploration. Must run 
loglikelihood first to plot these results

PlotOverlayResults.m: Plot IGG model best fit versus minimal model best
fit

plotting_simulations.m: Plotting IGG best fit

PlottingDiseaseState.m: IGG model simulations for different insulin
sensitivity factors (change delta_2)

runTorPlot.m: Runs and plots the tornado plots which increase and decreases 
parameter values to ensure we are at a minimum. 

setvalsMinMod: Sets the parameter values to the best fit parameter values
from the parameter search.

ThreeCompartmentModel: Function with IGG ODE model

TorPlot: Tornado plot function (Not written by me, see code for credits).


