clc;
clear all;
close all;
%% land
data_all = nan(8,5,7);
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
load('inTP.mat');
filters = lats> 17 & lats <49 & lons > 105 & lons < 140; % EA
% filters = lats> 5 & lats <20 & lons > 70 & lons < 85; %% TP
% filters = lats> 0 & lats <50 & lons > 110 & lons < 125; %% East asia

inTP = filters;
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
    
    data_all(1,season_i,1) = nanmean(FSA_Obs(inTP>0));
    data_all(1,season_i,2) = nanmean(FSA_PP(inTP>0));
    data_all(1,season_i,3) = nanmean(FSA_TOP(inTP>0));
    data_all(1,season_i,4) = nanmean(FSA_TOP_TP(inTP>0));
    data_all(1,season_i,[5 7 9]) = cal_RMSE3(FSA_Obs, FSA_PP);
    data_all(1,season_i,[6 8 10]) = cal_RMSE3(FSA_Obs, FSA_TOP_TP);
   
    %% Albedo
    Albedo_TOP = flipud(Albedo_TOP');
    Albedo_TOP_TP = flipud(Albedo_TOP_TP');
    Albedo_PP = flipud(Albedo_PP');
    Albedo_Obs = FSUS./FSDS;
    
    data_all(2,season_i,1) = nanmean(Albedo_Obs(inTP>0));
    data_all(2,season_i,2) = nanmean(Albedo_PP(inTP>0));
    data_all(2,season_i,3) = nanmean(Albedo_TOP(inTP>0));
    data_all(2,season_i,4) = nanmean(Albedo_TOP_TP(inTP>0));
    data_all(2,season_i,[5 7 9]) = cal_RMSE3(Albedo_Obs, Albedo_PP);
    data_all(2,season_i,[6 8 10]) = cal_RMSE3(Albedo_Obs, Albedo_TOP_TP);

    %% LH
    LH_TOP = flipud(LH_TOP');
    LH_TOP_TP = flipud(LH_TOP_TP');
    LH_PP = flipud(LH_PP');
    LH_Obs = LE;
    
    data_all(3,season_i,1) = nanmean(LH_Obs(inTP>0));
    data_all(3,season_i,2) = nanmean(LH_PP(inTP>0));
    data_all(3,season_i,3) = nanmean(LH_TOP(inTP>0));
    data_all(3,season_i,4) = nanmean(LH_TOP_TP(inTP>0));
    data_all(3,season_i,[5 7 9]) = cal_RMSE3(LH_Obs, LH_PP);
    data_all(3,season_i,[6 8 10]) = cal_RMSE3(LH_Obs, LH_TOP_TP);
    
    %% FSH
    FSH_TOP = flipud(FSH_TOP');
    FSH_TOP_TP = flipud(FSH_TOP_TP');
    FSH_PP = flipud(FSH_PP');
    FSH_Obs = H;
    
    data_all(4,season_i,1) = nanmean(FSH_Obs(inTP>0));
    data_all(4,season_i,2) = nanmean(FSH_PP(inTP>0));
    data_all(4,season_i,3) = nanmean(FSH_TOP(inTP>0));
    data_all(4,season_i,4) = nanmean(FSH_TOP_TP(inTP>0));
    data_all(4,season_i,[5 7 9]) = cal_RMSE3(FSH_Obs, FSH_PP);
    data_all(4,season_i,[6 8 10]) = cal_RMSE3(FSH_Obs, FSH_TOP_TP);
    
    
    %% FSNO
    FSNO_TOP = flipud(FSNO_TOP');
    FSNO_TOP_TP = flipud(FSNO_TOP_TP');
    FSNO_PP = flipud(FSNO_PP');
    FSNO_Obs = FSNO;
    data_all(5,season_i,1) = nanmean(FSNO_Obs(inTP>0));
    data_all(5,season_i,2) = nanmean(FSNO_PP(inTP>0));
    data_all(5,season_i,3) = nanmean(FSNO_TOP(inTP>0));
    data_all(5,season_i,4) = nanmean(FSNO_TOP_TP(inTP>0));
    data_all(5,season_i,[5 7 9]) = cal_RMSE3(FSNO_Obs, FSNO_PP);
    data_all(5,season_i,[6 8 10]) = cal_RMSE3(FSNO_Obs, FSNO_TOP_TP);
   
    
%     %% SWE
%     SWE_TOP = flipud(SWE_TOP');
%     SWE_TOP_TP = flipud(SWE_TOP_TP');
%     SWE_PP = flipud(SWE_PP');
%     SWE_Obs = SWE_PP;
%     
%     data_all(6,season_i,1) = nanmean(SWE_Obs(inTP>0));
%     data_all(6,season_i,2) = nanmean(SWE_PP(inTP>0));
%     data_all(6,season_i,3) = nanmean(SWE_TOP(inTP>0));
%     data_all(6,season_i,4) = nanmean(SWE_TOP_TP(inTP>0));
%     data_all(1,season_i,[5 7 9]) = cal_RMSE3(FSA_Obs, FSA_PP);
%     data_all(1,season_i,[6 8 10]) = cal_RMSE3(s_Obs, FSA_TOP_TP);
  
    
    %% TSA
    TSA_Obs = Tair + 273.15;
    TSA_TOP = flipud(TSA_TOP');
    TSA_TOP_TP = flipud(TSA_TOP_TP');
    TSA_PP = flipud(TSA_PP');
    data_all(6,season_i,1) = nanmean(TSA_Obs(inTP>0));
    data_all(6,season_i,2) = nanmean(TSA_PP(inTP>0));
    data_all(6,season_i,3) = nanmean(TSA_TOP(inTP>0));
    data_all(6,season_i,4) = nanmean(TSA_TOP_TP(inTP>0));
    data_all(6,season_i,[5 7 9]) = cal_RMSE3(TSA_Obs, TSA_PP);
    data_all(6,season_i,[6 8 10]) = cal_RMSE3(TSA_Obs, TSA_TOP);
  
    %% PREC
    PREC_Obs = Precp;
    PREC_TOP = flipud(PREC_TOP');
    PREC_TOP_TP = flipud(PREC_TOP_TP');
    PREC_PP = flipud(PREC_PP');
    data_all(7,season_i,1) = nanmean(PREC_Obs(inTP>0));
    data_all(7,season_i,2) = nanmean(PREC_PP(inTP>0));
    data_all(7,season_i,3) = nanmean(PREC_TOP(inTP>0));
    data_all(7,season_i,4) = nanmean(PREC_TOP_TP(inTP>0));
    data_all(7,season_i,[5 7 9]) = cal_RMSE3(PREC_Obs, PREC_PP);
    data_all(7,season_i,[6 8 10]) = cal_RMSE3(PREC_Obs, PREC_TOP);

end


data_output = [squeeze(data_all(2,:,5:10))
    squeeze(data_all(1,:,5:10))
    squeeze(data_all(3,:,5:10))
    squeeze(data_all(4,:,5:10))
    squeeze(data_all(5,:,5:10))
    squeeze(data_all(6,:,5:10))
    squeeze(data_all(7,:,5:10))   ];
