function Output_Param_Set = find_corr_best_set(correlation_matrix_binary, parameters_all)
% This function takes as input a binary matrix that represents all the 
% correlations between parameters.
% The next process is repeated for every parameter, 
% until all the parameters have been excluded:
% - The parameter X that has the highest number of correlations is 
%   selected and included in the Output_Param_Set.
% - All the parameters correlated with X are removed.

correlations_numbers = sum(correlation_matrix_binary, 2);

correlations_numbers_tmp = correlations_numbers;

i_param_saved = 1;
Output_Param_Set = struct;
while numel(correlations_numbers_tmp(~isnan(correlations_numbers_tmp))) ~= 0
    % Find parameter with most correlations.
    [corr_max, corr_max_index] = nanmax(correlations_numbers_tmp);
    % If multiple params are found, just grab the 1st.
    if numel(corr_max_index) > 1
        corr_max_index = corr_max_index(1);
    end
    % Save this param.
    Output_Param_Set(i_param_saved).ParamIndex = corr_max_index;
    Output_Param_Set(i_param_saved).ParamName = parameters_all{corr_max_index};
    Output_Param_Set(i_param_saved).NofCorrelations = corr_max;
    i_param_saved = i_param_saved + 1;
    % Remove selected param.
    correlations_numbers_tmp(corr_max_index) = NaN;
    % Remove all the correlated parameters.
    current_corrs = correlation_matrix_binary(:, corr_max_index);
    correlations_numbers_tmp(current_corrs == 1) = NaN;
end


