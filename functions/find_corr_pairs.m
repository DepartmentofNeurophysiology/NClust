function param_correlation_matrix = find_corr_pairs (correlation_pairs_unique)

n_param = numel(correlation_pairs_unique);

param_correlation_matrix = zeros(n_param, n_param);
for i_param_1 = 1:n_param
    
    % Find all the parameters correlated to param 1
    for i_param_2 = 1:n_param
        % Make sure there is an element there.
        if isempty(correlation_pairs_unique{i_param_2, 1})
            continue
        end
        current_corrs = correlation_pairs_unique{i_param_2, 1};
        [n_corr_pairs, ~] = size(current_corrs);
        for i_corr_pairs = 1:n_corr_pairs
            current_corr_pair = current_corrs(i_corr_pairs, :);
            % If there is a correlation between the 2 variables, put a 1.
            if current_corr_pair(1, 1) == i_param_1
                param_correlation_matrix(i_param_1, current_corr_pair(1, 2)) = 1;
                param_correlation_matrix(current_corr_pair(1, 2), i_param_1) = 1;
            elseif current_corr_pair(1, 2) == i_param_1
                param_correlation_matrix(i_param_1, current_corr_pair(1, 1)) = 1;
                param_correlation_matrix(current_corr_pair(1, 1), i_param_1) = 1;
            end
            
        end
    end
    
end