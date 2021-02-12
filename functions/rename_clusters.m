function [cluster_assignment_renamed, cluster_assignment_renamed_2] = rename_clusters (cluster_assignment, cluster_assignment_2)
% This function takes 2 clustering assignments, and changes the clusters 
% labels, to exclude all the empty clusters, therefore aligning the labels
% from 1 to # of clusters.
% If given only 1 input, it will rename that cluster assignment only.


number_of_cells = numel(cluster_assignment);

tag_min = nanmin(cluster_assignment);
tag_max = nanmax(cluster_assignment);

cluster_assignment_renamed = NaN(1, number_of_cells);
i_new_tag = 1;
for i_tag = tag_min:tag_max
    if numel(find(cluster_assignment == i_tag)) > 0
        cluster_assignment_renamed(find(cluster_assignment == i_tag)) = i_new_tag;
        i_new_tag = i_new_tag + 1;
    end
end

% Stop here if there is only 1 input.
if nargin == 1
    cluster_assignment_renamed_2 = [];
    return
end

tag_max_new = nanmax(cluster_assignment_renamed);

tag_min_2 = nanmin(cluster_assignment_2);
tag_max_2 = nanmax(cluster_assignment_2);

cluster_assignment_renamed_2 = NaN(1, number_of_cells);

% Find the tags that corresponds in the 2 old namings, and rename them
% in the 2nd cluster assignment according to the new naming...
i_new_tag = 1;
for i_tag_2 = tag_min_2:tag_max_2
    if numel(find(cluster_assignment == i_tag_2)) > 0
        % Find this tag in the 1st (old) assignment.
        if numel(find(cluster_assignment == i_tag_2)) > 0
            % Get the corresponding new lable.
            tmp = cluster_assignment_renamed(find(cluster_assignment == i_tag_2));
            new_lable = tmp(1);
            cluster_assignment_renamed_2(find(cluster_assignment_2 == i_tag_2)) = new_lable;
            i_new_tag = i_new_tag + 1;
        end
    end
end

tag_max_new_2 = nanmax(cluster_assignment_renamed_2);

% Find the remaining tags (if any), and give them a new name
i_new_tag = 1;
if numel(find(isnan(cluster_assignment_renamed_2))) > 0
    for i_tag_2 = tag_min_2:tag_max_2
        % If the tag exists.
        if numel(find(cluster_assignment_2 == i_tag_2)) > 0
            % If the tag has not already been translated.
            tmp = cluster_assignment_renamed_2(find(cluster_assignment_2 == i_tag_2));
            if isnan(tmp(1))
                % Assign a new label.
                cluster_assignment_renamed_2(find(cluster_assignment_2 == i_tag_2)) = tag_max_new + i_new_tag;
                i_new_tag = i_new_tag + 1;
            end
            
        end
        
    end
end

% Integrity Check.
if numel(find(isnan(cluster_assignment_renamed))) > 0
    error('Some clusters in the 1st assignment were not renamed correctly.')
end

if numel(find(isnan(cluster_assignment_renamed_2))) > 0
    error('Some clusters in the 2nd assignment were not renamed correctly.')
end

end




