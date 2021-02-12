function [parameters_correlation_matrix, parameters_correlation_matrix_ABS, correlation_pairs, correlation_pairs_unique, correlation_pairs_unique_names, uncorrelated_parameters, counter_corr_pars] = compute_parameters_correlations (DataMatrix, options)
% This function computes the correlation between each couple of parameters
% coming from the CC analysis.

FLAG_plot_parameters_corr = 1;
correlation_threshold = options.correlation_threshold;

[number_of_cells, number_of_parameters] = size(DataMatrix);


%% Get Correlation Coefficients.
counter_correlations = 0;
counter_corr09 = 0;
counter_corr08 = 0;
counter_corr07 = 0;
counter_corr06 = 0;
counter_corr05 = 0;
counter_corr04 = 0;
counter_corr03 = 0;
parameters_correlation_matrix = NaN(number_of_parameters, number_of_parameters);
for i_param_1 = 1:number_of_parameters
    current_param_1 = DataMatrix(:, i_param_1);
    for i_param_2 = 1:number_of_parameters
        if i_param_1 == i_param_2
            continue
        end
        current_param_2 = DataMatrix(:, i_param_2);
        % Now get the correlation. 
        tmp = corrcoef(current_param_1, current_param_2, 'rows', 'complete');
        parameters_correlation_matrix(i_param_1, i_param_2) = tmp(1, 2);
        if abs(tmp) >= correlation_threshold
            counter_correlations = counter_correlations + 1;
        end
        if abs(tmp) >= 0.9
            counter_corr09 = counter_corr09 + 1;
        end
        if abs(tmp) >= 0.8
            counter_corr08 = counter_corr08 + 1;
        end
        if abs(tmp) >= 0.7
            counter_corr07 = counter_corr07 + 1;
        end
        if abs(tmp) >= 0.6
            counter_corr06 = counter_corr06 + 1;
        end
        if abs(tmp) >= 0.5
            counter_corr05 = counter_corr05 + 1;
        end
        if abs(tmp) >= 0.4
            counter_corr04 = counter_corr04 + 1;
        end
        if abs(tmp) >= 0.3
            counter_corr03 = counter_corr03 + 1;
        end
    end
end
parameters_correlation_matrix_ABS = abs(parameters_correlation_matrix);
counter_corr_pars.counter_correlations = counter_correlations;

min_corr_per_param = nanmin(parameters_correlation_matrix_ABS);
max_corr_per_param = nanmax(parameters_correlation_matrix_ABS);


%% Get correlated parameters.
% Save Parameters Doublets with |correlation| > correlation_threshold.
correlation_pairs = cell(1, 1);
uncorrelated_parameters = NaN(1, number_of_parameters);
counter_uncorr_variables = 0;
for i_param = 1:number_of_parameters
    current_par_corrs = parameters_correlation_matrix(i_param, :);
%     current_par_corrs(isnan(current_par_corrs)) = [];
    correlated_pars = find(current_par_corrs > correlation_threshold);
    if ~isempty(correlated_pars)
        corr_pairs = NaN(numel(correlated_pars), 2);
        for i_pair = 1:numel(correlated_pars)
            corr_pairs(i_pair, 1:2) = [i_param, correlated_pars(i_pair)];
        end
        corr_pairs(isnan(corr_pairs));
        correlation_pairs{i_param, 1} = corr_pairs;
    else
        uncorrelated_parameters(i_param) = i_param;
        counter_uncorr_variables = counter_uncorr_variables + 1;
    end
    
end
counter_corr_variables = number_of_parameters - counter_uncorr_variables;
uncorrelated_parameters = uncorrelated_parameters';

% Save Unique Pairs only.
correlation_pairs_unique = correlation_pairs;
for i_param_1 = 1:number_of_parameters
    current_pairs_group = correlation_pairs_unique{i_param_1, 1};
    if isempty(current_pairs_group)
        continue
    end
    for i_pair_1 = 1:numel(current_pairs_group)/2
        current_pair = current_pairs_group(i_pair_1, :);
        % Find if this pair is repeated.
        current_pair_inverted = flip(current_pair);
        for i_param_2 = 1:number_of_parameters
            current_pairs_group_2 = correlation_pairs_unique{i_param_2, 1};
            if isempty(current_pairs_group_2)
                continue
            end
            for i_pair_2 = 1:numel(current_pairs_group_2)/2
                current_pair_2 = current_pairs_group_2(i_pair_2, :);
                if current_pair_2(1, 1) == current_pair_inverted(1, 1) && current_pair_2(1, 2) == current_pair_inverted(1, 2)
                    % Remove element.
                    tmp = current_pairs_group_2;
                    tmp(i_pair_2, :) = [];
                    correlation_pairs_unique{i_param_2} = tmp;
                end
            end
        end
    end
end

% Count number of unique correlated pairs.
number_of_unique_correlated_pairs = 0;
for i_param = 1:number_of_parameters
    current_pairs_group = correlation_pairs_unique{i_param, 1};
    if isempty(current_pairs_group)
        continue
    end
    [N, ~] = size(current_pairs_group);
    number_of_unique_correlated_pairs = number_of_unique_correlated_pairs + N;
end
counter_corr_pars.number_uncorr_variables = counter_uncorr_variables;
counter_corr_pars.counter_corr_variables = counter_corr_variables;
counter_corr_pars.number_of_unique_correlated_pairs = number_of_unique_correlated_pairs;
fprintf('Number of variables with |correlations| < %g = %g.\n', correlation_threshold, counter_uncorr_variables);
fprintf('Number of variables with |correlations| > %g = %g.\n', correlation_threshold, counter_corr_variables);
fprintf('Number of pairs with |correlations| > %g = %g.\n', correlation_threshold, number_of_unique_correlated_pairs);

parameters_all = param_to_number_correspondance;
parameters_all = parameters_all';

% Substitute tags to parameters names.
correlation_pairs_unique_names = cell(number_of_parameters, 1);
for i_param = 1:number_of_parameters
    current_pairs_group = correlation_pairs_unique{i_param, 1};
    if isempty(current_pairs_group)
        correlation_pairs_unique_names{i_param, 1} = [];
        continue
    end
    [Nr, Nc] = size(current_pairs_group);
    current_pairs_group_names = cell(1, 1);
    for i_row = 1:Nr
        current_pairs_group_names{i_row, 1} = parameters_all{current_pairs_group(i_row, 1)};
        current_pairs_group_names{i_row, 2} = parameters_all{current_pairs_group(i_row, 2)};
    end
    correlation_pairs_unique_names{i_param, 1} = current_pairs_group_names;
end





%% Plot
if FLAG_plot_parameters_corr == 1
    
    figure()
    set(gcf,'position', get(0,'screensize'));
    
    imAlpha = ones(size(parameters_correlation_matrix_ABS));
    imAlpha(isnan(parameters_correlation_matrix_ABS))=0;
    imagesc(parameters_correlation_matrix_ABS, 'AlphaData', imAlpha);
    set(gca,'color', [0, 0, 0]);
    
    %     tmp = NaN(number_of_parameters + 1, number_of_parameters + 1);
    %     tmp(1:number_of_parameters, 1:number_of_parameters) = parameters_correlation_matrix_ABS;
    %     pcolor(tmp);
    axis square;
    colorbar;
    halfwidth = 0.5;
    ticks_pos = halfwidth:10:number_of_parameters;
%     set(gca, 'xTick', ticks_pos);
%     set(gca, 'xTickLabel', ticks_pos-halfwidth);
%     set(gca, 'yTick', ticks_pos);
%     set(gca, 'yTickLabel', ticks_pos-halfwidth);
    set(gca,'Ydir','reverse')
    xtickangle(45)
    title('Parameters Correlation Matrix (abs).', 'FontSize', 20)
    xlabel('Parameter Label', 'FontSize', 12)
    ylabel('Parameter Label', 'FontSize', 12)
    
    saveas(gcf, 'Parameters Correlation Matrix ABS.png');
    saveas(gcf, 'Parameters Correlation Matrix ABS.fig');
    saveas(gcf, 'Parameters Correlation Matrix ABS.eps');
    

    
    figure()
    set(gcf,'position', get(0,'screensize'));
%     tmp = NaN(number_of_parameters + 1, number_of_parameters + 1);
%     tmp(1:number_of_parameters, 1:number_of_parameters) = parameters_correlation_matrix;
%     pcolor(tmp);

    imAlpha = ones(size(parameters_correlation_matrix));
    imAlpha(isnan(parameters_correlation_matrix))=0;
    imagesc(parameters_correlation_matrix, 'AlphaData', imAlpha);
    set(gca,'color', [0, 0, 0]);
    
    axis square;
    colorbar;
    halfwidth = 0.5;
    ticks_pos = halfwidth:10:number_of_parameters;
%     set(gca, 'xTick', ticks_pos);
%     set(gca, 'xTickLabel', ticks_pos-halfwidth);
%     set(gca, 'yTick', ticks_pos);
%     set(gca, 'yTickLabel', ticks_pos-halfwidth);
    set(gca,'Ydir','reverse')
    xtickangle(45)
    title('Parameters Correlation Matrix.', 'FontSize', 20)
    xlabel('Parameter Label', 'FontSize', 12)
    ylabel('Parameter Label', 'FontSize', 12)
    
    saveas(gcf, 'Parameters Correlation Matrix.png');
    saveas(gcf, 'Parameters Correlation Matrix.fig');
    saveas(gcf, 'Parameters Correlation Matrix.eps');
end

end