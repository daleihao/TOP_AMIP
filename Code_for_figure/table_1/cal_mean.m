function output = cal_mean(obs, area)

 load('inTP.mat');
 obs = obs(inTP>0);
 area = area(inTP>0);

filters = isnan(obs);
obs = obs(~filters);
area = area(~filters);

output = sum(area.*obs)/sum(area);

end