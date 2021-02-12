function new_exp_tags_tmp = merge_1_cluster (i_cluster_1, DataMatrix_clust, new_exp_tags_tmp, number_of_clusters, min_cluster_elements, FLAG_verbose)
% This functions dismembers the selected cluster (identified by the integer
% in "i_cluster_1"), element by element, into the closest neighbouring 
% clusters ("close" is defined by the Z distance between elements and other
% clusters)

% Get all elements of that cluster.
cluster_1_elements = find(new_exp_tags_tmp == i_cluster_1);
number_of_elements = numel(cluster_1_elements);

% Merge with closest neighbour.
if FLAG_verbose == 1; fprintf('Cluster Tagged #%d had %d elements, dismembering it...\n', i_cluster_1, number_of_elements); end
for i_element = 1:number_of_elements
    
    % Get single cluster element.
    current_element_index = cluster_1_elements(i_element);
    current_element = DataMatrix_clust(current_element_index, :);
    
    % Compute distance between the selected element and every other cluster.
    Z_distance = NaN(1, number_of_clusters);
    for i_cluster_2 = 1:number_of_clusters
        if i_cluster_2 == i_cluster_1
            continue
        end
        
        % Get every element of the other cluster.
        cluster_2_elements = DataMatrix_clust(new_exp_tags_tmp == i_cluster_2, :);
        
        if isempty(cluster_2_elements) % Check that the destination cluster is not empty.
            continue
        end
        
        % Compute the distance between this element, and every other cluster.
        Z_distance(i_cluster_2) = compute_Z_distance (current_element, cluster_2_elements);
    end
    
    % Find closest cluster.
    [min_distance, closest_cluster] = nanmin(Z_distance);
    
    % Mark current element for merging with the closest cluster.
    new_exp_tags_tmp(current_element_index) = closest_cluster;
    if FLAG_verbose == 1; fprintf('Experiment #%d reassigned to Cluster #%d\n', current_element_index, closest_cluster); end
end


end