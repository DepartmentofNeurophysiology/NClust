function [cluster_projection_distances_2param] = compute_distance_on_2_param (DataMatrix, clusters_assignment, options)
% This function computes the distances between clusters, projected on 
% every combination of two parameters.

[number_of_cells, number_of_parameters] = size(DataMatrix);
number_of_clusters = nanmax(clusters_assignment);

cluster_projection_distances_2param = cell(number_of_parameters, number_of_parameters);
for i_param_1 = 1:number_of_parameters
    for i_param_2 = 1:number_of_parameters
        if i_param_1 == i_param_2
            continue
        end

        % Get a parameters doublet.
        current_parameter_distribution_tmp1 = DataMatrix(:, i_param_1);
        current_parameter_distribution_tmp2 = DataMatrix(:, i_param_2);
        current_parameter_distribution = [current_parameter_distribution_tmp1, current_parameter_distribution_tmp2];

        % Get the distances between clusters along that projection.
        [cluster_single_param_distances_tmp] = compute_clusters_distance (current_parameter_distribution, clusters_assignment, options);
        cluster_projection_distances_2param{i_param_1, i_param_2} = cluster_single_param_distances_tmp;
    end
end

