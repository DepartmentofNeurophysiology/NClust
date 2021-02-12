% Auxiliary script to fill in the surviving variables labels.

for i_param = 1:numel(parameters_all)
    if ~isnan(uncorrelated_parameters(i_param, 1))
        correlation_pairs_unique_names{i_param, 2} = parameters_all{i_param, 1};
    end
end

% Count surviving variables.
counter_surviving_parameters = 0;
for i_param = 1:numel(parameters_all)
    if ~isempty(correlation_pairs_unique_names{i_param, 2})
        counter_surviving_parameters = counter_surviving_parameters + 1;
    end
end