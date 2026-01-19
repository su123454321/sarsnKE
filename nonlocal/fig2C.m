clear; clc; close all;

outputPath = 'C:\Users\1\Desktop\陈儒nonlocal论文\修订提交版\figures\';
figWidth_cm = 9;       
figHeight_cm = 8;      
fontName = 'Arial';   
axisFontSize_pt = 8;   
lineWidth_pt = 2.0;    
color1 = '#DA5953';   
color2 = '#1975BA';   

load('D:\nonlocal KE cascade Data\ER\E_gm24y.mat', 'el_gm', 'es_gm', 'er_gm');
interval=0.25;
dtt=0.25:interval:12;
kkk=1./dtt;
aa=sqrt((6378.1*pi/180*cos(0))*(6378.1*pi/180));
ratio1=er_gm./es_gm;
ratio2=er_gm./el_gm;

figure('Units', 'centimeters', 'Position', [5, 5, figWidth_cm, figHeight_cm]);

ax1_pos = [0.16, 0.25, 0.82, 0.70]; 
ax1 = axes('Position', ax1_pos);

yyaxis left;
p1 = plot(kkk./aa, ratio1, 'LineWidth', lineWidth_pt, 'Color', color1);
ylim([0 14]);
set(gca, 'YColor', color1, 'YTick', 0:2:14, 'TickDir', 'in');

yyaxis right;
p2 = plot(kkk./aa, ratio2, 'LineWidth', lineWidth_pt, 'Color', color2);
ylim([0 0.7]);
set(gca, 'YColor', color2, 'YTick', 0:0.1:0.7, 'TickDir', 'in');

set(ax1, ...
    'FontName', fontName, ...
    'FontSize', axisFontSize_pt, ...
    'FontUnits', 'points', ...
    'LineWidth', 0.5, ...
    'Box', 'on', ...      
    'XLim', [0 0.02], ...
    'TickDir', 'in', ...  
    'XColor', 'k');       

xlabel(ax1, '{\itK} (cpkm)', 'Interpreter', 'tex', ...
    'FontName', fontName, 'FontSize', axisFontSize_pt);

lgd = legend([p1, p2], 'KE_R^g/KE_S^g', 'KE_R^g/KE_L^g', 'Location', 'northeast', 'Interpreter', 'tex');
set(lgd, 'FontName', fontName, 'FontSize', axisFontSize_pt, 'Box', 'on');

desired_degrees = [7, 5, 3, 1, 0.5]; 
ticks_middle_K = 1 ./ (desired_degrees * aa);

tick_left_K = 0; 
label_left = '\infty'; 

degree_labels = string(desired_degrees) + "^{\circ}";

all_ticks_K = [tick_left_K, ticks_middle_K];
all_labels = [{label_left}, degree_labels];

[all_ticks_K, sortIdx] = sort(all_ticks_K);
all_labels = all_labels(sortIdx);

ax2 = axes('Position', ax1_pos, ... 
    'Color', 'none', ...
    'Box', 'off', ...
    'XAxisLocation', 'bottom', ... 
    'YAxisLocation', 'right', ... 
    'YTick', [], ...
    'YColor', 'none');

set(ax2, ...
    'XLim', get(ax1, 'XLim'), ...
    'XTick', all_ticks_K, ...
    'XTickLabel', all_labels, ...
    'TickLabelInterpreter', 'tex', ... 
    'FontName', fontName, ...
    'FontSize', axisFontSize_pt, ...
    'LineWidth', 0.5, ...
    'TickDir', 'in');

ax2.Position(2) = ax2.Position(2) - 0.12; 
ax2.Position(4) = 0.001; 

xlabel(ax2, 'Length scale', 'FontName', fontName, 'FontSize', axisFontSize_pt);

linkaxes([ax1, ax2], 'x');

if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end
exportgraphics(gcf, [outputPath, 'Figure2C_new.pdf'], 'ContentType', 'vector');