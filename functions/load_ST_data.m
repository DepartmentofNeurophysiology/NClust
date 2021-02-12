function experiments_tmp = load_ST_data(main_data_dir)
% This function loads all the Sawtooth Data.


% Initialize Folder Structure.
main_ST_dir = sprintf('%s\\VC Saw', main_data_dir);

% Get FileNames.
FilesList = dir(sprintf('%s\\*.mat', main_ST_dir));
FileNames_tmp = struct2cell(FilesList);
FileNames = FileNames_tmp(1, :);
clear FileNames_tmp

% Load Files
number_of_files_tmp = numel(FileNames);
experiments_tmp_1 = struct;
for i_file = 1:number_of_files_tmp
    exp_name_tmp = strsplit(FileNames{i_file}, '.');
    exp_name_tmp = exp_name_tmp{1};
    exp_name_tmp = strsplit(exp_name_tmp, '_');
    ST_Duration = exp_name_tmp{6};
    ST_Duration(1) = [];
    ST_Duration(1) = [];
    ST_Duration = str2double(ST_Duration);
    exp_FullPath = sprintf('%s\\%s', main_ST_dir, FileNames{i_file});
    fprintf('Preparing File "%s".\n', FileNames{i_file});
    trace_tmp = load(exp_FullPath);
    experiments_tmp_1(i_file).name = FileNames{i_file};
    experiments_tmp_1(i_file).path = exp_FullPath;
    experiments_tmp_1(i_file).date = exp_name_tmp{3};
    experiments_tmp_1(i_file).experimenter = exp_name_tmp{4};
    experiments_tmp_1(i_file).exp_number = exp_name_tmp{5};
    experiments_tmp_1(i_file).ST_Length = ST_Duration;
    experiments_tmp_1(i_file).analysis_results_raw = trace_tmp.output.data.sweep{1, 1}.plots;
end

% Sort the data between ST10, ST50, ST100.
i_ST100 = 1;
i_ST50 = 1;
i_ST10 = 1;
for i_file = 1:number_of_files_tmp
    if experiments_tmp_1(i_file).ST_Length == 100
        experiments_tmp_ST100(i_ST100) = experiments_tmp_1(i_file);
        i_ST100 = i_ST100 + 1;
    end
    if experiments_tmp_1(i_file).ST_Length == 50
        experiments_tmp_ST50(i_ST50) = experiments_tmp_1(i_file);
        i_ST50 = i_ST50 + 1;
    end
    if experiments_tmp_1(i_file).ST_Length == 10
        experiments_tmp_ST10(i_ST10) = experiments_tmp_1(i_file);
        i_ST10 = i_ST10 + 1;
    end
end

clear experiments_tmp_1
experiments_tmp.ST100 = experiments_tmp_ST100;
experiments_tmp.ST50 = experiments_tmp_ST50;
experiments_tmp.ST10 = experiments_tmp_ST10;

end