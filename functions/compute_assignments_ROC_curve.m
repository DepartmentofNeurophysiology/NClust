function compute_assignments_ROC_curve (cluster_assignment_1, cluster_assignment_2, Z_distance)

number_of_cells = numel(cluster_assignment_1);
number_of_clusters_1 = nanmax(cluster_assignment_1);
number_of_clusters_2 = nanmax(cluster_assignment_2);

n_clusters_max = max([number_of_clusters_1, number_of_clusters_2]);

if number_of_clusters_1 == number_of_clusters_2
    FLAG_same_n_clusters = 1;
else
    FLAG_same_n_clusters = 0;
end

% Normalize cell labels.
for i_cluster = 1:n_clusters_max
    % Find the Min distance between 2 clusters in the whole matrix.
    min_distance = nanmin(Z_distance(:));
    % Get their indexes.
    find(Z_distance == min_distance)
    % Use the same lable for both clusters.
    
    % Remove the correspondings raws/columns, as they have already been 
    % "translated".
    [~, Closest_Cluster] = nanmin(Z_distance(i_cluster, :));
    
end

[X, Y, T, AUC, OPTROCPT, SUBY] = perfcurve(cluster_assignment_1, cluster_assignment_2, 6);
plot(X, Y);









% Corr_Matrix = NaN(number_of_clusters_1, number_of_clusters_2);
% for i_cluster_1 = 1:number_of_clusters_1
%     cluster_assignment_1_tmp = cluster_assignment_1;
%     cluster_assignment_1_tmp(cluster_assignment_1_tmp ~= i_cluster_1) = 0;
%     cluster_assignment_1_tmp(cluster_assignment_1_tmp == i_cluster_1) = 1;
%     
%     for i_cluster_2 = 1:number_of_clusters_2
%         cluster_assignment_2_tmp = cluster_assignment_2;
%         cluster_assignment_2_tmp(cluster_assignment_2_tmp ~= i_cluster_2) = 0;
%         cluster_assignment_2_tmp(cluster_assignment_2_tmp == i_cluster_2) = 1;
%         
%         tmp = corrcoef(cluster_assignment_1_tmp, cluster_assignment_2_tmp);
%         Corr_Matrix(i_cluster_1, i_cluster_2) = tmp(1, 2);
%     end
% end
% imagesc(Corr_Matrix);
% axis square
% colorbar
% ylabel('Classification 35 param')
% xlabel('Classification 5 param')
%         corr(cluster_assignment_1_tmp, cluster_assignment_2_tmp);
% corrcoef(i_cluster_1, i_cluster_2)

% [X, Y, T, AUC, OPTROCPT, SUBY] = perfcurve(cluster_assignment_1, cluster_assignment_2, 6);
% plot(X, Y);
% 
% for i_cell = 1:number_of_cells
%     current_cell_assignment_1 = cluster_assignment_1(i_cell);
%     current_cell_assignment_2 = cluster_assignment_2(i_cell);
%     
%     
%     
%     
%     
% end


end
