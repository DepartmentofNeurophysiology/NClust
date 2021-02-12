function [WholeDataAvg_BestFit, WholeDataAvg_FitType] = fit_DataSet_Averages (DataSet_Projections, number_of_CCexperiments)
% Fit options can be:
% [fitresult, goodness_of_fit] = fit_logistic_simple (X, Y, minY, maxY, FLAG_plot)
% leave parameters empty if min & max are unknown (fit will be less precise).
% [e1, e2] = fit(, 'exp1')      f(x) = e1*e^(e2*x)
% [l1, l2] = fit(, 'poly1')     f(x) = l1*x + l2
% Logistic fit.
% Fit a logistic function: (minY + (maxY - minY))./(1 + exp((x - x0).*(-k)))
% (see https://en.wikipedia.org/wiki/Logistic_function, where L = minY + (maxY - minY), to include cases where minY != 0 and maxY != 0.


%% Options
FLAG_plot = 0;


%% Initialize variables.
tic
current_injected = (40:40:400)';
interpolation_points = (0:5:400)';
DataSet_Averages = DataSet_Projections.Averages;
DataSet_Max = DataSet_Projections.Max;
DataSet_Min = DataSet_Projections.Min;


%% Fit Stuff.
[WholeDataAvg_BestFit.APcount, WholeDataAvg_FitType.APcount] = fit_single_parameter (DataSet_Averages.APcount, DataSet_Max.APcount, DataSet_Min.APcount, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.FR_abs, WholeDataAvg_FitType.FR_abs] = fit_single_parameter (DataSet_Averages.FR_abs, DataSet_Max.FR_abs, DataSet_Min.FR_abs, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.FR_ins, WholeDataAvg_FitType.FR_ins] = fit_single_parameter (DataSet_Averages.FR_ins, DataSet_Max.FR_ins, DataSet_Min.FR_ins, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AP_lat_first, WholeDataAvg_FitType.AP_lat_first] = fit_single_parameter (DataSet_Averages.AP_lat_first, DataSet_Max.AP_lat_first, DataSet_Min.AP_lat_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_lat_last, WholeDataAvg_FitType.AP_lat_last] = fit_single_parameter (DataSet_Averages.AP_lat_last, DataSet_Max.AP_lat_last, DataSet_Min.AP_lat_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_lat_window, WholeDataAvg_FitType.AP_lat_window] = fit_single_parameter (DataSet_Averages.AP_lat_window, DataSet_Max.AP_lat_window, DataSet_Min.AP_lat_window, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_lat_compression, WholeDataAvg_FitType.AP_lat_compression] = fit_single_parameter (DataSet_Averages.AP_lat_compression, DataSet_Max.AP_lat_compression, DataSet_Min.AP_lat_compression, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.ISI_min, WholeDataAvg_FitType.ISI_min] = fit_single_parameter (DataSet_Averages.ISI_min, DataSet_Max.ISI_min, DataSet_Min.ISI_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.ISI_max, WholeDataAvg_FitType.ISI_max] = fit_single_parameter (DataSet_Averages.ISI_max, DataSet_Max.ISI_max, DataSet_Min.ISI_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.ISI_mean, WholeDataAvg_FitType.ISI_mean] = fit_single_parameter (DataSet_Averages.ISI_mean, DataSet_Max.ISI_mean, DataSet_Min.ISI_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.ISI_median, WholeDataAvg_FitType.ISI_median] = fit_single_parameter (DataSet_Averages.ISI_median, DataSet_Max.ISI_median, DataSet_Min.ISI_median, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.ISI_AdapRate, WholeDataAvg_FitType.ISI_AdapRate] = fit_single_parameter (DataSet_Averages.ISI_AdapRate, DataSet_Max.ISI_AdapRate, DataSet_Min.ISI_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AP_thr_first, WholeDataAvg_FitType.AP_thr_first] = fit_single_parameter (DataSet_Averages.AP_thr_first, DataSet_Max.AP_thr_first, DataSet_Min.AP_thr_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_thr_last, WholeDataAvg_FitType.AP_thr_last] = fit_single_parameter (DataSet_Averages.AP_thr_last, DataSet_Max.AP_thr_last, DataSet_Min.AP_thr_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_thr_min, WholeDataAvg_FitType.AP_thr_min] = fit_single_parameter (DataSet_Averages.AP_thr_min, DataSet_Max.AP_thr_min, DataSet_Min.AP_thr_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_thr_max, WholeDataAvg_FitType.AP_thr_max] = fit_single_parameter (DataSet_Averages.AP_thr_max, DataSet_Max.AP_thr_max, DataSet_Min.AP_thr_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_thr_mean, WholeDataAvg_FitType.AP_thr_mean] = fit_single_parameter (DataSet_Averages.AP_thr_mean, DataSet_Max.AP_thr_mean, DataSet_Min.AP_thr_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_thr_median, WholeDataAvg_FitType.AP_thr_median] = fit_single_parameter (DataSet_Averages.AP_thr_median, DataSet_Max.AP_thr_median, DataSet_Min.AP_thr_median, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_thr_AdapRate, WholeDataAvg_FitType.AP_thr_AdapRate] = fit_single_parameter (DataSet_Averages.AP_thr_AdapRate, DataSet_Max.AP_thr_AdapRate, DataSet_Min.AP_thr_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AP_HalfWidth_first, WholeDataAvg_FitType.AP_HalfWidth_first] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_first, DataSet_Max.AP_HalfWidth_first, DataSet_Min.AP_HalfWidth_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_HalfWidth_last, WholeDataAvg_FitType.AP_HalfWidth_last] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_last, DataSet_Max.AP_HalfWidth_last, DataSet_Min.AP_HalfWidth_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_HalfWidth_min, WholeDataAvg_FitType.AP_HalfWidth_min] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_min, DataSet_Max.AP_HalfWidth_min, DataSet_Min.AP_HalfWidth_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_HalfWidth_max, WholeDataAvg_FitType.AP_HalfWidth_max] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_max, DataSet_Max.AP_HalfWidth_max, DataSet_Min.AP_HalfWidth_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_HalfWidth_mean, WholeDataAvg_FitType.AP_HalfWidth_mean] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_mean, DataSet_Max.AP_HalfWidth_mean, DataSet_Min.AP_HalfWidth_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_HalfWidth_median, WholeDataAvg_FitType.AP_HalfWidth_median] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_median, DataSet_Max.AP_HalfWidth_median, DataSet_Min.AP_HalfWidth_median, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_HalfWidth_AdapRate, WholeDataAvg_FitType.AP_HalfWidth_AdapRate] = fit_single_parameter (DataSet_Averages.AP_HalfWidth_AdapRate, DataSet_Max.AP_HalfWidth_AdapRate, DataSet_Min.AP_HalfWidth_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AP_amplitude_first, WholeDataAvg_FitType.AP_amplitude_first] = fit_single_parameter (DataSet_Averages.AP_amplitude_first, DataSet_Max.AP_amplitude_first, DataSet_Min.AP_amplitude_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_amplitude_last, WholeDataAvg_FitType.AP_amplitude_last] = fit_single_parameter (DataSet_Averages.AP_amplitude_last, DataSet_Max.AP_amplitude_last, DataSet_Min.AP_amplitude_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_amplitude_min, WholeDataAvg_FitType.AP_amplitude_min] = fit_single_parameter (DataSet_Averages.AP_amplitude_min, DataSet_Max.AP_amplitude_min, DataSet_Min.AP_amplitude_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_amplitude_max, WholeDataAvg_FitType.AP_amplitude_max] = fit_single_parameter (DataSet_Averages.AP_amplitude_max, DataSet_Max.AP_amplitude_max, DataSet_Min.AP_amplitude_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_amplitude_mean, WholeDataAvg_FitType.AP_amplitude_mean] = fit_single_parameter (DataSet_Averages.AP_amplitude_mean, DataSet_Max.AP_amplitude_mean, DataSet_Min.AP_amplitude_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_amplitude_median, WholeDataAvg_FitType.AP_amplitude_median] = fit_single_parameter (DataSet_Averages.AP_amplitude_median, DataSet_Max.AP_amplitude_median, DataSet_Min.AP_amplitude_median, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AP_amplitude_AdapRate, WholeDataAvg_FitType.AP_amplitude_AdapRate] = fit_single_parameter (DataSet_Averages.AP_amplitude_AdapRate, DataSet_Max.AP_amplitude_AdapRate, DataSet_Min.AP_amplitude_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AHP_PeakLatency_first, WholeDataAvg_FitType.AHP_PeakLatency_first] = fit_single_parameter (DataSet_Averages.AHP_PeakLatency_first, DataSet_Max.AHP_PeakLatency_first, DataSet_Min.AHP_PeakLatency_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakLatency_last, WholeDataAvg_FitType.AHP_PeakLatency_last] = fit_single_parameter (DataSet_Averages.AHP_PeakLatency_last, DataSet_Max.AHP_PeakLatency_last, DataSet_Min.AHP_PeakLatency_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakLatency_min, WholeDataAvg_FitType.AHP_PeakLatency_min] = fit_single_parameter (DataSet_Averages.AHP_PeakLatency_min, DataSet_Max.AHP_PeakLatency_min, DataSet_Min.AHP_PeakLatency_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakLatency_max, WholeDataAvg_FitType.AHP_PeakLatency_max] = fit_single_parameter (DataSet_Averages.AHP_PeakLatency_max, DataSet_Max.AHP_PeakLatency_max, DataSet_Min.AHP_PeakLatency_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakLatency_mean, WholeDataAvg_FitType.AHP_PeakLatency_mean] = fit_single_parameter (DataSet_Averages.AHP_PeakLatency_mean, DataSet_Max.AHP_PeakLatency_mean, DataSet_Min.AHP_PeakLatency_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakLatency_AdapRate, WholeDataAvg_FitType.AHP_PeakLatency_AdapRate] = fit_single_parameter (DataSet_Averages.AHP_PeakLatency_AdapRate, DataSet_Max.AHP_PeakLatency_AdapRate, DataSet_Min.AHP_PeakLatency_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AHP_PeakAmp_first, WholeDataAvg_FitType.AHP_PeakAmp_first] = fit_single_parameter (DataSet_Averages.AHP_PeakAmp_first, DataSet_Max.AHP_PeakAmp_first, DataSet_Min.AHP_PeakAmp_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakAmp_last, WholeDataAvg_FitType.AHP_PeakAmp_last] = fit_single_parameter (DataSet_Averages.AHP_PeakAmp_last, DataSet_Max.AHP_PeakAmp_last, DataSet_Min.AHP_PeakAmp_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakAmp_min, WholeDataAvg_FitType.AHP_PeakAmp_min] = fit_single_parameter (DataSet_Averages.AHP_PeakAmp_min, DataSet_Max.AHP_PeakAmp_min, DataSet_Min.AHP_PeakAmp_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakAmp_max, WholeDataAvg_FitType.AHP_PeakAmp_max] = fit_single_parameter (DataSet_Averages.AHP_PeakAmp_max, DataSet_Max.AHP_PeakAmp_max, DataSet_Min.AHP_PeakAmp_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakAmp_mean, WholeDataAvg_FitType.AHP_PeakAmp_mean] = fit_single_parameter (DataSet_Averages.AHP_PeakAmp_mean, DataSet_Max.AHP_PeakAmp_mean, DataSet_Min.AHP_PeakAmp_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_PeakAmp_AdapRate, WholeDataAvg_FitType.AHP_PeakAmp_AdapRate] = fit_single_parameter (DataSet_Averages.AHP_PeakAmp_AdapRate, DataSet_Max.AHP_PeakAmp_AdapRate, DataSet_Min.AHP_PeakAmp_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AHP_duration_first, WholeDataAvg_FitType.AHP_duration_first] = fit_single_parameter (DataSet_Averages.AHP_duration_first, DataSet_Max.AHP_duration_first, DataSet_Min.AHP_duration_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_duration_last, WholeDataAvg_FitType.AHP_duration_last] = fit_single_parameter (DataSet_Averages.AHP_duration_last, DataSet_Max.AHP_duration_last, DataSet_Min.AHP_duration_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_duration_min, WholeDataAvg_FitType.AHP_duration_min] = fit_single_parameter (DataSet_Averages.AHP_duration_min, DataSet_Max.AHP_duration_min, DataSet_Min.AHP_duration_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_duration_max, WholeDataAvg_FitType.AHP_duration_max] = fit_single_parameter (DataSet_Averages.AHP_duration_max, DataSet_Max.AHP_duration_max, DataSet_Min.AHP_duration_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_duration_mean, WholeDataAvg_FitType.AHP_duration_mean] = fit_single_parameter (DataSet_Averages.AHP_duration_mean, DataSet_Max.AHP_duration_mean, DataSet_Min.AHP_duration_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_duration_AdapRate, WholeDataAvg_FitType.AHP_duration_AdapRate] = fit_single_parameter (DataSet_Averages.AHP_duration_AdapRate, DataSet_Max.AHP_duration_AdapRate, DataSet_Min.AHP_duration_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AHP_integral_first, WholeDataAvg_FitType.AHP_integral_first] = fit_single_parameter (DataSet_Averages.AHP_integral_first, DataSet_Max.AHP_integral_first, DataSet_Min.AHP_integral_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_integral_last, WholeDataAvg_FitType.AHP_integral_last] = fit_single_parameter (DataSet_Averages.AHP_integral_last, DataSet_Max.AHP_integral_last, DataSet_Min.AHP_integral_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_integral_min, WholeDataAvg_FitType.AHP_integral_min] = fit_single_parameter (DataSet_Averages.AHP_integral_min, DataSet_Max.AHP_integral_min, DataSet_Min.AHP_integral_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_integral_max, WholeDataAvg_FitType.AHP_integral_max] = fit_single_parameter (DataSet_Averages.AHP_integral_max, DataSet_Max.AHP_integral_max, DataSet_Min.AHP_integral_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_integral_mean, WholeDataAvg_FitType.AHP_integral_mean] = fit_single_parameter (DataSet_Averages.AHP_integral_mean, DataSet_Max.AHP_integral_mean, DataSet_Min.AHP_integral_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_integral_AdapRate, WholeDataAvg_FitType.AHP_integral_AdapRate] = fit_single_parameter (DataSet_Averages.AHP_integral_AdapRate, DataSet_Max.AHP_integral_AdapRate, DataSet_Min.AHP_integral_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AHP_FallSlope_first, WholeDataAvg_FitType.AHP_FallSlope_first] = fit_single_parameter (DataSet_Averages.AHP_FallSlope_first, DataSet_Max.AHP_FallSlope_first, DataSet_Min.AHP_FallSlope_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_FallSlope_last, WholeDataAvg_FitType.AHP_FallSlope_last] = fit_single_parameter (DataSet_Averages.AHP_FallSlope_last, DataSet_Max.AHP_FallSlope_last, DataSet_Min.AHP_FallSlope_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_FallSlope_min, WholeDataAvg_FitType.AHP_FallSlope_min] = fit_single_parameter (DataSet_Averages.AHP_FallSlope_min, DataSet_Max.AHP_FallSlope_min, DataSet_Min.AHP_FallSlope_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_FallSlope_max, WholeDataAvg_FitType.AHP_FallSlope_max] = fit_single_parameter (DataSet_Averages.AHP_FallSlope_max, DataSet_Max.AHP_FallSlope_max, DataSet_Min.AHP_FallSlope_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_FallSlope_mean, WholeDataAvg_FitType.AHP_FallSlope_mean] = fit_single_parameter (DataSet_Averages.AHP_FallSlope_mean, DataSet_Max.AHP_FallSlope_mean, DataSet_Min.AHP_FallSlope_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_FallSlope_AdapRate, WholeDataAvg_FitType.AHP_FallSlope_AdapRate] = fit_single_parameter (DataSet_Averages.AHP_FallSlope_AdapRate, DataSet_Max.AHP_FallSlope_AdapRate, DataSet_Min.AHP_FallSlope_AdapRate, current_injected, interpolation_points, FLAG_plot);

[WholeDataAvg_BestFit.AHP_RiseSlope_first, WholeDataAvg_FitType.AHP_RiseSlope_first] = fit_single_parameter (DataSet_Averages.AHP_RiseSlope_first, DataSet_Max.AHP_RiseSlope_first, DataSet_Min.AHP_RiseSlope_first, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_RiseSlope_last, WholeDataAvg_FitType.AHP_RiseSlope_last] = fit_single_parameter (DataSet_Averages.AHP_RiseSlope_last, DataSet_Max.AHP_RiseSlope_last, DataSet_Min.AHP_RiseSlope_last, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_RiseSlope_min, WholeDataAvg_FitType.AHP_RiseSlope_min] = fit_single_parameter (DataSet_Averages.AHP_RiseSlope_min, DataSet_Max.AHP_RiseSlope_min, DataSet_Min.AHP_RiseSlope_min, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_RiseSlope_max, WholeDataAvg_FitType.AHP_RiseSlope_max] = fit_single_parameter (DataSet_Averages.AHP_RiseSlope_max, DataSet_Max.AHP_RiseSlope_max, DataSet_Min.AHP_RiseSlope_max, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_RiseSlope_mean, WholeDataAvg_FitType.AHP_RiseSlope_mean] = fit_single_parameter (DataSet_Averages.AHP_RiseSlope_mean, DataSet_Max.AHP_RiseSlope_mean, DataSet_Min.AHP_RiseSlope_mean, current_injected, interpolation_points, FLAG_plot);
[WholeDataAvg_BestFit.AHP_RiseSlope_AdapRate, WholeDataAvg_FitType.AHP_RiseSlope_AdapRate] = fit_single_parameter (DataSet_Averages.AHP_RiseSlope_AdapRate, DataSet_Max.AHP_RiseSlope_AdapRate, DataSet_Min.AHP_RiseSlope_AdapRate, current_injected, interpolation_points, FLAG_plot);

time_elapsed = toc;
fprintf('Time estimated for the fitting: %ds.\n\n', double(int32(time_elapsed*number_of_CCexperiments)));

end