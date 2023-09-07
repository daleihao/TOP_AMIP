function output = cal_RMSE2(obs, model)

load('landmask.mat');
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
filters = lats> 10 & lats <25 & lons > 72 & lons < 100; % SA
% filters = lats> 17 & lats <25 & lons > 76 & lons < 85 & landmask>0; % SA

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