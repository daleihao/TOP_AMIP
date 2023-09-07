clc;
clear all;
close all;
%% plot
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
colors = flipud(brewermap(21, 'RdBu'));
colors(11,:) = [0.95 0.95 0.95];

%% telected
%% another 
season_name = 'ANN';
  load(['../../process_E3SM_simulation/ELM_season_' season_name '_F2010_final.mat']);
  load(['../../process_E3SM_simulation/EAM_season_' season_name '_F2010_final.mat']);
 load(['../../benchmark_datasets/mat_2005_2015/UDel_Temp_' season_name '.mat']);
 load(['../../benchmark_datasets/mat_2005_2015/GPCP_' season_name '.mat']);

TSA_Obs_annual = Tair + 273.15;

TSA_TOP_annual = flipud(TSA_TOP');
TSA_TOP_TP_annual = flipud(TSA_TOP_TP');
TSA_PP_annual = flipud(TSA_PP');
TSA_bias_annual = TSA_PP_annual - TSA_Obs_annual;
TSA_Dif_TP_annual = TSA_TOP_TP_annual - TSA_PP_annual;

PREC_Obs_annual = Precp;

PREC_TOP_annual = flipud(PREC_TOP');
PREC_TOP_TP_annual = flipud(PREC_TOP_TP');
PREC_PP_annual = flipud(PREC_PP');
PREC_bias_annual = PREC_PP_annual - PREC_Obs_annual;
PREC_Dif_TP_annual = PREC_TOP_TP_annual - PREC_PP_annual;


season_name = 'JJA';
  load(['../../process_E3SM_simulation/ELM_season_' season_name '_F2010_final.mat']);
  load(['../../process_E3SM_simulation/EAM_season_' season_name '_F2010_final.mat']);
   load(['../../benchmark_datasets/mat_2005_2015/UDel_Temp_' season_name '.mat']);

load(['../../benchmark_datasets/mat_2005_2015/GPCP_' season_name '.mat']);

TSA_Obs_summer = Tair + 273.15;

TSA_TOP_summer = flipud(TSA_TOP');
TSA_TOP_TP_summer = flipud(TSA_TOP_TP');
TSA_PP_summer = flipud(TSA_PP');
TSA_bias_summer = TSA_PP_summer - TSA_Obs_summer;
TSA_Dif_TP_summer = TSA_TOP_TP_summer - TSA_PP_summer;

PREC_Obs_summer = Precp;

PREC_TOP_summer = flipud(PREC_TOP');
PREC_TOP_TP_summer = flipud(PREC_TOP_TP');
PREC_PP_summer = flipud(PREC_PP');
PREC_bias_summer = PREC_PP_summer - PREC_Obs_summer;
PREC_Dif_TP_summer = PREC_TOP_TP_summer - PREC_PP_summer;

%% plot figure
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
colors = flipud(brewermap(21, 'RdBu'));
colors(11,:) = [0.95 0.95 0.95];

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.56,0.9]);
set(gca, 'Position', [0 0 1 1]);

ax1 = subplot('position', [0.08 0.75 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, TSA_bias_annual, -4, 4,"PP\_Globe - Benchmark",0,1,'(a)');
colormap(ax1, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Annual' 'Air temperature (K)',''},'fontweight','bold','fontsize',9)

ax2 = subplot('position', [0.52 0.75 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, TSA_Dif_TP_annual, -1, 1,"TOP\_TP - PP\_Globe",0,0,'(b)');
colormap(ax2, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax3 = subplot('position', [0.08 0.51 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, PREC_bias_annual, -4, 4,"",0,1,'(c)');
colormap(ax3, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Annual' 'Precipitation (mm/day)',''},'fontweight','bold','fontsize',9)

ax4 = subplot('position', [0.52 0.51 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, PREC_Dif_TP_annual, -0.5, 0.5,"",0,0,'(d)');
colormap(ax4, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax5 = subplot('position', [0.08 0.27 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, TSA_bias_summer, -4, 4,"",0,1,'(e)');
colormap(ax5, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Summer' 'Air temperature (K)',''},'fontweight','bold','fontsize',9)

ax6 = subplot('position', [0.52 0.27 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, TSA_Dif_TP_summer, -1, 1,"",0,0,'(f)');
colormap(ax6, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

ax7 = subplot('position', [0.08 0.03 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, PREC_bias_summer, -4, 4,"",1,1,'(g)');
colormap(ax7, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Summer','Precipitation (mm/day)',''},'fontweight','bold','fontsize',9)

ax8 = subplot('position', [0.52 0.03 0.47 0.22]);
plot_global_map_with_boundary(lats, lons, PREC_Dif_TP_summer, -0.5, 0.5,"",1,0,'(h)');
colormap(ax8, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';

print(gcf, '-dtiff', '-r300', ['../tif/figure_3_remote_effects.tif']);

close all
