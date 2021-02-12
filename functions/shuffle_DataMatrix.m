function [DataMatrix_Shuffled_Cells, DataMatrix_Shuffled_Params, DataMatrix_Shuffled_Tot] = shuffle_DataMatrix(DataMatrix)
% This function takes as inpute a DataMatrix, and gives as output the same, 
% with the position of its elements along raws or columns or both, randomly
% reassigned.


[number_of_cells, number_of_params] = size(DataMatrix);

% Randomly permute the columns (Cells).
DataMatrix_Shuffled_Cells = NaN(number_of_cells, number_of_params);
for i_column = 1:number_of_params
    current_column = DataMatrix(:, i_column);
    current_column_shuffled = current_column(randperm(length(current_column)));
    DataMatrix_Shuffled_Cells(:, i_column) = current_column_shuffled;
%     keyboard
end

% Randomly permute the raws (Parameters).
DataMatrix_Shuffled_Params = NaN(number_of_cells, number_of_params);
for i_raw = 1:number_of_cells
    current_raw = DataMatrix(i_raw, :);
    current_raw_shuffled = current_raw(randperm(length(current_raw)));
    DataMatrix_Shuffled_Params(i_raw, :) = current_raw_shuffled;
end

% Randomly permute both (Parameters and Cells.)
DataMatrix_Shuffled_Tot = NaN(number_of_cells, number_of_params);
for i_raw = 1:number_of_cells
    current_raw = DataMatrix_Shuffled_Params(i_raw, :);
    current_raw_shuffled = current_raw(randperm(length(current_raw)));
    DataMatrix_Shuffled_Tot(i_raw, :) = current_raw_shuffled;
end


end