function [Parameters_Step_Combinations, experiments] = compute_best_3steps_comb(experiments, cluster_assignment, main_figures_dir, options)
% This function computes the combination of 3 single values (from 3
% distinct current injection steps) that allows for the best cluster
% separation.

dimentions = 3;
n_of_exps = numel(experiments);
n_of_steps = numel(experiments(1).CC_Data_Means.APcount);
min_step_dist = 3;
fields_names_tmp = fieldnames(experiments(1).CC_Data_Means);
n_of_fields = numel(fields_names_tmp);
n_clusters = nanmax(cluster_assignment);
FLAG_3D_plots = 1;
plots_folder_main = sprintf('%s\\Single Parameters - Best 3 Steps', main_figures_dir);
plots_folder_png = sprintf('%s\\png', plots_folder_main);
plots_folder_fig = sprintf('%s\\fig', plots_folder_main);
plots_folder_eps = sprintf('%s\\eps', plots_folder_main);
if exist(plots_folder_png, 'dir') == 0
   mkdir(plots_folder_png);
   addpath(genpath(plots_folder_png));
end
if exist(plots_folder_fig, 'dir') == 0
   mkdir(plots_folder_fig);
   addpath(genpath(plots_folder_fig));
end
if exist(plots_folder_eps, 'dir') == 0
   mkdir(plots_folder_eps);
   addpath(genpath(plots_folder_eps));
end

Combinations = nchoosek(1:n_of_steps, dimentions);
[n_combinations, ~] = size(Combinations);

% Select only the combinations that have steps with a minimum distance 
% between each other.
if min_step_dist > 0
    for i_combination = n_combinations:-1:1
        dist_1 = abs(Combinations(i_combination, 1) - Combinations(i_combination, 2));
        dist_2 = abs(Combinations(i_combination, 1) - Combinations(i_combination, 3));
        dist_3 = abs(Combinations(i_combination, 2) - Combinations(i_combination, 3));
        if (dist_1 < min_step_dist) || (dist_2 < min_step_dist) || (dist_3 < min_step_dist)
            Combinations(i_combination, :) = [];
        end
    end
    [n_combinations, ~] = size(Combinations);
end


%% Compute Single Parameters DataMatrices.
if ~isfield(experiments, 'current_at_first_spike')
    % Add current at first spike.
    for i_exp = 1:n_of_exps
        current_exp_APcount = experiments(i_exp).CC_Data_Means.APcount;
        experiments(i_exp).current_at_first_spike = min(find(current_exp_APcount ~= 0));
    end
end

for i_field = 1:n_of_fields
    current_field_matrix = NaN(n_of_exps, n_of_steps);
    for i_exp = 1:n_of_exps
        current_cell_data = experiments(i_exp).CC_Data_Means;
        current_field = current_cell_data.(fields_names_tmp{i_field});
        current_field_matrix(i_exp, 1:n_of_steps) = current_field;
    end
    fields_matrices.(fields_names_tmp{i_field}) = current_field_matrix;
end


%% Compute best combination for each parameter.
Combination_Distances = struct;
Parameters_Step_Combinations = struct;
for i_field = 1:n_of_fields
    Z_distance_mean_array = NaN(1, n_combinations);
    fprintf('Computing best steps combination for parameter %d/%d: "%s".\n', i_field, n_of_fields, (fields_names_tmp{i_field}));
    current_field_matrix = fields_matrices.(fields_names_tmp{i_field});
    for i_combination = 1:n_combinations
        % For each combination, compute the distance between clusters (already existing).
        current_combination = Combinations(i_combination, :);
        current_comb_matrix = current_field_matrix(:, current_combination);
        [current_cluster_distances] = compute_clusters_distance (current_comb_matrix, cluster_assignment, options);
        Combination_Distances(i_combination).Combination = current_combination;
        Combination_Distances(i_combination).Zdistance = current_cluster_distances.Z_distance;
        Combination_Distances(i_combination).Zdistance_mean = current_cluster_distances.Z_distance_stats.mean;
        Combination_Distances(i_combination).Zdistance_median = current_cluster_distances.Z_distance_stats.median;
        Combination_Distances(i_combination).Zdistance_min = current_cluster_distances.Z_distance_stats.min;
        Combination_Distances(i_combination).Zdistance_max = current_cluster_distances.Z_distance_stats.max;
        Combination_Distances(i_combination).Edistance_mean = current_cluster_distances.Euclidean_distance_stats.mean;
        Combination_Distances(i_combination).Edistance_median = current_cluster_distances.Euclidean_distance_stats.median;
        Combination_Distances(i_combination).Edistance_min = current_cluster_distances.Euclidean_distance_stats.min;
        Combination_Distances(i_combination).Edistance_max = current_cluster_distances.Euclidean_distance_stats.max;
        Z_distance_mean_array(i_combination) = current_cluster_distances.Z_distance_stats.mean;
    end
    [min_Z_mean_distance, min_Z_mean_distance_index] = nanmin(Z_distance_mean_array);
    [max_Z_mean_distance, max_Z_mean_distance_index] = nanmax(Z_distance_mean_array);
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).Combination_Distance = Combination_Distances;
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).Z_distances = min_Z_mean_distance;
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).min_Z_mean_distance = min_Z_mean_distance;
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).min_Z_distance_combination = Combination_Distances(min_Z_mean_distance_index).Combination;
    tmp = Parameters_Step_Combinations.(fields_names_tmp{i_field});
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).min_Z_distance_index = find([tmp.Combination_Distance.Zdistance_mean] == tmp.min_Z_mean_distance);
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).max_Z_mean_distance = max_Z_mean_distance;
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).max_Z_distance_combination = Combination_Distances(max_Z_mean_distance_index).Combination;
    tmp = Parameters_Step_Combinations.(fields_names_tmp{i_field});
    Parameters_Step_Combinations.(fields_names_tmp{i_field}).max_Z_distance_index = find([tmp.Combination_Distance.Zdistance_mean] == tmp.max_Z_mean_distance);
end


%% Plots
subplot_raws = 1;
subplot_columns = 3;
Plot_LineWidth = 1;
title_FontSize = 18;
labels_FontSize = 16;
suptitle_FontSize = 22;
FLAG_PlotNaNs2zeros = 1;
FLAG_fig1_2 = 0;

% Check the maximum Z-Distance between clusters.
max_tmp = NaN(1, n_of_fields);
for i_field = 1:n_of_fields
    current_max_distance_index = Parameters_Step_Combinations.(fields_names_tmp{i_field}).max_Z_distance_index;
    max_tmp(i_field) = Parameters_Step_Combinations.(fields_names_tmp{i_field}).Combination_Distance(current_max_distance_index).Zdistance_max;
end
Z_distance_max = nanmax(max_tmp);

% Z_distance_max = 10;

colorbar_limits = [0, Z_distance_max];

% Plot each field (only the 3 selected steps).

for i_field = 1:n_of_fields
    current_field_matrix = fields_matrices.(fields_names_tmp{i_field});
    current_step_indexes = Parameters_Step_Combinations.(fields_names_tmp{i_field}).max_Z_distance_combination;
    current_max_distance_index = Parameters_Step_Combinations.(fields_names_tmp{i_field}).max_Z_distance_index;
    if i_field > 4 && FLAG_PlotNaNs2zeros == 1
        current_field_matrix(isnan(current_field_matrix)) = 0;
    end
    current_field_matrix_s1 = current_field_matrix(:, current_step_indexes(1));
    current_field_matrix_s2 = current_field_matrix(:, current_step_indexes(2));
    current_field_matrix_s3 = current_field_matrix(:, current_step_indexes(3));
    
    i1 = 1;
    [current_cluster_distances] = compute_clusters_distance (current_field_matrix_s1, cluster_assignment, options);
    current_distance_between_clusters(:, :, i1) = current_cluster_distances.Z_distance; i1 = i1 + 1;
    [current_cluster_distances] = compute_clusters_distance (current_field_matrix_s2, cluster_assignment, options);
    current_distance_between_clusters(:, :, i1) = current_cluster_distances.Z_distance;  i1 = i1 + 1;
    [current_cluster_distances] = compute_clusters_distance (current_field_matrix_s3, cluster_assignment, options);
    current_distance_between_clusters(:, :, i1) = current_cluster_distances.Z_distance;
    
    suptitle_str = strrep((fields_names_tmp{i_field}), '_', ' ');
    title_1 = sprintf('Step %d vs Step %d.', current_step_indexes(1), current_step_indexes(2));
    title_2 = sprintf('Step %d vs Step %d.', current_step_indexes(1), current_step_indexes(3));
    title_3 = sprintf('Step %d vs Step %d.', current_step_indexes(2), current_step_indexes(3));
    title_3D = sprintf('Step %d vs Step %d vs Step %d.', current_step_indexes(1), current_step_indexes(2), current_step_indexes(3));
    title_distances = sprintf('%s\n%s', suptitle_str, title_3D);
    label_1 = sprintf('%s - Step %d', strrep((fields_names_tmp{i_field}), '_', ' '), current_step_indexes(1));
    label_2 = sprintf('%s - Step %d', strrep((fields_names_tmp{i_field}), '_', ' '), current_step_indexes(2));
    label_3 = sprintf('%s - Step %d', strrep((fields_names_tmp{i_field}), '_', ' '), current_step_indexes(3));
    axis_max = max([nanmax(current_field_matrix_s1), nanmax(current_field_matrix_s2), nanmax(current_field_matrix_s3)]);
    axis_min = min([nanmin(current_field_matrix_s1), nanmin(current_field_matrix_s2), nanmin(current_field_matrix_s3)]);
    
    Figure_FileName_tmp = sprintf('%s', suptitle_str);
    Figure_FileName_tmp2 = sprintf('%s - 3D view', suptitle_str);
    Figure_FileName_tmp3 = sprintf('%s - Z-Distances', suptitle_str);
    
    % Plot 1 - 2: scatter plots of measurements.
    if FLAG_fig1_2 == 1
        DUMMY = 1;
        while DUMMY == 1
            h_fig1 = figure();
            set(gcf,'position', get(0,'screensize'));
            
            if FLAG_3D_plots == 1
                h_fig2 = figure();
                set(gcf,'position', get(0,'screensize'));
                %         hold on;
            end
            % Plot each cluster.
            for i_cluster = 1:n_clusters
                current_cluster_indexes = find(cluster_assignment == i_cluster);
                
                if FLAG_3D_plots == 1
                    figure(h_fig2);
                    hold on;
                    h_plot = plot3(current_field_matrix_s1(current_cluster_indexes), current_field_matrix_s2(current_cluster_indexes), current_field_matrix_s3(current_cluster_indexes), 'o', 'LineWidth', Plot_LineWidth);
                    h_plot.MarkerFaceColor = h_plot.Color;
                    title(title_3D, 'FontSize', title_FontSize);
                    xlabel(label_1, 'FontSize', labels_FontSize);
                    ylabel(label_2, 'FontSize', labels_FontSize);
                    zlabel(label_3, 'FontSize', labels_FontSize);
                    axis([axis_min, axis_max, axis_min, axis_max, axis_min, axis_max]);
                    grid on; box on; axis square;
                    view(45, 45)
                end
                
                figure(h_fig1);
                subplot(subplot_raws, subplot_columns, 1);
                hold on;
                h_plot = plot(current_field_matrix_s1(current_cluster_indexes), current_field_matrix_s2(current_cluster_indexes), 'o');
                h_plot.MarkerFaceColor = h_plot.Color;
                if i_cluster == n_clusters
                    title(title_1, 'FontSize', title_FontSize);
                    xlabel(label_1, 'FontSize', labels_FontSize);
                    ylabel(label_2, 'FontSize', labels_FontSize);
                    axis([axis_min, axis_max, axis_min, axis_max]);
                    grid on; box on; axis square;
                end
                
                subplot(subplot_raws, subplot_columns, 2);
                hold on;
                h_plot = plot(current_field_matrix_s1(current_cluster_indexes), current_field_matrix_s3(current_cluster_indexes), 'o');
                h_plot.MarkerFaceColor = h_plot.Color;
                if i_cluster == n_clusters
                    title(title_2, 'FontSize', title_FontSize);
                    xlabel(label_1, 'FontSize', labels_FontSize);
                    ylabel(label_3, 'FontSize', labels_FontSize);
                    axis([axis_min, axis_max, axis_min, axis_max]);
                    grid on; box on; axis square;
                end
                
                subplot(subplot_raws, subplot_columns, 3);
                hold on;
                h_plot = plot(current_field_matrix_s2(current_cluster_indexes), current_field_matrix_s3(current_cluster_indexes), 'o');
                h_plot.MarkerFaceColor = h_plot.Color;
                if i_cluster == n_clusters
                    title(title_3, 'FontSize', title_FontSize);
                    xlabel(label_2, 'FontSize', labels_FontSize);
                    ylabel(label_3, 'FontSize', labels_FontSize);
                    axis([axis_min, axis_max, axis_min, axis_max]);
                    grid on; box on; axis square;
                end
                
            end
            figure(h_fig1);
            h_suptitle = suptitle(suptitle_str);
            h_suptitle.FontSize = suptitle_FontSize;
            
            figure(h_fig2);
            h_suptitle = suptitle(suptitle_str);
            h_suptitle.FontSize = suptitle_FontSize;
            
            figure(h_fig1);
            saveas(gcf, sprintf('%s\\%s.png', plots_folder_png, Figure_FileName_tmp))
            saveas(gcf, sprintf('%s\\%s.fig', plots_folder_fig, Figure_FileName_tmp))
            saveas(gcf, sprintf('%s\\%s.eps', plots_folder_eps, Figure_FileName_tmp))
            close gcf
            figure(h_fig2);
            saveas(gcf, sprintf('%s\\%s.png', plots_folder_png, Figure_FileName_tmp2))
            saveas(gcf, sprintf('%s\\%s.fig', plots_folder_fig, Figure_FileName_tmp2))
            saveas(gcf, sprintf('%s\\%s.eps', plots_folder_eps, Figure_FileName_tmp2))
            close gcf
            DUMMY = 0;
        end
    end
    
    % Plot 3 - Distances between clusters.
    h_fig3 = figure();
    set(gcf,'position', get(0,'screensize'));
    
    [y, z] = meshgrid(linspace(0, n_clusters, n_clusters+1));
    tmp = nanmean(y);
    halfpoint = (tmp(2) - tmp(1))./2;
    ticks_array = tmp + halfpoint;
    for Step = 1:3
        x = Step + zeros(size(z));
        % Get distances - NaNs to Zeros (to have them displayed).
        tmp = current_distance_between_clusters(:, :, Step);
        tmp(isnan(tmp)) = 0;
        
        surf(x, y, z, tmp);
        hold on;
    end
    box on; axis square; hold off
    
    caxis(colorbar_limits);
    h_colorbar = colorbar;
    h_colorbar.Label.String = 'Z-Distance between clusters.';
    h_colorbar.Label.FontSize = labels_FontSize;
    
    % Fix Ticks & Labels.
    xlim([1 3])
    xticks(1:1:dimentions);
    xticklabels({sprintf('+%d', current_step_indexes(1)*40), sprintf('+%d', current_step_indexes(2)*40), sprintf('+%d', current_step_indexes(3)*40)});
    yticks(ticks_array)
    if n_clusters == 10
        yticklabels({'1','2','3','4','5','6','7', '8', '9', '10'})
    elseif n_clusters == 11
        yticklabels({'1','2','3','4','5','6','7', '8', '9', '10', '11'})
    end
    zticks(ticks_array)
    if n_clusters == 10
        zticklabels({'1','2','3','4','5','6','7', '8', '9', '10'})
    elseif n_clusters == 11
        zticklabels({'1','2','3','4','5','6','7', '8', '9', '10', '11'})
    end
    xlabel('Current step (pA)', 'FontSize', labels_FontSize)
    ylabel('Cluster ID', 'FontSize', labels_FontSize)
    zlabel('Cluster ID', 'FontSize', labels_FontSize)
    title(title_distances, 'FontSize', title_FontSize)
    ylim([0 n_clusters])
    zlim([0 n_clusters])
    figure(h_fig3);
    saveas(gcf, sprintf('%s\\%s.png', plots_folder_png, Figure_FileName_tmp3))
    saveas(gcf, sprintf('%s\\%s.fig', plots_folder_fig, Figure_FileName_tmp3))
    saveas(gcf, sprintf('%s\\%s.eps', plots_folder_eps, Figure_FileName_tmp3))
    close gcf
end


