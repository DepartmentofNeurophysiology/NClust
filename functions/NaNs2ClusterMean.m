function DataMatrix_NaNLess = NaNs2ClusterMean (DataMatrix, cluster_assignments)
% This function changes NaNs in the DataMatrix to mean of the cluster.
% (not fastest implementatio but works fine)


number_of_clusters = nanmax(cluster_assignments);
[~, number_of_parameters] = size(DataMatrix);

% Scroll every param, if NaN is found, get cluster corresponding to current
% cell, and substitute the NaN with the cluster average.
counter_NaN_removed = 0;
DataMatrix_NaNLess = DataMatrix;
for i_param = 1:number_of_parameters
    current_param = DataMatrix(:, i_param);
    % Get cells with a NaN in that parameter.
    nan_pos = find(isnan(current_param));
    if ~isempty(nan_pos)
        for i_nan_cell = 1:numel(nan_pos)
            % Get cell cluster.
            current_cluster_label = cluster_assignments(nan_pos(i_nan_cell));
            cell_indexes = find(cluster_assignments == current_cluster_label);
            ClusterDataMatrix_param = DataMatrix(cell_indexes, i_param);
            ClusterMean = nanmean(ClusterDataMatrix_param, 1);
            DataMatrix_NaNLess(nan_pos(i_nan_cell), i_param) = ClusterMean;
            counter_NaN_removed = counter_NaN_removed + 1;
        end
        counter_NaN_removed = counter_NaN_removed + 1;
    end
end
fprintf('# %d NaNs substituted.\n', counter_NaN_removed)

if numel(find(isnan(DataMatrix_NaNLess))) > 0
    fprintf('# %d leftover NaNs substituted with zeros.\n', numel(find(isnan(DataMatrix_NaNLess))))
    DataMatrix_NaNLess(isnan(DataMatrix_NaNLess)) = 0;
end


% % Scrolls every cluster, getting the ClusterDataMatrix
% for i_cluster = 1:number_of_clusters
%     
%     cell_indexes = find(cluster_assignments_new.MaxLikelihood == i_cluster);
%     cluster_assignments
%     ClusterDataMatrix = DataMatrix(cell_indexes, :);
%     % Scroll every parameter, if there is a NaN, replace it with the Cluster mean.
%     for i_param = 1:number_of_parameters
%         current_cluster_param = ClusterDataMatrix(:, i_param);
%         if 
%         
%     end
% end

