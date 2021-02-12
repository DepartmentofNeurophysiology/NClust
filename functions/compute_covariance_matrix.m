function DataCovariance = compute_covariance_matrix(DataMatrix)

DataCovariance = cov(DataMatrix_clust, 'partialrows');


pcolor(abs(DataCovariance));
colorbar;
halfwidth = 0.5;
ticks_pos = halfwidth:10:number_of_parameters;
set(gca, 'xTick', ticks_pos);
set(gca, 'xTickLabel', ticks_pos-halfwidth);
set(gca, 'yTick', ticks_pos);
set(gca, 'yTickLabel', ticks_pos-halfwidth);
set(gca,'Ydir','reverse')
title('Parameters Covariance Matrix (ABS).', 'FontSize', 20)
xlabel('Parameter Label', 'FontSize', 12)
ylabel('Parameter Label', 'FontSize', 12)



