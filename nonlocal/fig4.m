clear; clc; close all;


outputPath = 'C:\Users\1\Desktop\陈儒nonlocal论文\修订提交版\figures\';
figWidth_cm = 18.4;     
figHeight_cm = 21;      
fontName = 'Arial';     
axisFontSize_pt = 8;    
labelFontSize_pt = 9;   
coastColor = [0.7 0.7 0.7]; 

load(strcat('D:\nonlocal KE cascade Data\pais_and_js\Pil24ym.mat'),'pil_24ym');
load(strcat('D:\nonlocal KE cascade Data\pais_and_js\Pis24ym.mat'),'pis_24ym');
load(strcat('D:\nonlocal KE cascade Data\pais_and_js\Pir24ym.mat'),'pir_24ym');

lon = (1/8):(1/4):360; lat = (-90+1/8):(1/4):90;
lon1 = interp1(lon, 1:0.5:1440); lat1 = interp1(lat, 1:0.5:720);
[y0, x0] = meshgrid(lat1, lon1);

pil1 = squeeze(pil_24ym(:,:,4));
pil2 = squeeze(pil_24ym(:,:,20));
pis1 = squeeze(pis_24ym(:,:,4));
pis2 = squeeze(pis_24ym(:,:,20));
pir1 = squeeze(pir_24ym(:,:,4));
pir2 = squeeze(pir_24ym(:,:,20));

% % 平滑核函数
% resolution = 0.5;
% t = resolution / 0.25;
% tt = t * t;
% h = ones(t, t) / tt;

% pil1 = nanconv(squeeze(pil_24ym(:,:,4)), h, 'edge', 'nanout');
% pil2 = nanconv(squeeze(pil_24ym(:,:,20)), h, 'edge', 'nanout');
% pis1 = nanconv(squeeze(pis_24ym(:,:,4)), h, 'edge', 'nanout');
% pis2 = nanconv(squeeze(pis_24ym(:,:,20)), h, 'edge', 'nanout');
% pir1 = nanconv(squeeze(pir_24ym(:,:,4)), h, 'edge', 'nanout');
% pir2 = nanconv(squeeze(pir_24ym(:,:,20)), h, 'edge', 'nanout');

plot_data = {pil1, pil2; pis1, pis2; pir1, pir2};

clim_row1 = [-5e-6 5e-6]; clim_row2 = [-5e-6 5e-6]; clim_row3 = [-1e-4 1e-4]; 
row_clims = {clim_row1, clim_row2, clim_row3};

figure('Units', 'centimeters', 'Position', [5, 5, figWidth_cm, figHeight_cm]);

ha = tight_subplot(3, 2, [0.08 0.02], [0.08 0.05], [0.05 0.05]);

% 加载 colormap
load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat');
color3 = color(50:206, :);

labels = {'A', 'B', 'C', 'D', 'E', 'F'};
for k = 1:6
    axes(ha(k)); 
    current_row = ceil(k/2); 
    
    m_proj('miller', 'lon', [0 360], 'lat', [-80 80]);
    hold on;
    m_pcolor(x0, y0, plot_data{k});
    shading flat;
    m_coast('patch', coastColor, 'edgecolor', 'k');

    if mod(k, 2) == 1 
        if k == 5 
             m_grid('linestyle', 'none', 'xaxisloc', 'bottom', 'yaxisloc', 'left', 'fontsize', axisFontSize_pt, 'fontname', fontName);
        else
             m_grid('linestyle', 'none', 'xticklabel', [], 'yaxisloc', 'left', 'fontsize', axisFontSize_pt, 'fontname', fontName);
        end
    else
        if k == 6 
             m_grid('linestyle', 'none','xaxisloc', 'bottom', 'yticklabel', [], 'fontsize', axisFontSize_pt, 'fontname', fontName);
        else
             m_grid('linestyle', 'none','xticklabel', [], 'yticklabel', [], 'fontsize', axisFontSize_pt, 'fontname', fontName);
        end
    end
    
    colormap(gca, color3);
    clim(row_clims{current_row});

    m_text(35, 75, labels{k}, 'FontName', fontName, 'FontSize', labelFontSize_pt, 'FontWeight', 'bold', 'Margin', 1);

    if mod(k, 2) == 0
        pos_left = get(ha(k-1), 'Position'); 
        pos_right = get(ha(k), 'Position');  

        cb_indent = 0.3; 
        cb_left = pos_left(1) + cb_indent;
        cb_width = (pos_right(1) + pos_right(3)) - pos_left(1) - 2*cb_indent;
        cb_height = 0.02; 

        if current_row < 3
            offset_y = 0.025; 
        else
            offset_y = 0.04; 
        end
        
        cb_bottom = pos_left(2) - offset_y; 
      
        c = colorbar('Position', [cb_left, cb_bottom, cb_width, cb_height], ...
                     'Orientation', 'horizontal', ...
                     'Location', 'manual'); 
        
        c.Label.String = 'W/m^3'; 
        c.FontSize = axisFontSize_pt;
        c.FontName = fontName;
      
        c_limits = row_clims{current_row};
        c.Ticks = linspace(c_limits(1), c_limits(2), 5); 
        c.TickLabelInterpreter = 'tex';
    end
end
% --- 5. 导出为出版级TIFF ---
% exportgraphics(gcf, [outputPath, 'Figure4.tiff'], 'Resolution', 300);