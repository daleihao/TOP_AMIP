function plot_global_map_globe(lats, lons, sw_total, min_clr, max_clr, title_text)
axis equal
%m_proj('stereographic','lat',90,'long',0,'radius',65); % robinson Mollweide
m_proj('miller','lat',[0 50],'lon',[60 160]);
hold on
%m_proj('lambert','long',[0 360],'lat',[-90 90]);
m_grid('tickdir','in','linestyle','--', 'gridcolor',[0.7 0.7 0.7],...
        'fontsize',8,'tickstyle','dd','xtick',12,'ytick',6);

%sw_total = log10(sw_total);
%sw_total(lats>66.5) = nan; 

%% remove greenland etween latitudes 59° and 83°N, and longitudes 11° and 74°W. 
%filters = lats> 59 & lats <=90 & lons > (360-63) & lons < (360-11);
m_pcolor(lons,lats,sw_total);

%hold on
%m_coord('geographic');    

lat_border = [[25.5 26:40] 40*ones(1,38) [40:-1:26 25.5] 25.5*ones(1,38)];  %// (20 45 65 105)
lon_border = [68*ones(1,16) 68:105 105*ones(1,16) 105:-1:68];

lat_border = [25.5 40 40 25.5 25.5];  %// (20 45 65 105)
lon_border = [68 68 105 105 68];

m_line(lon_border, lat_border,'color','r','linewidth',1);


M=m_shaperead('TP_region/The_Tibetan_Plateau');
%M=m_shaperead('../TP_shp/ROTW_China');
for k=1:1;%length(M.ncst)
    m_line(M.ncst{k}(:,1),M.ncst{k}(:,2),'color','k','linewidth',1);,'backcolor',[.9 .99 1],
end

m_coast('color','k');

shading interp;

%% plot contour
caxis([min_clr-1e-5,max_clr+1e-5]);
%colormap(m_colmap('jet','step',10));
%m_text(-170,80,sub_text,'fontsize',10)
%colorbar
%colormap(colors_single);

if title_text ~= ""
    t = title({title_text},'fontsize',12, 'fontweight', 'bold');
%     set(t, 'horizontalAlignment', 'left');
%     set(t, 'units', 'normalized');
%     h1 = get(t, 'position');
%     set(t, 'position', [0 h1(2) h1(3)]);
end

set(gca, 'FontName', 'Time New Roman');

view(0,90);
hold off