function Z_distance = compute_Z_distance (cluster_1, cluster_2)
% Computes the Z distance between 2 axis, as described in 
% "Fast and accurate spike sorting in vitro and in vivo for up to 
% thousands of electrodes" - Pierre Yger, Giulia Spampinato et al.


% Get number of cluster elements.
[cluster_1_elements_N, number_of_parameters] = size(cluster_1);
[cluster_2_elements_N, ~] = size(cluster_2);

% Compute centroids as the median of the cluster 
%(less sensible to outliers than mean)
centroid_1_med = nanmedian(cluster_1, 1);
centroid_2_med = nanmedian(cluster_2, 1);

% Compute axis between the 2 centroids.
centroids_axis = centroid_1_med - centroid_2_med;
centroids_axis(isnan(centroids_axis)) = 0;

% Compute projection of Cluster 1 Elements on the centroids axis.
cluster_1_proj = NaN(cluster_1_elements_N, 1);
for i_element = 1:cluster_1_elements_N
    current_element = cluster_1(i_element, :);
    current_element(isnan(current_element)) = 0;
    cluster_1_proj(i_element, :) = current_element*centroids_axis';
%     cluster_1_proj(i_element, :) = (nansum(current_element.*centroids_axis)/(norm(centroids_axis)^2))*centroids_axis;
end

% Compute projection of Cluster 2 Elements on the centroids axis.
cluster_2_proj = NaN(cluster_2_elements_N, 1);
for i_element = 1:cluster_2_elements_N
    current_element = cluster_2(i_element, :);
    current_element(isnan(current_element)) = 0;
    cluster_2_proj(i_element, :) = current_element*centroids_axis';
%     cluster_2_proj(i_element, :) = (nansum(current_element.*centroids_axis)/(norm(centroids_axis)^2))*centroids_axis;
end


%% Compute the Z distance.
% If the dispersion is zero in both cases, it means that the clusters are
% both of single elements, in this case, the distance is the euclidean
% distance.
if cluster_1_elements_N == 1 && cluster_2_elements_N == 1
    Z_distance = sqrt(centroids_axis * centroids_axis');
else
    
    % Compute the dispersion of the clusters on the axis dimention.
    axis_dispersion_c1 = mad(cluster_1_proj);
    axis_dispersion_c2 = mad(cluster_2_proj);
    
    % Compute the Z distance.
    Z_distance = abs(nanmedian(cluster_1_proj) - nanmedian(cluster_2_proj))/(sqrt(axis_dispersion_c1^2 + axis_dispersion_c2^2));
end
if isinf(Z_distance)
    keyboard
end

end