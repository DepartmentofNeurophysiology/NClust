function [Fits, Fit_Constants, Goodness_of_Fits] = fit_CCall(experiments, FitTypes)
% This function performs the fit for all the CC experiments.
% It relies in several other functions, from the series "fit_".


%% Options
FLAG_plot = 0;


%% Initialize variables.
tic
current_injected = (40:40:400)';
interpolation_points = (0:5:400)';

number_of_CCexperiments = numel(experiments);

for i_exp = 1:number_of_CCexperiments
    fprintf('Fitting parameters for experiment %d...\n', i_exp);
    Averages = experiments(i_exp).CC_Data_Means;
    [Fits(i_exp), Fit_Constants(i_exp) Goodness_of_Fits(i_exp)] = fit_all_parameters(Averages, FitTypes, current_injected, interpolation_points, FLAG_plot);
end
