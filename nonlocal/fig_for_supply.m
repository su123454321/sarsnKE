clear;clc
load(strcat('F:\nonlocal KE cascade Data\pais_and_js\Pil24ym.mat'),'pil_24ym')
load(strcat('F:\nonlocal KE cascade Data\pais_and_js\Pis24ym.mat'),'pis_24ym')
load(strcat('F:\nonlocal KE cascade Data\pais_and_js\Pir24ym.mat'),'pir_24ym')
load('F:\nonlocal KE cascade Data\pais_and_js\pi_gmm_all.mat','piL_gmm','piS_gmm','piR_gmm')

%%
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
lon=(1/8):(1/4):360;lat=(-90+1/8):(1/4):90;%全球，1/4度分辨率
loni=lon(1:4:1440);lati=lat(1:4:720);
[y,x]=meshgrid(lati,loni);
lon1=interp1(lon,1:0.5:1440);lat1=interp1(lat,1:0.5:720);
[y0,x0]=meshgrid(lat1,lon1);
%%
ind=44;
pil = squeeze(pil_24ym(:,:,ind));
pis = squeeze(pis_24ym(:,:,ind));
pir = squeeze(pir_24ym(:,:,ind));
%% pil
figure
set(gca,'FontSize',11)
set(gcf,'color','w');  

load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5 5];
% set(gcf,'Units','centimeters','Position',[5 5 20 16])
m_proj('miller','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,pil*1e6);shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch',[.7 .7 .7],'edgecolor','k');
colormap(color3);
clim(clim_range);

c = colorbar;  % 可以改成 'southoutside' 放到底部
c.Location = 'eastoutside';
c.FontSize = 11;
c.FontWeight = 'bold';
c.Limits = clim_range;
c.Ticks = [-5 -2.5 0 2.5 5];
c.TickLength = 0.005;
c.Title.String = '\muW/m^3';  % 设置 colorbar 标注
c.Title.Position = [17 176.9304802261237 0];

savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\supply\l-11deg.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\pir_amp_5°running_average.jpg','Resolution',300)

%% pis
figure
set(gca,'FontSize',11)
set(gcf,'color','w');  

load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5 5];
% set(gcf,'Units','centimeters','Position',[5 5 20 16])
m_proj('miller','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,pis*1e6);shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch',[.7 .7 .7],'edgecolor','k');
colormap(color3);
clim(clim_range);

c = colorbar;  % 可以改成 'southoutside' 放到底部
c.Location = 'eastoutside';
c.FontSize = 11;
c.FontWeight = 'bold';
c.Limits = clim_range;
c.Ticks = [-5 -2.5 0 2.5 5];
c.TickLength = 0.005;
c.Title.String = '\muW/m^3';  % 设置 colorbar 标注
c.Title.Position = [17 176.9304802261237 0];

savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\supply\s-11deg.fig')

%% pir
figure
set(gca,'FontSize',11)
set(gcf,'color','w');  

load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5 5];
% set(gcf,'Units','centimeters','Position',[5 5 20 16])
m_proj('miller','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,pir*1e6);shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch',[.7 .7 .7],'edgecolor','k');
colormap(color3);
clim(clim_range);

c = colorbar;  % 可以改成 'southoutside' 放到底部
c.Location = 'eastoutside';
c.FontSize = 11;
c.FontWeight = 'bold';
c.Limits = clim_range;
c.Ticks = [-5 -2.5 0 2.5 5];
c.TickLength = 0.005;
c.Title.String = '\muW/m^3';  % 设置 colorbar 标注
c.Title.Position = [17 176.9304802261237 0];

savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\supply\r-11deg.fig')

%% 
% 初始化 number 数组
number = zeros(4, 12);

for i=1:12
    pil(i)=mean(pil_24ym(:,:,4*i),[1 2],'omitnan');
    pis(i)=mean(pis_24ym(:,:,4*i),[1 2],'omitnan');
    pir(i)=mean(pir_24ym(:,:,4*i),[1 2],'omitnan');
end
% 计算 number(i)
for i = 1:12
    ind0 = sum(~isnan(squeeze(pir_24ym(:,:,4*i))), 'all'); % 统计非 NaN 值
    ratio1 = find(abs(squeeze(pir_24ym(:,:,4*i)))./abs(pil(i)) > 0.1);
    ratio2 = find(abs(squeeze(pir_24ym(:,:,4*i)))./abs(pis(i)) > 0.1);
    % ratio3 = find(abs(squeeze(pir_24ym(:,:,4*i)))./(abs(pil(i))+abs(pis(i)))./2 > 0.1);
    ratio3 = find(abs(squeeze(pir_24ym(:,:,4*i)))./(abs(pil_24ym(:,:,4*i))+abs(pis_24ym(:,:,4*i)))./2 > 0.1);
    ind1 = find(abs(squeeze(pir_24ym(:,:,4*i))) > 1e-07); % 统计满足阈值条件的元素
    number(1,i) = numel(ratio1) ./ ind0; % 计算比例
    number(2,i) = numel(ratio2) ./ ind0;
    number(3,i) = numel(ratio3) ./ ind0;
    number(4,i) = numel(ind1) ./ ind0;
end

% 创建图形
figure
plot(1:12, number(3,:)*100, 'Color', '#B22222', 'LineStyle', '-', 'LineWidth', 2, 'Marker', 'o', 'MarkerFaceColor', '#B22222');
set(gca, 'FontSize', 12,'FontName','times new roman');
set(gcf,"Position",[617.8000000000001 529 526.4 281.6])
xlim([1, 12]); 
% ylim([0.75, 0.95]); 
xticks(1:2:12)
xlabel('   (degree)','FontName','times new roman');
ylabel('Percentage (%)', 'FontName', 'Times New Roman','FontWeight', 'Bold');
title('Percentage of imbalanced region in the global ocean', 'FontName', 'Times New Roman', 'FontSize', 15);
grid on;
hold on
plot(1:12, 98*ones(1,12),'color',[.5 .5 .5],'LineStyle','--','LineWidth',1)
text(2,97,'\it 98%','FontName','times new roman','FontWeight','bold')
% savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\ratio_pir.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\ratio_pir.jpg','Resolution',300)







