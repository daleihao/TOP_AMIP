clc;
clear all;
close all;

load('top_factor_0_5_degree_v2.mat');

global_elev = elev_low;
min_value = 0;
max_value = 5000;

res = 0.5;
[lons, lats] = meshgrid( (-180+res/2):res:(180-res/2),(90-res/2):-res:(-90+res/2));
colors = flipud(brewermap(21, 'Spectral'));
%colors(6,:) = [0.95 0.95 0.95];
figure;
set(gcf,'unit','normalized','position',[0.1,0.05,0.46,0.4]);
set(gca, 'Position', [0.01 0.05 0.95 0.9]);
colormap(colors);
plot_global_map_globe(lats, lons, global_elev, min_value, max_value,"");

hcb = colorbar;
hcb.Location = 'eastoutside';
hcb.Title.FontSize = 8;
hcb.Title.FontWeight = 'Bold';
hcb.Title.String = "m";
x1=get(gca,'position');
x=get(hcb,'Position');
x(2)=0.15;
x(1) = 0.9;
x(4) = 0.7;
set(hcb,'Position',x);
%text(-1.3,1.1,'a','fontweight','bold','fontsize',12)

% %% snow cover
% figure;
print(gcf, '-dtiff', '-r300', ['../tif/TP_elevation.tif']);
close all