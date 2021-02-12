function PCA = pca_analysis(cluster_assignments, DataMatrix, options)

% Normalized distance in principal component space between
% two clusters projected on the axis joining their two centroids

% cluster_centroids_coord = cluster_results.cluster_centroids_coord;
exp_tags = cluster_assignments;

% Options
FLAG_plot_PCA = 1;
FLAG_Plot_Centroids_Euclidean = 0;
N_principal_components = 20;

if options.FLAG_deMean_deSts == 1 
    DataMatrix = set_mean0std1 (DataMatrix);
end


%% PCA
[number_of_experiments, number_of_parameters] = size(DataMatrix);
number_of_clusters = nanmax(exp_tags);

% Run PCA (note: the columns in the PCcoeff are also the Eigenvectors)
[PCcoeff, PCscore, PCeigenvalues, ~, PCexplained_var, PCestimated_mean] = pca(DataMatrix, 'Algorithm', 'als'); % Standard: 'Algorithm', 'svd'

% Take the first N principal components.
PC_main_coeff = PCcoeff(:, 1:N_principal_components);

PC_sum_abs = nansum(abs(PC_main_coeff), 2);
PC_sum = nansum((PC_main_coeff), 2);

PCA.PCcoeff = PCcoeff;
PCA.PC_main_coeff = PC_main_coeff;
PCA.PC_coeff_sum_abs = PC_sum_abs;
PCA.PC_coeff_sum = PC_sum;
PCA.PCscore = PCscore;
PCA.PCeigenvalues = PCeigenvalues;
PCA.PCexplained_var = PCexplained_var;
PCA.PCestimated_mean = PCestimated_mean;

eigenvalues_sum = sum(PCeigenvalues);
normalized_eigenvalues = PCeigenvalues./eigenvalues_sum;

PCA.eigenvalues_sum = eigenvalues_sum;
PCA.normalized_eigenvalues = normalized_eigenvalues;
PCA.dimensionality = 1/sum(normalized_eigenvalues.^2);

% 
% % Plots
% while FLAG_plot_PCA == 1 
%     figure();
%     set(gcf,'position', get(0,'screensize'));
%     PC_Plot_LineWidth = 2;
%     
%     subplot(2, 2, 1);
%     plot(PCexplained_var, 'LineWidth', PC_Plot_LineWidth);
%     box on; grid on; grid minor;
%     xlabel('Principal Components')
%     ylabel('Variance explained [%]')
%     title('Explained variance by principal components.')
%     
%     subplot(2, 2, 2)
%     plot(cumsum(PCexplained_var), 'LineWidth', PC_Plot_LineWidth);
%     box on; grid on; grid minor;
%     xlabel('Parameters')
%     ylabel('Variance explained [cumulative %]')
%     title('Variance expained Cumulative sum.')
%     FLAG_plot_PCA = 0;
%     
%     subplot(2, 2, 3)
%     plot(PC_sum_abs, 'LineWidth', PC_Plot_LineWidth);
%     xlabel('Parameters')
%     ylabel('Sum of abs(loadings)')
%     title('Sum of abs(loadings) on the first 20 principal components.')
%     
%     subplot(2, 2, 4)
%     surf(PC_main_coeff);
%     xlabel('Principal Components')
%     ylabel('Parameters')
%     zlabel('Loadings (coefficients)')
%     title('Loadings of every parameter on the first 20 principal components.')
%     
% end


% %% Mahal distance between clusters in PC space.
% % Transform the coordinates of the Clusters Centroids from the parameters 
% % space to the PCA coordinates space.
% centroids_PC_coords = NaN(number_of_clusters, number_of_parameters);
% for i_cluster_1 = 1:number_of_clusters
%     current_centroid_coords = cluster_centroids_coord(i_cluster_1, :);
%     PC_centroid_coords_tmp = current_centroid_coords*PCcoeff;
%     centroids_PC_coords(i_cluster_1, :) = PC_centroid_coords_tmp;
% end
% 
% % Transform the coordinates of each Each Experiment from the parameters
% % space to the PCA coordinates space.
% DataMatrix_clust_PC_tmp = DataMatrix_clust;
% DataMatrix_clust_PC_tmp(isnan(DataMatrix_clust_PC_tmp)) = 0;
% PC_experiments_coords = NaN(number_of_experiments, number_of_parameters);
% for i_exp = 1:number_of_experiments
%     current_exp_coords = DataMatrix_clust_PC_tmp(i_exp, :);
%     PC_centroid_coords_tmp = current_exp_coords*PCcoeff;
%     PC_experiments_coords(i_exp, :) = PC_centroid_coords_tmp;
% end
% 
% 
% Mahal_ClusterWise = NaN(number_of_clusters, number_of_clusters);
% % Estimate the Mahalanobis distance between each pair of clusters.
% for i_cluster_1 = 1:number_of_clusters
%     clear cluster_1_PC_coords
%     clear cluster_2_PC_coords
%     % Get all experiments coordinates from 1st cluster.
%     number_of_cluster_elements = numel(find(exp_tags == i_cluster_1));
%     cluster_1_PC_coords = zeros(number_of_cluster_elements, number_of_parameters);
%     i_cluster_element = 1;
%     for i_exp = 1:number_of_experiments
%         if exp_tags(i_exp) == i_cluster_1
%             cluster_1_PC_coords(i_cluster_element, :) = PC_experiments_coords(i_exp, :);
%             i_cluster_element = i_cluster_element + 1;
%         end
%     end
%     
%     % Get 2nd cluster.
%     for i_cluster_2 = 1:number_of_clusters
%         if i_cluster_1 == i_cluster_2
%             continue
%         else
%             % Get all experiments coordinates from 2nd cluster.
%             number_of_cluster_elements = numel(find(exp_tags == i_cluster_2));
%             cluster_2_PC_coords = zeros(number_of_cluster_elements, number_of_parameters);
%             i_cluster_element = 1;
%             for i_exp = 1:number_of_experiments
%                 if exp_tags(i_exp) == i_cluster_2
%                     cluster_2_PC_coords(i_cluster_element, :) = PC_experiments_coords(i_exp, :);
%                     i_cluster_element = i_cluster_element + 1;
%                 end
%             end
%         end
%         Mahal_ClusterWise(i_cluster_1, i_cluster_2) = pdist2(cluster_1_PC_coords, cluster_2_PC_coords, 'mahalanobis');
%         Mahal_ClusterWise(i_cluster_1, i_cluster_2) = mahal(cluster_1_PC_coords, cluster_2_PC_coords);
%     end
%     
% end
% 
% 
% %% Euclidean Distance between centroids.
% % Compute distance between centroids in the PC coordinates space.
% centroids_distance_euclidean = zeros(number_of_clusters, number_of_clusters);
% for i_cluster_1 = 1:number_of_clusters
%     % Get 1st centroid coordinates.
%     centroid_1_PCcoords = cluster_centroids_coord(i_cluster_1, :);
%     for i_cluster_2 = 1:number_of_clusters
%         if i_cluster_1 == i_cluster_2
%             continue
%         else
%             % Get 2nd centroid coordinates.
%             centroid_2_PCcoords = cluster_centroids_coord(i_cluster_2, :);
%             
%             centroids_distance_euclidean(i_cluster_1, i_cluster_2) = pdist([centroid_1_PCcoords; centroid_2_PCcoords]);
%         end
%     end
% end
% if FLAG_Plot_Centroids_Euclidean = 1
%     figure;
%     surf(centroids_distance_euclidean)
%     title('Euclidean distance between centroids in PC space.')
%     axis([-inf, inf, -inf, inf])
%     xlabel('Cluster #')
%     ylabel('Cluster #')
% end
% 
% % Save output
% cluster_distances.Mahal_ClusterWise = Mahal_ClusterWise;
% cluster_distances.Centroids_Euclidean = centroids_distance_euclidean;