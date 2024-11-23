# IG Paper
Author: Mackenzie Dalton
Date: 2/2024


Three Compartment Model Folder README:

***********************************************************************

Folder: Parameter Search

Code:

dosing_func.m: Function containing glucose dosing info

myres.m: Function to caluclate residual

randomize_param_values.m: Function to randomize parameters

runPS_TwoCompartmentModel.m: File to run the parameter search fits (the file you
want to run)

TwoCompartmentModel.m: Function of ODE for two compartment model

TwoCompartmentPS: Function to randomize initial conditions of parameters and 
then use this initial conditions to fit the data using fmincon 

***********************************************************************

Folder: Sensitivity Analysis

Code:

dosing_func.m: Function containing glucose dosing info

myres.m: Function to caluclate residual

run_sim_TwoCompartmentModel.m: Plots overlay of best fit for the two
compartment model against data

runTorPlot.m: Runs and plots the tornado plots which increase and decreases 
parameter values to ensure we are at a minimum. 

setvals.m: Sets the parameter values to the best fit parameter values
from the parameter search.

TorPlot: Tornado plot function (Not written by me, see code for credits).

TwoCompartmentModel.m: Function of ODE for two compartment model

