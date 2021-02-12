function corr_threshold = plot_correlations_distribution (parameters_correlation_matrix_ABS)

parameters_correlation_matrix_ABS_sup = triu(parameters_correlation_matrix_ABS);
parameters_correlation_matrix_ABS_sup(parameters_correlation_matrix_ABS_sup == 0) = NaN;
parameters_correlation_array = reshape(parameters_correlation_matrix_ABS_sup, [1, numel(parameters_correlation_matrix_ABS_sup)]);

correlation_mean = nanmean(parameters_correlation_array);
correlation_std = nanstd(parameters_correlation_array);
correlation_2std = 2*correlation_std;
corr_threshold = correlation_mean + correlation_2std;
figure(); hold on;
n_bins = 150;
histogram(parameters_correlation_array, n_bins)

y1=get(gca,'ylim')
hold on
plot([corr_threshold corr_threshold], y1)


ylabel('Correlations Count');
xlabel('Correlations Value');
title('Correlations Distribution');
box on; grid on; axis tight;
FileName = 'Correlations Distribution';
saveas(gcf, sprintf('%s.png', FileName));
saveas(gcf, sprintf('%s.fig', FileName));
saveas(gcf, sprintf('%s.eps', FileName));