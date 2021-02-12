function Clusters = get_clusters_DataMatrices(clustering_assignment_tmp, DataMatrix, experiments)
% This function separately saves the Data from the cells coming from each 
% cluster alone.

number_of_cells = numel(clustering_assignment_tmp);
number_of_clusters = nanmax(clustering_assignment_tmp);

Clusters = struct;
for i_cluster = 1:number_of_clusters
    for i_cell = 1:number_of_cells
        current_cluster_indexes = find(clustering_assignment_tmp == i_cluster);
        if ~isempty(current_cluster_indexes)
            Clusters(i_cluster).DataMatrix = DataMatrix(current_cluster_indexes, :);
            Clusters(i_cluster).experiments = experiments(current_cluster_indexes);
        end
    end
end

