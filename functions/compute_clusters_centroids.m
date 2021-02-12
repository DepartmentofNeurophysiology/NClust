function cluster_centroids_coords = compute_clusters_centroids (DataMatrix_clust, cluster_assignment)
% Gets the centroids coordinates for each cluster, according to the median
% along each dimension.

number_of_clusters = nanmax(cluster_assignment);
[number_of_cells, number_of_parameters] = size(DataMatrix_clust);

cluster_centroids_coords = NaN(number_of_clusters, number_of_parameters);
for i_cluster = 1:number_of_clusters
    % Get all the elements of a cluster.
    current_cluster_data = DataMatrix_clust(find(cluster_assignment == i_cluster), :);
    % Compute the median over each dimention.
    cluster_centroids_coords(i_cluster, :) = nanmedian(current_cluster_data, 1);
end


