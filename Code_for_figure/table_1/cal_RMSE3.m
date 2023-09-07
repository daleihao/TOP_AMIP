function output = cal_RMSE3(obs, model)

load('landmask.mat');
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
filters = lats> 17 & lats <49 & lons > 105 & lons < 140; % EA
% filters = lats> 39 & lats <49 & lons > 117 & lons < 140; % EA
% filters = lats> 27 & lats <32 & lons > 105 & lons < 122; % EA
% filters = lats> 33 & lats <38 & lons > 105 & lons < 122; % EA
% filters = lats> 21 & lats <26 & lons > 105 & lons < 122; % EA

inTP = filters;
obs = obs(inTP>0);
model = model(inTP>0);

filters = isnan(obs) | isnan(model);
obs = obs(~filters);
model = model(~filters);
output = corrcoef(obs,model);
R = output(1,2);
Bias = mean(model-obs);
RMSE = sqrt(mean((obs-model).^2));
output = [R Bias RMSE];
end