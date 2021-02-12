function [Fit, FitConstants, Goodness_of_Fit] = fit_all_parameters(Averages, FitTypes, current_injected, interpolation_points, FLAG_plot)
% This function fits all the parameters for a single experiment. 
% It requires the function "fit_single_parameter_CCall".

[Fit.APcount, FitConstants.APcount, Goodness_of_Fit.APcount] = fit_single_parameter_CCall (Averages.APcount, FitTypes.APcount, current_injected, interpolation_points, FLAG_plot);
[Fit.FR_abs, FitConstants.FR_abs, Goodness_of_Fit.FR_abs] = fit_single_parameter_CCall (Averages.FR_abs, FitTypes.FR_abs, current_injected, interpolation_points, FLAG_plot);
[Fit.FR_ins, FitConstants.FR_ins, Goodness_of_Fit.FR_ins] = fit_single_parameter_CCall (Averages.FR_ins, FitTypes.FR_ins, current_injected, interpolation_points, FLAG_plot);

[Fit.AP_lat_first, FitConstants.AP_lat_first, Goodness_of_Fit.AP_lat_first] = fit_single_parameter_CCall (Averages.AP_lat_first, FitTypes.AP_lat_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_lat_last, FitConstants.AP_lat_last, Goodness_of_Fit.AP_lat_last] = fit_single_parameter_CCall (Averages.AP_lat_last, FitTypes.AP_lat_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_lat_window, FitConstants.AP_lat_window, Goodness_of_Fit.AP_lat_window] = fit_single_parameter_CCall (Averages.AP_lat_window, FitTypes.AP_lat_window, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_lat_compression, FitConstants.AP_lat_compression, Goodness_of_Fit.AP_lat_compression] = fit_single_parameter_CCall (Averages.AP_lat_compression, FitTypes.AP_lat_compression, current_injected, interpolation_points, FLAG_plot);

[Fit.ISI_min, FitConstants.ISI_min, Goodness_of_Fit.ISI_min] = fit_single_parameter_CCall (Averages.ISI_min, FitTypes.ISI_min, current_injected, interpolation_points, FLAG_plot);
[Fit.ISI_max, FitConstants.ISI_max, Goodness_of_Fit.ISI_max] = fit_single_parameter_CCall (Averages.ISI_max, FitTypes.ISI_max, current_injected, interpolation_points, FLAG_plot);
[Fit.ISI_mean, FitConstants.ISI_mean, Goodness_of_Fit.ISI_mean] = fit_single_parameter_CCall (Averages.ISI_mean, FitTypes.ISI_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.ISI_median, FitConstants.ISI_median, Goodness_of_Fit.ISI_median] = fit_single_parameter_CCall (Averages.ISI_median, FitTypes.ISI_median, current_injected, interpolation_points, FLAG_plot);
[Fit.ISI_AdapRate, FitConstants.ISI_AdapRate, Goodness_of_Fit.ISI_AdapRate] = fit_single_parameter_CCall (Averages.ISI_AdapRate, FitTypes.ISI_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AP_thr_first, FitConstants.AP_thr_first, Goodness_of_Fit.AP_thr_first] = fit_single_parameter_CCall (Averages.AP_thr_first, FitTypes.AP_thr_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_thr_last, FitConstants.AP_thr_last, Goodness_of_Fit.AP_thr_last] = fit_single_parameter_CCall (Averages.AP_thr_last, FitTypes.AP_thr_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_thr_min, FitConstants.AP_thr_min, Goodness_of_Fit.AP_thr_min] = fit_single_parameter_CCall (Averages.AP_thr_min, FitTypes.AP_thr_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_thr_max, FitConstants.AP_thr_max, Goodness_of_Fit.AP_thr_max] = fit_single_parameter_CCall (Averages.AP_thr_max, FitTypes.AP_thr_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_thr_mean, FitConstants.AP_thr_mean, Goodness_of_Fit.AP_thr_mean] = fit_single_parameter_CCall (Averages.AP_thr_mean, FitTypes.AP_thr_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_thr_median, FitConstants.AP_thr_median, Goodness_of_Fit.AP_thr_median] = fit_single_parameter_CCall (Averages.AP_thr_median, FitTypes.AP_thr_median, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_thr_AdapRate, FitConstants.AP_thr_AdapRate, Goodness_of_Fit.AP_thr_AdapRate] = fit_single_parameter_CCall (Averages.AP_thr_AdapRate, FitTypes.AP_thr_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AP_HalfWidth_first, FitConstants.AP_HalfWidth_first, Goodness_of_Fit.AP_HalfWidth_first] = fit_single_parameter_CCall (Averages.AP_HalfWidth_first, FitTypes.AP_HalfWidth_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_HalfWidth_last, FitConstants.AP_HalfWidth_last, Goodness_of_Fit.AP_HalfWidth_last] = fit_single_parameter_CCall (Averages.AP_HalfWidth_last, FitTypes.AP_HalfWidth_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_HalfWidth_min, FitConstants.AP_HalfWidth_min, Goodness_of_Fit.AP_HalfWidth_min] = fit_single_parameter_CCall (Averages.AP_HalfWidth_min, FitTypes.AP_HalfWidth_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_HalfWidth_max, FitConstants.AP_HalfWidth_max, Goodness_of_Fit.AP_HalfWidth_max] = fit_single_parameter_CCall (Averages.AP_HalfWidth_max, FitTypes.AP_HalfWidth_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_HalfWidth_mean, FitConstants.AP_HalfWidth_mean, Goodness_of_Fit.AP_HalfWidth_mean] = fit_single_parameter_CCall (Averages.AP_HalfWidth_mean, FitTypes.AP_HalfWidth_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_HalfWidth_median, FitConstants.AP_HalfWidth_median, Goodness_of_Fit.AP_HalfWidth_median] = fit_single_parameter_CCall (Averages.AP_HalfWidth_median, FitTypes.AP_HalfWidth_median, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_HalfWidth_AdapRate, FitConstants.AP_HalfWidth_AdapRate, Goodness_of_Fit.AP_HalfWidth_AdapRate] = fit_single_parameter_CCall (Averages.AP_HalfWidth_AdapRate, FitTypes.AP_HalfWidth_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AP_amplitude_first, FitConstants.AP_amplitude_first, Goodness_of_Fit.AP_amplitude_first] = fit_single_parameter_CCall (Averages.AP_amplitude_first, FitTypes.AP_amplitude_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_amplitude_last, FitConstants.AP_amplitude_last, Goodness_of_Fit.AP_amplitude_last] = fit_single_parameter_CCall (Averages.AP_amplitude_last, FitTypes.AP_amplitude_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_amplitude_min, FitConstants.AP_amplitude_min, Goodness_of_Fit.AP_amplitude_min] = fit_single_parameter_CCall (Averages.AP_amplitude_min, FitTypes.AP_amplitude_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_amplitude_max, FitConstants.AP_amplitude_max, Goodness_of_Fit.AP_amplitude_max] = fit_single_parameter_CCall (Averages.AP_amplitude_max, FitTypes.AP_amplitude_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_amplitude_mean, FitConstants.AP_amplitude_mean, Goodness_of_Fit.AP_amplitude_mean] = fit_single_parameter_CCall (Averages.AP_amplitude_mean, FitTypes.AP_amplitude_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_amplitude_median, FitConstants.AP_amplitude_median, Goodness_of_Fit.AP_amplitude_median] = fit_single_parameter_CCall (Averages.AP_amplitude_median, FitTypes.AP_amplitude_median, current_injected, interpolation_points, FLAG_plot);
[Fit.AP_amplitude_AdapRate, FitConstants.AP_amplitude_AdapRate, Goodness_of_Fit.AP_amplitude_AdapRate] = fit_single_parameter_CCall (Averages.AP_amplitude_AdapRate, FitTypes.AP_amplitude_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AHP_PeakLatency_first, FitConstants.AHP_PeakLatency_first, Goodness_of_Fit.AHP_PeakLatency_first] = fit_single_parameter_CCall (Averages.AHP_PeakLatency_first, FitTypes.AHP_PeakLatency_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakLatency_last, FitConstants.AHP_PeakLatency_last, Goodness_of_Fit.AHP_PeakLatency_last] = fit_single_parameter_CCall (Averages.AHP_PeakLatency_last, FitTypes.AHP_PeakLatency_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakLatency_min, FitConstants.AHP_PeakLatency_min, Goodness_of_Fit.AHP_PeakLatency_min] = fit_single_parameter_CCall (Averages.AHP_PeakLatency_min, FitTypes.AHP_PeakLatency_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakLatency_max, FitConstants.AHP_PeakLatency_max, Goodness_of_Fit.AHP_PeakLatency_max] = fit_single_parameter_CCall (Averages.AHP_PeakLatency_max, FitTypes.AHP_PeakLatency_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakLatency_mean, FitConstants.AHP_PeakLatency_mean, Goodness_of_Fit.AHP_PeakLatency_mean] = fit_single_parameter_CCall (Averages.AHP_PeakLatency_mean, FitTypes.AHP_PeakLatency_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakLatency_AdapRate, FitConstants.AHP_PeakLatency_AdapRate, Goodness_of_Fit.AHP_PeakLatency_AdapRate] = fit_single_parameter_CCall (Averages.AHP_PeakLatency_AdapRate, FitTypes.AHP_PeakLatency_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AHP_PeakAmp_first, FitConstants.AHP_PeakAmp_first, Goodness_of_Fit.AHP_PeakAmp_first] = fit_single_parameter_CCall (Averages.AHP_PeakAmp_first, FitTypes.AHP_PeakAmp_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakAmp_last, FitConstants.AHP_PeakAmp_last, Goodness_of_Fit.AHP_PeakAmp_last] = fit_single_parameter_CCall (Averages.AHP_PeakAmp_last, FitTypes.AHP_PeakAmp_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakAmp_min, FitConstants.AHP_PeakAmp_min, Goodness_of_Fit.AHP_PeakAmp_min] = fit_single_parameter_CCall (Averages.AHP_PeakAmp_min, FitTypes.AHP_PeakAmp_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakAmp_max, FitConstants.AHP_PeakAmp_max, Goodness_of_Fit.AHP_PeakAmp_max] = fit_single_parameter_CCall (Averages.AHP_PeakAmp_max, FitTypes.AHP_PeakAmp_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakAmp_mean, FitConstants.AHP_PeakAmp_mean, Goodness_of_Fit.AHP_PeakAmp_mean] = fit_single_parameter_CCall (Averages.AHP_PeakAmp_mean, FitTypes.AHP_PeakAmp_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_PeakAmp_AdapRate, FitConstants.AHP_PeakAmp_AdapRate, Goodness_of_Fit.AHP_PeakAmp_AdapRate] = fit_single_parameter_CCall (Averages.AHP_PeakAmp_AdapRate, FitTypes.AHP_PeakAmp_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AHP_duration_first, FitConstants.AHP_duration_first, Goodness_of_Fit.AHP_duration_first] = fit_single_parameter_CCall (Averages.AHP_duration_first, FitTypes.AHP_duration_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_duration_last, FitConstants.AHP_duration_last, Goodness_of_Fit.AHP_duration_last] = fit_single_parameter_CCall (Averages.AHP_duration_last, FitTypes.AHP_duration_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_duration_min, FitConstants.AHP_duration_min, Goodness_of_Fit.AHP_duration_min] = fit_single_parameter_CCall (Averages.AHP_duration_min, FitTypes.AHP_duration_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_duration_max, FitConstants.AHP_duration_max, Goodness_of_Fit.AHP_duration_max] = fit_single_parameter_CCall (Averages.AHP_duration_max, FitTypes.AHP_duration_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_duration_mean, FitConstants.AHP_duration_mean, Goodness_of_Fit.AHP_duration_mean] = fit_single_parameter_CCall (Averages.AHP_duration_mean, FitTypes.AHP_duration_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_duration_AdapRate, FitConstants.AHP_duration_AdapRate, Goodness_of_Fit.AHP_duration_AdapRate] = fit_single_parameter_CCall (Averages.AHP_duration_AdapRate, FitTypes.AHP_duration_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AHP_integral_first, FitConstants.AHP_integral_first, Goodness_of_Fit.AHP_integral_first] = fit_single_parameter_CCall (Averages.AHP_integral_first, FitTypes.AHP_integral_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_integral_last, FitConstants.AHP_integral_last, Goodness_of_Fit.AHP_integral_last] = fit_single_parameter_CCall (Averages.AHP_integral_last, FitTypes.AHP_integral_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_integral_min, FitConstants.AHP_integral_min, Goodness_of_Fit.AHP_integral_min] = fit_single_parameter_CCall (Averages.AHP_integral_min, FitTypes.AHP_integral_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_integral_max, FitConstants.AHP_integral_max, Goodness_of_Fit.AHP_integral_max] = fit_single_parameter_CCall (Averages.AHP_integral_max, FitTypes.AHP_integral_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_integral_mean, FitConstants.AHP_integral_mean, Goodness_of_Fit.AHP_integral_mean] = fit_single_parameter_CCall (Averages.AHP_integral_mean, FitTypes.AHP_integral_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_integral_AdapRate, FitConstants.AHP_integral_AdapRate, Goodness_of_Fit.AHP_integral_AdapRate] = fit_single_parameter_CCall (Averages.AHP_integral_AdapRate, FitTypes.AHP_integral_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AHP_FallSlope_first, FitConstants.AHP_FallSlope_first, Goodness_of_Fit.AHP_FallSlope_first] = fit_single_parameter_CCall (Averages.AHP_FallSlope_first, FitTypes.AHP_FallSlope_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_FallSlope_last, FitConstants.AHP_FallSlope_last, Goodness_of_Fit.AHP_FallSlope_last] = fit_single_parameter_CCall (Averages.AHP_FallSlope_last, FitTypes.AHP_FallSlope_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_FallSlope_min, FitConstants.AHP_FallSlope_min, Goodness_of_Fit.AHP_FallSlope_min] = fit_single_parameter_CCall (Averages.AHP_FallSlope_min, FitTypes.AHP_FallSlope_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_FallSlope_max, FitConstants.AHP_FallSlope_max, Goodness_of_Fit.AHP_FallSlope_max] = fit_single_parameter_CCall (Averages.AHP_FallSlope_max, FitTypes.AHP_FallSlope_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_FallSlope_mean, FitConstants.AHP_FallSlope_mean, Goodness_of_Fit.AHP_FallSlope_mean] = fit_single_parameter_CCall (Averages.AHP_FallSlope_mean, FitTypes.AHP_FallSlope_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_FallSlope_AdapRate, FitConstants.AHP_FallSlope_AdapRate, Goodness_of_Fit.AHP_FallSlope_AdapRate] = fit_single_parameter_CCall (Averages.AHP_FallSlope_AdapRate, FitTypes.AHP_FallSlope_AdapRate, current_injected, interpolation_points, FLAG_plot);

[Fit.AHP_RiseSlope_first, FitConstants.AHP_RiseSlope_first, Goodness_of_Fit.AHP_RiseSlope_first] = fit_single_parameter_CCall (Averages.AHP_RiseSlope_first, FitTypes.AHP_RiseSlope_first, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_RiseSlope_last, FitConstants.AHP_RiseSlope_last, Goodness_of_Fit.AHP_RiseSlope_last] = fit_single_parameter_CCall (Averages.AHP_RiseSlope_last, FitTypes.AHP_RiseSlope_last, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_RiseSlope_min, FitConstants.AHP_RiseSlope_min, Goodness_of_Fit.AHP_RiseSlope_min] = fit_single_parameter_CCall (Averages.AHP_RiseSlope_min, FitTypes.AHP_RiseSlope_min, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_RiseSlope_max, FitConstants.AHP_RiseSlope_max, Goodness_of_Fit.AHP_RiseSlope_max] = fit_single_parameter_CCall (Averages.AHP_RiseSlope_max, FitTypes.AHP_RiseSlope_max, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_RiseSlope_mean, FitConstants.AHP_RiseSlope_mean, Goodness_of_Fit.AHP_RiseSlope_mean] = fit_single_parameter_CCall (Averages.AHP_RiseSlope_mean, FitTypes.AHP_RiseSlope_mean, current_injected, interpolation_points, FLAG_plot);
[Fit.AHP_RiseSlope_AdapRate, FitConstants.AHP_RiseSlope_AdapRate, Goodness_of_Fit.AHP_RiseSlope_AdapRate] = fit_single_parameter_CCall (Averages.AHP_RiseSlope_AdapRate, FitTypes.AHP_RiseSlope_AdapRate, current_injected, interpolation_points, FLAG_plot);

end