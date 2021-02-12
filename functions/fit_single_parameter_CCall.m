function [Fit, constants, Goodness_of_Fit] = fit_single_parameter_CCall (Param_Avg, FitTypes, current_injected, interpolation_points, FLAG_plot)
% This function performs either a Liner, Logistic or Exponential fit on a 
% single parameter of a single experiment.

% Options.
n_fits = 3;

% Interpolate Data Points.
Data_interpolated = interp1(current_injected, Param_Avg', interpolation_points);
interpolation_points(~isfinite(Data_interpolated)) = NaN;
Data_interpolated(~isfinite(Data_interpolated)) = NaN;
interpolation_points(isnan(Data_interpolated)) = [];
Data_interpolated(isnan(Data_interpolated)) = [];
Parameter_Max = nanmax(Param_Avg);
Parameter_Min = nanmin(Param_Avg);

if isnan(Parameter_Max) && isnan(Parameter_Min) || numel(Param_Avg(~isnan(Param_Avg))) < 3
    Fit = NaN;
    Goodness_of_Fit = NaN;
    Fit = NaN;
    Goodness_of_Fit = NaN;
    constants.steepness = NaN;
    constants.zero_intercept = NaN;
else
    switch FitTypes
            % Linear
        case 'Linear'
            SumSquaredError = NaN(1, n_fits);
            for i_fit = 1:n_fits % Tries to perform fit 3 times, takes the best.
                try
                    [Fit_tmp{i_fit}, Goodness_of_Fit_tmp{i_fit}] = fit(interpolation_points, Data_interpolated, 'poly1');
                catch
                    Fit_tmp{i_fit} = NaN;
                    Goodness_of_Fit_tmp{i_fit}.sse = NaN;
                end
                SumSquaredError(i_fit) = Goodness_of_Fit_tmp{i_fit}.sse;
            end
            [min_error, best_fit_n] = nanmin(SumSquaredError);
            if isnan(min_error)
                Fit = NaN;
                Goodness_of_Fit = NaN;
                constants.steepness = NaN;
                constants.zero_intercept = NaN;
            else
                Fit = Fit_tmp{best_fit_n};
                Goodness_of_Fit = Goodness_of_Fit_tmp{i_fit};
                constants.steepness = Fit.p1;
                constants.zero_intercept = Fit.p2;
            end
            
            % Logistic
        case 'Logistic'
            SumSquaredError = NaN(1, n_fits);
            for i_fit = 1:n_fits % Tries to perform fit 3 times, takes the best.
                try
                    [Fit_tmp{i_fit}, Goodness_of_Fit_tmp{i_fit}] = fit_logistic_simple (interpolation_points, Data_interpolated, Parameter_Min, Parameter_Max, 0);
                catch
                    Fit_tmp{i_fit} = NaN;
                    Goodness_of_Fit_tmp{i_fit}.sse = NaN;
                end
                SumSquaredError(i_fit) = Goodness_of_Fit_tmp{i_fit}.sse;
            end
            [min_error, best_fit_n] = nanmin(SumSquaredError);
            if isnan(min_error)
                Fit = NaN;
                Goodness_of_Fit = NaN;
                constants.steepness = NaN;
                constants.midpoint_x = NaN;
            else
                Fit = Fit_tmp{best_fit_n};
                Goodness_of_Fit = Goodness_of_Fit_tmp{i_fit};
                constants.steepness = Fit.k;
                constants.midpoint_x = Fit.x0;
            end
            
            % Exponential
        case 'Exponential'
            SumSquaredError = NaN(1, n_fits);
            for i_fit = 1:n_fits % Tries to perform fit 3 times, takes the best.
                try
                    [Fit_tmp{i_fit}, Goodness_of_Fit_tmp{i_fit}] = fit(interpolation_points, Data_interpolated, 'exp1'); % a*exp(b*x)
                catch
                    Fit_tmp{i_fit} = NaN;
                    Goodness_of_Fit_tmp{i_fit}.sse = NaN;
                end
                SumSquaredError(i_fit) = Goodness_of_Fit_tmp{i_fit}.sse;
            end
            [min_error, best_fit_n] = nanmin(SumSquaredError);
            if isnan(min_error)
                Fit = NaN;
                Goodness_of_Fit = NaN;
                constants.start_value = NaN;
                constants.exp_constant = NaN;
            else
                Fit = Fit_tmp{best_fit_n};
                Goodness_of_Fit = Goodness_of_Fit_tmp{i_fit};
                constants.start_value = Fit.a; % a*exp(b*x)
                constants.exp_constant = NaN; % a*exp(b*x)
            end
            
    end
end

if FLAG_plot == 1
    figure(); hold on; box on; grid on;
    h_plot = plot(Fit, interpolation_points, Data_interpolated);
    h_plot(1).LineWidth = 1.5; h_plot(2).LineWidth = 1.5;
    h_plot(1).MarkerSize = 10;
    h_plot(2).Color = [0, 0, 0];    
    h_legend = legend({'Data', 'Fit'}, 'Location', 'NW');
    set(h_legend.BoxFace, 'ColorType','truecoloralpha', 'ColorData', uint8(255*[1; 1; 1; 0.25])); % Transparency
end

end