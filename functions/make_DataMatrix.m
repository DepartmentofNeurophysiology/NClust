function DataMatrix = make_DataMatrix (experiments, Fit_Constants, FitTypes)
% Make the main DataMatrix, Nx2M where N are the experiments, 
% and 2M the parameters


number_or_experiments = numel(experiments);
number_of_parameters = 2*numel(FitTypes) + 1; % The +1 is the current at 1st spike.

DataMatrix = NaN(number_or_experiments, number_of_parameters);
i_param = 1;
for i_exp = 1:number_or_experiments
    current_FitConstants = Fit_Constants(i_exp);
    i_param = 1;
    % AP Count / Firing Rates.
    var_tmp = current_FitConstants.APcount;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.APcount;
    if isfield(var_tmp, 'steepness')
        var_tmp.steepness(var_tmp.steepness == 0) = NaN;
    elseif isfield(var_tmp, 'exp_constant')
        var_tmp.exp_constant(var_tmp.exp_constant == 0) = NaN;
    end
    var_tmp_2(var_tmp_2 == 0) = NaN;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end, current_at_first_spike] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = current_at_first_spike; % Current at 1st spike.
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.FR_abs;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.FR_abs;
    if isfield(var_tmp, 'steepness')
        var_tmp.steepness(var_tmp.steepness == 0) = NaN;
    elseif isfield(var_tmp, 'exp_constant')
        var_tmp.exp_constant(var_tmp.exp_constant == 0) = NaN;
    end
    var_tmp_2(var_tmp_2 == 0) = NaN;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.FR_ins;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.FR_ins;
    if isfield(var_tmp, 'steepness')
        var_tmp.steepness(var_tmp.steepness == 0) = NaN;
    elseif isfield(var_tmp, 'exp_constant')
        var_tmp.exp_constant(var_tmp.exp_constant == 0) = NaN;
    end
    var_tmp_2(var_tmp_2 == 0) = NaN;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AP Latency.
    var_tmp = current_FitConstants.AP_lat_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_lat_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_lat_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_lat_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_lat_window;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_lat_window;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_lat_compression;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_lat_compression;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % ISI
    var_tmp = current_FitConstants.ISI_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.ISI_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.ISI_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.ISI_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.ISI_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.ISI_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.ISI_median;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.ISI_median;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.ISI_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.ISI_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AP Threshold.
    var_tmp = current_FitConstants.AP_thr_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_thr_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_thr_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_thr_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_thr_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_thr_median;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_median;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_thr_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_thr_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AP Half-Width
    var_tmp = current_FitConstants.AP_HalfWidth_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_HalfWidth_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_HalfWidth_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_HalfWidth_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_HalfWidth_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_HalfWidth_median;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_median;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_HalfWidth_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_HalfWidth_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AP Amplitude.
    var_tmp = current_FitConstants.AP_amplitude_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_amplitude_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_amplitude_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_amplitude_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_amplitude_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_amplitude_median;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_median;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AP_amplitude_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AP_amplitude_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AHP PeakLatency
    var_tmp = current_FitConstants.AHP_PeakLatency_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakLatency_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakLatency_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakLatency_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakLatency_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakLatency_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakLatency_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AHP PeakAmplitude.
    var_tmp = current_FitConstants.AHP_PeakAmp_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakAmp_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakAmp_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakAmp_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakAmp_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_PeakAmp_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_PeakAmp_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AHP Duration.
    var_tmp = current_FitConstants.AHP_duration_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_duration_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_duration_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_duration_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_duration_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_duration_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_duration_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_duration_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_duration_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_duration_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_duration_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_duration_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AHP Integral
    var_tmp = current_FitConstants.AHP_integral_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_integral_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_integral_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_integral_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_integral_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_integral_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_integral_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_integral_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_integral_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_integral_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_integral_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_integral_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AHP Fall Slope.
    var_tmp = current_FitConstants.AHP_FallSlope_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_FallSlope_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_FallSlope_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_FallSlope_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_FallSlope_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_FallSlope_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_FallSlope_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_FallSlope_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_FallSlope_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_FallSlope_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_FallSlope_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_FallSlope_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    % AHP Rise Slope.
    var_tmp = current_FitConstants.AHP_RiseSlope_first;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_first;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_RiseSlope_last;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_last;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_RiseSlope_min;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_min;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    var_tmp = current_FitConstants.AHP_RiseSlope_max;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_max;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_RiseSlope_mean;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_mean;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
    
    var_tmp = current_FitConstants.AHP_RiseSlope_AdapRate;
    var_tmp_2 = experiments(i_exp).CC_Data_Means.AHP_RiseSlope_AdapRate;
    [constant_tmp_fit, constant_tmp_start, constant_tmp_end] = get_CorrectConstValue (var_tmp, var_tmp_2);
    DataMatrix(i_exp, i_param) = constant_tmp_fit;
    i_param = i_param + 1;
    DataMatrix(i_exp, i_param) = constant_tmp_start;
    i_param = i_param + 1;
end




% SUBFUNCTION - Get the correct fit constant.
    function [constant_tmp_fit, constant_tmp_start, constant_tmp_end, current_at_first_spike] = get_CorrectConstValue (var_tmp, var_tmp_2)
        if isfield(var_tmp, 'steepness')
            constant_tmp_fit = var_tmp.steepness;
        elseif isfield(var_tmp, 'exp_constant')
            constant_tmp_fit = var_tmp.exp_constant;
        end
        
        % Gets the 1st non NaN value position.
        tmp = find(~isnan(var_tmp_2));
        if isempty(tmp)
            current_at_first_spike = NaN;
            constant_tmp_start = NaN;
            constant_tmp_end = NaN;
            return
        end
        current_at_first_spike = 40*tmp(1);
        
        % Gets the 1st non NaN value.
        var_tmp_2 = var_tmp_2((~isnan(var_tmp_2)));
        constant_tmp_start = var_tmp_2(1);
        constant_tmp_end = var_tmp_2(end);
    end

end