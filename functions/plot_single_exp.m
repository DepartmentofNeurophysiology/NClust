function plot_single_exp (selected_exp)
% This function plots every parameter for the CC Step 
% for a given experiment, over the current injections.

n_parameters = 70;
raws = 10;
columns = 7;

plotLineWidth = 1.5;
plotColor = [0, 0, 1];

% Get Data
Data_Means = selected_exp.CC_Data_Means;
Data_Stds = selected_exp.CC_Data_Stds;

% Exponential fits

% f = a*exp(b*x)
current_injected = (40:40:400)';
interpolation_points = (0:1:400)';
Data_interpolated = interp1(current_injected, Data_Means.APcount', interpolation_points);
Data_interpolated(isnan(Data_interpolated)) = 0;
Fits.APcount = fit(interpolation_points, Data_interpolated, 'exp1');

[param] = sigmoid_fit (interpolation_points, Data_interpolated);
Constants.APcount.a = Fits.APcount.a;
Constants.APcount.b = Fits.APcount.b;


figure();
set(gcf,'position', get(0,'screensize'));
i_plot = 1;

subplot(n_parameters/raws, n_parameters/columns, i_plot);
hold on;
errorbar(current_injected, Data_Means.APcount, Data_Stds.APcount, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
plot(Fits.APcount, current_injected, Data_Means.APcount)
title('APcount')
i_plot = i_plot + 1;

end