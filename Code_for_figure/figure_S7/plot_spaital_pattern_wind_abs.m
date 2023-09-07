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
season_name = 'JJA';
load(['../../process_E3SM_simulation/EAM_season_' season_name '_F2010_final_UV_2.mat']);

UPP = squeeze(U_PP(:,:,3));
VPP = squeeze(V_PP(:,:,3));

UPP = flipud(UPP');
VPP = flipud(VPP');

UVdif850 = sqrt(UPP.^2 + UPP.^2);

Udif850 = UPP;
Vdif850 = VPP;

%% 500
UPP = squeeze(U_PP(:,:,2));
VPP = squeeze(V_PP(:,:,2));

UPP = flipud(UPP');
VPP = flipud(VPP');

UVdif500 = sqrt(UPP.^2 + UPP.^2);

Udif500 = UPP;
Vdif500 = VPP;

%% 200
UPP = squeeze(U_PP(:,:,1));
VPP = squeeze(V_PP(:,:,1));

UPP = flipud(UPP');
VPP = flipud(VPP');

UVdif200 =  sqrt(UPP.^2 + UPP.^2);

Udif200 = UPP;
Vdif200 = VPP;
%% plot figure
res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
colors = flipud(brewermap(21, 'RdBu'));
colors(11,:) = [0.95 0.95 0.95];

figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.4,0.9]);
set(gca, 'Position', [0 0 1 1]);

ax1 = subplot('position', [0.08 0.67 0.9 0.29]);
plot_global_map(lats, lons, UVdif850, Udif850, Vdif850, 0, 10,"850hPa",0,1,'(a)');
colormap(ax1, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Summer wind speed (m/s)',''},'fontweight','bold','fontsize',9)

ax2 = subplot('position', [0.08 0.35 0.9 0.29]);
plot_global_map(lats, lons, UVdif500, Udif500, Vdif500, 0, 10,"500hPa",0,1,'(b)');
colormap(ax2, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Summer wind speed (m/s)',''},'fontweight','bold','fontsize',9)

ax3 = subplot('position', [0.08 0.03 0.9 0.29]);
plot_global_map(lats, lons, UVdif200, Udif200, Vdif200, 0, 10,"200hPa",1,1,'(c)');
colormap(ax3, colors);
cb = colorbar;
cb.FontSize = 10;
cb.FontWeight = 'bold';
ylabel({'Summer wind speed (m/s)',''},'fontweight','bold','fontsize',9)

print(gcf, '-dtiff', '-r300', ['../tif/figure_S7_wind_abs.tif']);

close all
