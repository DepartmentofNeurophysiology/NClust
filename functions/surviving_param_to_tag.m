function [DataMatrix_Relevant, surviving_param_label, surviving_param_names] = surviving_param_to_tag (DataMatrix, correlation_pairs_unique_names, parameters_all)
% This function gets the names of the parameters  surviving the correlation
% analysis, and filters the DataMatrix for the clustering accordingly.


number_of_parameters = numel(parameters_all);
surviving_param_names = correlation_pairs_unique_names(:, 2);

surviving_param_label_tmp = cell(number_of_parameters, 1);
for i_param_1 = 1:number_of_parameters
    current_param_1 = surviving_param_names{i_param_1, 1};
    if isempty(current_param_1)
%         surviving_param_label_tmp{i_param_1} = NaN;
        continue
    else
        % Look for the corresponding label.
        for i_param_2 = 1:number_of_parameters
            current_param_2 = parameters_all{i_param_2, 1};
            if strcmpi(current_param_1, current_param_2) == 1
                surviving_param_label_tmp{i_param_1} = i_param_2;
            end
        end
    end
end

surviving_param_label_tmp = cell2mat(surviving_param_label_tmp);
surviving_param_label = sort(surviving_param_label_tmp);

surviving_param_names = correlation_pairs_unique_names;
for i_param_name = numel(surviving_param_names):-1:1
   if isempty(surviving_param_names{i_param_name}) 
       surviving_param_names(i_param_name) = [];
   end
end

number_of_surviving_param = numel(surviving_param_label);

DataMatrix_Relevant = [];
for i_surviving_param = 1:number_of_surviving_param
    i_param = surviving_param_label(i_surviving_param);
    DataMatrix_Relevant = [DataMatrix_Relevant, DataMatrix(:, i_param)];
end