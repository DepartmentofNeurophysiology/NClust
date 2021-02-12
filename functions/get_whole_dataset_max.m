function [DataSet_Max] = get_whole_dataset_max (experiments, FLAG_normalize)


number_of_exps = numel(experiments);
number_of_sweeps = 10;

% Initialize Parameters Matrices.
APcount_matrix = NaN(number_of_exps, number_of_sweeps);
FR_abs_matrix = NaN(number_of_exps, number_of_sweeps);
FR_ins_matrix = NaN(number_of_exps, number_of_sweeps);
AP_lat_first_matrix = NaN(number_of_exps, number_of_sweeps);
AP_lat_last_matrix = NaN(number_of_exps, number_of_sweeps);
AP_lat_window_matrix = NaN(number_of_exps, number_of_sweeps);
AP_lat_compression_matrix = NaN(number_of_exps, number_of_sweeps);
ISI_min_matrix = NaN(number_of_exps, number_of_sweeps);
ISI_max_matrix = NaN(number_of_exps, number_of_sweeps);
ISI_mean_matrix = NaN(number_of_exps, number_of_sweeps);
ISI_median_matrix = NaN(number_of_exps, number_of_sweeps);
ISI_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_first_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_last_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_min_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_max_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_median_matrix = NaN(number_of_exps, number_of_sweeps);
AP_thr_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_first_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_last_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_min_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_max_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_median_matrix = NaN(number_of_exps, number_of_sweeps);
AP_HalfWidth_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_first_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_last_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_min_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_max_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_median_matrix = NaN(number_of_exps, number_of_sweeps);
AP_amplitude_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakLatency_first_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakLatency_last_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakLatency_min_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakLatency_max_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakLatency_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakLatency_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakAmp_first_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakAmp_last_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakAmp_min_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakAmp_max_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakAmp_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_PeakAmp_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_duration_first_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_duration_last_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_duration_min_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_duration_max_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_duration_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_duration_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_integral_first_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_integral_last_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_integral_min_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_integral_max_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_integral_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_integral_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_FallSlope_first_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_FallSlope_last_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_FallSlope_min_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_FallSlope_max_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_FallSlope_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_FallSlope_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_RiseSlope_first_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_RiseSlope_last_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_RiseSlope_min_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_RiseSlope_max_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_RiseSlope_mean_matrix = NaN(number_of_exps, number_of_sweeps);
AHP_RiseSlope_AdapRate_matrix = NaN(number_of_exps, number_of_sweeps);


% Fill Parameters Matrices.
if FLAG_normalize == 0
    for i_exp = 1:number_of_exps
        APcount_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.APcount;
        FR_abs_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.FR_abs;
        FR_ins_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.FR_ins;
        AP_lat_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_first;
        AP_lat_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_last;
        AP_lat_window_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_window;
        AP_lat_compression_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_compression;
        ISI_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_min;
        ISI_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_max;
        ISI_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_mean;
        ISI_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_median;
        ISI_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_AdapRate;
        AP_thr_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_first;
        AP_thr_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_last;
        AP_thr_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_min;
        AP_thr_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_max;
        AP_thr_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_mean;
        AP_thr_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_median;
        AP_thr_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_AdapRate;
        AP_HalfWidth_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_first;
        AP_HalfWidth_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_last;
        AP_HalfWidth_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_min;
        AP_HalfWidth_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_max;
        AP_HalfWidth_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_mean;
        AP_HalfWidth_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_median;
        AP_HalfWidth_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_AdapRate;
        AP_amplitude_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_first;
        AP_amplitude_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_last;
        AP_amplitude_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_min;
        AP_amplitude_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_max;
        AP_amplitude_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_mean;
        AP_amplitude_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_median;
        AP_amplitude_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_AdapRate;
        AHP_PeakLatency_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_first;
        AHP_PeakLatency_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_last;
        AHP_PeakLatency_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_min;
        AHP_PeakLatency_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_max;
        AHP_PeakLatency_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_mean;
        AHP_PeakLatency_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_AdapRate;
        AHP_PeakAmp_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_first;
        AHP_PeakAmp_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_last;
        AHP_PeakAmp_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_min;
        AHP_PeakAmp_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_max;
        AHP_PeakAmp_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_mean;
        AHP_PeakAmp_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_AdapRate;
        AHP_duration_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_first;
        AHP_duration_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_last;
        AHP_duration_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_min;
        AHP_duration_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_max;
        AHP_duration_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_mean;
        AHP_duration_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_AdapRate;
        AHP_integral_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_first;
        AHP_integral_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_last;
        AHP_integral_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_min;
        AHP_integral_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_max;
        AHP_integral_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_mean;
        AHP_integral_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_AdapRate;
        AHP_FallSlope_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_first;
        AHP_FallSlope_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_last;
        AHP_FallSlope_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_min;
        AHP_FallSlope_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_max;
        AHP_FallSlope_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_mean;
        AHP_FallSlope_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_AdapRate;
        AHP_RiseSlope_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_first;
        AHP_RiseSlope_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_last;
        AHP_RiseSlope_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_min;
        AHP_RiseSlope_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_max;
        AHP_RiseSlope_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_mean;
        AHP_RiseSlope_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_AdapRate;
    end
else
    for i_exp = 1:number_of_exps
        APcount_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.APcount./nanmax(experiments(i_exp).CC_Data_Means.APcount);
        FR_abs_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.FR_abs./nanmax(experiments(i_exp).CC_Data_Means.FR_abs);
        FR_ins_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.FR_ins./nanmax(experiments(i_exp).CC_Data_Means.FR_ins);
        AP_lat_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_first./nanmax(experiments(i_exp).CC_Data_Means.AP_lat_first);
        AP_lat_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_last./nanmax(experiments(i_exp).CC_Data_Means.AP_lat_last);
        AP_lat_window_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_window./nanmax(experiments(i_exp).CC_Data_Means.AP_lat_window);
        AP_lat_compression_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_lat_compression./nanmax(experiments(i_exp).CC_Data_Means.AP_lat_compression);
        ISI_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_min./nanmax(experiments(i_exp).CC_Data_Means.ISI_min);
        ISI_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_max./nanmax(experiments(i_exp).CC_Data_Means.ISI_max);
        ISI_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_mean./nanmax(experiments(i_exp).CC_Data_Means.ISI_mean);
        ISI_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_median./nanmax(experiments(i_exp).CC_Data_Means.ISI_median);
        ISI_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.ISI_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.ISI_AdapRate);
        AP_thr_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_first./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_first);
        AP_thr_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_last./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_last);
        AP_thr_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_min./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_min);
        AP_thr_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_max./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_max);
        AP_thr_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_mean./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_mean);
        AP_thr_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_median./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_median);
        AP_thr_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_thr_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AP_thr_AdapRate);
        AP_HalfWidth_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_first./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_first);
        AP_HalfWidth_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_last./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_last);
        AP_HalfWidth_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_min./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_min);
        AP_HalfWidth_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_max./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_max);
        AP_HalfWidth_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_mean./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_mean);
        AP_HalfWidth_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_median./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_median);
        AP_HalfWidth_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_HalfWidth_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AP_HalfWidth_AdapRate);
        AP_amplitude_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_first./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_first);
        AP_amplitude_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_last./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_last);
        AP_amplitude_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_min./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_min);
        AP_amplitude_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_max./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_max);
        AP_amplitude_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_mean./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_mean);
        AP_amplitude_median_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_median./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_median);
        AP_amplitude_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AP_amplitude_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AP_amplitude_AdapRate);
        AHP_PeakLatency_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_first./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakLatency_first);
        AHP_PeakLatency_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_last./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakLatency_last);
        AHP_PeakLatency_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_min./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakLatency_min);
        AHP_PeakLatency_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_max./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakLatency_max);
        AHP_PeakLatency_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_mean./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakLatency_mean);
        AHP_PeakLatency_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakLatency_AdapRate);
        AHP_PeakAmp_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_first./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakAmp_first);
        AHP_PeakAmp_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_last./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakAmp_last);
        AHP_PeakAmp_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_min./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakAmp_min);
        AHP_PeakAmp_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_max./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakAmp_max);
        AHP_PeakAmp_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_mean./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakAmp_mean);
        AHP_PeakAmp_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AHP_PeakAmp_AdapRate);
        AHP_duration_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_first./nanmax(experiments(i_exp).CC_Data_Means.AHP_duration_first);
        AHP_duration_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_last./nanmax(experiments(i_exp).CC_Data_Means.AHP_duration_last);
        AHP_duration_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_min./nanmax(experiments(i_exp).CC_Data_Means.AHP_duration_min);
        AHP_duration_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_max./nanmax(experiments(i_exp).CC_Data_Means.AHP_duration_max);
        AHP_duration_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_mean./nanmax(experiments(i_exp).CC_Data_Means.AHP_duration_mean);
        AHP_duration_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_duration_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AHP_duration_AdapRate);
        AHP_integral_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_first./nanmax(experiments(i_exp).CC_Data_Means.AHP_integral_first);
        AHP_integral_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_last./nanmax(experiments(i_exp).CC_Data_Means.AHP_integral_last);
        AHP_integral_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_min./nanmax(experiments(i_exp).CC_Data_Means.AHP_integral_min);
        AHP_integral_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_max./nanmax(experiments(i_exp).CC_Data_Means.AHP_integral_max);
        AHP_integral_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_mean./nanmax(experiments(i_exp).CC_Data_Means.AHP_integral_mean);
        AHP_integral_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_integral_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AHP_integral_AdapRate);
        AHP_FallSlope_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_first./nanmax(experiments(i_exp).CC_Data_Means.AHP_FallSlope_first);
        AHP_FallSlope_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_last./nanmax(experiments(i_exp).CC_Data_Means.AHP_FallSlope_last);
        AHP_FallSlope_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_min./nanmax(experiments(i_exp).CC_Data_Means.AHP_FallSlope_min);
        AHP_FallSlope_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_max./nanmax(experiments(i_exp).CC_Data_Means.AHP_FallSlope_max);
        AHP_FallSlope_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_mean./nanmax(experiments(i_exp).CC_Data_Means.AHP_FallSlope_mean);
        AHP_FallSlope_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_FallSlope_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AHP_FallSlope_AdapRate);
        AHP_RiseSlope_first_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_first./nanmax(experiments(i_exp).CC_Data_Means.AHP_RiseSlope_first);
        AHP_RiseSlope_last_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_last./nanmax(experiments(i_exp).CC_Data_Means.AHP_RiseSlope_last);
        AHP_RiseSlope_min_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_min./nanmax(experiments(i_exp).CC_Data_Means.AHP_RiseSlope_min);
        AHP_RiseSlope_max_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_max./nanmax(experiments(i_exp).CC_Data_Means.AHP_RiseSlope_max);
        AHP_RiseSlope_mean_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_mean./nanmax(experiments(i_exp).CC_Data_Means.AHP_RiseSlope_mean);
        AHP_RiseSlope_AdapRate_matrix(i_exp, :) = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_AdapRate./nanmax(experiments(i_exp).CC_Data_Means.AHP_RiseSlope_AdapRate);
    end
end

% Get Parameters max.
DataSet_Max.APcount = nanmax(APcount_matrix, [], 1);
DataSet_Max.FR_abs = nanmax(FR_abs_matrix, [], 1);
DataSet_Max.FR_ins = nanmax(FR_ins_matrix, [], 1);
DataSet_Max.AP_lat_first = nanmax(AP_lat_first_matrix, [], 1);
DataSet_Max.AP_lat_last = nanmax(AP_lat_last_matrix, [], 1);
DataSet_Max.AP_lat_window = nanmax(AP_lat_window_matrix, [], 1);
DataSet_Max.AP_lat_compression = nanmax(AP_lat_compression_matrix, [], 1);
DataSet_Max.ISI_min = nanmax(ISI_min_matrix, [], 1);
DataSet_Max.ISI_max = nanmax(ISI_max_matrix, [], 1);
DataSet_Max.ISI_mean = nanmax(ISI_mean_matrix, [], 1);
DataSet_Max.ISI_median = nanmax(ISI_median_matrix, [], 1);
DataSet_Max.ISI_AdapRate = nanmax(ISI_AdapRate_matrix, [], 1);
DataSet_Max.AP_thr_first = nanmax(AP_thr_first_matrix, [], 1);
DataSet_Max.AP_thr_last = nanmax(AP_thr_last_matrix, [], 1);
DataSet_Max.AP_thr_min = nanmax(AP_thr_min_matrix, [], 1);
DataSet_Max.AP_thr_max = nanmax(AP_thr_max_matrix, [], 1);
DataSet_Max.AP_thr_mean = nanmax(AP_thr_mean_matrix, [], 1);
DataSet_Max.AP_thr_median = nanmax(AP_thr_median_matrix, [], 1);
DataSet_Max.AP_thr_AdapRate = nanmax(AP_thr_AdapRate_matrix, [], 1);
DataSet_Max.AP_HalfWidth_first = nanmax(AP_HalfWidth_first_matrix, [], 1);
DataSet_Max.AP_HalfWidth_last = nanmax(AP_HalfWidth_last_matrix, [], 1);
DataSet_Max.AP_HalfWidth_min = nanmax(AP_HalfWidth_min_matrix, [], 1);
DataSet_Max.AP_HalfWidth_max = nanmax(AP_HalfWidth_max_matrix, [], 1);
DataSet_Max.AP_HalfWidth_mean = nanmax(AP_HalfWidth_mean_matrix, [], 1);
DataSet_Max.AP_HalfWidth_median = nanmax(AP_HalfWidth_median_matrix, [], 1);
DataSet_Max.AP_HalfWidth_AdapRate = nanmax(AP_HalfWidth_AdapRate_matrix, [], 1);
DataSet_Max.AP_amplitude_first = nanmax(AP_amplitude_first_matrix, [], 1);
DataSet_Max.AP_amplitude_last = nanmax(AP_amplitude_last_matrix, [], 1);
DataSet_Max.AP_amplitude_min = nanmax(AP_amplitude_min_matrix, [], 1);
DataSet_Max.AP_amplitude_max = nanmax(AP_amplitude_max_matrix, [], 1);
DataSet_Max.AP_amplitude_mean = nanmax(AP_amplitude_mean_matrix, [], 1);
DataSet_Max.AP_amplitude_median = nanmax(AP_amplitude_median_matrix, [], 1);
DataSet_Max.AP_amplitude_AdapRate = nanmax(AP_amplitude_AdapRate_matrix, [], 1);
DataSet_Max.AHP_PeakLatency_first = nanmax(AHP_PeakLatency_first_matrix, [], 1);
DataSet_Max.AHP_PeakLatency_last = nanmax(AHP_PeakLatency_last_matrix, [], 1);
DataSet_Max.AHP_PeakLatency_min = nanmax(AHP_PeakLatency_min_matrix, [], 1);
DataSet_Max.AHP_PeakLatency_max = nanmax(AHP_PeakLatency_max_matrix, [], 1);
DataSet_Max.AHP_PeakLatency_mean = nanmax(AHP_PeakLatency_mean_matrix, [], 1);
DataSet_Max.AHP_PeakLatency_AdapRate = nanmax(AHP_PeakLatency_AdapRate_matrix, [], 1);
DataSet_Max.AHP_PeakAmp_first = nanmax(AHP_PeakAmp_first_matrix, [], 1);
DataSet_Max.AHP_PeakAmp_last = nanmax(AHP_PeakAmp_last_matrix, [], 1);
DataSet_Max.AHP_PeakAmp_min = nanmax(AHP_PeakAmp_min_matrix, [], 1);
DataSet_Max.AHP_PeakAmp_max = nanmax(AHP_PeakAmp_max_matrix, [], 1);
DataSet_Max.AHP_PeakAmp_mean = nanmax(AHP_PeakAmp_mean_matrix, [], 1);
DataSet_Max.AHP_PeakAmp_AdapRate = nanmax(AHP_PeakAmp_AdapRate_matrix, [], 1);
DataSet_Max.AHP_duration_first = nanmax(AHP_duration_first_matrix, [], 1);
DataSet_Max.AHP_duration_last = nanmax(AHP_duration_last_matrix, [], 1);
DataSet_Max.AHP_duration_min = nanmax(AHP_duration_min_matrix, [], 1);
DataSet_Max.AHP_duration_max = nanmax(AHP_duration_max_matrix, [], 1);
DataSet_Max.AHP_duration_mean = nanmax(AHP_duration_mean_matrix, [], 1);
DataSet_Max.AHP_duration_AdapRate = nanmax(AHP_duration_AdapRate_matrix, [], 1);
DataSet_Max.AHP_integral_first = nanmax(AHP_integral_first_matrix, [], 1);
DataSet_Max.AHP_integral_last = nanmax(AHP_integral_last_matrix, [], 1);
DataSet_Max.AHP_integral_min = nanmax(AHP_integral_min_matrix, [], 1);
DataSet_Max.AHP_integral_max = nanmax(AHP_integral_max_matrix, [], 1);
DataSet_Max.AHP_integral_mean = nanmax(AHP_integral_mean_matrix, [], 1);
DataSet_Max.AHP_integral_AdapRate = nanmax(AHP_integral_AdapRate_matrix, [], 1);
DataSet_Max.AHP_FallSlope_first = nanmax(AHP_FallSlope_first_matrix, [], 1);
DataSet_Max.AHP_FallSlope_last = nanmax(AHP_FallSlope_last_matrix, [], 1);
DataSet_Max.AHP_FallSlope_min = nanmax(AHP_FallSlope_min_matrix, [], 1);
DataSet_Max.AHP_FallSlope_max = nanmax(AHP_FallSlope_max_matrix, [], 1);
DataSet_Max.AHP_FallSlope_mean = nanmax(AHP_FallSlope_mean_matrix, [], 1);
DataSet_Max.AHP_FallSlope_AdapRate = nanmax(AHP_FallSlope_AdapRate_matrix, [], 1);
DataSet_Max.AHP_RiseSlope_first = nanmax(AHP_RiseSlope_first_matrix, [], 1);
DataSet_Max.AHP_RiseSlope_last = nanmax(AHP_RiseSlope_last_matrix, [], 1);
DataSet_Max.AHP_RiseSlope_min = nanmax(AHP_RiseSlope_min_matrix, [], 1);
DataSet_Max.AHP_RiseSlope_max = nanmax(AHP_RiseSlope_max_matrix, [], 1);
DataSet_Max.AHP_RiseSlope_mean = nanmax(AHP_RiseSlope_mean_matrix, [], 1);
DataSet_Max.AHP_RiseSlope_AdapRate = nanmax(AHP_RiseSlope_AdapRate_matrix, [], 1);
end
