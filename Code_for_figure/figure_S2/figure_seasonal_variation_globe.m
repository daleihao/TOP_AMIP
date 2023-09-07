clc;
clear all;
close all;
%% land
FSA_dif_all = [];
Albedo_dif_all = [];
LH_dif_all = [];
FSH_dif_all = [];
FSNO_dif_all = [];
SWE_dif_all = [];
TSA_dif_all = [];
PREC_dif_all = [];

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
    
    %% FSA
    FSA_TOP = flipud(FSA_TOP');
    FSA_TOP_TP = flipud(FSA_TOP_TP');
    FSA_PP = flipud(FSA_PP');
    
    tmp = FSA_TOP - FSA_PP;
    FSA_dif_all =[FSA_dif_all tmp(inTP>0)];
    
    
    %% Albedo
    Albedo_TOP = flipud(Albedo_TOP');
    Albedo_TOP_TP = flipud(Albedo_TOP_TP');
    Albedo_PP = flipud(Albedo_PP');
    
    tmp = Albedo_TOP - Albedo_PP;
    Albedo_dif_all =[Albedo_dif_all tmp(inTP>0)];
    
     %% LH 
    LH_TOP = flipud(LH_TOP');
    LH_TOP_TP = flipud(LH_TOP_TP');
    LH_PP = flipud(LH_PP');
    
    tmp = (LH_TOP - LH_PP);
    LH_dif_all =[LH_dif_all tmp(inTP>0)];


    %% FSH 
    FSH_TOP = flipud(FSH_TOP');
    FSH_TOP_TP = flipud(FSH_TOP_TP');
    FSH_PP = flipud(FSH_PP');
    
    tmp = (FSH_TOP - FSH_PP);
    FSH_dif_all =[FSH_dif_all tmp(inTP>0)];


    
    %% FSNO
    FSNO_TOP = flipud(FSNO_TOP');
    FSNO_TOP_TP = flipud(FSNO_TOP_TP');
    FSNO_PP = flipud(FSNO_PP');
    
    tmp = (FSNO_TOP - FSNO_PP)*100;
    FSNO_dif_all =[FSNO_dif_all tmp(inTP>0)];
   
    %% SWE
    SWE_TOP = flipud(SWE_TOP');
    SWE_TOP_TP = flipud(SWE_TOP_TP');
    SWE_PP = flipud(SWE_PP');
    
    tmp = (SWE_TOP - SWE_PP);
    SWE_dif_all =[SWE_dif_all tmp(inTP>0)];

   
        %% TSA 
    TSA_TOP = flipud(TSA_TOP');
    TSA_TOP_TP = flipud(TSA_TOP_TP');
    TSA_PP = flipud(TSA_PP');
    
    tmp = TSA_TOP - TSA_PP;
    TSA_dif_all =[TSA_dif_all tmp(inTP>0)];
    
        %% PREC
    PREC_TOP = flipud(PREC_TOP');
    PREC_TOP_TP = flipud(PREC_TOP_TP');
    PREC_PP = flipud(PREC_PP');
    
    tmp = (PREC_TOP - PREC_PP);
    PREC_dif_all =[PREC_dif_all tmp(inTP>0)];

end

%% plot
figure;

set(gcf,'unit','normalized','position',[0.1,0.05,0.9,0.6]);
set(gca, 'Position', [0 0 1 1])

condition_names = {'Winter', 'Spring', 'Summer', 'Autumn' , 'Annual'};
colors =  [0.45, 0.80, 0.69;...
    0.98, 0.40, 0.35;...
    0.55, 0.60, 0.79];

%% albedo
subplot('position',[0.05 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(Albedo_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('Unitless','fontweight','bold')
text(0.6,-0.06*0.85,'(a)','fontsize',10,'fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in land surface albedo','fontsize',12)
xlim([0.5 5.5])
ylim([-0.06-eps 0.06+eps])

subplot('position',[0.295 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(FSA_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('W/m^{2}','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in net solar radiation','fontsize',12)
text(0.6,-15*0.85,'(b)','fontsize',10,'fontweight','bold')

xlim([0.5 5.5])
ylim([-15 15])

%% LH FSH
subplot('position',[0.54 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(LH_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('W/m^{2}','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in latent heat flux','fontsize',12)
xlim([0.5 5.5])
ylim([-8 8])
text(0.6,-8*0.85,'(c)','fontsize',10,'fontweight','bold')

subplot('position',[0.785 0.56 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(FSH_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('W/m^{2}','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10, 'xticklabel',[],'fontweight','bold')
title('\Delta in sensible heat flux','fontsize',12)
text(0.6,-8*0.85,'(d)','fontsize',10,'fontweight','bold')

xlim([0.5 5.5])
ylim([-8 8])

%% snow
subplot('position',[0.05 0.12 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(FSNO_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('%','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
title('\Delta in snow cover fraction','fontsize',12)
xlim([0.5 5.5])
ylim([-10 10])
xtickangle(45)
text(0.6,-10*0.85,'(e)','fontsize',10,'fontweight','bold')

subplot('position',[0.295 0.12 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(SWE_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('mm','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
title('\Delta in snow water equivalent','fontsize',12)
xlim([0.5 5.5])
ylim([-20 20])
xtickangle(45)
text(0.6,-20*0.85,'(f)','fontsize',10,'fontweight','bold')

%% air prec
subplot('position',[0.54 0.12 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(TSA_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('K','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
title('\Delta in air temperature','fontsize',12)
xlim([0.5 5.5])
ylim([-1.5 1.5])
xtickangle(45)
text(0.6,-1.5*0.85,'(g)','fontsize',10,'fontweight','bold')


subplot('position',[0.785 0.12 0.2 0.38])
hold on
plot([-1 6],[0 0],'--k');
h = daboxplot(PREC_dif_all(:,1:end),'outsymbol','k+',...
    'xtlabels', condition_names,'color',colors,...
    'whiskers',1,'scatter',0,'jitter',0,'scattersize',13,'mean',1, 'outliers',0);
ylabel('mm','fontweight','bold')
box on
set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
title('\Delta in precipitation','fontsize',12)
xtickangle(45)
xlim([0.5 5.5])
ylim([-1 1])
text(0.6,-1*0.85,'(h)','fontsize',10,'fontweight','bold')


%% %% output
print(gcf, '-dtiff', '-r300', '../tif/figure_S2_season_variation.tif')

