function between_assignments_cluster_distances = compute_distance_between_cluster_assignments (DataMatrix, clusters_assignment_1, clusters_assignment_2, assignment_names)


%% Compute distance between clusters
number_of_clusters_1 = nanmax(clusters_assignment_1);
number_of_clusters_2 = nanmax(clusters_assignment_2);
[number_of_cells, number_of_parameters] = size(DataMatrix);

% Compute Z-distance between clusters.
Z_distance = NaN(number_of_clusters_1, number_of_clusters_2);
for i_cluster_1 = 1:number_of_clusters_1
    cluster_1 = DataMatrix(find(clusters_assignment_1 == i_cluster_1), :);
    if isempty(cluster_1)
        continue
    end
    for i_cluster_2 = 1:number_of_clusters_2
        cluster_2 = DataMatrix(find(clusters_assignment_2 == i_cluster_2), :);
        if isempty(cluster_2)
            continue
        end
        Z_distance(i_cluster_1, i_cluster_2) = compute_Z_distance (cluster_1, cluster_2);
    end
    
end
between_assignments_cluster_distances = Z_distance;

figure();
set(gcf,'position', get(0,'screensize'));

suptitle_str = sprintf('Clustering %s vs Clustering %s.', assignment_names{1, 1}, assignment_names{1, 2});
xlabel_str = sprintf('Clustering %s', assignment_names{1, 1});
ylabel_str = sprintf('Clustering %s', assignment_names{1, 2});
imAlpha = ones(size(Z_distance));
imAlpha(isnan(Z_distance))=0;
imagesc(Z_distance, 'AlphaData', imAlpha);
set(gca,'color', [0, 0, 0]);
axis square
title('Z-Distance Between Cluster Assignments.')
xlabel(xlabel_str)
ylabel(ylabel_str)
colorbar
h_suptitle = suptitle(suptitle_str);

tmp_str = sprintf('Z-Distances between Assignments - %s vs %s', assignment_names{1, 1}, assignment_names{1, 2});
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));


