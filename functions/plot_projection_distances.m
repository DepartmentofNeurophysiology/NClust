function plot_projection_distances (cluster_projection_distances, surviving_param_names, number_of_projection_parameters)
% This function plots the distances between clusters, along single parameters.

% Initialize.
number_of_parameters = numel(cluster_projection_distances);

max_euclidean_array = NaN(1, number_of_parameters);
max_z_array = NaN(1, number_of_parameters);
for i_param = 1:number_of_parameters
    max_euclidean_array(i_param) = cluster_projection_distances{i_param, 1}.Euclidean_distance_stats.max;
    max_z_array(i_param) = cluster_projection_distances{i_param, 1}.Z_distance_stats.max;
end
max_euclidean = nanmax(max_euclidean_array);
max_z = nanmax(max_z_array);

subplot_raws = 5;
subplot_colums = 5;


%% Euclideans.
figure();
set(gcf,'position', get(0,'screensize'));
i_subplot = 1;
for i_param = 1:(subplot_raws*subplot_colums)
    i_raw = idivide(i_subplot, int16(subplot_raws), 'ceil');
    i_column = i_subplot - subplot_raws*i_raw + subplot_raws;
    title_str = sprintf('%s', surviving_param_names{i_param});
    current_data_display = cluster_projection_distances{i_param, 1}.Euclidean_distance;
    h_subplot = subplot(subplot_raws, subplot_colums, i_subplot);
    
    imAlpha = ones(size(current_data_display));
    imAlpha(isnan(current_data_display))=0;
    imagesc(current_data_display, 'AlphaData', imAlpha);
    set(gca,'color', [0, 0, 0]);

    axis square
%     view(2);
%     set(gca,'Ydir','reverse')
    title(title_str);
    if i_raw == subplot_raws
        xlabel('Cluster')
    end
    if i_column == 1
        ylabel('Cluster')
    end
    caxis([0, ceil(max_euclidean)])
    if i_column == subplot_colums
        colorbar
    end
    i_subplot = i_subplot + 1;
end
h_suptitle = suptitle('Euclidean Distance between centroids, along single parameters.');
set(h_suptitle, 'FontSize', 24)

if number_of_projection_parameters == 1
    tmp_str = 'Euclidean Distance along Single Parameters - pt1';
elseif number_of_projection_parameters == 2
    tmp_str = 'Euclidean Distance along 2 Parameters - pt1';
end
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Part 2.
figure();
set(gcf,'position', get(0,'screensize'));
i_subplot = 1;
for i_param = (subplot_raws*subplot_colums):number_of_parameters
    
    i_raw = idivide(i_subplot, int16(subplot_raws), 'ceil');
    i_column = i_subplot - subplot_raws*i_raw + subplot_raws;
    title_str = sprintf('%s', surviving_param_names{i_param});
    current_data_display = cluster_projection_distances{i_param, 1}.Euclidean_distance;
    h_subplot = subplot(subplot_raws, subplot_colums, i_subplot);
    
    imAlpha = ones(size(current_data_display));
    imAlpha(isnan(current_data_display))=0;
    imagesc(current_data_display, 'AlphaData', imAlpha);
    set(gca,'color', [0, 0, 0]);

    axis square
%     view(2);
%     set(gca,'Ydir','reverse')
    title(title_str);
    if i_raw == subplot_raws
        xlabel('Cluster')
    end
    if i_column == 1
        ylabel('Cluster')
    end
    caxis([0, ceil(max_euclidean)])
    if i_column == subplot_colums
        colorbar
    end
    i_subplot = i_subplot + 1;
end
h_suptitle = suptitle('Euclidean Distance between centroids, along single parameters.');
set(h_suptitle, 'FontSize', 24)

if number_of_projection_parameters == 1
    tmp_str = 'Euclidean Distance along Single Parameters - pt2';
elseif number_of_projection_parameters == 2
    tmp_str = 'Euclidean Distance along 2 Parameters - pt2';
end
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));


%% Z-Distance.
figure();
set(gcf,'position', get(0,'screensize'));
i_subplot = 1;
for i_param = 1:(subplot_raws*subplot_colums)
    i_raw = idivide(i_subplot, int16(subplot_raws), 'ceil');
    i_column = i_subplot - subplot_raws*i_raw + subplot_raws;
    title_str = sprintf('%s', surviving_param_names{i_param});
    current_data_display = cluster_projection_distances{i_param, 1}.Z_distance;
    h_subplot = subplot(subplot_raws, subplot_colums, i_subplot);
    
    imAlpha = ones(size(current_data_display));
    imAlpha(isnan(current_data_display))=0;
    imagesc(current_data_display, 'AlphaData', imAlpha);
    set(gca,'color', [0, 0, 0]);

    axis square
%     view(2);
%     set(gca,'Ydir','reverse')
    title(title_str);
    if i_raw == subplot_raws
        xlabel('Cluster')
    end
    if i_column == 1
        ylabel('Cluster')
    end
    caxis([0, ceil(max_z)])
    if i_column == subplot_colums
        colorbar
    end
    i_subplot = i_subplot + 1;
end
h_suptitle = suptitle('Z distance between centroids, along single parameters.');
set(h_suptitle, 'FontSize', 24)

if number_of_projection_parameters == 1
    tmp_str = 'Z Distance along Single Parameters - pt1';
elseif number_of_projection_parameters == 2
    tmp_str = 'Z Distance along 2 Parameters - pt1';
end
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Part 2.
figure();
set(gcf,'position', get(0,'screensize'));
i_subplot = 1;
for i_param = (subplot_raws*subplot_colums):number_of_parameters
    
    i_raw = idivide(i_subplot, int16(subplot_raws), 'ceil');
    i_column = i_subplot - subplot_raws*i_raw + subplot_raws;
    title_str = sprintf('%s', surviving_param_names{i_param});
    current_data_display = cluster_projection_distances{i_param, 1}.Z_distance;
    h_subplot = subplot(subplot_raws, subplot_colums, i_subplot);
    
    imAlpha = ones(size(current_data_display));
    imAlpha(isnan(current_data_display))=0;
    imagesc(current_data_display, 'AlphaData', imAlpha);
    set(gca,'color', [0, 0, 0]);

    axis square
%     view(2);
%     set(gca,'Ydir','reverse')
    title(title_str);
    if i_raw == subplot_raws
        xlabel('Cluster')
    end
    if i_column == 1
        ylabel('Cluster')
    end
    caxis([0, ceil(max_z)])
    if i_column == subplot_colums
        colorbar
    end
    i_subplot = i_subplot + 1;
end
h_suptitle = suptitle('Z Distance between centroids, along single parameters.');
set(h_suptitle, 'FontSize', 24)

if number_of_projection_parameters == 1
    tmp_str = 'Z Distance along Single Parameters - pt2';
elseif number_of_projection_parameters == 2
    tmp_str = 'Z Distance along 2 Parameters - pt2';
end
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));


%% Average distances.
Z_distance_mean = NaN(1, numel(cluster_projection_distances));
Z_distance_median = NaN(1, numel(cluster_projection_distances));
E_distance_mean = NaN(1, numel(cluster_projection_distances));
E_distance_median = NaN(1, numel(cluster_projection_distances));
for i_param = 1:numel(cluster_projection_distances)
    Z_distance_mean(1, i_param) = cluster_projection_distances{i_param, 1}.Z_distance_stats.mean;
    Z_distance_median(1, i_param) = cluster_projection_distances{i_param, 1}.Z_distance_stats.median;
    E_distance_mean(1, i_param) = cluster_projection_distances{i_param, 1}.Euclidean_distance_stats.mean;
    E_distance_median(1, i_param) = cluster_projection_distances{i_param, 1}.Euclidean_distance_stats.median;
end

figure();
set(gcf,'position', get(0,'screensize'));
subplot_raws = 4;
subplot_colums = 2;
y_axis_max = (max([nanmax(Z_distance_mean), nanmax(Z_distance_median), nanmax(E_distance_mean), nanmax(E_distance_median)]));

subplot(subplot_raws, subplot_colums, 1)
bar(Z_distance_mean)
axis([0, inf, 0, y_axis_max])
grid on;
title('Z-Distance Projection on single dimentions - Mean')

subplot(subplot_raws, subplot_colums, 2)
bar(Z_distance_median)
axis([0, inf, 0, y_axis_max])
grid on;
title('Z-Distance Projection on single dimentions - Median')

subplot(subplot_raws, subplot_colums, 3)
bar(sort(Z_distance_mean, 'descend'))
axis([0, inf, 0, y_axis_max])
grid on;
title('Z-Distance Projection on single dimentions - Sorted - Mean')

subplot(subplot_raws, subplot_colums, 4)
bar(sort(Z_distance_median, 'descend'))
axis([0, inf, 0, y_axis_max])
grid on;
title('Z-Distance Projection on single dimentions - Sorted - Median')

subplot(subplot_raws, subplot_colums, 5)
bar(E_distance_mean)
axis([0, inf, 0, y_axis_max])
grid on;
title('E-Distance Projection on single dimentions - Mean')

subplot(subplot_raws, subplot_colums, 6)
bar(E_distance_median)
axis([0, inf, 0, y_axis_max])
grid on;
title('E-Distance Projection on single dimentions - Median')

subplot(subplot_raws, subplot_colums, 7)
bar(sort(E_distance_mean, 'descend'))
axis([0, inf, 0, y_axis_max])
grid on;
title('E-Distance Projection on single dimentions - Sorted - Mean')

subplot(subplot_raws, subplot_colums, 8)
bar(sort(E_distance_median, 'descend'))
axis([0, inf, 0, y_axis_max])
grid on;
title('E-Distance Projection on single dimentions - Sorted - Median')


if number_of_projection_parameters == 1
    tmp_str = 'Z and E Distances along Single Parameters - Mean and median distances per parameters';
elseif number_of_projection_parameters == 2
    tmp_str = 'Z and E Distances along 2 Parameters - Mean and median distances per parameters';
end
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));
