function [cluster_projection_distances, clusters_projection_mean, clusters_projection_std, clusters_projection_ttest] = compute_distance_on_single_param (DataMatrix, clusters_assignment, options)


[number_of_cells, number_of_parameters] = size(DataMatrix);
number_of_clusters = nanmax(clusters_assignment);

% Compute the mean and standard deviation for that parameter.
% current_parameter_mean = nanmean(current_parameter_distribution);
% current_parameter_std = nanstd(current_parameter_distribution);


cluster_projection_distances = cell(number_of_parameters, 1);
clusters_projection_mean = cell(number_of_parameters, 1);
clusters_projection_std = cell(number_of_parameters, 1);

% single_par_distances_stat = struct;
for i_param = 1:number_of_parameters
    % Get a parameter.
    current_parameter_distribution = DataMatrix(:, i_param);
    
    % Get the distances between clusters along that dimension.
    [cluster_single_param_distances_tmp] = compute_clusters_distance (current_parameter_distribution, clusters_assignment, options);
    cluster_projection_distances{i_param, 1} = cluster_single_param_distances_tmp;
    
%     % Get the statistics value of the distances between clusters.
%     single_par_distances_tmp = triu(cluster_single_param_distances_tmp);
%     single_par_distances_tmp((single_par_distances_tmp) == 0) = NaN;
%     single_par_distances_tmp = reshape(single_par_distances_tmp, [1, number_of_clusters^2]);
%     single_par_distances_stat(i_param).mean = nanmean(single_par_distances_tmp);
%     single_par_distances_stat(i_param).median = nanmedian(single_par_distances_tmp);
%     single_par_distances_stat(i_param).std = nanstd(single_par_distances_tmp);
%     single_par_distances_stat(i_param).max = nanmax(single_par_distances_tmp);
%     single_par_distances_stat(i_param).min = nanmin(single_par_distances_tmp);
    
    % For each cluster, get the parameter mean and std.
    currents_cluster_mean = NaN(1, number_of_clusters);
    currents_cluster_std = NaN(1, number_of_clusters);
    for i_cluster = 1:number_of_clusters
        current_cluster = current_parameter_distribution(find(clusters_assignment == i_cluster), :);
        currents_cluster_mean(i_cluster) = nanmean(current_cluster);
        currents_cluster_std(i_cluster) = nanstd(current_cluster);
    end
    clusters_projection_mean{i_param, 1} = currents_cluster_mean;
    clusters_projection_std{i_param, 1} = currents_cluster_std;
    
    % Get a significance test between parameters values distributions between each couple of clusters.
    p_value = NaN(number_of_clusters, number_of_clusters);
    confidence_interval = cell(number_of_clusters, number_of_clusters);
    for i_cluster_1 = 1:number_of_clusters
        current_cluster_1 = current_parameter_distribution(find(clusters_assignment == i_cluster_1), :);
        for i_cluster_2 = 1:number_of_clusters
            if i_cluster_1 == i_cluster_2
                continue
            end
            current_cluster_2 = current_parameter_distribution(find(clusters_assignment == i_cluster_2), :);
                
            % Change NaN to cluster average.
            cluster_1_mean = nanmean(current_cluster_1);
            cluster_2_mean = nanmean(current_cluster_2);
            current_cluster_1(isnan(current_cluster_1)) = cluster_1_mean;
            current_cluster_2(isnan(current_cluster_2)) = cluster_2_mean;
            [~, p_value(i_cluster_1, i_cluster_2), conf_int_tmp, ~] = ttest2(current_cluster_1, current_cluster_2);
            confidence_interval{i_cluster_1, i_cluster_2} = conf_int_tmp;
        end
    end
    clusters_projection_ttest(i_param).p_value = p_value;
    clusters_projection_ttest(i_param).confidence_interval = confidence_interval;
end

