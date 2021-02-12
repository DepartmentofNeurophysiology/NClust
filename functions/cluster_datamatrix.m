function [cluster_results, DataMatrix_clust] = cluster_datamatrix (DataMatrix, options)

% Options.
FLAG_fixed_n_clusters = 1;
% number_of_clusters = 100;
max_number_of_clusters = 50;
FLAG_plot_clusters_silhuette_mahal = 0;

if nargin < 2
    Kmeans_distance_metric = 'cityblock'; % 'cityblock', 'sqeuclidean' (cityblock is L1, results in centroid being median)
    k_means_iterations = 10000;
else
    Kmeans_distance_metric = options.Kmeans_distance_metric;
    k_means_iterations = options.n_of_k_means_iterations;
end
% Set DataMatrix parameters to mean = 0, std = 1?
if options.FLAG_deMean_deSts == 1 
    DataMatrix_clust = set_mean0std1 (DataMatrix);
else
    DataMatrix_clust = DataMatrix;
end

% % Agglomerative Clustering.
% if FLAG_fixed_n_clusters == 1
%     cluster_results = clusterdata(DataMatrix_clust, 'maxclust', number_of_clusters, 'linkage', 'ward');
% else
%     cluster_results = clusterdata(DataMatrix_clust, 'linkage', 'ward');
% end

if FLAG_fixed_n_clusters == 0
    % K-Means with varying number of clusters.
    cluster_eval_silh = NaN(max_number_of_clusters, 3);
    for i_n_clusters = 1:max_number_of_clusters
        tic
        % Compute K-Means.
        fprintf('Clustering with K-Means: #%d Clusters.\n...\n', i_n_clusters)
        [Cout1, Cout2, Cout3, Cout4] = kmeans(DataMatrix_clust, i_n_clusters,...
            'Distance', Kmeans_distance_metric, 'MaxIter', 1000,...
            'Display', 'final', 'Replicates', k_means_iterations);
        
        cluster_results(i_n_clusters).exp_tags = Cout1;
        cluster_results(i_n_clusters).cluster_centroids_coord = Cout2;
        cluster_results(i_n_clusters).cluster_sum_distances_within = Cout3;
        cluster_results(i_n_clusters).distances_from_centroids_matrix = Cout4;
        
        % Number of elements per cluster.
        number_of_exps_per_cluster = zeros(1, i_n_clusters);
        for i_cluster = 1:i_n_clusters
            number_of_exps_per_cluster(1, i_cluster) = numel(find(Cout1 == i_cluster));
        end
        cluster_results(i_n_clusters).number_of_exps_per_cluster = number_of_exps_per_cluster;
        
        % Estimate average silhuette.
        [sil, h] = silhouette(DataMatrix_clust, Cout1, Kmeans_distance_metric);
        cluster_eval_silh(i_n_clusters, 1) = i_n_clusters;
        cluster_eval_silh(i_n_clusters, 2) = nanmean(sil);
        
        % Estimate average Mahal distance of centroids from the rest of the data.
        DataMatrix_clust_tmp = DataMatrix_clust;
        DataMatrix_clust_tmp(isnan(DataMatrix_clust_tmp)) = 0;
        tmp = mahal(cluster_results(i_n_clusters).cluster_centroids_coord, DataMatrix_clust_tmp);
        cluster_eval_silh(i_n_clusters, 3) = nanmean(tmp);
        %     eva = evalclusters(DataMatrix_clust,'kmeans', 'silhouette','KList', 1:50)
        
        time_elapsed_tmp = toc;
        fprintf('Time Elapsed: %ds.\n', double(int16(time_elapsed_tmp)));
    end
    
    if FLAG_plot_clusters_silhuette_mahal == 1
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
    
else
    
    % K-Means with fixed number of clusters.
    cluster_eval_silh = NaN(1, 3);
    n_clusters = max_number_of_clusters;
    tic
    % Compute K-Means.
    fprintf('Clustering with K-Means: #%d Clusters.\n...\n', n_clusters)
    [Cout1, Cout2, Cout3, Cout4] = kmeans(DataMatrix_clust, n_clusters,...
        'Distance', Kmeans_distance_metric, 'MaxIter', 10000,...
        'Display', 'final', 'Replicates', k_means_iterations);
    
    cluster_results.exp_tags = Cout1;
    cluster_results.cluster_centroids_coord = Cout2;
    cluster_results.cluster_sum_distances_within = Cout3;
    cluster_results.distances_from_centroids_matrix = Cout4;
    
    % Number of elements per cluster.
    number_of_exps_per_cluster = zeros(1, n_clusters);
    for i_cluster = 1:n_clusters
        number_of_exps_per_cluster(1, i_cluster) = numel(find(Cout1 == i_cluster));
    end
    cluster_results.number_of_exps_per_cluster = number_of_exps_per_cluster;
    
    % Estimate average silhuette.
    [sil, h] = silhouette(DataMatrix_clust, Cout1, Kmeans_distance_metric);
    cluster_eval_silh(1, 1) = n_clusters;
    cluster_eval_silh(1, 2) = nanmean(sil);
    
    % Estimate average Mahal distance of centroids from the rest of the data.
    DataMatrix_clust_tmp = DataMatrix_clust;
    DataMatrix_clust_tmp(isnan(DataMatrix_clust_tmp)) = 0;
    tmp = mahal(cluster_results.cluster_centroids_coord, DataMatrix_clust_tmp);
    cluster_eval_silh(1, 3) = nanmean(tmp);
    %     eva = evalclusters(DataMatrix_clust,'kmeans', 'silhouette','KList', 1:50)
    
    time_elapsed_tmp = toc;
    fprintf('Time Elapsed: %ds.\n', double(int16(time_elapsed_tmp)));
    
end
end