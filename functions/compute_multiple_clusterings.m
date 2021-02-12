function clustering_assignment = compute_multiple_clusterings (DataMatrix, options)


[number_of_cells, number_of_parameters] = size(DataMatrix);
Kmeans_distance_metric = options.Kmeans_distance_metric;
min_number_of_elements = options.min_cluster_elements;

K_means_fixed_n_clusters = 1;

% Maximum number of Clusters
number_of_clusters_min = 2;
number_of_clusters_max = 14;
number_of_clusters_fixed = number_of_clusters_max;

% DataMatrix_Relevant_mean0std1_5TopOnly
% DataMatrix_Relevant_mean0std1;
% DataMatrix_mean0std1;

% K-means
% K-Means with varying number of clusters.
if K_means_fixed_n_clusters == 1
    rng default
    [clustering_assignment.k_means, ~, ~, ~] = kmeans(DataMatrix, number_of_clusters_fixed,...
        'Distance', Kmeans_distance_metric, 'MaxIter', 1000,...
        'Display', 'final', 'Replicates', options.n_of_k_means_iterations);
else
    cluster_eval_distances = NaN(number_of_clusters_max, 4);
    for i_n_clusters = 1:number_of_clusters_max
        tic
        rng default
        % Compute K-Means.
        fprintf('Clustering with K-Means: #%d Clusters.\n...\n', i_n_clusters)
        [Cout1, Cout2, Cout3, Cout4] = kmeans(DataMatrix, i_n_clusters,...
            'Distance', Kmeans_distance_metric, 'MaxIter', 1000,...
            'Display', 'final', 'Replicates', options.n_of_k_means_iterations);
        
        cluster_results_k_means(i_n_clusters).exp_tags = Cout1;
        cluster_results_k_means(i_n_clusters).cluster_centroids_coord = Cout2;
        cluster_results_k_means(i_n_clusters).cluster_sum_distances_within = Cout3;
        cluster_results_k_means(i_n_clusters).distances_from_centroids_matrix = Cout4;
        
        % Number of elements per cluster.
        number_of_exps_per_cluster = zeros(1, i_n_clusters);
        for i_cluster = 1:i_n_clusters
            number_of_exps_per_cluster(1, i_cluster) = numel(find(Cout1 == i_cluster));
        end
        cluster_results_k_means(i_n_clusters).number_of_exps_per_cluster = number_of_exps_per_cluster;
        
        % Estimate average silhuette.
        [sil, h] = silhouette(DataMatrix, Cout1, Kmeans_distance_metric);
        cluster_eval_distances(i_n_clusters, 1) = i_n_clusters;
        cluster_eval_distances(i_n_clusters, 2) = nanmean(sil);
        
        % Estimate average Mahal distance of centroids from the rest of the data.
        DataMatrix_clust_tmp = DataMatrix;
        DataMatrix_clust_tmp(isnan(DataMatrix_clust_tmp)) = 0;
        tmp = mahal(cluster_results_k_means(i_n_clusters).cluster_centroids_coord, DataMatrix_clust_tmp);
        cluster_eval_distances(i_n_clusters, 3) = nanmean(tmp);
        
        % Compute Z-Distance and Euclidean
        [cluster_distances_tmp1] = compute_clusters_distance (DataMatrix, Cout1, options);
        cluster_results_k_means(i_n_clusters).distances = cluster_distances_tmp1;
        
        time_elapsed_tmp = toc;
        fprintf('Time Elapsed: %ds.\n', double(int16(time_elapsed_tmp)));
    end
    
    if number_of_clusters_min ~= number_of_clusters_max
        figure;
        plot(cluster_eval_silh(:, 1), cluster_eval_silh(:, 2), 'b', 'LineWidth', 2);
        grid on; box on; hold on;
        yyaxis right
        plot(cluster_eval_silh(:, 1), cluster_eval_silh(:, 3), 'r', 'LineWidth', 2);
        xlabel('Number of Clusters');
        h_legend = legend({'Mean Silhuette', 'Mean Mahal'}, 'Location', 'NorthWest');
        set(h_legend.BoxFace, 'ColorType','truecoloralpha', 'ColorData', uint8(255*[1; 1; 1; 0.25])); % Transparency
        
        % ylabel('Mean Silhuette')
        title('Measures of similarity within clusters/between clusters');
    end
    
end

% Linkage
rng default
clustering_assignment.linkage_euclidean_ward = clusterdata(DataMatrix, 'linkage', 'ward', 'Maxclust', number_of_clusters_max);
rng default
clustering_assignment.linkage_cosine_average = clusterdata(DataMatrix, 'linkage', 'average', 'distance', 'cosine', 'Maxclust', number_of_clusters_max);
rng default
clustering_assignment.linkage_correlation_average = clusterdata(DataMatrix, 'linkage', 'average', 'distance', 'correlation', 'Maxclust', number_of_clusters_max);
rng default
clustering_assignment.linkage_stdeuclidean_average = clusterdata(DataMatrix, 'linkage', 'average', 'distance', 'seuclidean', 'Maxclust', number_of_clusters_max);
rng default
linkage_tmp = linkage(DataMatrix, 'weighted', 'cityblock');
clustering_assignment.linkage_cityblock_weighted = cluster(linkage_tmp, 'maxclust', number_of_clusters_max);

clustering_assignment.linkage_euclidean_ward = merge_whole_clusters (DataMatrix, clustering_assignment.linkage_euclidean_ward, options);
clustering_assignment.linkage_cosine_average = merge_whole_clusters (DataMatrix, clustering_assignment.linkage_cosine_average, options);
clustering_assignment.linkage_correlation_average = merge_whole_clusters (DataMatrix, clustering_assignment.linkage_correlation_average, options);
clustering_assignment.linkage_stdeuclidean_average = merge_whole_clusters (DataMatrix, clustering_assignment.linkage_stdeuclidean_average, options);
clustering_assignment.linkage_cityblock_weighted = merge_whole_clusters (DataMatrix, clustering_assignment.linkage_cityblock_weighted, options);
clustering_assignment.k_means = merge_whole_clusters (DataMatrix, clustering_assignment.k_means, options);


%% Plots
hist_edges = 0.5:1:number_of_clusters_max+0.5;

suptitle_FontSize = 22;
title_FontSize = 16;
figure();
set(gcf,'position', get(0,'screensize'));
subplot_raws = 2;
subplot_columns = 3;

% Linkage Ward - Distance Euclidean
subplot(subplot_raws, subplot_columns, 1)
histogram(clustering_assignment.linkage_euclidean_ward, hist_edges)
title_str = sprintf('Linkage Dist:Euclidean - Link:Ward.');
ylabel('Number of Cells')
xlabel('Cluster')
box on; grid on;
title(title_str, 'FontSize', title_FontSize)

% Linkage Average - Distance Cosine
subplot(subplot_raws, subplot_columns, 2)
histogram(clustering_assignment.linkage_cosine_average, hist_edges)
title_str = sprintf('Linkage Dist:Cosine - Link:Average.');
ylabel('Number of Cells')
xlabel('Cluster')
box on; grid on;
title(title_str, 'FontSize', title_FontSize)

% Linkage Average - Distance Correlation
subplot(subplot_raws, subplot_columns, 3)
histogram(clustering_assignment.linkage_correlation_average, hist_edges)
title_str = sprintf('Linkage Dist:Correlation - Link:Average.');
ylabel('Number of Cells')
xlabel('Cluster')
box on; grid on;
title(title_str, 'FontSize', title_FontSize)

% Linkage Average - Distance Std Euclidean
subplot(subplot_raws, subplot_columns, 4)
histogram(clustering_assignment.linkage_stdeuclidean_average, hist_edges)
title_str = sprintf('Linkage Dist:StdEuclidean - Link:Average.');
ylabel('Number of Cells')
xlabel('Cluster')
box on; grid on;
title(title_str, 'FontSize', title_FontSize)

% Linkage Average - Distance Std Euclidean
subplot(subplot_raws, subplot_columns, 5)
histogram(clustering_assignment.linkage_cityblock_weighted, hist_edges)
title_str = sprintf('Linkage Dist:CityBlock - Link:WeightedAvg.');
ylabel('Number of Cells')
xlabel('Cluster')
box on; grid on;
title(title_str, 'FontSize', title_FontSize)

% K-Means
subplot(subplot_raws, subplot_columns, 6)
histogram(clustering_assignment.k_means, hist_edges)
title_str = sprintf('K-Means.');
ylabel('Number of Cells')
xlabel('Cluster')
box on; grid on;
title(title_str, 'FontSize', title_FontSize)

title_str = sprintf('Clustering with %d parameters.', number_of_parameters);
h_suptitle = suptitle(title_str);
h_suptitle.FontSize = suptitle_FontSize;


OutputFileName = sprintf('Clusterings with %d parameters', number_of_parameters);
saveas(gcf, sprintf('%s.png', OutputFileName));
saveas(gcf, sprintf('%s.fig', OutputFileName));
saveas(gcf, sprintf('%s.eps', OutputFileName));


%% SUBFUNCTION - Merge Whole Clusters
    function cluster_tags = merge_whole_clusters (DataMatrix, cluster_tags, options)
        % Merge cluster with the closest neighbour, if smaller than 10 cells.
        i_new_cluster = nanmax(cluster_tags) + 1;
        
        % Assign clusters to cells tagged with NaN.
        for i_cell = 1:numel(cluster_tags)
            if isnan(cluster_tags(i_cell)) == 1
                cluster_tags(i_cell) = i_new_cluster;
                i_new_cluster = i_new_cluster + 1;
            end
        end
        
        number_of_clusters = nanmax(cluster_tags);
        for i_cluster_1 = 1:number_of_clusters
            % Find number of elements in each assignment.
            cluster_elements = find(cluster_tags == i_cluster_1);
            number_of_elements = numel(cluster_elements);
            % If not enough cells, then compute distance with every other cluster.
            if number_of_elements < options.min_cluster_elements
                [cluster_distances_tmp] = compute_clusters_distance (DataMatrix, cluster_tags, options);
                cluster_distances_tmp.Z_distance
                % Find the closest Cluster.
                Z_distances_tmp = cluster_distances_tmp.Z_distance;
                [~, Closest_Cluster] = nanmin(Z_distances_tmp(i_cluster_1, :));
                % Merge the two together (assign same tag).
                cluster_tags(find(cluster_tags == i_cluster_1)) = Closest_Cluster;
            end
        end
    end


end