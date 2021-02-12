function Plot_DataAverages (DataSet_Averages, DataSet_Stds, FLAG_normalize)

n_parameters = 70;
raws = 10;
columns = 7;

plotLineWidth = 0.75;
plotColor = [0, 0, 1];


current_injected = (40:40:400)';
interpolation_points = (0:20:400)';

figure();
set(gcf,'position', get(0,'screensize'));
i_plot = 1;

%% APcount / FR
DUMMY = 1;
while DUMMY == 1
    % Avg APcount.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.APcount)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.APcount)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('APcount')
    i_plot = i_plot + 1;
    
    % FR_abs
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.FR_abs)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.FR_abs)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('FR_abs')
    i_plot = i_plot + 1;
    
    % FR_ins.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.FR_ins)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.FR_ins)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('FR_ins')
    i_plot = i_plot + 1;
    DUMMY = 0;
end

%% AP Latency.
DUMMY = 1;
while DUMMY == 1
    % Avg AP_lat_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_lat_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_lat_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_lat_first')
    i_plot = i_plot + 1;
    
    % Avg AP_lat_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_lat_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_lat_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_lat_last')
    i_plot = i_plot + 1;
    
    % Avg AP_lat_window.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_lat_window)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_lat_window)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_lat_window')
    i_plot = i_plot + 1;
    
    % Avg AP_lat_compression.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_lat_compression)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_lat_compression)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_lat_compression')
    i_plot = i_plot + 1;
    DUMMY = 0;
end

%% ISI.
DUMMY = 1;
while DUMMY == 1
    % Avg ISI_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.ISI_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.ISI_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('ISI_min')
    i_plot = i_plot + 1;
    
    % Avg ISI_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.ISI_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.ISI_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('ISI_max')
    i_plot = i_plot + 1;
    
    % Avg ISI_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.ISI_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.ISI_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('ISI_mean')
    i_plot = i_plot + 1;
    
    % Avg ISI_median.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.ISI_median)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.ISI_median)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('ISI_median')
    i_plot = i_plot + 1;
    
    % Avg ISI_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.ISI_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.ISI_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('ISI_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AP threshold.
DUMMY = 1;
while DUMMY == 1
    % Avg AP_thr_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_first')
    i_plot = i_plot + 1;
    
    % Avg AP_thr_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_last')
    i_plot = i_plot + 1;
    
    % Avg AP_thr_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_min')
    i_plot = i_plot + 1;
    
    % Avg AP_thr_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_max')
    i_plot = i_plot + 1;
    
    % Avg AP_thr_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_mean')
    i_plot = i_plot + 1;
    
    % Avg AP_thr_median.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_median)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_median)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_median')
    i_plot = i_plot + 1;
    
    % Avg AP_thr_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_thr_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_thr_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_thr_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AP Half-Width.
DUMMY = 1;
while DUMMY == 1
    % Avg AP_HalfWidth_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_first')
    i_plot = i_plot + 1;
    
    % Avg AP_HalfWidth_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_last')
    i_plot = i_plot + 1;
    
    % Avg AP_HalfWidth_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_min')
    i_plot = i_plot + 1;
    
    % Avg AP_HalfWidth_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_max')
    i_plot = i_plot + 1;
    
    % Avg AP_HalfWidth_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_mean')
    i_plot = i_plot + 1;
    
    % Avg AP_HalfWidth_median.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_median)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_median)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_median')
    i_plot = i_plot + 1;
    
    % Avg AP_HalfWidth_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_HalfWidth_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_HalfWidth_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_HalfWidth_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AP amplitude.
DUMMY = 1;
while DUMMY == 1
    % Avg AP_amplitude_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_first')
    i_plot = i_plot + 1;
    
    % Avg AP_amplitude_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_last')
    i_plot = i_plot + 1;
    
    % Avg AP_amplitude_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_min')
    i_plot = i_plot + 1;
    
    % Avg AP_amplitude_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_max')
    i_plot = i_plot + 1;
    
    % Avg AP_amplitude_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_mean')
    i_plot = i_plot + 1;
    
    % Avg AP_amplitude_median.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_median)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_median)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_median')
    i_plot = i_plot + 1;
    
    % Avg AP_amplitude_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AP_amplitude_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AP_amplitude_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AP_amplitude_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AHP PeakLatency.
DUMMY = 1;
while DUMMY == 1
    % Avg AHP_PeakLatency_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakLatency_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakLatency_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakLatency_first')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakLatency_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakLatency_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakLatency_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakLatency_last')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakLatency_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakLatency_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakLatency_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakLatency_min')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakLatency_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakLatency_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakLatency_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakLatency_max')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakLatency_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakLatency_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakLatency_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakLatency_mean')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakLatency_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakLatency_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakLatency_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakLatency_AdapRate')
    i_plot = i_plot + 1;

    DUMMY = 0;
end

%% AHP Peak Amplitude.
DUMMY = 1;
while DUMMY == 1
    % Avg AHP_PeakAmp_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakAmp_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakAmp_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakAmp_first')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakAmp_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakAmp_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakAmp_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakAmp_last')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakAmp_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakAmp_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakAmp_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakAmp_min')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakAmp_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakAmp_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakAmp_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakAmp_max')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakAmp_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakAmp_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakAmp_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakAmp_mean')
    i_plot = i_plot + 1;
    
    % Avg AHP_PeakAmp_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_PeakAmp_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_PeakAmp_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_PeakAmp_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AHP Duration.
DUMMY = 1;
while DUMMY == 1
    % Avg AHP_duration_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_duration_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_duration_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_duration_first')
    i_plot = i_plot + 1;
    
    % Avg AHP_duration_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_duration_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_duration_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_duration_last')
    i_plot = i_plot + 1;
    
    % Avg AHP_duration_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_duration_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_duration_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_duration_min')
    i_plot = i_plot + 1;
    
    % Avg AHP_duration_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_duration_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_duration_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_duration_max')
    i_plot = i_plot + 1;
    
    % Avg AHP_duration_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_duration_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_duration_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_duration_mean')
    i_plot = i_plot + 1;
    
    % Avg AHP_duration_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_duration_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_duration_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_duration_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AHP Integral.
DUMMY = 1;
while DUMMY == 1
    % Avg AHP_integral_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_integral_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_integral_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_integral_first')
    i_plot = i_plot + 1;
    
    % Avg AHP_integral_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_integral_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_integral_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_integral_last')
    i_plot = i_plot + 1;
    
    % Avg AHP_integral_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_integral_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_integral_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_integral_min')
    i_plot = i_plot + 1;
    
    % Avg AHP_integral_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_integral_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_integral_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_integral_max')
    i_plot = i_plot + 1;
    
    % Avg AHP_integral_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_integral_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_integral_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_integral_mean')
    i_plot = i_plot + 1;
    
    % Avg AHP_integral_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_integral_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_integral_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_integral_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AHP FallSlope.
DUMMY = 1;
while DUMMY == 1
    % Avg AHP_FallSlope_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_FallSlope_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_FallSlope_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_FallSlope_first')
    i_plot = i_plot + 1;
    
    % Avg AHP_FallSlope_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_FallSlope_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_FallSlope_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_FallSlope_last')
    i_plot = i_plot + 1;
    
    % Avg AHP_FallSlope_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_FallSlope_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_FallSlope_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_FallSlope_min')
    i_plot = i_plot + 1;
    
    % Avg AHP_FallSlope_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_FallSlope_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_FallSlope_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_FallSlope_max')
    i_plot = i_plot + 1;
    
    % Avg AHP_FallSlope_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_FallSlope_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_FallSlope_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_FallSlope_mean')
    i_plot = i_plot + 1;
    
    % Avg AHP_FallSlope_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_FallSlope_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_FallSlope_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_FallSlope_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

%% AHP RiseSlope.
DUMMY = 1;
while DUMMY == 1
    % Avg AHP_RiseSlope_first.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_RiseSlope_first)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_RiseSlope_first)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_RiseSlope_first')
    i_plot = i_plot + 1;
    
    % Avg AHP_RiseSlope_last.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_RiseSlope_last)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_RiseSlope_last)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_RiseSlope_last')
    i_plot = i_plot + 1;
    
    % Avg AHP_RiseSlope_min.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_RiseSlope_min)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_RiseSlope_min)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_RiseSlope_min')
    i_plot = i_plot + 1;
    
    % Avg AHP_RiseSlope_max.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_RiseSlope_max)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_RiseSlope_max)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_RiseSlope_max')
    i_plot = i_plot + 1;
    
    % Avg AHP_RiseSlope_mean.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_RiseSlope_mean)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_RiseSlope_mean)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_RiseSlope_mean')
    i_plot = i_plot + 1;
    
    % Avg AHP_RiseSlope_AdapRate.
    Data_Avg_interpolated = interp1(current_injected, (DataSet_Averages.AHP_RiseSlope_AdapRate)', interpolation_points);
    Data_Avg_interpolated(isnan(Data_Avg_interpolated)) = 0;
    Data_Std_interpolated = interp1(current_injected, (DataSet_Stds.AHP_RiseSlope_AdapRate)', interpolation_points);
    Data_Std_interpolated(isnan(Data_Std_interpolated)) = 0;
    subplot(n_parameters/raws, n_parameters/columns, i_plot);
    errorbar(interpolation_points, Data_Avg_interpolated, Data_Std_interpolated, '-o', 'LineWidth', plotLineWidth, 'Color', plotColor)
    title('AHP_RiseSlope_AdapRate')
    i_plot = i_plot + 1;
    
    DUMMY = 0;
end

if FLAG_normalize == 0
    h_suptitle = suptitle('Whole Dataset Averages + Standard Deviations');
else
    h_suptitle = suptitle('Whole Dataset Averages + Standard Deviations (Experiments normalized by their max)');
end
h_suptitle.FontSize = 24;