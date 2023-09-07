clc;
clear all;
close all;


for season_i = 1:5 %% annual
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
    
    FSA_dif = FSA_TOP_TP - FSA_PP;
    FSA_dif_Globe = FSA_TOP - FSA_PP;
    
    %% Albedo
    Albedo_TOP = flipud(Albedo_TOP');
    Albedo_TOP_TP = flipud(Albedo_TOP_TP');
    Albedo_PP = flipud(Albedo_PP');
    
    Albedo_dif = Albedo_TOP_TP - Albedo_PP;
    Albedo_dif_Globe = Albedo_TOP - Albedo_PP;
    
     %% LH 
    LH_TOP = flipud(LH_TOP');
    LH_TOP_TP = flipud(LH_TOP_TP');
    LH_PP = flipud(LH_PP');
    
    LH_dif = (LH_TOP_TP - LH_PP);
    LH_dif_Globe = (LH_TOP - LH_PP);


    %% FSH 
    FSH_TOP = flipud(FSH_TOP');
    FSH_TOP_TP = flipud(FSH_TOP_TP');
    FSH_PP = flipud(FSH_PP');
    
    FSH_dif = (FSH_TOP_TP - FSH_PP);
    FSH_dif_Globe = (FSH_TOP - FSH_PP);


    
    %% FSNO
    FSNO_TOP = flipud(FSNO_TOP');
    FSNO_TOP_TP = flipud(FSNO_TOP_TP');
    FSNO_PP = flipud(FSNO_PP');
    
    FSNO_dif = (FSNO_TOP_TP - FSNO_PP)*100;
    FSNO_dif_Globe = (FSNO_TOP - FSNO_PP)*100;
   
    %% SWE
    SWE_TOP = flipud(SWE_TOP');
    SWE_TOP_TP = flipud(SWE_TOP_TP');
    SWE_PP = flipud(SWE_PP');
    
    SWE_dif = (SWE_TOP_TP - SWE_PP);
    SWE_dif_Globe = (SWE_TOP - SWE_PP);

   
        %% TSA 
    TSA_TOP = flipud(TSA_TOP');
    TSA_TOP_TP = flipud(TSA_TOP_TP');
    TSA_PP = flipud(TSA_PP');
    
    TSA_dif = TSA_TOP_TP - TSA_PP;
    TSA_dif_Globe = TSA_TOP - TSA_PP;
    
        %% PREC
    PREC_TOP = flipud(PREC_TOP');
    PREC_TOP_TP = flipud(PREC_TOP_TP');
    PREC_PP = flipud(PREC_PP');
    
    PREC_dif = (PREC_TOP_TP - PREC_PP);
    PREC_dif_Globe = (PREC_TOP - PREC_PP);


%% figure

res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
colors = flipud(brewermap(21, 'RdBu'));
colors(11,:) = [0.95 0.95 0.95];

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.9]);
set(gca, 'Position', [0 0 1 1]);

ax1 = subplot('position', [0.05 0.76 0.45 0.2]);
plot_TP_map(lats, lons, Albedo_dif, -0.05, 0.05,"\Delta in land surface albedo (Unitless)",0,1,'(a)');
colormap(ax1, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';


ax2 = subplot('position', [0.53 0.76 0.45 0.2]);
plot_TP_map(lats, lons, FSA_dif, -15, 15,"\Delta in net solar radiation (W/m^2)",0,0,'(b)');
colormap(ax2, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax3 = subplot('position', [0.05 0.52 0.45 0.2]);
plot_TP_map(lats, lons, LH_dif, -8, 8,"\Delta in latent heat flux (W/m^2)",0,1,'(c)');
colormap(ax3, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax4 = subplot('position', [0.53 0.52 0.45 0.2]);
plot_TP_map(lats, lons, FSH_dif, -8, 8,"\Delta in sensible heat flux (W/m^2)",0,0,'(d)');
colormap(ax4, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax5 = subplot('position', [0.05 0.28 0.45 0.2]);
plot_TP_map(lats, lons, FSNO_dif, -10, 10,"\Delta in snow cover fraction (%)",0,1,'(e)');
colormap(ax5, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax6 = subplot('position', [0.53 0.28 0.45 0.2]);
plot_TP_map(lats, lons, SWE_dif, -20, 20,"\Delta in snow water equivalent (mm)",0,0,'(f)');
colormap(ax6, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax7 = subplot('position', [0.05 0.04 0.45 0.2]);
plot_TP_map(lats, lons, TSA_dif, -1, 1,"\Delta in air temperature (K)",1,1,'(g)');
colormap(ax7, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax8 = subplot('position', [0.53 0.04 0.45 0.2]);
plot_TP_map(lats, lons, PREC_dif, -0.5, 0.5,"\Delta in precipitation (mm/day)",1,0,'(h)');
colormap(ax8, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

%% %% output
print(gcf, '-dtiff', '-r300', ['../tif/figure_1_spatial_pattern_' season_name '.tif'])

close all
end
