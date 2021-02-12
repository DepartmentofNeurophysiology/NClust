function plot_projection_distances_2_param (cluster_projection_distances_2param, surviving_param_names)
% This function plots the distances between clusters, along 2 parameters.


title_FontSize = 20;
labels_FontSize = 13;

% Initialize.
[number_of_parameters, ~] = size(cluster_projection_distances_2param);

Z_distance_matrix_mean = NaN(number_of_parameters, number_of_parameters);
Z_distance_matrix_median = NaN(number_of_parameters, number_of_parameters);
Z_distance_matrix_max = NaN(number_of_parameters, number_of_parameters);
Z_distance_matrix_min = NaN(number_of_parameters, number_of_parameters);
E_distance_matrix_mean = NaN(number_of_parameters, number_of_parameters);
E_distance_matrix_median = NaN(number_of_parameters, number_of_parameters);
E_distance_matrix_max = NaN(number_of_parameters, number_of_parameters);
E_distance_matrix_min = NaN(number_of_parameters, number_of_parameters);
for i_parameter_i = 1:number_of_parameters
    for i_parameter_j = 1:number_of_parameters
        if i_parameter_i == i_parameter_j
            continue
        end
        Z_distance_matrix_mean(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Z_distance_stats.mean;
        Z_distance_matrix_median(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Z_distance_stats.median;
        Z_distance_matrix_max(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Z_distance_stats.max;
        Z_distance_matrix_min(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Z_distance_stats.min;
        E_distance_matrix_mean(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Euclidean_distance_stats.mean;
        E_distance_matrix_median(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Euclidean_distance_stats.median;
        E_distance_matrix_max(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Euclidean_distance_stats.max;
        E_distance_matrix_min(i_parameter_i, i_parameter_j) = cluster_projection_distances_2param{i_parameter_i, i_parameter_j}.Euclidean_distance_stats.min;
    end
end
tmp1_max(1, 1) = nanmax(reshape(Z_distance_matrix_mean, [1, number_of_parameters*number_of_parameters]));
tmp1_max(1, 2) = nanmax(reshape(Z_distance_matrix_median, [1, number_of_parameters*number_of_parameters]));
tmp1_max(1, 3) = nanmax(reshape(Z_distance_matrix_max, [1, number_of_parameters*number_of_parameters]));
tmp1_max(1, 4) = nanmax(reshape(Z_distance_matrix_min, [1, number_of_parameters*number_of_parameters]));
tmp2_max(1, 1) = nanmax(reshape(E_distance_matrix_mean, [1, number_of_parameters*number_of_parameters]));
tmp2_max(1, 2) = nanmax(reshape(E_distance_matrix_median, [1, number_of_parameters*number_of_parameters]));
tmp2_max(1, 3) = nanmax(reshape(E_distance_matrix_median, [1, number_of_parameters*number_of_parameters]));
tmp2_max(1, 4) = nanmax(reshape(E_distance_matrix_median, [1, number_of_parameters*number_of_parameters]));

Z_colorbar_max = max(tmp1_max);
E_colorbar_max = max(tmp2_max);

%% Z-Distances.

% Fig 1 - Mean.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = Z_distance_matrix_mean;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(Z_colorbar_max)])
colorbar;

title('Z-distance - Mean along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'Z-distance - Mean along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Fig 2 - Median.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = Z_distance_matrix_median;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(Z_colorbar_max)])
colorbar;

title(' Z-distance - Median along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'Z-distance - Median along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Fig 3 - Max.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = Z_distance_matrix_max;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(Z_colorbar_max)])
colorbar;

title('Z-distance - Max along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'Z-distance - Max along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Fig 4 - Min.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = Z_distance_matrix_min;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(Z_colorbar_max)])
colorbar;

title('Z-distance - Min along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'Z-distance - Min along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));


%% E-Distances.

% Fig 1 - Mean.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = E_distance_matrix_mean;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(E_colorbar_max)])
colorbar;

title('E-distance - Mean along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'E-distance - Mean along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Fig 2 - Median.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = E_distance_matrix_median;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(E_colorbar_max)])
colorbar;

title('E-distance - Median along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'E-distance - Median along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Fig 3 - Max.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = E_distance_matrix_max;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(E_colorbar_max)])
colorbar;

title('E-distance - Max along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'E-distance - Max along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));

% Fig 4 - Min.
figure();
set(gcf,'position', get(0,'screensize'));
current_data_display = E_distance_matrix_min;
imAlpha = ones(number_of_parameters);
imAlpha(isnan(current_data_display)) = 0;
imagesc(current_data_display, 'AlphaData', imAlpha);

set(gca,'color', [0, 0, 0]);
axis square
caxis([0, ceil(E_colorbar_max)])
colorbar;

title('E-distance - Min along 2 Parameters projection', 'FontSize', title_FontSize);
xlabel('Parameters.', 'FontSize', labels_FontSize);
ylabel('Parameters.', 'FontSize', labels_FontSize);

xticks(1:number_of_parameters);
yticks(1:number_of_parameters);
yticklabels(surviving_param_names');

tmp_str = 'E-distance - Min along 2 Parameters projection';
saveas(gcf, sprintf('%s.png', tmp_str));
saveas(gcf, sprintf('%s.fig', tmp_str));
saveas(gcf, sprintf('%s.eps', tmp_str));
