function [Distance_Param_Combinations, best_100_combinations] = compute_distance_on_N_param(DataMatrix, clusters_assignment, options)

rng default
[number_of_cells, number_of_parameters] = size(DataMatrix);
number_of_clusters = nanmax(clusters_assignment);

% cluster_projection_distances_Nparam = cell(number_of_parameters, number_of_parameters);
N_projection_param = 5;

comb_matrix = nchoosek(1:number_of_parameters, N_projection_param);
n_combinations = nchoosek(number_of_parameters, N_projection_param);

% Initializing waitbar.
prog_bar = waitbar(0, 'Cylon virus detected!', 'Name', 'Computing distances on Parameters Projections...',...
    'CreateCancelBtn',...
    'setappdata(gcbf,''canceling'',1)');
setappdata(prog_bar, 'canceling', 0);

tic
for i_comb = n_combinations:-1:1
    current_parameter_distribution = DataMatrix(:, comb_matrix(i_comb, :));
    [cluster_N_param_distances_tmp] = compute_clusters_distance (current_parameter_distribution, clusters_assignment, options);
    Distance_Param_Combinations(i_comb).Combination = comb_matrix(i_comb, :);
    Distance_Param_Combinations(i_comb).Z_distance_mean = cluster_N_param_distances_tmp.Z_distance_stats.mean;
    Distance_Param_Combinations(i_comb).Z_distance_median = cluster_N_param_distances_tmp.Z_distance_stats.median;
    Distance_Param_Combinations(i_comb).Z_distance_max = cluster_N_param_distances_tmp.Z_distance_stats.max;
    Distance_Param_Combinations(i_comb).Z_distance_min = cluster_N_param_distances_tmp.Z_distance_stats.min;
    
    Distance_Param_Combinations(i_comb).E_distance_mean = cluster_N_param_distances_tmp.Euclidean_distance_stats.mean;
    Distance_Param_Combinations(i_comb).E_distance_median = cluster_N_param_distances_tmp.Euclidean_distance_stats.median;
    Distance_Param_Combinations(i_comb).E_distance_max = cluster_N_param_distances_tmp.Euclidean_distance_stats.max;
    Distance_Param_Combinations(i_comb).E_distance_min = cluster_N_param_distances_tmp.Euclidean_distance_stats.min;
    
    if i_comb == n_combinations-1000
        time_1000_comb = toc;
        time_estimated_1_comb = time_1000_comb/1000;
        time_estimated = (time_estimated_1_comb)*n_combinations - time_1000_comb;
        time_est_hour = floor(time_estimated/(60*60));
        time_est_m = floor( (time_estimated - time_est_hour*(60*60)) /60);
        time_est_s = floor(rem( (time_estimated - time_est_hour*(60*60)), 60));
        fprintf('\nEstimated time to complete: %dh:%dm:%ds.\n', time_est_hour, time_est_m, time_est_s);
    end
    
    % Update waitbar
    i_comb_tmp = n_combinations - i_comb;
    waitbar(i_comb_tmp/n_combinations, prog_bar, sprintf('Parameters Combination #%d / %d', i_comb_tmp, n_combinations));
    if getappdata(prog_bar, 'canceling')
        delete(prog_bar);
        warning('Operation cancelled by user.');
        return
    end
end

combinations_Z_mean = [Distance_Param_Combinations.Z_distance_mean];
combinations_Z_mean(isnan(combinations_Z_mean)) = 0;
combinations_Z_median = [Distance_Param_Combinations.Z_distance_median];
combinations_Z_median(isnan(combinations_Z_median)) = 0;
combinations_E_mean = [Distance_Param_Combinations.E_distance_mean];
combinations_E_mean(isnan(combinations_E_mean)) = 0;
combinations_E_median = [Distance_Param_Combinations.E_distance_median];
combinations_E_median(isnan(combinations_E_median)) = 0;

[combinations_Z_mean_tmp, combinations_Z_mean_indexes] = sort(combinations_Z_mean, 'descend');
[combinations_Z_median_tmp, combinations_Z_median_indexes] = sort(combinations_Z_median, 'descend');
[combinations_E_mean_tmp, combinations_E_mean_indexes] = sort(combinations_E_mean, 'descend');
[combinations_E_median_tmp, combinations_E_median_indexes] = sort(combinations_E_median, 'descend');

k = 10;
best_100_combinations.Z_mean = combinations_Z_mean_tmp(1:k);
best_100_combinations.Z_mean_index = combinations_Z_mean_indexes(1:k);
best_100_combinations.Z_median = combinations_Z_median_tmp(1:k);
best_100_combinations.Z_median_index = combinations_Z_median_indexes(1:k);
best_100_combinations.E_mean = combinations_E_mean_tmp(1:k);
best_100_combinations.E_mean_index = combinations_E_mean_indexes(1:k);
best_100_combinations.E_median = combinations_E_median_tmp(1:k);
best_100_combinations.E_median_index = combinations_E_median_indexes(1:k);

% [best_100_combinations.Z_mean, best_100_combinations.Z_mean_index] = maxk(combinations_Z_mean, k);
% [best_100_combinations.Z_median, best_100_combinations.Z_median_index] = maxk(combinations_Z_median, k);
% [best_100_combinations.E_mean, best_100_combinations.E_mean_index] = maxk(combinations_E_mean, k);
% [best_100_combinations.E_median, best_100_combinations.E_median_index] = maxk(combinations_E_median, k);

computation_time = toc;
time_comp_hour = floor(computation_time/(60*60));
time_comp_m = floor( (computation_time - time_comp_hour*(60*60)) /60);
time_comp_s = floor(rem( (computation_time - time_comp_hour*(60*60)), 60));
fprintf('\nDistances of Projections along every combination of groups of %d parameters, on a total of %d, have been computed.\n', N_projection_param, number_of_parameters);
fprintf('\nTime elapsed: %dh:%dm:%ds.\n', time_comp_hour, time_comp_m, time_comp_s);

delete(prog_bar);

