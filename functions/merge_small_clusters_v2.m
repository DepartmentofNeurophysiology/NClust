function [configs, probability_cluster_assignment, cluster_assignments, min_elements_number, cluster_assignments_evolution] = merge_small_clusters_v2 (DataMatrix_clust, cluster_results, main_figures_dir, options)
% This function works as follows:
% 1) assigns every cell that was not considered in the clustering 
% (because of NaN values) to a single-cell cluster.
% 2) Searches for every cluster that has N cells < K.
% 3) Dismembers the marked clusters, assigning every cell from these ones
% to the cluster that is closest to them (the distance computed as 
% Z-distance)
% 4) Step 3 is repeated for N = N cluster times, each time starting from a
% different cluster.
% 5) The probability for each cell to be part of cluster X (probablility 
% on the starting cluster permutations for the merging) is computed.
% 6) Two clustering configurations are chosen: the existing clustering that
% is output from the merging and that whose most stable for cell assignment
% variation, and a maximum likelihood cluster, built assigning each cell
% to the cluster they are most likely to be part of (the probability is 
% still given by the merging).


% Options
min_cluster_elements = options.min_cluster_elements;
number_of_repetitions = options.number_of_mergings_repetitions;
FLAG_verbose = options.FLAG_verbose_mergings;

% Initialize
rng default
% if isfield(cluster_results, 'cluster_centroids_coord')
%   [number_of_clusters, number_of_parameters] = size(cluster_results.cluster_centroids_coord);
% else
    number_of_clusters = max(cluster_results.exp_tags);
    [~, number_of_parameters] = size(DataMatrix_clust);
% end
number_of_experiments = numel(cluster_results.exp_tags);
new_exp_tags = cluster_results.exp_tags;
new_exp_tags_tmp_1 = cluster_results.exp_tags;


%% Add NaN tagged experiments to new singleton clusters.
NaNs_exps_number = numel(find(isnan(cluster_results.exp_tags)));
NaNs_exp_indexes = find(isnan(cluster_results.exp_tags));

% Add NaN experiments as new clusters.
for i_NaN = 1:NaNs_exps_number
    new_exp_tags_tmp_1(NaNs_exp_indexes(i_NaN)) = number_of_clusters + i_NaN;
end
number_of_clusters = number_of_clusters + NaNs_exps_number;


%% Merge small clusters.
% number_of_repetitions = number_of_clusters;
new_exp_tags = cell(1, number_of_repetitions);
cluster_start_memory = NaN(1, number_of_repetitions);

number_of_samples = 3;
random_sample = NaN(1, number_of_repetitions);
for i_assignment_sample = 1:number_of_samples
    random_sample(1, i_assignment_sample) = randi([1, number_of_repetitions]);
end
random_sample = sort(random_sample);
i_assignment_sample = 1;
cluster_assignments_evolution = cell(1, number_of_samples);

% Initializing waitbar.
prog_bar = waitbar(0, 'Cylon virus detected!', 'Name', 'Merging Clusters...',...
    'CreateCancelBtn',...
    'setappdata(gcbf,''canceling'',1)');
% setappdata(prog_bar, 'canceling', 0);

tic
for i_rep = 1:number_of_repetitions
    % Get a new start each time.
    FLAG_small_clusters = 1;
    new_exp_tags_tmp = new_exp_tags_tmp_1;
%     cluster_start = randi([1, number_of_clusters]);
    cluster_start = i_rep;
    i_iter = 1;
%     fprintf('--->>> Starting from cluster #%d\n\n', cluster_start);
    while FLAG_small_clusters == 1 % Repeat till there are only clusters with at least N elements.
        % Select a new random cluster.
        i_cluster_1 = randi([1, number_of_clusters]);
        % Check that the cluster is not empty.
        if isempty(new_exp_tags_tmp(new_exp_tags_tmp == i_cluster_1)) % Select a new cluster, as this one is empty.
           continue 
        end
        
        % Check if cluster is small and to be removed.
        cluster_1_elements = find(new_exp_tags_tmp == i_cluster_1);
        number_of_elements = numel(cluster_1_elements);
        if number_of_elements < min_cluster_elements && number_of_elements > 0
            new_exp_tags_tmp = merge_1_cluster (i_cluster_1, DataMatrix_clust, new_exp_tags_tmp, number_of_clusters, min_cluster_elements, FLAG_verbose);
            if i_rep == random_sample(i_assignment_sample)
                cluster_assignments_evolution{i_iter, i_assignment_sample} = new_exp_tags_tmp;
                i_assignment_sample = i_assignment_sample + 1;
            end
        end
        
        % Check that every cluster now has at least N elements.
        cluster_number_of_elements = zeros(1, number_of_clusters);
        FLAG_small_clusters = 0;
        for i_cluster = 1:number_of_clusters
            cluster_number_of_elements(i_cluster) = numel(find(new_exp_tags_tmp == i_cluster));
            if cluster_number_of_elements(i_cluster) < min_cluster_elements && cluster_number_of_elements(i_cluster) > 0
                if FLAG_verbose == 1
                    fprintf('More small clusters to remove, iterating...\n');
                end
                FLAG_small_clusters = 1;
            else
                
            end
        end
        i_iter = i_iter + 1;
    end
    if FLAG_verbose == 1
        fprintf('No more small clusters to remove.\n');
    end
    new_exp_tags{i_rep} = new_exp_tags_tmp; % Save the merged cluster config.
    cluster_start_memory(1, i_rep) = cluster_start;
    
    % Update waitbar
    waitbar(i_rep/number_of_repetitions, prog_bar, sprintf('Mergings Realization #%d / %d', i_rep, number_of_repetitions));
    if getappdata(prog_bar, 'canceling')
        delete(prog_bar);
        warning('Operation cancelled by user.');
        return
    end
    
end

delete(prog_bar);
computation_time = toc;
time_comp_hour = floor(computation_time/(60*60));
time_comp_m = floor( (computation_time - time_comp_hour*(60*60)) /60);
time_comp_s = floor(rem( (computation_time - time_comp_hour*(60*60)), 60));
fprintf('\nTime elapsed: %dh:%dm:%ds.\n', time_comp_hour, time_comp_m, time_comp_s);       


%% Clustering Statistics.
% Build merging_config x experiments matrix.
configs = NaN(number_of_repetitions, number_of_experiments);
for i_config = 1:number_of_repetitions
    configs(i_config, :) = new_exp_tags{i_config};
end

% Probability of each element of being assigned to cluster X
probability_cluster_assignment = NaN(number_of_clusters, number_of_experiments);
for i_exp = 1:number_of_experiments
    current_exp = configs(:, i_exp);
    for i_cluster = 1:number_of_clusters
        probability_cluster_assignment(i_cluster, i_exp) = nansum(numel(current_exp(current_exp == i_cluster)))./number_of_repetitions;
    end
end
cluster_relevancy = nansum(probability_cluster_assignment, 2);
number_of_relevant_clusters = numel(find(cluster_relevancy > 0));

% Maximal probability for each cell.
probability_max = NaN(1, number_of_experiments);
probability_max_cluster = NaN(1, number_of_experiments);
for i_exp = 1:number_of_experiments
    current_exp = probability_cluster_assignment(:, i_exp);
    current_exp(current_exp == 0) = NaN;
    [probability_max(1, i_exp), probability_max_cluster(1, i_exp)] = nanmax(current_exp);
end

% Probability variance per cell.
probability_std = NaN(1, number_of_experiments);
for i_exp = 1:number_of_experiments
    current_exp = probability_cluster_assignment(:, i_exp);
    current_exp(current_exp == 0) = NaN;
    probability_std(1, i_exp) = nanstd(current_exp);
end

% Probability distribution per cluster, ordered.
probability_cluster_assignment_ordered = sort(probability_cluster_assignment, 2, 'descend');
for i_cluster = 1:number_of_clusters
    current_cluster_probability = probability_cluster_assignment_ordered(i_cluster, :);
    current_cluster_probability_ordered = sort(current_cluster_probability, 'descend');
end

% Compute Same assignment occurrences.
same_assignment = NaN(number_of_repetitions, number_of_repetitions);
for i_rep_1 = 1:number_of_repetitions
    current_cluster_tags_1 = configs(i_rep_1, :);
    for i_rep_2 = 1:number_of_repetitions
       if i_rep_1 == i_rep_2
           continue
       end
        current_cluster_tags_2 = configs(i_rep_2, :);
        same_assignment(i_rep_1, i_rep_2) = numel(find(current_cluster_tags_1 == current_cluster_tags_2) == 1);
        
    end
end
average_same_assignment = nanmean(same_assignment, 2);

% Test assigning cells to the cluster where they belong most of the times.
cluster_assignment_maximum_likelihood = probability_max_cluster;

% Test using the realized set of clusters that is most stable (median) 
% "Most stable" means that is has the most common cell assignments.
% (Ignore clusters# > 50, as they are artificially made for the NaN cells)
[max_stability, cluster_most_stable] = nanmax(average_same_assignment(1:50));
cluster_assignment_most_stable = configs(cluster_most_stable, :);

cluster_assignments.MaxLikelihood = cluster_assignment_maximum_likelihood;
cluster_assignments.MostStable = cluster_assignment_most_stable;

% Get minimum number of elements in a cluster.
number_of_elements_in_cluster = zeros(1, max(cluster_assignment_maximum_likelihood));
for i_cluster = 1:max(cluster_assignment_maximum_likelihood)
    number_of_elements_in_cluster(i_cluster) = numel(find(cluster_assignment_maximum_likelihood == i_cluster));
end
number_of_elements_in_cluster(number_of_elements_in_cluster == 0) = NaN;
min_elements_number = nanmin(number_of_elements_in_cluster);


%% Plots
Title_FontSize = 18;
Labels_FontSize = 12;
% Plot Probability of Cluster Assignment per cell.
probability_cluster_assignment_tmp = probability_cluster_assignment;
probability_cluster_assignment_tmp(probability_cluster_assignment_tmp < 0.05) = NaN;
tmp = nansum(probability_cluster_assignment_tmp, 2);
tmp(tmp > 0) = 1;
tmp = ~tmp;
probability_cluster_assignment_tmp(tmp, :) = [];
figure();
set(gcf,'position', get(0,'screensize'));

imAlpha = ones(size(probability_cluster_assignment_tmp));
imAlpha(isnan(probability_cluster_assignment_tmp))=0;
imagesc(probability_cluster_assignment_tmp, 'AlphaData', imAlpha);
set(gca,'color', [0, 0, 0]);
% pcolor(probability_cluster_assignment_tmp);
colorbar;
title('Probability of Cluster assignment per cell.', 'FontSize', Title_FontSize)
xlabel('Cell', 'FontSize', Labels_FontSize)
ylabel('Cluster #', 'FontSize', Labels_FontSize)

filename_tmp = sprintf('%s\\Probability of Cluster assignment per cell', main_figures_dir);
if exist(sprintf('%s.png', filename_tmp), 'file') ~= 0
    saveas(gcf, sprintf('%s_new.png', filename_tmp));
    saveas(gcf, sprintf('%s_new.fig', filename_tmp));
    saveas(gcf, sprintf('%s_new.eps', filename_tmp));
else
    saveas(gcf, sprintf('%s.png', filename_tmp));
    saveas(gcf, sprintf('%s.fig', filename_tmp));
    saveas(gcf, sprintf('%s.eps', filename_tmp));
end

% Plot.
figure();
set(gcf,'position', get(0,'screensize'));

probability_cluster_assignment_tmp = probability_cluster_assignment_ordered;
probability_cluster_assignment_tmp(probability_cluster_assignment_tmp < 0.05) = NaN;
tmp = nansum(probability_cluster_assignment_tmp, 2);
tmp(tmp > 0) = 1;
tmp = ~tmp;
probability_cluster_assignment_tmp(tmp, :) = [];

% probability_cluster_assignment_ordered(probability_cluster_assignment_ordered == 0) = NaN;
[dim1, dim2] = size(probability_cluster_assignment_tmp);
tmp2 = NaN(dim1 + 1, dim2 + 1);
tmp2(1:dim1, 1:dim2) = probability_cluster_assignment_tmp;
pcolor(tmp2);
set(gca,'color',[0 0 0])
set(gca,'Ydir','reverse')
halfwidth = 0.5;
ticks_pos = halfwidth:1:dim1;
% set(gca, 'xTick', ticks_pos);
% set(gca, 'xTickLabel', ticks_pos-halfwidth);
set(gca, 'yTick', ticks_pos);
set(gca, 'yTickLabel', ticks_pos-halfwidth);

colorbar;
title('Probability of Cluster assignment ordered.', 'FontSize', Title_FontSize)
xlabel('Cell #', 'FontSize', Labels_FontSize)
ylabel('Cluster #', 'FontSize', Labels_FontSize)


filename_tmp = sprintf('%s\\Probability of Cluster assignment per cell - Ordered', main_figures_dir);
if exist(sprintf('%s.png', filename_tmp), 'file') ~= 0
    saveas(gcf, sprintf('%s_new.png', filename_tmp));
    saveas(gcf, sprintf('%s_new.fig', filename_tmp));
    saveas(gcf, sprintf('%s_new.eps', filename_tmp));
else
    saveas(gcf, sprintf('%s.png', filename_tmp));
    saveas(gcf, sprintf('%s.fig', filename_tmp));
    saveas(gcf, sprintf('%s.eps', filename_tmp));
end

% Plot Various
figure();
set(gcf,'position', get(0,'screensize'));
subplot(3, 1, 1)
str_tmp = sprintf('Clusters - Number of relevant clusters = %d.', number_of_relevant_clusters);
bar(cluster_relevancy)
xticks(0:5:80);
box on; grid on; grid minor;
title('Sum of the probabilities of cells to belong to a cluster - "Cluster Relevancy"')
xlabel(str_tmp)
ylabel('Sum of probabilities')

subplot(3, 1, 2)
bar(probability_max);
box on; grid on; grid minor;
axis([-inf, inf, -inf, inf])
title('Max probability for a cell to be assigned to a specific cluster.')
xlabel('Cell')
ylabel('Max Probability.')

subplot(3, 1, 3)
bar(probability_std);
box on; grid on; grid minor;
axis([-inf, inf, -inf, inf])
title('Variance in the probability of assignment of a cell between different clusters.')
xlabel('Cell')
ylabel('Probability Standard Deviation.')


filename_tmp = sprintf('%s\\Probability of assignment - stats', main_figures_dir);
if exist(sprintf('%s.png', filename_tmp), 'file') ~= 0
    saveas(gcf, sprintf('%s_new.png', filename_tmp));
    saveas(gcf, sprintf('%s_new.fig', filename_tmp));
    saveas(gcf, sprintf('%s_new.eps', filename_tmp));
else
    saveas(gcf, sprintf('%s.png', filename_tmp));
    saveas(gcf, sprintf('%s.fig', filename_tmp));
    saveas(gcf, sprintf('%s.eps', filename_tmp));
end

% % Plot Cluster stability over merging .
% figure();
% set(gcf,'position', get(0,'screensize'));
% subplot(2, 1, 1)
% pcolor(same_assignment)
% colorbar
% box on; axis square
% title('Number of cells whose tag does not change between cluster assignments.')
% xlabel('Clusters')
% ylabel('Clusters')
% 
% subplot(2, 1, 2)
% plot(average_same_assignment, 'LineWidth', 2)
% box on; grid on; grid minor;
% title('Average number of cells whose tag does not change between cluster assignments.')
% xlabel('Clusters')
% ylabel('Avg number of cells not changing cluster tag between two merging repetitions.')
% suptitle('Stability of clusters over merging randomization.')
% 
% filename_tmp = sprintf('%s\\Stability of clusters over merging randomization', main_figures_dir);
% if exist(sprintf('%s.png', filename_tmp), 'file') ~= 0
%     saveas(gcf, sprintf('%s_new.png', filename_tmp));
%     saveas(gcf, sprintf('%s_new.fig', filename_tmp));
%     saveas(gcf, sprintf('%s_new.eps', filename_tmp));
% else
%     saveas(gcf, sprintf('%s.png', filename_tmp));
%     saveas(gcf, sprintf('%s.fig', filename_tmp));
%     saveas(gcf, sprintf('%s.eps', filename_tmp));
% end

% Compare cluster assignments.
figure();
set(gcf,'position', get(0,'screensize'));

subplot(1, 2, 1)
hist_edges = [0.5:1:80.5];
histogram(cluster_assignments.MaxLikelihood, hist_edges);
box on; grid on;
title('Cells assigned to the cluster with the maximal probability of having them.', 'FontSize', Title_FontSize)
xlabel('Clusters.', 'FontSize', Labels_FontSize)
ylabel('Number of cells assigned to that cluster.', 'FontSize', Labels_FontSize)
axis([0, 70, 0, 60]);

subplot(1, 2, 2)
histogram(cluster_assignments.MostStable, hist_edges);
box on; grid on;
title('Cells assigned to the most stable existing clustering configuration.', 'FontSize', Title_FontSize)
xlabel('Clusters.', 'FontSize', Labels_FontSize)
ylabel('Number of cells assigned to that cluster.', 'FontSize', Labels_FontSize)
axis([0, 70, 0, 60]);

filename_tmp = sprintf('%s\\Cluster Assignments Comparison', main_figures_dir);
if exist(sprintf('%s.png', filename_tmp), 'file') ~= 0
    saveas(gcf, sprintf('%s_new.png', filename_tmp));
    saveas(gcf, sprintf('%s_new.fig', filename_tmp));
    saveas(gcf, sprintf('%s_new.eps', filename_tmp));
else
    saveas(gcf, sprintf('%s.png', filename_tmp));
    saveas(gcf, sprintf('%s.fig', filename_tmp));
    saveas(gcf, sprintf('%s.eps', filename_tmp));
end


%% Find repeated configurations
% configs = NaN(number_of_clusters, number_of_experiments);
% degree_of_equality = NaN(number_of_repetitions, number_of_repetitions);
% for i_cluster_start = 1:number_of_clusters
%     % Get all the configurations that originated by merging from this 
%     % cluster.
%     cluster_start_indexes = find(cluster_start_memory == i_cluster_start);
%     % Check that the configurations that start merging from the same
%     % cluster are the same.
%     FLAGs_control_fail = zeros(1, numel(cluster_start_indexes));
%     FLAG_control_fail = 0;
%     for i_rep = 1:numel(cluster_start_indexes)-1
%         if isempty(i_rep)
%             FLAG_control_fail = 0;
%         else
%             current_config_1 = new_exp_tags{cluster_start_indexes(i_rep)};
%             current_config_2 = new_exp_tags{cluster_start_indexes(i_rep + 1)};
%             control_array = NaN(1, number_of_experiments);
%             for i_element = 1:number_of_experiments
%                 control_array(i_element) = current_config_1(i_element) == current_config_2(i_element);
%             end
%             
%             if numel(find(control_array == 0)) == 1
%                 FLAGs_control_fail = 1;
%             end
%         end
%     end
%     if numel(find(control_array == 1)) == 1
%         FLAG_control_fail = 1;
%     end
%         
%     if FLAG_control_fail == 0 && ~isempty(i_rep)
%         configs(i_cluster_start, :) = new_exp_tags{cluster_start_indexes(1)};
%     end
% end
    






end
