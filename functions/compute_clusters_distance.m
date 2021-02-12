function [cluster_distances] = compute_clusters_distance (DataMatrix_clust, clusters_assignment, options)



%% Compute distance between clusters
number_of_clusters = nanmax(clusters_assignment);
[number_of_cells, number_of_parameters] = size(DataMatrix_clust);

% Compute Z-distance between clusters.
Z_distance = NaN(number_of_clusters, number_of_clusters);
for i_cluster_1 = 1:number_of_clusters
    cluster_1 = DataMatrix_clust(find(clusters_assignment == i_cluster_1), :);
    if isempty(cluster_1)
        continue
    end
    for i_cluster_2 = 1:number_of_clusters
        if i_cluster_1 == i_cluster_2
            continue
        end
        cluster_2 = DataMatrix_clust(find(clusters_assignment == i_cluster_2), :);
        if isempty(cluster_2)
            continue
        end
        Z_distance(i_cluster_1, i_cluster_2) = compute_Z_distance (cluster_1, cluster_2);
    end
    
end
cluster_distances.Z_distance = Z_distance;

% Compute statistics.
Z_distance_tmp = triu(Z_distance);
Z_distance_tmp((Z_distance_tmp) == 0) = NaN;
Z_distance_tmp = reshape(Z_distance_tmp, [1, number_of_clusters^2]);
cluster_distances.Z_distance_stats.mean = nanmean(Z_distance_tmp);
cluster_distances.Z_distance_stats.median = nanmedian(Z_distance_tmp);
cluster_distances.Z_distance_stats.std = nanstd(Z_distance_tmp);
cluster_distances.Z_distance_stats.min = nanmin(Z_distance_tmp);
cluster_distances.Z_distance_stats.max = nanmax(Z_distance_tmp);

cluster_distances.Z_distance_stats.BetweenClustersMean = nanmean(Z_distance);

% Compute Clusters Silhuette
silhuette_tmp = silhouette(DataMatrix_clust, clusters_assignment', options.Kmeans_distance_metric);
cluster_distances.clusters_silhuette = silhuette_tmp;

cluster_distances.silhuette.mean = nanmean(nanmean(silhuette_tmp));
cluster_distances.silhuette.std = nanmean(nanstd(silhuette_tmp));
cluster_distances.silhuette.min = nanmin(nanmin(silhuette_tmp));
cluster_distances.silhuette.max = nanmax(nanmax(silhuette_tmp));

% Compute Euclidean Distance between (median) Centroids
cluster_centroids_coords = compute_clusters_centroids (DataMatrix_clust, clusters_assignment);
euclidean = NaN(number_of_clusters, number_of_clusters);
for i_cluster_1 = 1:number_of_clusters
    current_centroid_1 = cluster_centroids_coords(i_cluster_1, :);
    if isempty(current_centroid_1)
        continue
    end
    for i_cluster_2 = 1:number_of_clusters
        if i_cluster_1 == i_cluster_2
            continue
        end
        current_centroid_2 = cluster_centroids_coords(i_cluster_2, :);
        if isempty(current_centroid_2)
            continue
        end
        sum_of_square_differences = 0;
        for i_param = 1:number_of_parameters
            sum_of_square_differences = sum_of_square_differences + (current_centroid_1(1, i_param) - current_centroid_2(1, i_param))^2;
        end
        euclidean_tmp = sqrt(sum_of_square_differences);
        euclidean(i_cluster_1, i_cluster_2) = euclidean_tmp;
    end
    
end



cluster_distances.Euclidean_distance = euclidean;
% Compute statistics.
Euclidean_distance_tmp = triu(euclidean);
Euclidean_distance_tmp((Euclidean_distance_tmp) == 0) = NaN;
Euclidean_distance_tmp = reshape(Euclidean_distance_tmp, [1, number_of_clusters^2]);
cluster_distances.Euclidean_distance_stats.mean = nanmean(Euclidean_distance_tmp);
cluster_distances.Euclidean_distance_stats.median = nanmedian(Euclidean_distance_tmp);
cluster_distances.Euclidean_distance_stats.std = nanstd(Euclidean_distance_tmp);
cluster_distances.Euclidean_distance_stats.min = nanmin(Euclidean_distance_tmp);
cluster_distances.Euclidean_distance_stats.max = nanmax(Euclidean_distance_tmp);

cluster_distances.Euclidean_distance_stats.BetweenClustersMean = nanmean(euclidean);

