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
    
    %% FSDS
    FSDS_TOP = flipud(FSDS_TOP');
    FSDS_TOP_TP = flipud(FSDS_TOP_TP');
    FSDS_PP = flipud(FSDS_PP');
    
    FSDS_dif = FSDS_TOP_TP - FSDS_PP;
    FSDS_dif_Globe = FSDS_TOP - FSDS_PP;
    
    %% FLDS
    FLDS_TOP = flipud(FLDS_TOP');
    FLDS_TOP_TP = flipud(FLDS_TOP_TP');
    FLDS_PP = flipud(FLDS_PP');
    
    FLDS_dif = FLDS_TOP_TP - FLDS_PP;
    FLDS_dif_Globe = FLDS_TOP - FLDS_PP;
    
     %% FIRE 
    FIRE_TOP = flipud(FIRE_TOP');
    FIRE_TOP_TP = flipud(FIRE_TOP_TP');
    FIRE_PP = flipud(FIRE_PP');
    
    FIRE_dif = (FIRE_TOP_TP - FIRE_PP);
    FIRE_dif_Globe = (FIRE_TOP - FIRE_PP);

   %% Snowfall 
    SNOW_TOP = flipud(SNOW_TOP');
    SNOW_TOP_TP = flipud(SNOW_TOP_TP');
    SNOW_PP = flipud(SNOW_PP');
    
    SNOW_dif = (SNOW_TOP_TP - SNOW_PP);
    SNOW_dif_Globe = (SNOW_TOP - SNOW_PP);



    %% QSNOWMELT 
    QSNOWMELT_TOP = flipud(QSNOMELT_TOP')*3600 *24;
    QSNOWMELT_TOP_TP = flipud(QSNOMELT_TOP_TP')*3600 *24;
    QSNOWMELT_PP = flipud(QSNOMELT_PP')*3600 *24;
    
    QSNOWMELT_dif = (QSNOWMELT_TOP_TP - QSNOWMELT_PP);
    QSNOWMELT_dif_Globe = (QSNOWMELT_TOP - QSNOWMELT_PP);


    
    %% CLD
    CLD_TOP = flipud(CLD_TOP');
    CLD_TOP_TP = flipud(CLD_TOP_TP');
    CLD_PP = flipud(CLD_PP');
    
    CLD_dif = (CLD_TOP_TP - CLD_PP)*100;
    CLD_dif_Globe = (CLD_TOP - CLD_PP)*100;
   


%% figure

res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
colors = flipud(brewermap(21, 'RdBu'));
colors(11,:) = [0.95 0.95 0.95];

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.6,0.7]);
set(gca, 'Position', [0 0 1 1]);

ax1 = subplot('position', [0.05 0.67 0.45 0.31]);
plot_TP_map(lats, lons, FSDS_dif, -10, 10,"\Delta in downward shortwave radiation (W/m^2)",0,1,'(a)');
colormap(ax1, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';


ax2 = subplot('position', [0.53 0.67 0.45 0.31]);
plot_TP_map(lats, lons, FLDS_dif,  -10, 10,"\Delta in downward longwave radiation (W/m^2)",0,0,'(b)');
colormap(ax2, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax3 = subplot('position', [0.05 0.35 0.45 0.31]);
plot_TP_map(lats, lons, FIRE_dif, -10, 10,"\Delta in upward shortwave radiation (W/m^2)",0,1,'(c)');
colormap(ax3, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax4 = subplot('position', [0.53 0.35 0.45 0.31]);
plot_TP_map(lats, lons, SNOW_dif, -0.5, 0.5,"\Delta in snowfall rate (mm/day)",0,0,'(d)');
colormap(ax4, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax5 = subplot('position', [0.05 0.03 0.45 0.31]);
plot_TP_map(lats, lons, QSNOWMELT_dif, -0.5, 0.5,"\Delta in snowmelt rate (mm/day)",1,1,'(e)');
colormap(ax5, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax6 = subplot('position', [0.53 0.03 0.45 0.31]);
plot_TP_map(lats, lons, CLD_dif, -5, 5,"\Delta in cloud cover fraction (%)",1,0,'(f)');
colormap(ax6, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';


%% %% output
print(gcf, '-dtiff', '-r300', ['../tif/figure_S4_spatial_pattern_' season_name '_others.tif'])

close all
end
