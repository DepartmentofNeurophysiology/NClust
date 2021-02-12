function comb_matrix_ranked = plot_projection_distances_N_param(Distance_Param_Combinations, best_100_combinations, surviving_param_names, OutputFileName, comb_matrix_ranked)


suptitle_FontSize = 24;
title_FontSize = 18;
labels_FontSize = 12;
Plot_LineWidth = 1.5;

downsampling_factor = 2;

number_of_parameters = numel(surviving_param_names);



%% All 300k.
combinations_Z_mean = [Distance_Param_Combinations.Z_distance_mean];
combinations_Z_mean(isnan(combinations_Z_mean)) = 0;
combinations_Z_median = [Distance_Param_Combinations.Z_distance_median];
combinations_Z_median(isnan(combinations_Z_median)) = 0;
combinations_Z_max = [Distance_Param_Combinations.Z_distance_max];
combinations_Z_max(isnan(combinations_Z_max)) = 0;
combinations_Z_min = [Distance_Param_Combinations.Z_distance_min];
combinations_Z_min(isnan(combinations_Z_min)) = 0;

combinations_E_mean = [Distance_Param_Combinations.E_distance_mean];
combinations_E_mean(isnan(combinations_E_mean)) = 0;
combinations_E_median = [Distance_Param_Combinations.E_distance_median];
combinations_E_median(isnan(combinations_E_median)) = 0;
combinations_E_max = [Distance_Param_Combinations.E_distance_max];
combinations_E_max(isnan(combinations_E_max)) = 0;
combinations_E_min = [Distance_Param_Combinations.E_distance_min];
combinations_E_min(isnan(combinations_E_min)) = 0;

[combinations_Z_mean, combinations_Z_mean_indexes] = sort(combinations_Z_mean, 'descend');
[combinations_Z_median, combinations_Z_median_indexes] = sort(combinations_Z_median, 'descend');
[combinations_Z_max, combinations_Z_max_indexes] = sort(combinations_Z_max, 'descend');
[combinations_Z_min, combinations_Z_min_indexes] = sort(combinations_Z_min, 'descend');
[combinations_E_mean, combinations_E_mean_indexes] = sort(combinations_E_mean, 'descend');
[combinations_E_median, combinations_E_median_indexes] = sort(combinations_E_median, 'descend');
[combinations_E_max, combinations_E_max_indexes] = sort(combinations_E_max, 'descend');
[combinations_E_min, combinations_E_min_indexes] = sort(combinations_E_min, 'descend');

number_of_combinations = numel(combinations_Z_mean);

% Get the matrix of combinations, sorted by mean Z distance.
if nargin < 5
    % Initializing waitbar.
    prog_bar = waitbar(0, 'Cylon virus detected!', 'Name', ...
        'Making Combinations Matrix...',...
        'CreateCancelBtn', 'setappdata(gcbf,''canceling'',1)');
    
    tic
    comb_matrix_ranked = zeros(number_of_parameters, number_of_combinations);
    comb_matrix_ranked = logical(comb_matrix_ranked);
    for i_comb = 1:number_of_combinations
        %     current_param_combination = Distance_Param_Combinations(combinations_Z_mean_indexes(i_comb)).Combination;
        comb_matrix_ranked(Distance_Param_Combinations(combinations_Z_mean_indexes(i_comb)).Combination, i_comb) = 1;
        
        if i_comb == 1000
            computation_time = toc;
            computation_time = (computation_time/1000)*number_of_combinations;
            time_comp_hour = floor(computation_time/(60*60));
            time_comp_m = floor( (computation_time - time_comp_hour*(60*60)) /60);
            time_comp_s = floor(rem( (computation_time - time_comp_hour*(60*60)), 60));
            fprintf('\nEstimated Computation time: %dh:%dm:%ds.\n', time_comp_hour, time_comp_m, time_comp_s);
        end
        
        % Update waitbar
        waitbar(i_comb/number_of_combinations, prog_bar, sprintf('Combination #%d / %d', i_comb, number_of_combinations));
        if getappdata(prog_bar, 'canceling')
            delete(prog_bar);
            warning('Operation stopped by user.');
            return
        end
    end
    
    computation_time = toc;
    time_comp_hour = floor(computation_time/(60*60));
    time_comp_m = floor( (computation_time - time_comp_hour*(60*60)) /60);
    time_comp_s = floor(rem( (computation_time - time_comp_hour*(60*60)), 60));
    fprintf('\nTime elapsed: %dh:%dm:%ds.\n', time_comp_hour, time_comp_m, time_comp_s);
    delete(prog_bar);
end

% Get the cumulative sum.
comb_matrix_cumsum = zeros(number_of_parameters, number_of_combinations);
comb_matrix_ranked = double(comb_matrix_ranked);
for i_param = 1:number_of_parameters
    comb_matrix_cumsum(i_param, :) = cumsum(comb_matrix_ranked(i_param, :));
%     comb_matrix_cumsum_downsampled(i_param, :) = downsample(comb_matrix_cumsum(i_param, :), 10);
end
% Normalize to 1.
sum_total = nanmax(comb_matrix_cumsum(1, :));
comb_matrix_cumsum = comb_matrix_cumsum./sum_total;

% Find when each parameter reaches 0.5.
param_05_index_tmp = NaN(number_of_parameters, 1);
for i_param = 1:number_of_parameters
    current_param = comb_matrix_cumsum(i_param, :);
    param_05_index_tmp(i_param) = min(find(current_param > 0.5));
end
[~, param_05_index_sorted] = sort(param_05_index_tmp);

comb_matrix_cumsum_sorted = NaN(size(comb_matrix_cumsum));
param_names_sorted = cell(number_of_parameters, 1);
for i_param = 1:number_of_parameters
    comb_matrix_cumsum_sorted(i_param, :) = comb_matrix_cumsum(param_05_index_sorted(i_param), :);
    param_names_sorted{i_param, :} = surviving_param_names{param_05_index_sorted(i_param), :};
end


%% Plots
% Figure 1 - Cumulative sum, ordered by most informative.
figure();
set(gcf,'position', get(0,'screensize'));

imagesc(comb_matrix_cumsum)

yticks(1:number_of_parameters);
yticklabels(surviving_param_names');
xlabel('5 Param Combinations - ordered by mean Z-Distance between clusters.', 'FontSize', labels_FontSize)
ylabel('Cumsum of appearance in the 5 param combinations.', 'FontSize', labels_FontSize)
title('Parameters, ordered by most informative.', 'FontSize', title_FontSize)
h_suptitle = suptitle('Combinations of 5 param - Parameters Importance');
h_suptitle.FontSize = suptitle_FontSize;

h_colorbar = colorbar;
h_colorbar.Label.String = 'Cumulative Sum.';
h_colorbar.Label.FontSize = labels_FontSize;

output_str_tmp = 'Combinations of 5 param - Parameters Importance';
saveas(gcf, sprintf('%s.png', output_str_tmp));
saveas(gcf, sprintf('%s.fig', output_str_tmp));
saveas(gcf, sprintf('%s.eps', output_str_tmp));

% Figure 2 - Cumulative sum, ordered by parameters most common in 
%            informative combinations.
figure();
set(gcf,'position', get(0,'screensize'));

imagesc(comb_matrix_cumsum_sorted)

yticks(1:number_of_parameters);
yticklabels(param_names_sorted');
xlabel('5 Param Combinations - ordered by mean Z-Distance between clusters.', 'FontSize', labels_FontSize)
ylabel('Cumsum of appearance in the 5 param combinations.', 'FontSize', labels_FontSize)
title('Parameters, ordered by most informative.', 'FontSize', title_FontSize)
h_suptitle = suptitle('Combinations of 5 param - Parameters Importance Sorted');
h_suptitle.FontSize = suptitle_FontSize;

h_colorbar = colorbar;
h_colorbar.Label.String = 'Cumulative Sum.';
h_colorbar.Label.FontSize = labels_FontSize;

output_str_tmp = 'Combinations of 5 param - Parameters Importance Sorted';
saveas(gcf, sprintf('%s.png', output_str_tmp));
saveas(gcf, sprintf('%s.fig', output_str_tmp));
saveas(gcf, sprintf('%s.eps', output_str_tmp));


% Figure 3 - Distances.
combinations_Z_mean = downsample(combinations_Z_mean, downsampling_factor);
combinations_Z_median = downsample(combinations_Z_median, downsampling_factor);
combinations_Z_max = downsample(combinations_Z_max, downsampling_factor);
combinations_Z_min = downsample(combinations_Z_min, downsampling_factor);
combinations_E_mean = downsample(combinations_E_mean, downsampling_factor);
combinations_E_median = downsample(combinations_E_median, downsampling_factor);
combinations_E_max = downsample(combinations_Z_mean, downsampling_factor);
combinations_E_min = downsample(combinations_E_min, downsampling_factor);

figure();
set(gcf,'position', get(0,'screensize'));
subplot_raws = 4;
subplot_columns = 2;
y_axis_max = 4;
y_axis_max_max = 20;

subplot(subplot_raws, subplot_columns, 1);
plot(combinations_Z_mean, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max]);
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('Z-dist - Mean.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 3);
plot(combinations_Z_median, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max]);
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('Z-dist - Median.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 5);
plot(combinations_Z_max, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max_max]);
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('Z-dist - Max.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 7);
plot(combinations_Z_min, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max]);
xlabel('5 Param Combinations.', 'FontSize', labels_FontSize)
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('Z-dist - Min.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 2);
plot(combinations_E_mean, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max]);
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('E-dist - Mean.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 4);
plot(combinations_E_median, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max]);
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('E-dist - Median.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 6);
plot(combinations_E_max, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max_max]);
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('E-dist - Max.', 'FontSize', title_FontSize)

subplot(subplot_raws, subplot_columns, 8);
plot(combinations_E_min, 'LineWidth', Plot_LineWidth);
grid on; box on;
axis([0, inf, 0, y_axis_max]);
xlabel('5 Param Combinations.', 'FontSize', labels_FontSize)
ylabel('Distance between clusters.', 'FontSize', labels_FontSize)
title('E-dist - Min.', 'FontSize', title_FontSize)

if nargin < 4
    OutputFileName = 'Combinations of 5 param - Distances between Clusters';
end

h_suptitle = suptitle(OutputFileName);
h_suptitle.FontSize = suptitle_FontSize;

saveas(gcf, sprintf('%s.png', OutputFileName));
saveas(gcf, sprintf('%s.fig', OutputFileName));
saveas(gcf, sprintf('%s.eps', OutputFileName));

