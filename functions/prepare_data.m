function experiments = prepare_data(cell_type, analyzed_files_directory_tmp)

% Options

% Initialize
main_program_directory = pwd;
addpath(genpath(main_program_directory));


%% Load all .mat files.
% In case the folder can't be found, have the user select it.
if exist(analyzed_files_directory_tmp, 'dir') == 0
    fprintf('Please select the directory where the analyzed experiments are stored.')
    analyzed_files_directory_tmp = uigetdir(main_program_directory, 'Select the folder where the Analyzed experiment .mat files are stored.');
    addpath(genpath(analyzed_files_directory_tmp));
end
% Get experiments with +40pA Step
fprintf('Preparing Experiments with Step = 40pA.\n')
cd(analyzed_files_directory_tmp)
main_analyzed_files_directory = pwd;
files_analyzed_tmp = dir('*.mat');
files_analyzed_tmp = struct2cell(files_analyzed_tmp);
files_analyzed = files_analyzed_tmp(1, :);
number_of_files = numel(files_analyzed);

current_step = 40;
[experiments_40pA] = get_exp_means_stds (number_of_files, files_analyzed, cell_type, current_step);
cd(main_program_directory);

% Get experiments with +20pA Step
fprintf('Preparing Experiments with Step = 20pA.\n')
analyzed_files_directory_tmp = sprintf('%s\\20pA Step', analyzed_files_directory_tmp);
if exist(analyzed_files_directory_tmp, 'dir') == 0
    fprintf('No 20pA Step experiments found');
    mkdir(analyzed_files_directory_tmp)
    addpath(genpath(analyzed_files_directory_tmp))
end
cd(analyzed_files_directory_tmp)
files_analyzed_tmp = dir('*.mat');
files_analyzed_tmp = struct2cell(files_analyzed_tmp);
files_analyzed = files_analyzed_tmp(1, :);
number_of_files = numel(files_analyzed);

current_step = 20;
[experiments_20pA] = get_exp_means_stds (number_of_files, files_analyzed, cell_type, current_step);
cd(main_program_directory);

% Put experiments together.
experiments = [experiments_40pA, experiments_20pA];

% Reorder the array according to the experiment number.
field_number = 6;
experiments = sort_structure (experiments, field_number);



%% Auxiliary Function: Prepare means and stds.
    function [experiments] = get_exp_means_stds (number_of_files, files_analyzed, cell_type, current_step)
        experiments = struct;
        i_date = 1;
        
        for i_file = 1:number_of_files
            var_name_tmp = files_analyzed{i_file};
            fprintf('Preparing File "%s".\n', var_name_tmp);
            var_name_tmp = strsplit(files_analyzed{i_file}, '_');
            var_name = sprintf('%s_%s_%s_%s', var_name_tmp{1,3}, var_name_tmp{1,4}, var_name_tmp{1,5}, cell_type);
            %     if numel(strsplit(var_name_tmp{1,7}, '.')) > 1 % Ignore the file format
            %         tmp = strsplit(var_name_tmp{1,7}, '.');
            %         var_name_tmp{1,7} = tmp{1, 1};
            %         clear tmp
            %     end
            trace_tmp = load(files_analyzed{i_file});
            experiments(i_file).analysis_results_raw = trace_tmp.gdata.columnar;
            
            experiments(i_file).current_injected = trace_tmp.gdata.columnar.current.amp(1, :);
            experiments(i_file).name_full = var_name;
            experiments(i_file).date = sprintf('%s', var_name_tmp{1, 3});
            experiments(i_file).experimenter = var_name_tmp{1, 4};
            experiments(i_file).exp_number = var_name_tmp{1, 5};
            experiments(i_file).cell_type = cell_type;
            if current_step == 40
                experiments(i_file).current_step = '40pA';
            elseif current_step == 20
                experiments(i_file).current_step = '20pA';
            end
            
            % Compute Means
            trace_tmp.gdata.columnar.APcount(isinf(trace_tmp.gdata.columnar.APcount)) = NaN;
            experiments(i_file).analysis_results_means.APcount = nanmean(trace_tmp.gdata.columnar.APcount, 1);
            
            trace_tmp.gdata.columnar.FR.abs(isinf(trace_tmp.gdata.columnar.FR.abs)) = NaN;
            trace_tmp.gdata.columnar.FR.ins(isinf(trace_tmp.gdata.columnar.FR.ins)) = NaN;
            experiments(i_file).analysis_results_means.FR_abs = nanmean(trace_tmp.gdata.columnar.FR.abs, 1);
            experiments(i_file).analysis_results_means.FR_ins = nanmean(trace_tmp.gdata.columnar.FR.ins, 1);
            
            trace_tmp.gdata.columnar.APlat.first(isinf(trace_tmp.gdata.columnar.APlat.first)) = NaN;
            trace_tmp.gdata.columnar.APlat.last(isinf(trace_tmp.gdata.columnar.APlat.last)) = NaN;
            trace_tmp.gdata.columnar.APlat.window(isinf(trace_tmp.gdata.columnar.APlat.window)) = NaN;
            trace_tmp.gdata.columnar.APlat.compression(isinf(trace_tmp.gdata.columnar.APlat.compression)) = NaN;
            experiments(i_file).analysis_results_means.AP_lat_first = nanmean(trace_tmp.gdata.columnar.APlat.first, 1);
            experiments(i_file).analysis_results_means.AP_lat_last = nanmean(trace_tmp.gdata.columnar.APlat.last, 1);
            experiments(i_file).analysis_results_means.AP_lat_window = nanmean(trace_tmp.gdata.columnar.APlat.window, 1);
            experiments(i_file).analysis_results_means.AP_lat_compression = nanmean(trace_tmp.gdata.columnar.APlat.compression, 1);
            
            trace_tmp.gdata.columnar.ISI.min(isinf(trace_tmp.gdata.columnar.ISI.min)) = NaN;
            trace_tmp.gdata.columnar.ISI.max(isinf(trace_tmp.gdata.columnar.ISI.max)) = NaN;
            trace_tmp.gdata.columnar.ISI.mean(isinf(trace_tmp.gdata.columnar.ISI.mean)) = NaN;
            trace_tmp.gdata.columnar.ISI.median(isinf(trace_tmp.gdata.columnar.ISI.median)) = NaN;
            trace_tmp.gdata.columnar.ISI.AdapRate(isinf(trace_tmp.gdata.columnar.ISI.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.ISI_min = nanmean(trace_tmp.gdata.columnar.ISI.min, 1);
            experiments(i_file).analysis_results_means.ISI_max = nanmean(trace_tmp.gdata.columnar.ISI.max, 1);
            experiments(i_file).analysis_results_means.ISI_mean = nanmean(trace_tmp.gdata.columnar.ISI.mean, 1);
            experiments(i_file).analysis_results_means.ISI_median = nanmean(trace_tmp.gdata.columnar.ISI.median, 1);
            experiments(i_file).analysis_results_means.ISI_AdapRate = nanmean(trace_tmp.gdata.columnar.ISI.AdapRate, 1);
            
            trace_tmp.gdata.columnar.APthr.first(isinf(trace_tmp.gdata.columnar.APthr.first)) = NaN;
            trace_tmp.gdata.columnar.APthr.last(isinf(trace_tmp.gdata.columnar.APthr.last)) = NaN;
            trace_tmp.gdata.columnar.APthr.min(isinf(trace_tmp.gdata.columnar.APthr.min)) = NaN;
            trace_tmp.gdata.columnar.APthr.max(isinf(trace_tmp.gdata.columnar.APthr.max)) = NaN;
            trace_tmp.gdata.columnar.APthr.mean(isinf(trace_tmp.gdata.columnar.APthr.mean)) = NaN;
            trace_tmp.gdata.columnar.APthr.median(isinf(trace_tmp.gdata.columnar.APthr.median)) = NaN;
            trace_tmp.gdata.columnar.APthr.AdapRate(isinf(trace_tmp.gdata.columnar.APthr.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AP_thr_first = nanmean(trace_tmp.gdata.columnar.APthr.first, 1);
            experiments(i_file).analysis_results_means.AP_thr_last = nanmean(trace_tmp.gdata.columnar.APthr.last, 1);
            experiments(i_file).analysis_results_means.AP_thr_min = nanmean(trace_tmp.gdata.columnar.APthr.min, 1);
            experiments(i_file).analysis_results_means.AP_thr_max = nanmean(trace_tmp.gdata.columnar.APthr.max, 1);
            experiments(i_file).analysis_results_means.AP_thr_mean = nanmean(trace_tmp.gdata.columnar.APthr.mean, 1);
            experiments(i_file).analysis_results_means.AP_thr_median = nanmean(trace_tmp.gdata.columnar.APthr.median, 1);
            experiments(i_file).analysis_results_means.AP_thr_AdapRate = nanmean(trace_tmp.gdata.columnar.APthr.AdapRate, 1);
            
            trace_tmp.gdata.columnar.APhalfwidth.first(isinf(trace_tmp.gdata.columnar.APhalfwidth.first)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.last(isinf(trace_tmp.gdata.columnar.APhalfwidth.last)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.min(isinf(trace_tmp.gdata.columnar.APhalfwidth.min)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.max(isinf(trace_tmp.gdata.columnar.APhalfwidth.max)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.mean(isinf(trace_tmp.gdata.columnar.APhalfwidth.mean)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.median(isinf(trace_tmp.gdata.columnar.APhalfwidth.median)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.AdapRate(isinf(trace_tmp.gdata.columnar.APhalfwidth.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AP_HalfWidth_first = nanmean(trace_tmp.gdata.columnar.APhalfwidth.first, 1);
            experiments(i_file).analysis_results_means.AP_HalfWidth_last = nanmean(trace_tmp.gdata.columnar.APhalfwidth.last, 1);
            experiments(i_file).analysis_results_means.AP_HalfWidth_min = nanmean(trace_tmp.gdata.columnar.APhalfwidth.min, 1);
            experiments(i_file).analysis_results_means.AP_HalfWidth_max = nanmean(trace_tmp.gdata.columnar.APhalfwidth.max, 1);
            experiments(i_file).analysis_results_means.AP_HalfWidth_mean = nanmean(trace_tmp.gdata.columnar.APhalfwidth.mean, 1);
            experiments(i_file).analysis_results_means.AP_HalfWidth_median = nanmean(trace_tmp.gdata.columnar.APhalfwidth.median, 1);
            experiments(i_file).analysis_results_means.AP_HalfWidth_AdapRate = nanmean(trace_tmp.gdata.columnar.APhalfwidth.AdapRate, 1);
            
            trace_tmp.gdata.columnar.APamp.first(isinf(trace_tmp.gdata.columnar.APamp.first)) = NaN;
            trace_tmp.gdata.columnar.APamp.last(isinf(trace_tmp.gdata.columnar.APamp.last)) = NaN;
            trace_tmp.gdata.columnar.APamp.min(isinf(trace_tmp.gdata.columnar.APamp.min)) = NaN;
            trace_tmp.gdata.columnar.APamp.max(isinf(trace_tmp.gdata.columnar.APamp.max)) = NaN;
            trace_tmp.gdata.columnar.APamp.mean(isinf(trace_tmp.gdata.columnar.APamp.mean)) = NaN;
            trace_tmp.gdata.columnar.APamp.median(isinf(trace_tmp.gdata.columnar.APamp.median)) = NaN;
            trace_tmp.gdata.columnar.APamp.AdapRate(isinf(trace_tmp.gdata.columnar.APamp.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AP_amplitude_first = nanmean(trace_tmp.gdata.columnar.APamp.first, 1);
            experiments(i_file).analysis_results_means.AP_amplitude_last = nanmean(trace_tmp.gdata.columnar.APamp.last, 1);
            experiments(i_file).analysis_results_means.AP_amplitude_min = nanmean(trace_tmp.gdata.columnar.APamp.min, 1);
            experiments(i_file).analysis_results_means.AP_amplitude_max = nanmean(trace_tmp.gdata.columnar.APamp.max, 1);
            experiments(i_file).analysis_results_means.AP_amplitude_mean = nanmean(trace_tmp.gdata.columnar.APamp.mean, 1);
            experiments(i_file).analysis_results_means.AP_amplitude_median = nanmean(trace_tmp.gdata.columnar.APamp.median, 1);
            experiments(i_file).analysis_results_means.AP_amplitude_AdapRate = nanmean(trace_tmp.gdata.columnar.APamp.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.peaklatency.first(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.last(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.min(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.max(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.mean(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AHP_PeakLatency_first = nanmean(trace_tmp.gdata.columnar.AHP.peaklatency.first, 1);
            experiments(i_file).analysis_results_means.AHP_PeakLatency_last = nanmean(trace_tmp.gdata.columnar.AHP.peaklatency.last, 1);
            experiments(i_file).analysis_results_means.AHP_PeakLatency_min = nanmean(trace_tmp.gdata.columnar.AHP.peaklatency.min, 1);
            experiments(i_file).analysis_results_means.AHP_PeakLatency_max = nanmean(trace_tmp.gdata.columnar.AHP.peaklatency.max, 1);
            experiments(i_file).analysis_results_means.AHP_PeakLatency_mean = nanmean(trace_tmp.gdata.columnar.AHP.peaklatency.mean, 1);
            experiments(i_file).analysis_results_means.AHP_PeakLatency_AdapRate = nanmean(trace_tmp.gdata.columnar.AHP.peaklatency.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.peakamp.first(isinf(trace_tmp.gdata.columnar.AHP.peakamp.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.last(isinf(trace_tmp.gdata.columnar.AHP.peakamp.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.min(isinf(trace_tmp.gdata.columnar.AHP.peakamp.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.max(isinf(trace_tmp.gdata.columnar.AHP.peakamp.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.mean(isinf(trace_tmp.gdata.columnar.AHP.peakamp.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.peakamp.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AHP_PeakAmp_first = nanmean(trace_tmp.gdata.columnar.AHP.peakamp.first, 1);
            experiments(i_file).analysis_results_means.AHP_PeakAmp_last = nanmean(trace_tmp.gdata.columnar.AHP.peakamp.last, 1);
            experiments(i_file).analysis_results_means.AHP_PeakAmp_min = nanmean(trace_tmp.gdata.columnar.AHP.peakamp.min, 1);
            experiments(i_file).analysis_results_means.AHP_PeakAmp_max = nanmean(trace_tmp.gdata.columnar.AHP.peakamp.max, 1);
            experiments(i_file).analysis_results_means.AHP_PeakAmp_mean = nanmean(trace_tmp.gdata.columnar.AHP.peakamp.mean, 1);
            experiments(i_file).analysis_results_means.AHP_PeakAmp_AdapRate = nanmean(trace_tmp.gdata.columnar.AHP.peakamp.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.duration.first(isinf(trace_tmp.gdata.columnar.AHP.duration.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.last(isinf(trace_tmp.gdata.columnar.AHP.duration.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.min(isinf(trace_tmp.gdata.columnar.AHP.duration.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.max(isinf(trace_tmp.gdata.columnar.AHP.duration.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.mean(isinf(trace_tmp.gdata.columnar.AHP.duration.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.duration.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AHP_duration_first = nanmean(trace_tmp.gdata.columnar.AHP.duration.first, 1);
            experiments(i_file).analysis_results_means.AHP_duration_last = nanmean(trace_tmp.gdata.columnar.AHP.duration.last, 1);
            experiments(i_file).analysis_results_means.AHP_duration_min = nanmean(trace_tmp.gdata.columnar.AHP.duration.min, 1);
            experiments(i_file).analysis_results_means.AHP_duration_max = nanmean(trace_tmp.gdata.columnar.AHP.duration.max, 1);
            experiments(i_file).analysis_results_means.AHP_duration_mean = nanmean(trace_tmp.gdata.columnar.AHP.duration.mean, 1);
            experiments(i_file).analysis_results_means.AHP_duration_AdapRate = nanmean(trace_tmp.gdata.columnar.AHP.duration.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.integral.first(isinf(trace_tmp.gdata.columnar.AHP.integral.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.last(isinf(trace_tmp.gdata.columnar.AHP.integral.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.min(isinf(trace_tmp.gdata.columnar.AHP.integral.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.max(isinf(trace_tmp.gdata.columnar.AHP.integral.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.mean(isinf(trace_tmp.gdata.columnar.AHP.integral.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.integral.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AHP_integral_first = nanmean(trace_tmp.gdata.columnar.AHP.integral.first, 1);
            experiments(i_file).analysis_results_means.AHP_integral_last = nanmean(trace_tmp.gdata.columnar.AHP.integral.last, 1);
            experiments(i_file).analysis_results_means.AHP_integral_min = nanmean(trace_tmp.gdata.columnar.AHP.integral.min, 1);
            experiments(i_file).analysis_results_means.AHP_integral_max = nanmean(trace_tmp.gdata.columnar.AHP.integral.max, 1);
            experiments(i_file).analysis_results_means.AHP_integral_mean = nanmean(trace_tmp.gdata.columnar.AHP.integral.mean, 1);
            experiments(i_file).analysis_results_means.AHP_integral_AdapRate = nanmean(trace_tmp.gdata.columnar.AHP.integral.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.fallslope.first(isinf(trace_tmp.gdata.columnar.AHP.fallslope.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.last(isinf(trace_tmp.gdata.columnar.AHP.fallslope.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.min(isinf(trace_tmp.gdata.columnar.AHP.fallslope.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.max(isinf(trace_tmp.gdata.columnar.AHP.fallslope.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.mean(isinf(trace_tmp.gdata.columnar.AHP.fallslope.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.fallslope.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AHP_FallSlope_first = nanmean(trace_tmp.gdata.columnar.AHP.fallslope.first, 1);
            experiments(i_file).analysis_results_means.AHP_FallSlope_last = nanmean(trace_tmp.gdata.columnar.AHP.fallslope.last, 1);
            experiments(i_file).analysis_results_means.AHP_FallSlope_min = nanmean(trace_tmp.gdata.columnar.AHP.fallslope.min, 1);
            experiments(i_file).analysis_results_means.AHP_FallSlope_max = nanmean(trace_tmp.gdata.columnar.AHP.fallslope.max, 1);
            experiments(i_file).analysis_results_means.AHP_FallSlope_mean = nanmean(trace_tmp.gdata.columnar.AHP.fallslope.mean, 1);
            experiments(i_file).analysis_results_means.AHP_FallSlope_AdapRate = nanmean(trace_tmp.gdata.columnar.AHP.fallslope.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.risingslope.first(isinf(trace_tmp.gdata.columnar.AHP.risingslope.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.last(isinf(trace_tmp.gdata.columnar.AHP.risingslope.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.min(isinf(trace_tmp.gdata.columnar.AHP.risingslope.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.max(isinf(trace_tmp.gdata.columnar.AHP.risingslope.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.mean(isinf(trace_tmp.gdata.columnar.AHP.risingslope.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.risingslope.AdapRate)) = NaN;
            experiments(i_file).analysis_results_means.AHP_RiseSlope_first = nanmean(trace_tmp.gdata.columnar.AHP.risingslope.first, 1);
            experiments(i_file).analysis_results_means.AHP_RiseSlope_last = nanmean(trace_tmp.gdata.columnar.AHP.risingslope.last, 1);
            experiments(i_file).analysis_results_means.AHP_RiseSlope_min = nanmean(trace_tmp.gdata.columnar.AHP.risingslope.min, 1);
            experiments(i_file).analysis_results_means.AHP_RiseSlope_max = nanmean(trace_tmp.gdata.columnar.AHP.risingslope.max, 1);
            experiments(i_file).analysis_results_means.AHP_RiseSlope_mean = nanmean(trace_tmp.gdata.columnar.AHP.risingslope.mean, 1);
            experiments(i_file).analysis_results_means.AHP_RiseSlope_AdapRate = nanmean(trace_tmp.gdata.columnar.AHP.risingslope.AdapRate, 1);
            
            
            % Compute Stds
            trace_tmp.gdata.columnar.APcount(isinf(trace_tmp.gdata.columnar.APcount)) = NaN;
            experiments(i_file).analysis_results_stds.APcount = nanstd(trace_tmp.gdata.columnar.APcount, 1);
            
            trace_tmp.gdata.columnar.FR.abs(isinf(trace_tmp.gdata.columnar.FR.abs)) = NaN;
            trace_tmp.gdata.columnar.FR.ins(isinf(trace_tmp.gdata.columnar.FR.ins)) = NaN;
            experiments(i_file).analysis_results_stds.FR_abs = nanstd(trace_tmp.gdata.columnar.FR.abs, 1);
            experiments(i_file).analysis_results_stds.FR_ins = nanstd(trace_tmp.gdata.columnar.FR.ins, 1);
            
            trace_tmp.gdata.columnar.APlat.first(isinf(trace_tmp.gdata.columnar.APlat.first)) = NaN;
            trace_tmp.gdata.columnar.APlat.last(isinf(trace_tmp.gdata.columnar.APlat.last)) = NaN;
            trace_tmp.gdata.columnar.APlat.window(isinf(trace_tmp.gdata.columnar.APlat.window)) = NaN;
            trace_tmp.gdata.columnar.APlat.compression(isinf(trace_tmp.gdata.columnar.APlat.compression)) = NaN;
            experiments(i_file).analysis_results_stds.AP_lat_first = nanstd(trace_tmp.gdata.columnar.APlat.first, 1);
            experiments(i_file).analysis_results_stds.AP_lat_last = nanstd(trace_tmp.gdata.columnar.APlat.last, 1);
            experiments(i_file).analysis_results_stds.AP_lat_window = nanstd(trace_tmp.gdata.columnar.APlat.window, 1);
            experiments(i_file).analysis_results_stds.AP_lat_compression = nanstd(trace_tmp.gdata.columnar.APlat.compression, 1);
            
            trace_tmp.gdata.columnar.ISI.min(isinf(trace_tmp.gdata.columnar.ISI.min)) = NaN;
            trace_tmp.gdata.columnar.ISI.max(isinf(trace_tmp.gdata.columnar.ISI.max)) = NaN;
            trace_tmp.gdata.columnar.ISI.mean(isinf(trace_tmp.gdata.columnar.ISI.mean)) = NaN;
            trace_tmp.gdata.columnar.ISI.median(isinf(trace_tmp.gdata.columnar.ISI.median)) = NaN;
            trace_tmp.gdata.columnar.ISI.AdapRate(isinf(trace_tmp.gdata.columnar.ISI.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.ISI_min = nanstd(trace_tmp.gdata.columnar.ISI.min, 1);
            experiments(i_file).analysis_results_stds.ISI_max = nanstd(trace_tmp.gdata.columnar.ISI.max, 1);
            experiments(i_file).analysis_results_stds.ISI_mean = nanstd(trace_tmp.gdata.columnar.ISI.mean, 1);
            experiments(i_file).analysis_results_stds.ISI_median = nanstd(trace_tmp.gdata.columnar.ISI.median, 1);
            experiments(i_file).analysis_results_stds.ISI_AdapRate = nanstd(trace_tmp.gdata.columnar.ISI.AdapRate, 1);
            
            trace_tmp.gdata.columnar.APthr.first(isinf(trace_tmp.gdata.columnar.APthr.first)) = NaN;
            trace_tmp.gdata.columnar.APthr.last(isinf(trace_tmp.gdata.columnar.APthr.last)) = NaN;
            trace_tmp.gdata.columnar.APthr.min(isinf(trace_tmp.gdata.columnar.APthr.min)) = NaN;
            trace_tmp.gdata.columnar.APthr.max(isinf(trace_tmp.gdata.columnar.APthr.max)) = NaN;
            trace_tmp.gdata.columnar.APthr.mean(isinf(trace_tmp.gdata.columnar.APthr.mean)) = NaN;
            trace_tmp.gdata.columnar.APthr.median(isinf(trace_tmp.gdata.columnar.APthr.median)) = NaN;
            trace_tmp.gdata.columnar.APthr.AdapRate(isinf(trace_tmp.gdata.columnar.APthr.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AP_thr_first = nanstd(trace_tmp.gdata.columnar.APthr.first, 1);
            experiments(i_file).analysis_results_stds.AP_thr_last = nanstd(trace_tmp.gdata.columnar.APthr.last, 1);
            experiments(i_file).analysis_results_stds.AP_thr_min = nanstd(trace_tmp.gdata.columnar.APthr.min, 1);
            experiments(i_file).analysis_results_stds.AP_thr_max = nanstd(trace_tmp.gdata.columnar.APthr.max, 1);
            experiments(i_file).analysis_results_stds.AP_thr_mean = nanstd(trace_tmp.gdata.columnar.APthr.mean, 1);
            experiments(i_file).analysis_results_stds.AP_thr_median = nanstd(trace_tmp.gdata.columnar.APthr.median, 1);
            experiments(i_file).analysis_results_stds.AP_thr_AdapRate = nanstd(trace_tmp.gdata.columnar.APthr.AdapRate, 1);
            
            trace_tmp.gdata.columnar.APhalfwidth.first(isinf(trace_tmp.gdata.columnar.APhalfwidth.first)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.last(isinf(trace_tmp.gdata.columnar.APhalfwidth.last)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.min(isinf(trace_tmp.gdata.columnar.APhalfwidth.min)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.max(isinf(trace_tmp.gdata.columnar.APhalfwidth.max)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.mean(isinf(trace_tmp.gdata.columnar.APhalfwidth.mean)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.median(isinf(trace_tmp.gdata.columnar.APhalfwidth.median)) = NaN;
            trace_tmp.gdata.columnar.APhalfwidth.AdapRate(isinf(trace_tmp.gdata.columnar.APhalfwidth.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AP_HalfWidth_first = nanstd(trace_tmp.gdata.columnar.APhalfwidth.first, 1);
            experiments(i_file).analysis_results_stds.AP_HalfWidth_last = nanstd(trace_tmp.gdata.columnar.APhalfwidth.last, 1);
            experiments(i_file).analysis_results_stds.AP_HalfWidth_min = nanstd(trace_tmp.gdata.columnar.APhalfwidth.min, 1);
            experiments(i_file).analysis_results_stds.AP_HalfWidth_max = nanstd(trace_tmp.gdata.columnar.APhalfwidth.max, 1);
            experiments(i_file).analysis_results_stds.AP_HalfWidth_mean = nanstd(trace_tmp.gdata.columnar.APhalfwidth.mean, 1);
            experiments(i_file).analysis_results_stds.AP_HalfWidth_median = nanstd(trace_tmp.gdata.columnar.APhalfwidth.median, 1);
            experiments(i_file).analysis_results_stds.AP_HalfWidth_AdapRate = nanstd(trace_tmp.gdata.columnar.APhalfwidth.AdapRate, 1);
            
            trace_tmp.gdata.columnar.APamp.first(isinf(trace_tmp.gdata.columnar.APamp.first)) = NaN;
            trace_tmp.gdata.columnar.APamp.last(isinf(trace_tmp.gdata.columnar.APamp.last)) = NaN;
            trace_tmp.gdata.columnar.APamp.min(isinf(trace_tmp.gdata.columnar.APamp.min)) = NaN;
            trace_tmp.gdata.columnar.APamp.max(isinf(trace_tmp.gdata.columnar.APamp.max)) = NaN;
            trace_tmp.gdata.columnar.APamp.mean(isinf(trace_tmp.gdata.columnar.APamp.mean)) = NaN;
            trace_tmp.gdata.columnar.APamp.median(isinf(trace_tmp.gdata.columnar.APamp.median)) = NaN;
            trace_tmp.gdata.columnar.APamp.AdapRate(isinf(trace_tmp.gdata.columnar.APamp.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AP_amplitude_first = nanstd(trace_tmp.gdata.columnar.APamp.first, 1);
            experiments(i_file).analysis_results_stds.AP_amplitude_last = nanstd(trace_tmp.gdata.columnar.APamp.last, 1);
            experiments(i_file).analysis_results_stds.AP_amplitude_min = nanstd(trace_tmp.gdata.columnar.APamp.min, 1);
            experiments(i_file).analysis_results_stds.AP_amplitude_max = nanstd(trace_tmp.gdata.columnar.APamp.max, 1);
            experiments(i_file).analysis_results_stds.AP_amplitude_mean = nanstd(trace_tmp.gdata.columnar.APamp.mean, 1);
            experiments(i_file).analysis_results_stds.AP_amplitude_median = nanstd(trace_tmp.gdata.columnar.APamp.median, 1);
            experiments(i_file).analysis_results_stds.AP_amplitude_AdapRate = nanstd(trace_tmp.gdata.columnar.APamp.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.peaklatency.first(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.last(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.min(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.max(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.mean(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.peaklatency.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.peaklatency.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AHP_PeakLatency_first = nanstd(trace_tmp.gdata.columnar.AHP.peaklatency.first, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakLatency_last = nanstd(trace_tmp.gdata.columnar.AHP.peaklatency.last, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakLatency_min = nanstd(trace_tmp.gdata.columnar.AHP.peaklatency.min, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakLatency_max = nanstd(trace_tmp.gdata.columnar.AHP.peaklatency.max, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakLatency_mean = nanstd(trace_tmp.gdata.columnar.AHP.peaklatency.mean, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakLatency_AdapRate = nanstd(trace_tmp.gdata.columnar.AHP.peaklatency.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.peakamp.first(isinf(trace_tmp.gdata.columnar.AHP.peakamp.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.last(isinf(trace_tmp.gdata.columnar.AHP.peakamp.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.min(isinf(trace_tmp.gdata.columnar.AHP.peakamp.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.max(isinf(trace_tmp.gdata.columnar.AHP.peakamp.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.mean(isinf(trace_tmp.gdata.columnar.AHP.peakamp.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.peakamp.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.peakamp.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AHP_PeakAmp_first = nanstd(trace_tmp.gdata.columnar.AHP.peakamp.first, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakAmp_last = nanstd(trace_tmp.gdata.columnar.AHP.peakamp.last, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakAmp_min = nanstd(trace_tmp.gdata.columnar.AHP.peakamp.min, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakAmp_max = nanstd(trace_tmp.gdata.columnar.AHP.peakamp.max, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakAmp_mean = nanstd(trace_tmp.gdata.columnar.AHP.peakamp.mean, 1);
            experiments(i_file).analysis_results_stds.AHP_PeakAmp_AdapRate = nanstd(trace_tmp.gdata.columnar.AHP.peakamp.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.duration.first(isinf(trace_tmp.gdata.columnar.AHP.duration.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.last(isinf(trace_tmp.gdata.columnar.AHP.duration.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.min(isinf(trace_tmp.gdata.columnar.AHP.duration.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.max(isinf(trace_tmp.gdata.columnar.AHP.duration.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.mean(isinf(trace_tmp.gdata.columnar.AHP.duration.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.duration.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.duration.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AHP_duration_first = nanstd(trace_tmp.gdata.columnar.AHP.duration.first, 1);
            experiments(i_file).analysis_results_stds.AHP_duration_last = nanstd(trace_tmp.gdata.columnar.AHP.duration.last, 1);
            experiments(i_file).analysis_results_stds.AHP_duration_min = nanstd(trace_tmp.gdata.columnar.AHP.duration.min, 1);
            experiments(i_file).analysis_results_stds.AHP_duration_max = nanstd(trace_tmp.gdata.columnar.AHP.duration.max, 1);
            experiments(i_file).analysis_results_stds.AHP_duration_mean = nanstd(trace_tmp.gdata.columnar.AHP.duration.mean, 1);
            experiments(i_file).analysis_results_stds.AHP_duration_AdapRate = nanstd(trace_tmp.gdata.columnar.AHP.duration.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.integral.first(isinf(trace_tmp.gdata.columnar.AHP.integral.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.last(isinf(trace_tmp.gdata.columnar.AHP.integral.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.min(isinf(trace_tmp.gdata.columnar.AHP.integral.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.max(isinf(trace_tmp.gdata.columnar.AHP.integral.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.mean(isinf(trace_tmp.gdata.columnar.AHP.integral.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.integral.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.integral.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AHP_integral_first = nanstd(trace_tmp.gdata.columnar.AHP.integral.first, 1);
            experiments(i_file).analysis_results_stds.AHP_integral_last = nanstd(trace_tmp.gdata.columnar.AHP.integral.last, 1);
            experiments(i_file).analysis_results_stds.AHP_integral_min = nanstd(trace_tmp.gdata.columnar.AHP.integral.min, 1);
            experiments(i_file).analysis_results_stds.AHP_integral_max = nanstd(trace_tmp.gdata.columnar.AHP.integral.max, 1);
            experiments(i_file).analysis_results_stds.AHP_integral_mean = nanstd(trace_tmp.gdata.columnar.AHP.integral.mean, 1);
            experiments(i_file).analysis_results_stds.AHP_integral_AdapRate = nanstd(trace_tmp.gdata.columnar.AHP.integral.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.fallslope.first(isinf(trace_tmp.gdata.columnar.AHP.fallslope.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.last(isinf(trace_tmp.gdata.columnar.AHP.fallslope.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.min(isinf(trace_tmp.gdata.columnar.AHP.fallslope.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.max(isinf(trace_tmp.gdata.columnar.AHP.fallslope.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.mean(isinf(trace_tmp.gdata.columnar.AHP.fallslope.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.fallslope.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.fallslope.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AHP_FallSlope_first = nanstd(trace_tmp.gdata.columnar.AHP.fallslope.first, 1);
            experiments(i_file).analysis_results_stds.AHP_FallSlope_last = nanstd(trace_tmp.gdata.columnar.AHP.fallslope.last, 1);
            experiments(i_file).analysis_results_stds.AHP_FallSlope_min = nanstd(trace_tmp.gdata.columnar.AHP.fallslope.min, 1);
            experiments(i_file).analysis_results_stds.AHP_FallSlope_max = nanstd(trace_tmp.gdata.columnar.AHP.fallslope.max, 1);
            experiments(i_file).analysis_results_stds.AHP_FallSlope_mean = nanstd(trace_tmp.gdata.columnar.AHP.fallslope.mean, 1);
            experiments(i_file).analysis_results_stds.AHP_FallSlope_AdapRate = nanstd(trace_tmp.gdata.columnar.AHP.fallslope.AdapRate, 1);
            
            trace_tmp.gdata.columnar.AHP.risingslope.first(isinf(trace_tmp.gdata.columnar.AHP.risingslope.first)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.last(isinf(trace_tmp.gdata.columnar.AHP.risingslope.last)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.min(isinf(trace_tmp.gdata.columnar.AHP.risingslope.min)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.max(isinf(trace_tmp.gdata.columnar.AHP.risingslope.max)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.mean(isinf(trace_tmp.gdata.columnar.AHP.risingslope.mean)) = NaN;
            trace_tmp.gdata.columnar.AHP.risingslope.AdapRate(isinf(trace_tmp.gdata.columnar.AHP.risingslope.AdapRate)) = NaN;
            experiments(i_file).analysis_results_stds.AHP_RiseSlope_first = nanstd(trace_tmp.gdata.columnar.AHP.risingslope.first, 1);
            experiments(i_file).analysis_results_stds.AHP_RiseSlope_last = nanstd(trace_tmp.gdata.columnar.AHP.risingslope.last, 1);
            experiments(i_file).analysis_results_stds.AHP_RiseSlope_min = nanstd(trace_tmp.gdata.columnar.AHP.risingslope.min, 1);
            experiments(i_file).analysis_results_stds.AHP_RiseSlope_max = nanstd(trace_tmp.gdata.columnar.AHP.risingslope.max, 1);
            experiments(i_file).analysis_results_stds.AHP_RiseSlope_mean = nanstd(trace_tmp.gdata.columnar.AHP.risingslope.mean, 1);
            experiments(i_file).analysis_results_stds.AHP_RiseSlope_AdapRate = nanstd(trace_tmp.gdata.columnar.AHP.risingslope.AdapRate, 1);
            
            % Ignore odd current steps in case of Steps of +20pA
            if current_step == 20
                % Means
                experiments(i_file).analysis_results_means.APcount(1:2:10) = [];
                experiments(i_file).analysis_results_means.APcount = [experiments(i_file).analysis_results_means.APcount, NaN(1, 5)];
                experiments(i_file).analysis_results_means.FR_abs(1:2:10) = [];
                experiments(i_file).analysis_results_means.FR_abs = [experiments(i_file).analysis_results_means.FR_abs, NaN(1, 5)];
                experiments(i_file).analysis_results_means.FR_ins(1:2:10) = [];
                experiments(i_file).analysis_results_means.FR_ins = [experiments(i_file).analysis_results_means.FR_ins, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_lat_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_lat_first = [experiments(i_file).analysis_results_means.AP_lat_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_lat_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_lat_last = [experiments(i_file).analysis_results_means.AP_lat_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_lat_window(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_lat_window = [experiments(i_file).analysis_results_means.AP_lat_window, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_lat_compression(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_lat_compression = [experiments(i_file).analysis_results_means.AP_lat_compression, NaN(1, 5)];
                experiments(i_file).analysis_results_means.ISI_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.ISI_min = [experiments(i_file).analysis_results_means.ISI_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.ISI_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.ISI_max = [experiments(i_file).analysis_results_means.ISI_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.ISI_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.ISI_mean = [experiments(i_file).analysis_results_means.ISI_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.ISI_median(1:2:10) = [];
                experiments(i_file).analysis_results_means.ISI_median = [experiments(i_file).analysis_results_means.ISI_median, NaN(1, 5)];
                experiments(i_file).analysis_results_means.ISI_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.ISI_AdapRate = [experiments(i_file).analysis_results_means.ISI_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_first = [experiments(i_file).analysis_results_means.AP_thr_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_last = [experiments(i_file).analysis_results_means.AP_thr_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_min = [experiments(i_file).analysis_results_means.AP_thr_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_max = [experiments(i_file).analysis_results_means.AP_thr_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_mean = [experiments(i_file).analysis_results_means.AP_thr_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_median(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_median = [experiments(i_file).analysis_results_means.AP_thr_median, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_thr_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_thr_AdapRate = [experiments(i_file).analysis_results_means.AP_thr_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_first = [experiments(i_file).analysis_results_means.AP_HalfWidth_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_last = [experiments(i_file).analysis_results_means.AP_HalfWidth_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_min = [experiments(i_file).analysis_results_means.AP_HalfWidth_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_max = [experiments(i_file).analysis_results_means.AP_HalfWidth_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_mean = [experiments(i_file).analysis_results_means.AP_HalfWidth_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_median(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_median = [experiments(i_file).analysis_results_means.AP_HalfWidth_median, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_HalfWidth_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_HalfWidth_AdapRate = [experiments(i_file).analysis_results_means.AP_HalfWidth_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_first = [experiments(i_file).analysis_results_means.AP_amplitude_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_last = [experiments(i_file).analysis_results_means.AP_amplitude_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_min = [experiments(i_file).analysis_results_means.AP_amplitude_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_max = [experiments(i_file).analysis_results_means.AP_amplitude_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_mean = [experiments(i_file).analysis_results_means.AP_amplitude_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_median(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_median = [experiments(i_file).analysis_results_means.AP_amplitude_median, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AP_amplitude_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AP_amplitude_AdapRate = [experiments(i_file).analysis_results_means.AP_amplitude_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_first = [experiments(i_file).analysis_results_means.AHP_PeakLatency_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_last = [experiments(i_file).analysis_results_means.AHP_PeakLatency_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_min = [experiments(i_file).analysis_results_means.AHP_PeakLatency_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_max = [experiments(i_file).analysis_results_means.AHP_PeakLatency_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_mean = [experiments(i_file).analysis_results_means.AHP_PeakLatency_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakLatency_AdapRate = [experiments(i_file).analysis_results_means.AHP_PeakLatency_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_first = [experiments(i_file).analysis_results_means.AHP_PeakAmp_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_last = [experiments(i_file).analysis_results_means.AHP_PeakAmp_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_min = [experiments(i_file).analysis_results_means.AHP_PeakAmp_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_max = [experiments(i_file).analysis_results_means.AHP_PeakAmp_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_mean = [experiments(i_file).analysis_results_means.AHP_PeakAmp_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_PeakAmp_AdapRate = [experiments(i_file).analysis_results_means.AHP_PeakAmp_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_duration_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_duration_first = [experiments(i_file).analysis_results_means.AHP_duration_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_duration_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_duration_last = [experiments(i_file).analysis_results_means.AHP_duration_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_duration_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_duration_min = [experiments(i_file).analysis_results_means.AHP_duration_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_duration_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_duration_max = [experiments(i_file).analysis_results_means.AHP_duration_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_duration_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_duration_mean = [experiments(i_file).analysis_results_means.AHP_duration_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_duration_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_duration_AdapRate = [experiments(i_file).analysis_results_means.AHP_duration_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_integral_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_integral_first = [experiments(i_file).analysis_results_means.AHP_integral_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_integral_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_integral_last = [experiments(i_file).analysis_results_means.AHP_integral_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_integral_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_integral_min = [experiments(i_file).analysis_results_means.AHP_integral_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_integral_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_integral_max = [experiments(i_file).analysis_results_means.AHP_integral_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_integral_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_integral_mean = [experiments(i_file).analysis_results_means.AHP_integral_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_integral_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_integral_AdapRate = [experiments(i_file).analysis_results_means.AHP_integral_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_FallSlope_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_FallSlope_first = [experiments(i_file).analysis_results_means.AHP_FallSlope_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_FallSlope_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_FallSlope_last = [experiments(i_file).analysis_results_means.AHP_FallSlope_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_FallSlope_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_FallSlope_min = [experiments(i_file).analysis_results_means.AHP_FallSlope_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_FallSlope_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_FallSlope_max = [experiments(i_file).analysis_results_means.AHP_FallSlope_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_FallSlope_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_FallSlope_mean = [experiments(i_file).analysis_results_means.AHP_FallSlope_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_FallSlope_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_FallSlope_AdapRate = [experiments(i_file).analysis_results_means.AHP_FallSlope_AdapRate, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_first(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_first = [experiments(i_file).analysis_results_means.AHP_RiseSlope_first, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_last(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_last = [experiments(i_file).analysis_results_means.AHP_RiseSlope_last, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_min(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_min = [experiments(i_file).analysis_results_means.AHP_RiseSlope_min, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_max(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_max = [experiments(i_file).analysis_results_means.AHP_RiseSlope_max, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_mean(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_mean = [experiments(i_file).analysis_results_means.AHP_RiseSlope_mean, NaN(1, 5)];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_AdapRate(1:2:10) = [];
                experiments(i_file).analysis_results_means.AHP_RiseSlope_AdapRate = [experiments(i_file).analysis_results_means.AHP_RiseSlope_AdapRate, NaN(1, 5)];
                
                % Stds

                % Exception for Experiments with only 1 C-Clamp.
                if isscalar(experiments(i_file).analysis_results_stds.APcount)
                    experiments(i_file).analysis_results_stds.APcount(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.FR_abs(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.FR_ins(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_lat_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_lat_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_lat_window(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_lat_compression(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.ISI_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.ISI_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.ISI_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.ISI_median(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.ISI_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_median(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_thr_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_median(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_median(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AP_amplitude_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_duration_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_duration_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_duration_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_duration_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_duration_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_duration_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_integral_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_integral_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_integral_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_integral_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_integral_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_integral_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_AdapRate(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_first(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_last(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_min(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_max(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_mean(1:10) = NaN(1, 10);
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_AdapRate(1:10) = NaN(1, 10);
                else
                    experiments(i_file).analysis_results_stds.APcount(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.APcount = [experiments(i_file).analysis_results_stds.APcount, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.FR_abs(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.FR_abs = [experiments(i_file).analysis_results_stds.FR_abs, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.FR_ins(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.FR_ins = [experiments(i_file).analysis_results_stds.FR_ins, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_lat_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_lat_first = [experiments(i_file).analysis_results_stds.AP_lat_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_lat_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_lat_last = [experiments(i_file).analysis_results_stds.AP_lat_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_lat_window(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_lat_window = [experiments(i_file).analysis_results_stds.AP_lat_window, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_lat_compression(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_lat_compression = [experiments(i_file).analysis_results_stds.AP_lat_compression, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.ISI_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.ISI_min = [experiments(i_file).analysis_results_stds.ISI_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.ISI_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.ISI_max = [experiments(i_file).analysis_results_stds.ISI_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.ISI_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.ISI_mean = [experiments(i_file).analysis_results_stds.ISI_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.ISI_median(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.ISI_median = [experiments(i_file).analysis_results_stds.ISI_median, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.ISI_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.ISI_AdapRate = [experiments(i_file).analysis_results_stds.ISI_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_first = [experiments(i_file).analysis_results_stds.AP_thr_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_last = [experiments(i_file).analysis_results_stds.AP_thr_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_min = [experiments(i_file).analysis_results_stds.AP_thr_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_max = [experiments(i_file).analysis_results_stds.AP_thr_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_mean = [experiments(i_file).analysis_results_stds.AP_thr_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_median(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_median = [experiments(i_file).analysis_results_stds.AP_thr_median, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_thr_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_thr_AdapRate = [experiments(i_file).analysis_results_stds.AP_thr_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_first = [experiments(i_file).analysis_results_stds.AP_HalfWidth_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_last = [experiments(i_file).analysis_results_stds.AP_HalfWidth_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_min = [experiments(i_file).analysis_results_stds.AP_HalfWidth_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_max = [experiments(i_file).analysis_results_stds.AP_HalfWidth_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_mean = [experiments(i_file).analysis_results_stds.AP_HalfWidth_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_median(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_median = [experiments(i_file).analysis_results_stds.AP_HalfWidth_median, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_HalfWidth_AdapRate = [experiments(i_file).analysis_results_stds.AP_HalfWidth_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_first = [experiments(i_file).analysis_results_stds.AP_amplitude_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_last = [experiments(i_file).analysis_results_stds.AP_amplitude_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_min = [experiments(i_file).analysis_results_stds.AP_amplitude_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_max = [experiments(i_file).analysis_results_stds.AP_amplitude_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_mean = [experiments(i_file).analysis_results_stds.AP_amplitude_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_median(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_median = [experiments(i_file).analysis_results_stds.AP_amplitude_median, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AP_amplitude_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AP_amplitude_AdapRate = [experiments(i_file).analysis_results_stds.AP_amplitude_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_first = [experiments(i_file).analysis_results_stds.AHP_PeakLatency_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_last = [experiments(i_file).analysis_results_stds.AHP_PeakLatency_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_min = [experiments(i_file).analysis_results_stds.AHP_PeakLatency_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_max = [experiments(i_file).analysis_results_stds.AHP_PeakLatency_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_mean = [experiments(i_file).analysis_results_stds.AHP_PeakLatency_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakLatency_AdapRate = [experiments(i_file).analysis_results_stds.AHP_PeakLatency_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_first = [experiments(i_file).analysis_results_stds.AHP_PeakAmp_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_last = [experiments(i_file).analysis_results_stds.AHP_PeakAmp_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_min = [experiments(i_file).analysis_results_stds.AHP_PeakAmp_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_max = [experiments(i_file).analysis_results_stds.AHP_PeakAmp_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_mean = [experiments(i_file).analysis_results_stds.AHP_PeakAmp_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_PeakAmp_AdapRate = [experiments(i_file).analysis_results_stds.AHP_PeakAmp_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_duration_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_duration_first = [experiments(i_file).analysis_results_stds.AHP_duration_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_duration_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_duration_last = [experiments(i_file).analysis_results_stds.AHP_duration_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_duration_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_duration_min = [experiments(i_file).analysis_results_stds.AHP_duration_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_duration_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_duration_max = [experiments(i_file).analysis_results_stds.AHP_duration_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_duration_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_duration_mean = [experiments(i_file).analysis_results_stds.AHP_duration_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_duration_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_duration_AdapRate = [experiments(i_file).analysis_results_stds.AHP_duration_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_integral_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_integral_first = [experiments(i_file).analysis_results_stds.AHP_integral_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_integral_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_integral_last = [experiments(i_file).analysis_results_stds.AHP_integral_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_integral_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_integral_min = [experiments(i_file).analysis_results_stds.AHP_integral_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_integral_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_integral_max = [experiments(i_file).analysis_results_stds.AHP_integral_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_integral_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_integral_mean = [experiments(i_file).analysis_results_stds.AHP_integral_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_integral_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_integral_AdapRate = [experiments(i_file).analysis_results_stds.AHP_integral_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_first = [experiments(i_file).analysis_results_stds.AHP_FallSlope_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_last = [experiments(i_file).analysis_results_stds.AHP_FallSlope_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_min = [experiments(i_file).analysis_results_stds.AHP_FallSlope_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_max = [experiments(i_file).analysis_results_stds.AHP_FallSlope_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_mean = [experiments(i_file).analysis_results_stds.AHP_FallSlope_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_FallSlope_AdapRate = [experiments(i_file).analysis_results_stds.AHP_FallSlope_AdapRate, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_first(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_first = [experiments(i_file).analysis_results_stds.AHP_RiseSlope_first, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_last(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_last = [experiments(i_file).analysis_results_stds.AHP_RiseSlope_last, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_min(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_min = [experiments(i_file).analysis_results_stds.AHP_RiseSlope_min, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_max(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_max = [experiments(i_file).analysis_results_stds.AHP_RiseSlope_max, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_mean(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_mean = [experiments(i_file).analysis_results_stds.AHP_RiseSlope_mean, NaN(1, 5)];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_AdapRate(1:2:10) = [];
                    experiments(i_file).analysis_results_stds.AHP_RiseSlope_AdapRate = [experiments(i_file).analysis_results_stds.AHP_RiseSlope_AdapRate, NaN(1, 5)];
                end
            end
      
        end
    end



end