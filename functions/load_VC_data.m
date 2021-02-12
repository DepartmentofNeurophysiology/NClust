function experiments_tmp = load_VC_data(main_data_dir)
% This function loads all the VC Step Data.


% Initialize Folder Structure.
main_VC_dir = sprintf('%s\\VC Step', main_data_dir);

% Get FileNames.
FilesList = dir(sprintf('%s\\*.mat', main_VC_dir));
FileNames_tmp = struct2cell(FilesList);
FileNames = FileNames_tmp(1, :);
clear FileNames_tmp

% Load Files
number_of_files_tmp = numel(FileNames);
experiments_tmp = struct;
for i_file = 1:number_of_files_tmp
    exp_name_tmp = strsplit(FileNames{i_file}, '.');
    exp_name_tmp = exp_name_tmp{1};
    exp_name_tmp = strsplit(exp_name_tmp, '_');
    exp_FullPath = sprintf('%s\\%s', main_VC_dir, FileNames{i_file});
    fprintf('Preparing File "%s".\n', FileNames{i_file});
    trace_tmp = load(exp_FullPath);
    experiments_tmp(i_file).name = FileNames{i_file};
    experiments_tmp(i_file).path = exp_FullPath;
    experiments_tmp(i_file).date = exp_name_tmp{3};
    experiments_tmp(i_file).experimenter = exp_name_tmp{4};
    experiments_tmp(i_file).exp_number = exp_name_tmp{5};
    experiments_tmp(i_file).analysis_results_raw = trace_tmp.output.data.plots;
end

end