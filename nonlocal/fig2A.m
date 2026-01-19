clear; clc; close all;

outputPath = 'C:\Users\1\Desktop\陈儒nonlocal论文\修订提交版\figures\'; 
figWidth_cm = 18.4;     % 双栏宽度 (cm)
figHeight_cm = 9;     
fontName = 'Arial';    
axisFontSize_pt = 8;   
lineWidth_pt = 0.5;     
boxLineWidth_pt = 1.5;  

load('D:\nonlocal KE cascade Data\ER\ER_24y.mat');
dt = 0.125; 
interval = 0.25;
dtt = 0.25:interval:12;
lon = (1/8):(1/4):360; lat = (-90+1/8):(1/4):90;
loni = lon(1:4:1440); lati = lat(1:4:720);
[y, x] = meshgrid(lati, loni);
lon1 = interp1(lon, 1:0.5:1440); lat1 = interp1(lat, 1:0.5:720);
[y0, x0] = meshgrid(lat1, lon1);
i1 = find(loni > 150 & loni < 225); j1 = find(lati > 10 & lati < 22);
i2 = find(loni > 130 & loni < 170); j2 = find(lati > 29 & lati < 42);
i3 = find(loni > 282 & loni < 307); j3 = find(lati > 29 & lati < 42);
i4 = find(loni > 25 & loni < 150); j4 = find(lati > -65 & lati < -40);
i5 = find(loni > 150 & loni < 287); j5 = find(lati > -65 & lati < -40);
i6 = find(loni > 287 & loni < 360); j6 = find(lati > -65 & lati < -40);
i7 = find(loni > 0 & loni < 25); j7 = find(lati > -65 & lati < -40);

figure('Units', 'centimeters', 'Position', [5, 5, figWidth_cm, figHeight_cm]);

m_proj('equidistant cylindrical', 'lon', [0 360], 'lat', [-80 80]);
hold on;
m_pcolor(x0, y0, ER_24ym(:, :, 4));
shading flat; 

m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');

% m_grid('linestyle', '-', 'linewidth', 0.5, 'xaxisloc', 'bottom', ...
%       'yaxisloc', 'left', 'fontsize', axisFontSize_pt, 'fontname', fontName, ...
%       'color', [0.5 0.5 0.5]);

m_grid('linestyle', 'none', 'tickdir', 'out', 'xaxisloc', 'bottom', ...
       'yaxisloc', 'left', 'fontsize', axisFontSize_pt, 'fontname', fontName);

c = colorbar;
% c.Label.String = 'J/m^3';
set(get(c,'Title'),'string','J/m^3');
c.Label.FontSize = axisFontSize_pt;
c.Label.FontName = fontName;
c.FontSize = axisFontSize_pt;
c.FontName = fontName;
caxis([-10 10]);  
colormap(othercolor('BuDRd_18'));


hold on
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',boxLineWidth_pt);    
    hold on  
end

set(gca, 'LineWidth', lineWidth_pt, 'Box', 'on');
set(gcf, 'color', 'w'); 

exportgraphics(gcf, [outputPath, 'Figure2A.tiff'], 'Resolution', 300);


