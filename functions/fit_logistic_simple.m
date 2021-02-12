function [fitresult, goodness_of_fit] = fit_logistic_simple (X, Y, minY, maxY, FLAG_plot)
% Fit a logistic function: (minY + (maxY - minY))./(1 + exp((x - x0).*(-k)))
% (see https://en.wikipedia.org/wiki/Logistic_function, where L = minY + (maxY - minY), to include cases where minY != 0 and maxY != 0.
% X, Y = Data.
% minY, maxT can be specified for a more specific fit, or left blank [].
% FLAG_plot = 1 if you want to see the plot automatically.

% If min, max are specified.
if ~isempty(minY) && ~isempty(maxY)
    logistic_function = sprintf('(%d + (%d - %d))./(1 + exp((x - x0).*(-k)))', minY, maxY, minY);
end
% If min only is specified.
if ~isempty(minY) && isempty(maxY)
    logistic_function = sprintf('(%d + (maxY - %d))./(1 + exp((x - x0).*(-k)))', minY, minY);
end
% If max only is specified.
if isempty(minY) && ~isempty(maxY)
    logistic_function = sprintf('(minY + (%d - minY))./(1 + exp((x - x0).*(-k)))', maxY);
end
% If min/max are not specified.
if isempty(minY) && isempty(maxY)
    logistic_function = '(minY + (maxY - minY))./(1 + exp((x - x0).*(-k)))';
end

% Fit options.
opts = fitoptions('Method', 'NonlinearLeastSquares');
opts.Display = 'Off';
warning off

% Specify fit type.
fit_type = fittype(logistic_function, 'independent', 'x', 'dependent', 'y');

% Fit.
[fitresult, goodness_of_fit] = fit(X, Y, fit_type, opts );

% Plot fit with data.
if FLAG_plot == 1
    figure( 'Name', 'untitled fit 1' );
    h = plot( fitresult, X, Y );
    legend( h, 'YDATA vs. XDATA', 'untitled fit 1', 'Location', 'NorthEast');
    % Label axes
    xlabel XDATA
    ylabel YDATA
    grid on
end

warning on

end