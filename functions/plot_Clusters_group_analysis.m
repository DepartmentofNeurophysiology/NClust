function [Cluster_Data, Cluster_Data_plot] = plot_Clusters_group_analysis (Clusters)

% Initialize.

% Get field names.
fields_names_tmp = fieldnames(Clusters(1).experiments(1).CC_Data_Means);
n_of_fields = numel(fields_names_tmp);
n_of_clusters = numel(Clusters);
n_of_current_injections = numel(Clusters(1).experiments(1).CC_Data_Means.CurrentInjected);

% Take raw measurements from single cells, and arrange them per cluster 
% and per measurement type.
for i_cluster = 1:n_of_clusters
    current_cluster = Clusters(i_cluster);
    number_of_cells_in_clusters = numel(current_cluster.experiments);
    fprintf('Checking Cluster #%d, with #%d cells.\n', i_cluster, number_of_cells_in_clusters);
    if number_of_cells_in_clusters == 0
        Cluster_Data(i_cluster).DataAll = [];
        Cluster_Data(i_cluster).Mean = [];
        Cluster_Data(i_cluster).Std = [];
        continue
    end
    for i_cell = 1:number_of_cells_in_clusters
        current_cell = current_cluster.experiments(i_cell);
        current_cell_data = current_cell.CC_Data_Means;

        for i_field = 1:n_of_fields
            current_field = current_cell_data.(fields_names_tmp{i_field});
            cluster_data_tmp(i_cell, :).(fields_names_tmp{i_field}) = current_field;
        end
    end
    
    Cluster_Data(i_cluster).DataAll = cluster_data_tmp;
    for i_field = 1:n_of_fields

        tmp = [cluster_data_tmp.(fields_names_tmp{i_field})];
        tmp2 = (reshape(tmp, [n_of_current_injections, number_of_cells_in_clusters]))';
        Cluster_Data(i_cluster).Mean.(fields_names_tmp{i_field}) = nanmean(tmp2, 1);
        Cluster_Data(i_cluster).Std.(fields_names_tmp{i_field}) = nanstd(tmp2, 0, 1);
        Cluster_Data(i_cluster).SE.(fields_names_tmp{i_field}) = nanstd(tmp2, 0, 1)./sqrt(number_of_cells_in_clusters);
    end
    clear tmp; clear tmp2; clear cluster_data_tmp;
end


tmp_index = ~cellfun('isempty', {Cluster_Data.DataAll});
Cluster_Data_plot = Cluster_Data(tmp_index);
number_of_clusters_plot = numel(Cluster_Data_plot);


%% Plots variables.
subplot_raws = 2;
subplot_columns = 5;
color_cluster{1} = [0 0 1];
color_cluster{2} = [0 1 1];
color_cluster{3} = [1 0 0];
color_cluster{4} = [1 0 1];
color_cluster{5} = [1 1 0];
color_cluster{6} = [0.7 0.7 0.7];
color_cluster{7} = [0 0.5 0.5];
color_cluster{8} = [0.5 0.5 0];
color_cluster{9} = [0.5 0 0.5];
color_cluster{10} = [0.7 0.2 0.5];
color_cluster{11} = [0.2 0.7 0.5];
color_cluster{12} = [0.7 0.7 0.2];
color_cluster{13} = [0.5 0.5 0];

title_FontSize = 18;
labels_FontSize = 13;
plot_LineWidth = 1.5;
FLAG_errorbar = 1;


%% Plot in 70/10 = 7 separate figures.
n_figures = 7;
for i_fig = 1:n_figures
    Figure_FileName_tmp = sprintf('Cluster Group Analysis - Fig%d', i_fig);
    h_fig = figure();
    set(gcf,'position', get(0,'screensize'));
    i_subplot = 1;
    for i_field = ((subplot_raws*subplot_columns)*(i_fig-1))+1:(subplot_raws*subplot_columns)*i_fig
        current_title_str = strrep((fields_names_tmp{i_field}), '_', ' ');
        
        subplot(subplot_raws, subplot_columns, i_subplot)
        hold on; box on; grid on;
        for i_cluster = 1:number_of_clusters_plot
            if FLAG_errorbar == 1
                
                errorbar(Cluster_Data_plot(i_cluster).Mean.(fields_names_tmp{i_field}), Cluster_Data_plot(i_cluster).SE.(fields_names_tmp{i_field}), 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
            else
                plot(Cluster_Data_plot(i_cluster).Mean.(fields_names_tmp{i_field}), '-o', 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
            end
        end
        i_subplot = i_subplot + 1;
        axis([1, n_of_current_injections, -inf, inf])
        title(current_title_str, 'FontSize', title_FontSize)
        xlabel('Current Step', 'FontSize', labels_FontSize)
        xticklabels({'+80', '+160', '+240', '+320', '+400'});
    end
    saveas(gcf, sprintf('%s.png', Figure_FileName_tmp))
    saveas(gcf, sprintf('%s.fig', Figure_FileName_tmp))
    saveas(gcf, sprintf('%s.eps', Figure_FileName_tmp))
    close gcf
end



% % AP Count
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.APcount, Cluster_Data_plot(i_cluster).Std.APcount, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.APcount, '-o', 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('AP count')
% 
% % FR abs
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.FR_abs, Cluster_Data_plot(i_cluster).Std.FR_abs, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.FR_abs, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('FR abs')
% 
% % FR ins
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.FR_ins, Cluster_Data_plot(i_cluster).Std.FR_ins, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.FR_ins, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('FR ins')
% 
% % AP_lat_first
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.AP_lat_first, Cluster_Data_plot(i_cluster).Std.AP_lat_first, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.AP_lat_first, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('AP lat first')
% 
% % AP_lat_last
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.AP_lat_last, Cluster_Data_plot(i_cluster).Std.AP_lat_last, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.AP_lat_last, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('AP lat last')
% 
% % AP_lat_window
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.AP_lat_window, Cluster_Data_plot(i_cluster).Std.AP_lat_window, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.AP_lat_window, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('AP lat window')
% 
% % AP_lat_compression
% subplot(subplot_raws, subplot_columns, i_subplot)
% hold on; box on; grid on;
% for i_cluster = 1:number_of_clusters_plot
%     if FLAG_errorbar == 1
%         errorbar(Cluster_Data_plot(i_cluster).Mean.AP_lat_compression, Cluster_Data_plot(i_cluster).Std.AP_lat_compression, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     else
%         plot(Cluster_Data_plot(i_cluster).Mean.AP_lat_compression, 'Color', color_cluster{i_cluster}, 'LineWidth', plot_LineWidth);
%     end
% end
% i_subplot = i_subplot + 1;
% axis([1, n_of_current_injections, -inf, inf])
% title('AP lat compression')
