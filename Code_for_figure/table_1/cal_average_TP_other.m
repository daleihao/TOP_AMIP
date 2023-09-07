clc;
clear all;
close all;
%% land
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));

[Area1, Area2, Area3] = CalculateArea(lats);
data_all = nan(8,5,7);
load('inTP.mat');
for season_i = 1:5
    switch season_i
        case 1
            season_name = 'DJF';
        case 2
            season_name = 'MAM';
        case 3
            season_name = 'JJA';
        case 4
            season_name = 'SON';
        case 5
            season_name = 'ANN';
    end
    
    load(['../../process_E3SM_simulation/ELM_season_' season_name '_F2010_final.mat']);
    load(['../../process_E3SM_simulation/EAM_season_' season_name '_F2010_final.mat']);
    load(['../../benchmark_datasets/mat_2005_2015/CERES_' season_name '.mat']);
    load(['../../benchmark_datasets/mat_2005_2015/FLUXCOM_' season_name '.mat']);
    load(['../../benchmark_datasets/mat_2005_2015/GPCP_' season_name '.mat']);
    load(['../../benchmark_datasets/mat_2005_2015/UDel_Temp_' season_name '.mat']);
    %% CLD
    CLD_TOP = flipud(CLD_TOP')*100;
    CLD_TOP_TP = flipud(CLD_TOP_TP')*100;
    CLD_PP = flipud(CLD_PP')*100;
    CLD_Obs = Cld;
    
    data_all(1,season_i,1) = cal_mean(CLD_Obs, Area3);
    data_all(1,season_i,2) = cal_mean(CLD_PP, Area3);
    data_all(1,season_i,3) = cal_mean(CLD_TOP, Area3);
    data_all(1,season_i,4) = cal_mean(CLD_TOP_TP, Area3);
    data_all(1,season_i,[5 7 9]) = cal_RMSE(CLD_Obs, CLD_PP);
    data_all(1,season_i,[6 8 10]) = cal_RMSE(CLD_Obs, CLD_TOP_TP);
   
    %% FSDS
    FSDS_TOP = flipud(FSDS_TOP');
    FSDS_TOP_TP = flipud(FSDS_TOP_TP');
    FSDS_PP = flipud(FSDS_PP');
    FSDS_Obs = FSDS;
    
    data_all(2,season_i,1) = cal_mean(FSDS_Obs, Area3);
    data_all(2,season_i,2) = cal_mean(FSDS_PP, Area3);
    data_all(2,season_i,3) = cal_mean(FSDS_TOP, Area3);
    data_all(2,season_i,4) = cal_mean(FSDS_TOP_TP, Area3);
    data_all(2,season_i,[5 7 9]) = cal_RMSE(FSDS_Obs, FSDS_PP);
    data_all(2,season_i,[6 8 10]) = cal_RMSE(FSDS_Obs, FSDS_TOP_TP);

    %% FLDS
    FLDS_TOP = flipud(FLDS_TOP');
    FLDS_TOP_TP = flipud(FLDS_TOP_TP');
    FLDS_PP = flipud(FLDS_PP');
    FLDS_Obs = FLDS;
    
    data_all(3,season_i,1) = cal_mean(FLDS_Obs, Area3);
    data_all(3,season_i,2) = cal_mean(FLDS_PP, Area3);
    data_all(3,season_i,3) = cal_mean(FLDS_TOP, Area3);
    data_all(3,season_i,4) = cal_mean(FLDS_TOP_TP, Area3);
    data_all(3,season_i,[5 7 9]) = cal_RMSE(FLDS_Obs, FLDS_PP);
    data_all(3,season_i,[6 8 10]) = cal_RMSE(FLDS_Obs, FLDS_TOP_TP);
    
    %% FIRE
    FIRE_TOP = flipud(FIRE_TOP');
    FIRE_TOP_TP = flipud(FIRE_TOP_TP');
    FIRE_PP = flipud(FIRE_PP');
    FIRE_Obs = FLUS;
    
    data_all(4,season_i,1) = cal_mean(FIRE_Obs, Area3);
    data_all(4,season_i,2) = cal_mean(FIRE_PP, Area3);
    data_all(4,season_i,3) = cal_mean(FIRE_TOP, Area3);
    data_all(4,season_i,4) = cal_mean(FIRE_TOP_TP, Area3);
    data_all(4,season_i,[5 7 9]) = cal_RMSE(FIRE_Obs, FIRE_PP);
    data_all(4,season_i,[6 8 10]) = cal_RMSE(FIRE_Obs, FIRE_TOP_TP);
    
    
    %% FIRE    
    FIRE_TOP = sqrt(sqrt(FIRE_TOP./(5.67*1e-8)));
FIRE_TOP_TP = sqrt(sqrt(FIRE_TOP_TP./(5.67*1e-8)));
FIRE_PP = sqrt(sqrt(FIRE_PP./(5.67*1e-8)));
FIRE_Obs = sqrt(sqrt(FIRE_Obs./(5.67*1e-8)));
            
    data_all(5,season_i,1) = cal_mean(FIRE_Obs, Area3);
    data_all(5,season_i,2) = cal_mean(FIRE_PP, Area3);
    data_all(5,season_i,3) = cal_mean(FIRE_TOP, Area3);
    data_all(5,season_i,4) = cal_mean(FIRE_TOP_TP, Area3);
    data_all(5,season_i,[5 7 9]) = cal_RMSE(FIRE_Obs, FIRE_PP);
    data_all(5,season_i,[6 8 10]) = cal_RMSE(FIRE_Obs, FIRE_TOP_TP);
   
    
%     %% SWE
%     SWE_TOP = flipud(SWE_TOP');
%     SWE_TOP_TP = flipud(SWE_TOP_TP');
%     SWE_PP = flipud(SWE_PP');
%     SWE_Obs = SWE_PP;
%     
%     data_all(6,season_i,1) = nanmean(SWE_Obs, Area3);
%     data_all(6,season_i,2) = nanmean(SWE_PP, Area3);
%     data_all(6,season_i,3) = nanmean(SWE_TOP, Area3);
%     data_all(6,season_i,4) = nanmean(SWE_TOP_TP, Area3);
%     data_all(1,season_i,[5 7 9]) = cal_RMSE(CLD_Obs, CLD_PP);
%     data_all(1,season_i,[6 8 10]) = cal_RMSE(s_Obs, CLD_TOP_TP);
  
    
    %% TSA
    TSA_Obs = Tair + 273.15;
    TSA_TOP = flipud(TSA_TOP');
    TSA_TOP_TP = flipud(TSA_TOP_TP');
    TSA_PP = flipud(TSA_PP');
    data_all(6,season_i,1) = cal_mean(TSA_Obs, Area3);
    data_all(6,season_i,2) = cal_mean(TSA_PP, Area3);
    data_all(6,season_i,3) = cal_mean(TSA_TOP, Area3);
    data_all(6,season_i,4) = cal_mean(TSA_TOP_TP, Area3);
    data_all(6,season_i,[5 7 9]) = cal_RMSE(TSA_Obs, TSA_PP);
    data_all(6,season_i,[6 8 10]) = cal_RMSE(TSA_Obs, TSA_TOP_TP);
  
    %% PREC
    PREC_Obs = Precp;
    PREC_TOP = flipud(PREC_TOP');
    PREC_TOP_TP = flipud(PREC_TOP_TP');
    PREC_PP = flipud(PREC_PP');
    data_all(7,season_i,1) = cal_mean(PREC_Obs, Area3);
    data_all(7,season_i,2) = cal_mean(PREC_PP, Area3);
    data_all(7,season_i,3) = cal_mean(PREC_TOP, Area3);
    data_all(7,season_i,4) = cal_mean(PREC_TOP_TP, Area3);
    data_all(7,season_i,[5 7 9]) = cal_RMSE(PREC_Obs, PREC_PP);
    data_all(7,season_i,[6 8 10]) = cal_RMSE(PREC_Obs, PREC_TOP_TP);

end

data_output1 = [squeeze(data_all(2,:,1:4))
    squeeze(data_all(1,:,1:4))
    squeeze(data_all(3,:,1:4))
    squeeze(data_all(4,:,1:4))
    squeeze(data_all(5,:,1:4))
    squeeze(data_all(6,:,1:4))
    squeeze(data_all(7,:,1:4))   ];

data_output = [squeeze(data_all(2,:,5:10))
    squeeze(data_all(1,:,5:10))
    squeeze(data_all(3,:,5:10))
    squeeze(data_all(4,:,5:10))
    squeeze(data_all(5,:,5:10))
    squeeze(data_all(6,:,5:10))
    squeeze(data_all(7,:,5:10))   ];
