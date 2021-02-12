function experiments_output = group_protocols (experiments_tmp)
% This function takes all the protocols, and groups them in another 
% variable, according to the experiment name (same experiment/cell go in 
% the same index.

% Initialize Data.
CCstep = experiments_tmp.CCStep;
ST100 = experiments_tmp.ST.ST100;
ST50 = experiments_tmp.ST.ST50;
ST10 = experiments_tmp.ST.ST10;
VCstep = experiments_tmp.VCStep;
n_CCstep = numel(CCstep);
n_ST100 = numel(ST100);
n_ST50 = numel(ST50);
n_ST10 = numel(ST10);
n_VCstep = numel(VCstep);

experiments_output = struct;

% Sort per experiment.
i_exp = 1;
for i_CCstep = 1:n_CCstep
    % Get current experiment name.
    CC_exp_name = sprintf('%s_%s_%s', CCstep(i_CCstep).date, CCstep(i_CCstep).experimenter, CCstep(i_CCstep).exp_number);
    experiments_output(i_exp).exp_name = CC_exp_name;
    
    % Get CC data.
    experiments_output(i_exp).CC_Data_Means = CCstep(i_CCstep).analysis_results_means;
    experiments_output(i_exp).CC_Data_Stds = CCstep(i_CCstep).analysis_results_stds;
    
    % Get corresponding ST100 data (if any).
    for i_ST100 = 1:n_ST100
        ST100_exp_name = sprintf('%s_%s_%s', ST100(i_ST100).date, ST100(i_ST100).experimenter, ST100(i_ST100).exp_number);
        if strcmpi(ST100_exp_name, CC_exp_name) == 1
            experiments_output(i_exp).ST100_Data = ST100(i_ST100).analysis_results_raw;
        end
    end
    
    % Get corresponding ST50 data (if any).
    for i_ST50 = 1:n_ST50
        ST50_exp_name = sprintf('%s_%s_%s', ST50(i_ST50).date, ST50(i_ST50).experimenter, ST50(i_ST50).exp_number);
        if strcmpi(ST50_exp_name, CC_exp_name) == 1
            experiments_output(i_exp).ST50_Data = ST50(i_ST50).analysis_results_raw;
        end
    end
    
    % Get corresponding ST10 data (if any).
    for i_ST10 = 1:n_ST10
        ST10_exp_name = sprintf('%s_%s_%s', ST10(i_ST10).date, ST10(i_ST10).experimenter, ST10(i_ST10).exp_number);
        if strcmpi(ST10_exp_name, CC_exp_name) == 1
            experiments_output(i_exp).ST10_Data = ST10(i_ST10).analysis_results_raw;
        end
    end
    
    % Get corresponding VC data (if any).
    for i_VCstep = 1:n_VCstep
        VCstep_exp_name = sprintf('%s_%s_%s', VCstep(i_VCstep).date, VCstep(i_VCstep).experimenter, VCstep(i_VCstep).exp_number);
        if strcmpi(VCstep_exp_name, CC_exp_name) == 1
            experiments_output(i_exp).VCstep_Data = VCstep(i_VCstep).analysis_results_raw;
        end
    end
    
    % Fill empty fields with NaNs (ST100).
    if isfield(experiments_output(i_exp), 'ST100_Data') == 0
        experiments_output(i_exp).ST100_Data = NaN;
    end
    if isempty(experiments_output(i_exp).ST100_Data)
        experiments_output(i_exp).ST100_Data = NaN;
    end
    % Fill empty fields with NaNs (ST50).
    if isfield(experiments_output(i_exp), 'ST50_Data') == 0
        experiments_output(i_exp).ST50_Data = NaN;
    end
    if isempty(experiments_output(i_exp).ST50_Data)
        experiments_output(i_exp).ST50_Data = NaN;
    end
    % Fill empty fields with NaNs (ST10).
    if isfield(experiments_output(i_exp), 'ST10_Data') == 0
        experiments_output(i_exp).ST10_Data = NaN;
    end
    if isempty(experiments_output(i_exp).ST10_Data)
        experiments_output(i_exp).ST10_Data = NaN;
    end
    % Fill empty fields with NaNs (VCstep).
    if isfield(experiments_output(i_exp), 'VCstep_Data') == 0
        experiments_output(i_exp).VCstep_Data = NaN;
    end
    if isempty(experiments_output(i_exp).VCstep_Data)
        experiments_output(i_exp).VCstep_Data = NaN;
    end
    
    i_exp = i_exp + 1;
end


