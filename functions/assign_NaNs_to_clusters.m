function assign_NaNs_to_clusters (DataMatrix_clust, cluster_results_tmp)

% Options

% Initialize
[number_of_clusters, number_of_parameters] = size(cluster_results_tmp.cluster_centroids_coord);
number_of_experiments = numel(cluster_results_tmp.exp_tags);
new_exp_tags = cluster_results_tmp.exp_tags;

NaNs_exps_number = numel(find(isnan(cluster_results_tmp.exp_tags)));
NaNs_exp_indexes = find(isnan(cluster_results_tmp.exp_tags));

% Add NaN experiments as new clusters.
for i_NaN = 1:NaNs_exps_number
    new_exp_tags(NaNs_exp_indexes(i_NaN)) = number_of_clusters + i_NaN;
end
number_of_clusters = number_of_clusters + NaNs_exps_number;


for i_cluster_1 = 1:number_of_clusters
    number_of_elements = cluster_results_tmp.number_of_exps_per_cluster;
    if number_of_elements < min_cluster_elements
        % Get all elements of that cluster.
        cluster_elements = find(cluster_results_tmp.exp_tags == i_cluster_1);
        for i_element = 1:number_of_elements
            
            % Get single cluster element.
            current_element_index = cluster_elements(i_element);
            current_element = DataMatrix_clust(current_element_index, :);
            
            % Compute distance between the selected element and every other cluster.
            Z_distance = NaN(1, number_of_clusters);
            for i_cluster_2 = 1:number_of_clusters
                if i_cluster_2 == i_cluster_1
                    continue
                end
                
                % Get every element of the other cluster.
                current_2ndClust_elements = DataMatrix_clust(cluster_results_tmp.exp_tags == i_cluster_2, :);
                
                % Compute the distance between this element, and every other cluster.
                Z_distance(i_cluster_2) = compute_Z_distance (current_element, current_2ndClust_elements);
                
                % Find closest cluster.
                [min_distance, closest_cluster] = nanmin(Z_distance);
                
                % Mark for merging with the closest cluster.
                new_exp_tags = 
                
                % 
            end


            
            
            
        end
        
    end
    
end
end