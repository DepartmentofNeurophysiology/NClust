function experiments_tmp = load_CC_data (main_data_dir)
% This function loads the CC Step analyzed data present in the 
% 40pA and 20pA folders, and returns it in a neat output variable.

% Initialize Folder Structure.
main_CC_dir = sprintf('%s\\CC Step', main_data_dir);
CC_20pA_dir = sprintf('%s\\20pA', main_CC_dir);
CC_40pA_dir = sprintf('%s\\40pA', main_CC_dir);

% Check if the file for all the CC toghether is already present.
CCStep_main_FileName = sprintf('%s\\CCStep.mat', main_data_dir);
if exist(CCStep_main_FileName, 'file') ~= 0
    load(CCStep_main_FileName);
    experiments_tmp = CCStep;
    return
end

% Load 40pA Experiments.
CC_step_size = 40;
fprintf('Preparing Experiments with Step = 40pA.\n')
experiments_40pA = load_specific_CC_Step(CC_40pA_dir, CC_step_size);

% Load 20pA Experiments.
tmp = dir(CC_20pA_dir);
if numel(tmp) > 2
    CC_step_size = 20;
    fprintf('Preparing Experiments with Step = 20pA.\n')
    experiments_20pA = load_specific_CC_Step(CC_20pA_dir, CC_step_size);
    
    % Put Them together.
    experiments_tmp = [experiments_40pA, experiments_20pA];
else
    experiments_tmp = experiments_40pA;
end


end