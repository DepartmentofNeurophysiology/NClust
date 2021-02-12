function DataMatrix_out = set_mean0std1 (DataMatrix_in)
% This function sets each column (parameter) for the DataMatrix, to have
% mean = 0, and standard deviation = 1.

[number_of_experiments, number_of_parameters] = size(DataMatrix_in);

DataMatrix_out = NaN(number_of_experiments, number_of_parameters);
for i_par = 1:number_of_parameters
    current_par = DataMatrix_in(:, i_par);
    current_par(:, 1) = current_par(:, 1) - nanmean(current_par(:, 1));
    current_par(:, 1) = current_par(:, 1)./nanstd(current_par(:, 1));
    DataMatrix_out(:, i_par) = current_par;
    clear current_par
end


end