function [BestFit, FitType] = fit_single_parameter (Parameter_avg, Parameter_Max, Parameter_Min, current_injected, interpolation_points, FLAG_plot)
% This function fits Logistic, Linear, Exponential to each single parameter
% in the total experiments average, checks which one is the best fit, and
% saves it.

% Options
FORCE_LINEAR_FIT = 1;

% Interpolate Data Points.
Data_interpolated = interp1(current_injected, Parameter_avg', interpolation_points);
interpolation_points(~isfinite(Data_interpolated)) = NaN;
Data_interpolated(~isfinite(Data_interpolated)) = NaN;
interpolation_points(isnan(Data_interpolated)) = [];
Data_interpolated(isnan(Data_interpolated)) = [];
Parameter_Max = nanmax(Parameter_Max);
Parameter_Min = nanmin(Parameter_Min);

% Linear fits.
[Fits_tmp.Linear, Goodness_of_Fits.Linear] = fit(interpolation_points, Data_interpolated, 'poly1');

% Logistic fits.
[Fits_tmp.Logistic, Goodness_of_Fits.Logistic] = fit_logistic_simple (interpolation_points, Data_interpolated, Parameter_Min, Parameter_Max, 0);

% Logistic fits.
[Fits_tmp.Exp, Goodness_of_Fits.Exp] = fit(interpolation_points, Data_interpolated, 'exp1');

[~, Best_Fit_tmp] = min([Goodness_of_Fits.Linear.sse, Goodness_of_Fits.Logistic.sse, Goodness_of_Fits.Exp.sse]);
switch Best_Fit_tmp
    case 1
        BestFit = Fits_tmp.Linear;
        FitType = 'Linear';
    case 2
        BestFit = Fits_tmp.Logistic;
        FitType = 'Logistic';
    case 3
        BestFit = Fits_tmp.Exp;
        FitType = 'Exponential';
end

if FORCE_LINEAR_FIT == 1
    BestFit = Fits_tmp.Linear;
    FitType = 'Linear';
end

if FLAG_plot == 1
    figure(); hold on; box on; grid on;
    h_plot = plot(Fits_tmp.Linear, interpolation_points, Data_interpolated);
    h_plot(1).LineWidth = 1.5; h_plot(2).LineWidth = 1.5;
    h_plot(1).MarkerSize = 10;
    h_plot(2).Color = [0, 0, 0];
    h_plot = plot(Fits_tmp.Logistic);
    
    h_plot(1).LineWidth = 1.5;
    h_plot(1).Color = [0, 1, 0];
    
    h_plot = plot(Fits_tmp.Exp);
    h_plot(1).LineWidth = 1.5;
    h_plot(1).Color = [1, 0, 0];
    
    h_legend = legend({'Data', 'Linear Fit', 'Logistic Fit', 'Exponential Fit'}, 'Location', 'NW');
    set(h_legend.BoxFace, 'ColorType','truecoloralpha', 'ColorData', uint8(255*[1; 1; 1; 0.25])); % Transparency
end

end