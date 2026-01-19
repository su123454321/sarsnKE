clear; clc; close all;

outputPath = 'C:\Users\1\Desktop\陈儒nonlocal论文\修订提交版\figures\';
figWidth_cm = 18.4;    
figHeight_cm = 9.5;    
fontName = 'Arial';    
axisFontSize_pt = 8;    
coastColor = [0.7 0.7 0.7];

load(strcat('F:\nonlocal KE cascade Data\pais_and_js\Pir24ym.mat'),'pir_24ym');
lon = (1/8):(1/4):360; lat = (-90+1/8):(1/4):90;
loni = lon(1:4:1440); lati = lat(1:4:720);
lon1 = interp1(lon, 1:0.5:1440); lat1 = interp1(lat, 1:0.5:720);
[y0, x0] = meshgrid(lat1, lon1);
resolution = 5; t = resolution/0.25; h = ones(t,t)/(t*t);
pir_map_data = nanconv(squeeze(pir_24ym(:,:,12)), h, 'edge', 'nanout');

i1=find(loni>150 & loni<225); j1=find(lati>10 & lati<22);
i2=find(loni>130 & loni<170); j2=find(lati>29 & lati<42);
i3=find(loni>282 & loni<307); j3=find(lati>29 & lati<42);
i4=find(loni>25 & loni<150); j4=find(lati>-65 & lati<-40);
i5=find(loni>150 & loni<287); j5=find(lati>-65 & lati<-40);
i6=find(loni>287 & loni<360); j6=find(lati>-65 & lati<-40);
i7=find(loni>0 & loni<25); j7=find(lati>-65 & lati<-40); 
region_indices = {{i1,j1},{i2,j2},{i3,j3},{i4,j4},{i5,j5},{i6,j6},{i7,j7}};

figure('Units', 'centimeters', 'Position', [5, 5, figWidth_cm, figHeight_cm]);
axA = axes('Position', [0.05, 0.05, 0.8, 0.9]); 
m_proj('robinson', 'lon', [0 360], 'lat', [-80 80]);
hold on;
m_pcolor(x0, y0, pir_map_data); shading flat;
m_coast('patch', coastColor, 'edgecolor', 'k');
m_grid('linestyle', 'none', 'tickdir', 'out', 'xaxisloc', 'bottom', 'yaxisloc', 'left', ...
    'fontsize', axisFontSize_pt, 'fontname', fontName,'BackgroundColor', [0.7 0.7 0.7]);

for rr=1:7
    idx = region_indices{rr};
    loni_box = loni(idx{1}([1 1 end end 1]));
    lati_box = lati(idx{2}([1 end end 1 1]));
    m_line(loni_box, lati_box, 'color', 'k', 'LineWidth', 1.0);
end
c = colorbar('Location', 'eastoutside');
set(get(c,'Title'),'string','W/m^3');
c.FontSize = axisFontSize_pt; c.FontName = fontName;
c.Position=[0.874820143884892,0.237043942952646,0.031654676258993,0.526187254818941];
clim([-5e-6 5e-6]); 
set(c,'ytick',[-5e-6 -2.5e-6 0 2.5e-6 5e-6])

load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat');
colormap(axA, color(50:206,:));

set(gcf, 'color', 'w');
exportgraphics(gcf, [outputPath, 'Figure5G.tiff'], 'Resolution', 600);
