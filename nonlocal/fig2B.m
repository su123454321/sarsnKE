clear; clc; close all;

outputPath = 'C:\Users\1\Desktop\陈儒nonlocal论文\修订提交版\figures\'; 
figWidth_cm = 9;       
figHeight_cm = 8;      
fontName = 'Arial';   
axisFontSize_pt = 8;   

dt = 0.125; 
interval = 0.25;
dtt = 0.25:interval:12;
kkk = 1./dtt;

load('D:\nonlocal KE cascade Data\ER\E_gm24_all.mat','EL_gm24y','ES_gm24y','ER_gm24y');
M = 24;
stes = zeros(1, 48); stel = zeros(1, 48); ster = zeros(1, 48);

for k2=1:48
    [c1,~]=xcov(squeeze(ES_gm24y(:,k2)),M-1,'coeff');
    [c2,~]=xcov(squeeze(EL_gm24y(:,k2)),M-1,'coeff');
    [c3,~]=xcov(squeeze(ER_gm24y(:,k2)),M-1,'coeff');
    C1 = zeros(1, M-1); C2 = zeros(1, M-1); C3 = zeros(1, M-1);
    for lag = 1:M-1
        C1(lag) = sum(c1(M-lag:M+lag));
        C2(lag) = sum(c2(M-lag:M+lag));
        C3(lag) = sum(c3(M-lag:M+lag));
    end
    df1=M/max(C1); df2=M/max(C2); df3=M/max(C3);
    stes(k2)=2*std(squeeze(ES_gm24y(:,k2)),0)/sqrt(df1);
    stel(k2)=2*std(squeeze(EL_gm24y(:,k2)),0)/sqrt(df2);
    ster(k2)=2*std(squeeze(ER_gm24y(:,k2)),0)/sqrt(df3);
end

load('D:\nonlocal KE cascade Data\ER\E_gm24y.mat','el_gm','es_gm','er_gm');
aa=sqrt((6378.1*pi/180*cos(0))*(6378.1*pi/180));

figure('Units', 'centimeters', 'Position', [5, 5, figWidth_cm, figHeight_cm]);

ax1_pos = [0.16, 0.25, 0.82, 0.70]; 
ax1 = axes('Position', ax1_pos);
hold on; 

s1 = shadedErrorBar(kkk/aa, el_gm, stel, 'lineProps', {'-','Color','#3A5FCD','LineWidth',1.5});
if isfield(s1, 'edge'), set(s1.edge,'color',[1 1 1]); end
s1.patch.FaceColor = '#294390';
s1.mainLine.Color = '#3A5FCD';

s2 = shadedErrorBar(kkk/aa, es_gm, stes, 'lineProps', {'-','Color','#BA3838','LineWidth',1.5});
if isfield(s2, 'edge'), set(s2.edge,'color',[1 1 1]); end
s2.patch.FaceColor = '#952D2D';
s2.mainLine.Color = '#BA3838';

s3 = shadedErrorBar(kkk/aa, er_gm, ster, 'lineProps', {'-','Color','#FFBF71','LineWidth',1.5});
if isfield(s3, 'edge'), set(s3.edge,'color',[1 1 1]); end
s3.patch.FaceColor = '#CC7000';
s3.mainLine.Color = '#FFBF71';

set(ax1, ...
    'FontName', fontName, ...
    'FontSize', axisFontSize_pt, ...
    'LineWidth', 0.5, ...
    'Box', 'on', ...
    'XLim', [0 0.02], ...
    'TickDir', 'in', ...
    'XColor', 'k', 'YColor', 'k');

xlabel(ax1, '{\itK} (cpkm)', 'Interpreter', 'tex', ...
    'FontName', fontName, 'FontSize', axisFontSize_pt);
ylabel(ax1, 'Energy (J/m^3)', 'Interpreter', 'tex', 'FontName', fontName, 'FontSize', axisFontSize_pt);


lgd = legend([s1.mainLine, s2.mainLine, s3.mainLine], 'KE_L^g', 'KE_S^g', 'KE_R^g', 'Location', 'east');
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

xlabel(ax2, 'Length scale', 'FontName', fontName, 'FontSize', axisFontSize_pt, 'Interpreter',['tex']);

linkaxes([ax1, ax2], 'x');

if ~exist(outputPath, 'dir')
    mkdir(outputPath);
end
exportgraphics(gcf, [outputPath, 'Figure2B_new.pdf'], 'ContentType', 'vector');