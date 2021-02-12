function [inmodel, history, surviving_params_names] = feature_selection_test (DataMatrix, cluster_assignments, param_labels, param_names)

%  fun = @(x,y) (immse(x,y));
X = DataMatrix;
Y = (cluster_assignments)';

fun = @(x0,y0,x1,y1) norm(y1-x1*(x0\y0))^2; % residual sum of squares
[inmodel, history] = sequentialfs(fun, X, Y);

% 
%     function dev = critfun(X,Y)
%         model = fitglm(X,Y,'Distribution','normal');
%         dev = model.Deviance;
%     end

% for i_param_name = numel(param_names):-1:1
%    if isempty(param_names{i_param_name}) 
%        param_names(i_param_name) = [];
%    end
% end

number_of_surviving_params = numel(inmodel(inmodel == 1));
surviving_param_labels = find(param_labels(inmodel == 1));
% keyboard
for i_param = 1:number_of_surviving_params
    surviving_params_names{i_param} = param_names{surviving_param_labels(i_param)};
end
% % keyboard