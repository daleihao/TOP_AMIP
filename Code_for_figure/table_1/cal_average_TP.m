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
    load(['../../benchmark_datasets/mat_2005_2015/MODIS_FSNO.mat']);
    FSNO = (FSNOs_M+FSNOs_S)/2;
    FSNO = squeeze(FSNO(:,:,season_i));
    %% FSA
    FSA_TOP = flipud(FSA_TOP');
    FSA_TOP_TP = flipud(FSA_TOP_TP');
    FSA_PP = flipud(FSA_PP');
    FSA_Obs = FSNS;
    
    data_all(1,season_i,1) = cal_mean(FSA_Obs, Area3);
    data_all(1,season_i,2) = cal_mean(FSA_PP, Area3);
    data_all(1,season_i,3) = cal_mean(FSA_TOP, Area3);
    data_all(1,season_i,4) = cal_mean(FSA_TOP_TP, Area3);
    data_all(1,season_i,[5 7 9]) = cal_RMSE(FSA_Obs, FSA_PP);
    data_all(1,season_i,[6 8 10]) = cal_RMSE(FSA_Obs, FSA_TOP_TP);
   
    %% Albedo
    Albedo_TOP = flipud(Albedo_TOP');
    Albedo_TOP_TP = flipud(Albedo_TOP_TP');
    Albedo_PP = flipud(Albedo_PP');
    Albedo_Obs = FSUS./FSDS;
    
    data_all(2,season_i,1) = cal_mean(Albedo_Obs, Area3);
    data_all(2,season_i,2) = cal_mean(Albedo_PP, Area3);
    data_all(2,season_i,3) = cal_mean(Albedo_TOP, Area3);
    data_all(2,season_i,4) = cal_mean(Albedo_TOP_TP, Area3);
    data_all(2,season_i,[5 7 9]) = cal_RMSE(Albedo_Obs, Albedo_PP);
    data_all(2,season_i,[6 8 10]) = cal_RMSE(Albedo_Obs, Albedo_TOP_TP);

    %% LH
    LH_TOP = flipud(LH_TOP');
    LH_TOP_TP = flipud(LH_TOP_TP');
    LH_PP = flipud(LH_PP');
    LH_Obs = LE;
    
    data_all(3,season_i,1) = cal_mean(LH_Obs, Area3);
    data_all(3,season_i,2) = cal_mean(LH_PP, Area3);
    data_all(3,season_i,3) = cal_mean(LH_TOP, Area3);
    data_all(3,season_i,4) = cal_mean(LH_TOP_TP, Area3);
    data_all(3,season_i,[5 7 9]) = cal_RMSE(LH_Obs, LH_PP);
    data_all(3,season_i,[6 8 10]) = cal_RMSE(LH_Obs, LH_TOP_TP);
    
    %% FSH
    FSH_TOP = flipud(FSH_TOP');
    FSH_TOP_TP = flipud(FSH_TOP_TP');
    FSH_PP = flipud(FSH_PP');
    FSH_Obs = H;
    
    data_all(4,season_i,1) = cal_mean(FSH_Obs, Area3);
    data_all(4,season_i,2) = cal_mean(FSH_PP, Area3);
    data_all(4,season_i,3) = cal_mean(FSH_TOP, Area3);
    data_all(4,season_i,4) = cal_mean(FSH_TOP_TP, Area3);
    data_all(4,season_i,[5 7 9]) = cal_RMSE(FSH_Obs, FSH_PP);
    data_all(4,season_i,[6 8 10]) = cal_RMSE(FSH_Obs, FSH_TOP_TP);
    
    
    %% FSNO
    FSNO_TOP = flipud(FSNO_TOP');
    FSNO_TOP_TP = flipud(FSNO_TOP_TP');
    FSNO_PP = flipud(FSNO_PP');
    FSNO_Obs = FSNO;
    data_all(5,season_i,1) = cal_mean(FSNO_Obs, Area3);
    data_all(5,season_i,2) = cal_mean(FSNO_PP, Area3);
    data_all(5,season_i,3) = cal_mean(FSNO_TOP, Area3);
    data_all(5,season_i,4) = cal_mean(FSNO_TOP_TP, Area3);
    data_all(5,season_i,[5 7 9]) = cal_RMSE(FSNO_Obs, FSNO_PP);
    data_all(5,season_i,[6 8 10]) = cal_RMSE(FSNO_Obs, FSNO_TOP_TP);
   
    
    %% SWE
    SWE_TOP = flipud(SWE_TOP');
    SWE_TOP_TP = flipud(SWE_TOP_TP');
    SWE_PP = flipud(SWE_PP');
    SWE_Obs = SWE_PP;
    
    data_all(8,season_i,1) = cal_mean(SWE_Obs, Area3);
    data_all(8,season_i,2) = cal_mean(SWE_PP, Area3);
    data_all(8,season_i,3) = cal_mean(SWE_TOP, Area3);
    data_all(8,season_i,4) = cal_mean(SWE_TOP_TP, Area3);
    data_all(8,season_i,[5 7 9]) = cal_RMSE(FSA_Obs, FSA_PP);
    data_all(8,season_i,[6 8 10]) = cal_RMSE(FSA_Obs, FSA_TOP_TP);
  
    
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
    squeeze(data_all(7,:,1:4)) 
    squeeze(data_all(8,:,1:4)) ];

data_output = [squeeze(data_all(2,:,5:10))
    squeeze(data_all(1,:,5:10))
    squeeze(data_all(3,:,5:10))
    squeeze(data_all(4,:,5:10))
    squeeze(data_all(5,:,5:10))
    squeeze(data_all(6,:,5:10))
    squeeze(data_all(7,:,5:10))   ];
