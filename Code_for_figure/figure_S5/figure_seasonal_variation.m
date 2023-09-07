clc;
clear all;
close all;
%% land
FSDS_dif_all = [];
FLDS_dif_all = [];
FIRE_dif_all = [];
SNOW_dif_all = [];
QSNOMELT_dif_all = [];
CLD_dif_all = [];

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
    
    %% FSDS
    FSDS_TOP = flipud(FSDS_TOP');
    FSDS_TOP_TP = flipud(FSDS_TOP_TP');
    FSDS_PP = flipud(FSDS_PP');
    
    tmp = FSDS_TOP_TP - FSDS_PP;
    FSDS_dif_all =[FSDS_dif_all tmp(inTP>0)];
    
    
    %% FLDS
    FLDS_TOP = flipud(FLDS_TOP');
    FLDS_TOP_TP = flipud(FLDS_TOP_TP');
    FLDS_PP = flipud(FLDS_PP');
    
    tmp = FLDS_TOP_TP - FLDS_PP;
    FLDS_dif_all =[FLDS_dif_all tmp(inTP>0)];
    
     %% FIRE 
    FIRE_TOP = flipud(FIRE_TOP');
    FIRE_TOP_TP = flipud(FIRE_TOP_TP');
    FIRE_PP = flipud(FIRE_PP');
    
    tmp = (FIRE_TOP_TP - FIRE_PP);
    FIRE_dif_all =[FIRE_dif_all tmp(inTP>0)];


    %% SNOW 
    SNOW_TOP = flipud(SNOW_TOP');
    SNOW_TOP_TP = flipud(SNOW_TOP_TP');
    SNOW_PP = flipud(SNOW_PP');
    
    tmp = (SNOW_TOP_TP - SNOW_PP);
    SNOW_dif_all =[SNOW_dif_all tmp(inTP>0)];


    
    %% QSNOMELT
    QSNOMELT_TOP = flipud(QSNOMELT_TOP')*3600*24;
    QSNOMELT_TOP_TP = flipud(QSNOMELT_TOP_TP')*3600*24;
    QSNOMELT_PP = flipud(QSNOMELT_PP')*3600*24;
    
    tmp = (QSNOMELT_TOP_TP - QSNOMELT_PP);
    QSNOMELT_dif_all =[QSNOMELT_dif_all tmp(inTP>0)];
   
    %% CLD
    CLD_TOP = flipud(CLD_TOP')*100;
    CLD_TOP_TP = flipud(CLD_TOP_TP')*100;
    CLD_PP = flipud(CLD_PP')*100;
    
    tmp = (CLD_TOP_TP - CLD_PP);
    CLD_dif_all =[CLD_dif_all tmp(inTP>0)];

   
        

end

%% plot
figure;

set(gcf,'unit','normalized','position',[0.1,0.05,0.9,0.6]);
set(gca, 'Position', [0 0 1 1])

condition_names = {'Winter', 'Spring', 'Summer', 'Autumn' , 'Annual'};
colors =  [0.45, 0.80, 0.69;...
    0.98, 0.40, 0.35;...
    0.55, 0.60, 0.79];

%% FLDS
subplot('position',[0.05 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(FSDS_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('W/m^{2}','fontweight','bold')
text(0.6,-10*0.85,'(a)','fontsize',10,'fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in downward shortwave radiation','fontsize',12)
xlim([0.5 5.5])
ylim([-10 10])

subplot('position',[0.295 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(FLDS_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('W/m^{2}','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in downward longwave radiation','fontsize',12)
text(0.6,-10*0.85,'(b)','fontsize',10,'fontweight','bold')

xlim([0.5 5.5])
ylim([-10 10])

%% FIRE SNOW
subplot('position',[0.54 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(FIRE_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('W/m^{2}','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in upward longwave radiation','fontsize',12)
xlim([0.5 5.5])
ylim([-10 10])
text(0.6,-10*0.85,'(c)','fontsize',10,'fontweight','bold')

subplot('position',[0.785 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(SNOW_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('mm/day','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in snowfall rate','fontsize',12)
text(0.6,-0.5*0.85,'(d)','fontsize',10,'fontweight','bold')

xlim([0.5 5.5])
ylim([-0.5 0.5])

%% snow
subplot('position',[0.05 0.12 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(QSNOMELT_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('mm/day','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
title('\Delta in snowmelt rate','fontsize',12)
xlim([0.5 5.5])
ylim([-0.5 0.5])
xtickangle(45)
text(0.6,-0.5*0.85,'(e)','fontsize',10,'fontweight','bold')

subplot('position',[0.295 0.12 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(CLD_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('%','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
title('\Delta in cloud cover fraction','fontsize',12)
xlim([0.5 5.5])
ylim([-5 5])
xtickangle(45)
text(0.6,-5*0.85,'(f)','fontsize',10,'fontweight','bold')




%% %% output
print(gcf, '-dtiff', '-r300', '../tif/figure_S5_season_variation_other.tif')

