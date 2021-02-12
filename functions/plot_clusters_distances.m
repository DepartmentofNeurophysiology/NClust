function plot_clusters_distances (cluster_distances, main_figures_dir)


% Initialize.
Z_distance_1 = cluster_distances.MostStable.Z_distance;
Z_distance_2 = cluster_distances.MaxLikelihood.Z_distance;
E_distance_1 = cluster_distances.MostStable.Euclidean_distance;
E_distance_2 = cluster_distances.MaxLikelihood.Euclidean_distance;
[h_1, w_1] = size(Z_distance_1);
[h_2, w_2] = size(Z_distance_2);

% Fill with NaNs the empty clusters, to make the plots more comparable.
if h_1 > h_2
    Z_distance_2_tmp = NaN(h_1, w_1);
    E_distance_2_tmp = NaN(h_1, w_1);
    Z_distance_2_tmp(1:h_2, 1:w_2) = Z_distance_2;
    E_distance_2_tmp(1:h_2, 1:w_2) = E_distance_2;
    Z_distance_2 = Z_distance_2_tmp;
    E_distance_2 = E_distance_2_tmp;
elseif h_2 > h_1
    Z_distance_1_tmp = NaN(h_2, w_2);
    E_distance_1_tmp = NaN(h_2, w_2);
    Z_distance_1_tmp(1:h_1, 1:w_1) = Z_distance_1;
    E_distance_1_tmp(1:h_1, 1:w_1) = E_distance_1;
    Z_distance_1 = Z_distance_1_tmp;
    E_distance_1 = E_distance_1_tmp;
end
[h_1, w_1] = size(Z_distance_1);

% Appent one extra raw-column of NaNs...because Matlab is retarded.
Z_distance_1_tmp = NaN(h_1+1, w_1+1); Z_distance_1_tmp(1:h_1, 1:w_1) = Z_distance_1; Z_distance_1 = Z_distance_1_tmp;
E_distance_1_tmp = NaN(h_1+1, w_1+1); E_distance_1_tmp(1:h_1, 1:w_1) = E_distance_1; E_distance_1 = E_distance_1_tmp;
Z_distance_2_tmp = NaN(h_1+1, w_1+1); Z_distance_2_tmp(1:h_1, 1:w_1) = Z_distance_2; Z_distance_2 = Z_distance_2_tmp;
E_distance_2_tmp = NaN(h_1+1, w_1+1); E_distance_2_tmp(1:h_1, 1:w_1) = E_distance_2; E_distance_2 = E_distance_2_tmp;


Z_distance_max = nanmax([cluster_distances.MaxLikelihood.Z_distance_stats.max, cluster_distances.MostStable.Z_distance_stats.max]);
E_distance_max = nanmax([cluster_distances.MaxLikelihood.Euclidean_distance_stats.max, cluster_distances.MostStable.Euclidean_distance_stats.max]);

Z_distance_cluster_avg_ML = cluster_distances.MaxLikelihood.Z_distance_stats.BetweenClustersMean;
Z_distance_cluster_avg_MS = cluster_distances.MostStable.Z_distance_stats.BetweenClustersMean;
E_distance_cluster_avg_ML = cluster_distances.MaxLikelihood.Euclidean_distance_stats.BetweenClustersMean;
E_distance_cluster_avg_MS = cluster_distances.MostStable.Euclidean_distance_stats.BetweenClustersMean;


%% Z-Distance
figure();
set(gcf,'position', get(0,'screensize'));
halfwidth = 0.5;
ticks_pos = halfwidth:1:h_1+halfwidth;

% Maximum Likelihood Assignment.
subplot(1, 2, 2)
pcolor(Z_distance_2);
title('Z-Distance Between Clusters - Maximum Likelihood Assignment.')
axis square;
set(gca,'Ydir','reverse')
colorbar
caxis([0, ceil(Z_distance_max)])
set(gca, 'xTick', ticks_pos);
set(gca, 'xTickLabel', ticks_pos-halfwidth);
set(gca, 'yTick', ticks_pos);
set(gca, 'yTickLabel', ticks_pos-halfwidth);
xlabel('Cluster')
ylabel('Cluster')
set(gca,'color',[0 0 0])

% Most Stable Configuration.
subplot(1, 2, 1)
pcolor(Z_distance_1);
title('Z-Distance Between Clusters - Most Stable Assignment.')
set(gca,'Ydir','reverse')
axis square;
colorbar
caxis([0, ceil(Z_distance_max)])
set(gca, 'xTick', ticks_pos);
set(gca, 'xTickLabel', ticks_pos-halfwidth);
set(gca, 'yTick', ticks_pos);
set(gca, 'yTickLabel', ticks_pos-halfwidth);
xlabel('Cluster')
ylabel('Cluster')
set(gca,'color',[0 0 0])

saveas(gcf, sprintf('%s\\Z-Distance between clusters.png', main_figures_dir));
saveas(gcf, sprintf('%s\\Z-Distance between clusters.fig', main_figures_dir));
saveas(gcf, sprintf('%s\\Z-Distance between clusters.eps', main_figures_dir));


%% Euclidean Distance
figure();
set(gcf,'position', get(0,'screensize'));

% Maximum Likelihood Assignment.
subplot(1, 2, 2)
pcolor(E_distance_2);
title('Euclidean Distance Between Centroids - Maximum Likelihood Assignment.')
set(gca,'Ydir','reverse')
axis square;
colorbar
caxis([0, ceil(E_distance_max)])
set(gca, 'xTick', ticks_pos);
set(gca, 'xTickLabel', ticks_pos-halfwidth);
set(gca, 'yTick', ticks_pos);
set(gca, 'yTickLabel', ticks_pos-halfwidth);
xlabel('Cluster')
ylabel('Cluster')
set(gca,'color',[0 0 0])

% Most Stable Configuration.
subplot(1, 2, 1)
pcolor(E_distance_1);
title('Euclidean Distance Between Centroids - Most Stable Assignment.')
set(gca,'Ydir','reverse')
axis square;
colorbar
caxis([0, ceil(E_distance_max)])
set(gca, 'xTick', ticks_pos);
set(gca, 'xTickLabel', ticks_pos-halfwidth);
set(gca, 'yTick', ticks_pos);
set(gca, 'yTickLabel', ticks_pos-halfwidth);
xlabel('Cluster')
ylabel('Cluster')
set(gca,'color',[0 0 0])

saveas(gcf, sprintf('%s\\Euclidean Distance between Centroids.png', main_figures_dir));
saveas(gcf, sprintf('%s\\Euclidean Distance between Centroids.fig', main_figures_dir));
saveas(gcf, sprintf('%s\\Euclidean Distance between Centroids.eps', main_figures_dir));


%% Average distance of a cluster with other clusters.
hist_edges = [0.5:1:(h_1)];
figure();
set(gcf,'position', get(0,'screensize'));
subplot(2, 2, 1)
bar(Z_distance_cluster_avg_ML)
axis square; grid on; box on;
xlabel('Cluster')
ylabel('Mean distance to other clusters.')
title('Mean Z Distance from cluster X to other clusters - MaxLikelihood Assignment.')

subplot(2, 2, 2)
bar(Z_distance_cluster_avg_MS)
axis square; grid on; box on;
xlabel('Cluster')
ylabel('Mean distance to other clusters.')
title('Mean Z Distance from cluster X to other clusters - MaxStability Assignment.')

subplot(2, 2, 3)
bar(E_distance_cluster_avg_ML)
axis square; grid on; box on;
xlabel('Cluster')
ylabel('Mean distance to other clusters.')
title('Mean Euclidean Distance from cluster X to other clusters - MaxLikelihood Assignment.')

subplot(2, 2, 4)
bar(E_distance_cluster_avg_MS)
axis square; grid on; box on;
xlabel('Cluster')
ylabel('Mean distance to other clusters.')
title('Mean Euclidean Distance from cluster X to other clusters - MaxStability Assignment.')


saveas(gcf, sprintf('%s\\Average Distance between clusters.png', main_figures_dir));
saveas(gcf, sprintf('%s\\Average Distance between clusters.fig', main_figures_dir));
saveas(gcf, sprintf('%s\\Average Distance between clusters.eps', main_figures_dir));