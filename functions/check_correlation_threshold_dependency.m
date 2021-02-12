function check_correlation_threshold_dependency(DataMatrix)
% This function checks the number of parameters that would survive the 
% selection based on the maximum covariance, and how that depends on the 
% chosen threshold for selection.
i = 1;
for corr_threshold = 0.95:-0.05:0.1
    options_tmp.correlation_threshold = corr_threshold;
    [~, ~, ~, ~, ~, ~, counter_corr_pars_tmp] = compute_parameters_correlations (DataMatrix, options_tmp);
    n_correlations(i) = counter_corr_pars_tmp.counter_correlations;
    n_uncorr_param(i) = counter_corr_pars_tmp.number_uncorr_variables;
    n_corr_param(i) = counter_corr_pars_tmp.counter_corr_variables;
    n_unique_corr_pairs(i) = counter_corr_pars_tmp.number_of_unique_correlated_pairs;
    i = i + 1;
end
corr_threshold_array = 0.95:-0.05:0.1;

Plot_LineWidth = 2;

figure();
set(gcf,'position', get(0,'screensize'));

subplot(2, 2, 1);
plot(corr_threshold_array, n_correlations, 'LineWidth', Plot_LineWidth)
grid on; grid minor; box on;
set ( gca, 'xdir', 'reverse' )
title('Number of parameters correlations.')
xlabel('Covariance Threshold')
ylabel('# of correlations > Threshold.')

subplot(2, 2, 2);
plot(corr_threshold_array, n_uncorr_param, 'LineWidth', Plot_LineWidth)
grid on; grid minor; box on;
set ( gca, 'xdir', 'reverse' )
title('Number of uncorrelated parameters.')
xlabel('Covariance Threshold')
ylabel('# of param with Cov < Threshold..')

subplot(2, 2, 3);
plot(corr_threshold_array, n_corr_param, 'LineWidth', Plot_LineWidth)
set ( gca, 'xdir', 'reverse' )
grid on; grid minor; box on;
title('Number of correlated parameters.')
xlabel('Covariance Threshold')
ylabel('# of param with Cov > Threshold..')

subplot(2, 2, 4);
plot(corr_threshold_array, sqrt(n_unique_corr_pairs), 'LineWidth', Plot_LineWidth)
set ( gca, 'xdir', 'reverse' )
grid on; grid minor; box on;
title('Number of correlated parameters unique pairs.')
xlabel('Covariance Threshold')
ylabel('# of param pairs with Cov > Threshold..')
