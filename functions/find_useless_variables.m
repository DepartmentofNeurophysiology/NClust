function output = find_useless_variables (DataMatrix_clust, cluster_assignments_new, cluster_distances, options)

% This function takes as reference the distances between clusters, as 
% computed in the whole parameters space.
% It then proceed removing variables 1 by 1, and computing the distances
% between clusters again.
% If the distances are changed significantly (change > k%), the iteration
% is stopped, and the set of variables being used till the last iteration
% that did not change the distances is saved.

% The top N smallest set of variables not changing the iterations are also
% saved separately.


%% Initialize.
clusters_assignment = cluster_assignments_new.MaxLikelihood;
Distances_Ref = cluster_distances.MaxLikelihood;
[number_of_cells, number_of_parameters] = size(DataMatrix_clust);
[number_of_clusters, ~] = size(Distances_Ref.Z_distance);
number_of_iterations = 20000;
options.relative_change_threshold = 0.015;


%% 

% Initializing waitbar.
prog_bar = waitbar(0, 'Cylon virus detected!', 'Name', 'Iteration Number',...
    'CreateCancelBtn',...
    'setappdata(gcbf,''canceling'',1)');
setappdata(prog_bar, 'canceling', 0);
tic

% Iterate.
removed_param_per_iter = cell(number_of_iterations, 1);
num_of_removed_param_per_iter = NaN(number_of_iterations, 1);
for i_iter = 1:number_of_iterations
    fprintf('Iteration #%d.\n', i_iter)
    removed_param_array = [];
    num_of_removed_param = 0;
    current_DataMatrix = DataMatrix_clust;
    current_distances = Distances_Ref;
    [current_DataMatrix, removed_param_array, current_distances, num_of_removed_param] = remove_param(current_DataMatrix, removed_param_array, current_distances, num_of_removed_param, Distances_Ref, clusters_assignment, number_of_cells, number_of_parameters, number_of_clusters, options);
    removed_param_per_iter{i_iter, 1} = removed_param_array;
    num_of_removed_param_per_iter(i_iter, 1) = num_of_removed_param;
    % Update waitbar
    waitbar(i_iter/number_of_iterations, prog_bar, sprintf('Checking Useless Parameters...Iteration #%d / %d', i_iter, number_of_iterations));
    if getappdata(prog_bar, 'canceling')
        delete(prog_bar);
        warning('Operation cancelled by user.');
        return
    end
end
output.removed_param_per_iter = removed_param_per_iter;
output.num_of_removed_param_per_iter = num_of_removed_param_per_iter;
% Close waitbar, get time elapsed.
delete(prog_bar);
computation_time = toc;
time_comp_hour = floor(computation_time/(60*60));
time_comp_m = floor( (computation_time - time_comp_hour*(60*60)) /60);
time_comp_s = floor(rem( (computation_time - time_comp_hour*(60*60)), 60));
fprintf('\nTime elapsed: %dh:%dm:%ds.\n', time_comp_hour, time_comp_m, time_comp_s);



%% Auxiliary Function - Remove Parameters Iterativly.
    function [current_DataMatrix, removed_param_array, current_distances, num_of_removed_param] = remove_param(current_DataMatrix, removed_param_array, current_distances, num_of_removed_param, Distances_Ref, clusters_assignment, number_of_cells, number_of_parameters, number_of_clusters, options)
        relative_change_threshold = options.relative_change_threshold;
        previous_distances = current_distances;
        
        i_param_to_remove = randi([1, number_of_parameters]);
        
        FLAG_first_iteration = 0;
        % For the 1st iteration, the removed param array will be empty...
        if isempty(removed_param_array)
            FLAG_first_iteration = 1;
        end
        
        % Check that the parameter has not been removed already, keep choosing a new one, in case it is.
        while numel(find(removed_param_array == i_param_to_remove)) ~= 0 && FLAG_first_iteration == 0
            i_param_to_remove = randi([1, number_of_parameters]);
        end
        % Add parameter to the removed parameters list.
        removed_param_array = [removed_param_array, i_param_to_remove];
        num_of_removed_param = num_of_removed_param + 1;
        current_DataMatrix(:, i_param_to_remove) = zeros(number_of_cells, 1);
        % Re-compute distances.
        [current_distances] = compute_clusters_distance (current_DataMatrix, clusters_assignment, options);
        % Check that the new distances are similar enough to the old ones.
        distance_differences.Z_distance = abs(Distances_Ref.Z_distance - current_distances.Z_distance);
        distance_differences.Euclidean_distance = abs(Distances_Ref.Euclidean_distance - current_distances.Euclidean_distance);
        % Fractional difference respect to original cluster distances.
        fractional_difference.Z_distance = distance_differences.Z_distance ./ abs(Distances_Ref.Z_distance);
        fractional_difference.Euclidean_distance = distance_differences.Euclidean_distance ./ abs(Distances_Ref.Euclidean_distance);
        % Check that every cluster distance does not decrease by more than k% respect to the previous distances.
        FLAG_distance_changed = 0;
        for i_cluster = 1:number_of_clusters
            if FLAG_distance_changed == 1
                break
            end
            for j_cluster = 1:number_of_clusters
                if i_cluster == j_cluster
                    continue
                end
                distance_fractional_difference = fractional_difference.Euclidean_distance;
                if distance_fractional_difference(i_cluster, j_cluster) > relative_change_threshold
                    FLAG_distance_changed = 1;
                    break
                end
            end
        end
        % Return Result, or go to the next iteration, removing the next variable.
        if FLAG_distance_changed == 1
            return
        else
            [current_DataMatrix, removed_param_array, current_distances, num_of_removed_param] = remove_param(current_DataMatrix, removed_param_array, current_distances, num_of_removed_param, Distances_Ref, clusters_assignment, number_of_cells, number_of_parameters, number_of_clusters, options);
        end
        
        
        
        
        
        
        
        
    end








end

