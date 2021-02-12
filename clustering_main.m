% Main Clustering Script.
rng default

% Options.
FLAG_plot_DataAverages = 0;
options.Kmeans_distance_metric = 'cityblock'; % 'cityblock', 'sqeuclidean' (cityblock is L1, results in centroid being median)
options.FLAG_deMean_deSts = 1; % Set data mean and std to 1? 
options.FLAG_verbose_mergings = 0; % Turn on for more more spam in the command window (debug utility)
options.correlation_threshold = 0.55; % Minimum correlation
options.min_cluster_elements = 10;
options.n_of_k_means_iterations = 25000;
options.number_of_mergings_repetitions = 10000;

% Initialize Folder Structure.
main_dir = pwd;
addpath(genpath(main_dir));
main_data_dir = sprintf('%s\\Data\\Analyzed', main_dir);
main_figures_dir = sprintf('%s\\Figures', main_dir);
if exist(main_data_dir, 7) == 0
    main_data_dir = uigetdir(main_dir, 'Select the folder containing the data.');
end
if exist(main_figures_dir, 7) == 0
    mkdir(main_figures_dir);
    addpath(genpath(main_dir));
end


%% Load Data and Initialize DataMatrix.
% Load CC Step Data.
experiments_tmp.CCStep = load_CC_data (main_data_dir);

% Load Sawtooth Data.
experiments_tmp.ST = load_ST_data(main_data_dir); % Unused atm

% Load VC Step Data.
experiments_tmp.VCStep = load_VC_data(main_data_dir); % Unused atm


% Match data coming from different protocols but same experiment.
experiments = group_protocols (experiments_tmp);
number_of_CCexperiments = numel(experiments);

% Get average, max & min between all cells.
FLAG_normalize = 0;
[DataSet_Projections.Averages, DataSet_Projections.Stds] = get_whole_dataset_average (experiments, FLAG_normalize);
[DataSet_Projections.Max] = get_whole_dataset_max (experiments, FLAG_normalize);
[DataSet_Projections.Min] = get_whole_dataset_min (experiments, FLAG_normalize);

% Decide the best fit based on the total average.
[WholeDataAvg_BestFit, FitTypes] = fit_DataSet_Averages (DataSet_Projections, number_of_CCexperiments);
if FLAG_plot_DataAverages == 1
    Plot_DataAverages (DataSet_Projections.Averages, DataSet_Projections.Stds, FLAG_normalize);
end

% Fit Every Experiment.
[Fits, Fit_Constants, Goodness_of_Fits] = fit_CCall(experiments, FitTypes);

% Build Data Matrix.
DataMatrix = make_DataMatrix (experiments, Fit_Constants, FitTypes);

% Parameters Translation cell array for CC data.
parameters_all = param_to_number_correspondance;


%% Check Parameters Relevancy.
% Set DataMatrix parameters to mean = 0, std = 1?
if options.FLAG_deMean_deSts == 1 
    DataMatrix_mean0std1 = set_mean0std1 (DataMatrix);
else
    DataMatrix_mean0std1 = DataMatrix;
end

% Check Covariance Matrix
DataCovariance = cov(DataMatrix_mean0std1, 'includenan');

% Check Relevant Parameters
[parameters_correlation_matrix, parameters_correlation_matrix_ABS, correlation_pairs, correlation_pairs_unique, correlation_pairs_unique_names, uncorrelated_parameters, counter_corr_pars] = compute_parameters_correlations (DataMatrix_mean0std1, options);

corr_threshold = plot_correlations_distribution (parameters_correlation_matrix_ABS);
options.correlation_threshold = corr_threshold;
[parameters_correlation_matrix, parameters_correlation_matrix_ABS, correlation_pairs, correlation_pairs_unique, correlation_pairs_unique_names, uncorrelated_parameters, counter_corr_pars] = compute_parameters_correlations (DataMatrix_mean0std1, options);

% Binary Correlation Matrix
correlation_matrix_binary = find_corr_pairs (correlation_pairs_unique);

% Find smallest, least correlated parameters set.
Output_Param_Set = find_corr_best_set(correlation_matrix_binary, parameters_all);
surviving_param_label = [Output_Param_Set.ParamIndex]';
surviving_param_names = parameters_all(surviving_param_label);
DataMatrix_Relevant = DataMatrix(:, [Output_Param_Set.ParamIndex]);
DataMatrix_Relevant_mean0std1 = set_mean0std1 (DataMatrix_Relevant);
n_noncorr_parameters = numel(surviving_param_label);


%% Clustering.
% Cluster.
DataMatrix_clustering = DataMatrix;
DataMatrix_clustering = set_mean0std1 (DataMatrix_clustering);

[cluster_results, DataMatrix_clustering] = cluster_datamatrix (DataMatrix_clustering, options);

% cluster_results = cluster_results_original;
cluster_results_original = cluster_results;
min_elements_number = 0;
i_mergings_iteration = 1;
mergings_info = struct;
while min_elements_number < 10
    
    % Merge Small Clusters together.
    figures_output_dir = sprintf('%s\\Mergings Iteration %d', main_figures_dir, i_mergings_iteration);
    if exist(figures_output_dir) == 0
        mkdir(figures_output_dir)
        addpath(genpath(figures_output_dir));
    end
    
    [configs, probability_cluster_assignment, cluster_assignments, min_elements_number, cluster_assignments_evolution] = merge_small_clusters_v2 (DataMatrix_clustering, cluster_results, figures_output_dir, options);
    
    % Rename Clusters to exclude non-existing labels.
    [cluster_assignments_new.MostStable, cluster_assignments_new.MaxLikelihood] = rename_clusters (cluster_assignments.MostStable, cluster_assignments.MaxLikelihood);
    
    cluster_results.exp_tags = cluster_assignments_new.MaxLikelihood;
    
    fprintf('Merging iteration %g.\nSmallest Cluster has %d elements.\n\n', i_mergings_iteration, min_elements_number);
    
    mergings_info(i_mergings_iteration).probability_cluster_assignment = probability_cluster_assignment;
    mergings_info(i_mergings_iteration).cluster_assignments = cluster_assignments;
    mergings_info(i_mergings_iteration).min_elements_number = min_elements_number;
    mergings_info(i_mergings_iteration).configs = configs;
    mergings_info(i_mergings_iteration).cluster_assignments_evolution_samples = cluster_assignments_evolution;
    mergings_info(i_mergings_iteration).MaxLikelihood_assignment = cluster_assignments_new.MaxLikelihood;
    mergings_info(i_mergings_iteration).MostStable_assignment = cluster_assignments_new.MostStable;
    
    i_mergings_iteration = i_mergings_iteration + 1;
end


%% Compute Cluster Distances.
% Most Stable Cluster.
[cluster_distances.MostStable] = compute_clusters_distance (DataMatrix_clustering, cluster_assignments_new.MostStable, options);

% Maximum Likelihood Cluster.
[cluster_distances.MaxLikelihood] = compute_clusters_distance (DataMatrix_clustering, cluster_assignments_new.MaxLikelihood, options);

% Plot Distances Between Clusters.
plot_clusters_distances (cluster_distances, main_figures_dir);

% Compute Distances along single Parameters.
[cluster_projection_distances, clusters_projection_mean, clusters_projection_std, clusters_projection_ttest] = compute_distance_on_single_param (DataMatrix_clustering, cluster_assignments_new.MaxLikelihood, options);
% Plot Distances along single Parameters.
number_of_projection_parameters = 1;
plot_projection_distances (cluster_projection_distances, surviving_param_names, number_of_projection_parameters)

% Compute Distances along 2 Parameters.
[cluster_projection_distances_2param] = compute_distance_on_2_param (DataMatrix_clustering, cluster_assignments_new.MaxLikelihood, options);
% Plot Distances along single Parameters.
plot_projection_distances_2_param (cluster_projection_distances_2param, surviving_param_names)


%% Best Combination of 5 parameters.
% Compute distance along every combination of 5 parameters.
[Distance_Param_Combinations, best_100_combinations] = compute_distance_on_N_param(DataMatrix_Relevant_mean0std1, cluster_assignments_new.MaxLikelihood, options);
OutputFileName = 'Combinations of 5 param - Distances between Clusters';
comb_matrix_ranked = plot_projection_distances_N_param(Distance_Param_Combinations, best_100_combinations, surviving_param_names, OutputFileName);

% Compute distance along every combination of 5 parameters - shuffling the clustering assignmets.
[DataMatrix_Shuffled_Cells, ~, ~] = shuffle_DataMatrix(DataMatrix_Relevant_mean0std1);
[Distance_Param_Combinations_Shuffled, best_100_combinations_Shuffled] = compute_distance_on_N_param(DataMatrix_Shuffled_Cells, cluster_assignments_new.MaxLikelihood, options);
OutputFileName = 'Combinations of 5 param - Distances between Clusters - Shuffled Cells';
comb_matrix_ranked_shuffled = plot_projection_distances_N_param(Distance_Param_Combinations_Shuffled, best_100_combinations_Shuffled, surviving_param_names, OutputFileName);

% Plot best combination.
OutputFileName = 'Combinations of 5 param - Distances';
comb_matrix_ranked = plot_projection_distances_N_param(Distance_Param_Combinations, best_100_combinations, surviving_param_names, OutputFileName, comb_matrix_ranked);
[max_tmp, max_index_tmp] = nanmax([Distance_Param_Combinations.Z_distance_mean]);
best_5_param_comb = Distance_Param_Combinations(max_index_tmp).Combination;
best_5_param_comb = surviving_param_label(best_5_param_comb);
best_5_param_comb_names = parameters_all(best_5_param_comb);
DataMatrix_Relevant_5TopOnly = DataMatrix(:, best_5_param_comb);
DataMatrix_Relevant_mean0std1_5TopOnly = set_mean0std1(DataMatrix_Relevant_5TopOnly);


%% Final Cluster Assignment.
cluster_assignment_final_139_merged = compute_multiple_clusterings (DataMatrix_mean0std1, options);
cluster_assignment_final_35_merged = compute_multiple_clusterings (DataMatrix_Relevant_mean0std1, options);
cluster_assignment_final_5_merged = compute_multiple_clusterings (DataMatrix_Relevant_mean0std1_5TopOnly, options);
% Rename clusters (remove empty ones, squeeze cluster tags towards zero)
[cluster_assignment_final_139.k_means, ~] = rename_clusters (cluster_assignment_final_139_merged.k_means);
[cluster_assignment_final_139.linkage_euclidean_ward, ~] = rename_clusters (cluster_assignment_final_139_merged.linkage_euclidean_ward);
[cluster_assignment_final_35.k_means, ~] = rename_clusters (cluster_assignment_final_35_merged.k_means);
[cluster_assignment_final_35.linkage_euclidean_ward, ~] = rename_clusters (cluster_assignment_final_35_merged.linkage_euclidean_ward);
[cluster_assignment_final_5.k_means, ~] = rename_clusters (cluster_assignment_final_5_merged.k_means);
[cluster_assignment_final_5.linkage_euclidean_ward, ~] = rename_clusters (cluster_assignment_final_5_merged.linkage_euclidean_ward);

% Compute Distances between different Cluster Assignments.
assignment_names{1, 1} = '139 Param'; assignment_names{1, 2} = sprintf('%d Param', n_noncorr_parameters);
between_assignments_cluster_distances.c139_c35 = compute_distance_between_cluster_assignments (DataMatrix_mean0std1, cluster_assignment_final_139.k_means, cluster_assignment_final_35.k_means, assignment_names);
assignment_names{1, 1} = '139 Param'; assignment_names{1, 2} = '5 Param';
between_assignments_cluster_distances.c139_c5 = compute_distance_between_cluster_assignments (DataMatrix_mean0std1, cluster_assignment_final_139.k_means, cluster_assignment_final_5.k_means, assignment_names);
assignment_names{1, 1} = sprintf('%d Param', n_noncorr_parameters); assignment_names{1, 2} = '5 Param';
between_assignments_cluster_distances.c35_c5 = compute_distance_between_cluster_assignments (DataMatrix_mean0std1, cluster_assignment_final_35.k_means, cluster_assignment_final_5.k_means, assignment_names);


%% Final Analysis.
% Display the clustering according to single "raw" parameters, along the 
% best combination of 3 current injection steps.
[Parameters_Step_Combinations, experiments] = compute_best_3steps_comb(experiments, cluster_assignment_final_5.k_means, main_figures_dir, options);

% Group Analysis (plot of "raw" data), according to clusters.
Clusters = get_clusters_DataMatrices(cluster_assignment_final_5.k_means, DataMatrix, experiments);
[Cluster_Data, Cluster_Data_plot] = plot_Clusters_group_analysis (Clusters);

% PCA
PCA_139 = pca_analysis(cluster_assignment_final_139.k_means, DataMatrix, options);
PCA_35 = pca_analysis(cluster_assignment_final_35.k_means, DataMatrix_Relevant_mean0std1, options);
