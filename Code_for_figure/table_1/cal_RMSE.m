function output = cal_RMSE(obs, model)

 load('inTP.mat');
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