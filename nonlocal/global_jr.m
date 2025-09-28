clear;clc
load('F:\nonlocal KE cascade Data\pais_and_js\JR.mat')
load('F:\global_JR_mask.mat')
% load('D:\data\pi_pe\pi_avg_2013.mat')
%%
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
lon=(1/8):(1/4):360;lat=(-90+1/8):(1/4):90;%全球，1/4度分辨率
loni=lon(1:4:1440);lati=lat(1:4:720);
[y,x]=meshgrid(lati,loni);
lon1=interp1(lon,1:0.5:1440);lat1=interp1(lat,1:0.5:720);
[y0,x0]=meshgrid(lat1,lon1);
% lon1=0.0625:1/8:360;lat1=-89.9375:1/8:89.9375;
% [y0,x0]=meshgrid(lat1,lon1);
%% 缩小南大洋区域
ii1 = find(loni >= 70 & loni <= 73);
jj1 = find(lati >= -50 & lati <= -47);

ii2 = find(loni >= 167 & loni <= 170);
jj2 = find(lati >= -52 & lati <= -49);

ii3 = find(loni >= 292 & loni <= 296);
jj3 = find(lati >= -54 & lati <= -50);
%% 平滑
% pil=mean(piL_gmm);pis=mean(piS_gmm);
% pir=pil-pis;
% [pir_max, ind] = max(pir);

resolution1=1;%几度
t1=resolution1./0.25;%平均倍数
tt1=t1.*t1;
h1=ones(t1,t1)/tt1;

resolution2=5;%几度
t2=resolution2./0.25;%平均倍数
tt2=t2.*t2;
h2=ones(t2,t2)/tt2;

resolution=4;%几度
t=resolution./0.25;%平均倍数
tt=t.*t;
h=ones(t,t)/tt;
% mke=nanconv(squeeze(pir_24ym(:,:,ind)),h,'edge','nanout');

%% jr
% jr1 = nanconv(squeeze(jr(:,:,4)),h,'edge','nanout');
% jr1 = squeeze(jr(:,:,4));
jr2 = nanconv(squeeze(jr(:,:,20)),h,'edge','nanout');
% jrr = jr.*double(global_JR_mask);
% jr2 = squeeze(jrr(:,:,20));
% jr2(jr2 == 0) = nan;

% 创建 figure
figure;
set(gcf,"Position",[141 292.2 1472.8 651.2]);

% ha=tight_subplot(1,2,[0.1 0.02],[.1 .1],[.1 .1]);

% 载入 colormap
load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5e-5 5e-5];
% 
% axes(ha(1));
% m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
% m_pcolor(x0, y0, jr1); shading flat;
% m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
%     'bottom', 'yaxisloc', 'left', 'fontsize', 15,'yticklabel',[]);
% m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
% colormap(color3);
% clim(clim_range);

% axes(ha(2));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, jr2); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 15);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
% 
for rr=1:3    
    eval(['xx=loni(ii',num2str(rr),'(1));'])
    eval(['yy=lati(jj',num2str(rr),'(1));'])
    eval(['len1=length(ii',num2str(rr),');'])
    eval(['len2=length(jj',num2str(rr),');'])  

    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',1.5);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end

colormap(color3);
clim(clim_range);
% set(ha(2),'YTickLabel','none');

c = colorbar;  % 可以改成 'southoutside' 放到底部
c.Location = 'eastoutside';
c.FontSize = 15;
c.FontWeight = 'bold';
c.Limits = clim_range;
c.Ticks = [-5e-5 -2.5e-5 0 2.5e-5 5e-5];
c.Label.String = 'W/m^3';  % 设置 colorbar 标注
c.TickLength = 0.005;
% c.Position = [0.098316132536665 0.124078624078624 0.80228136882129 0.031510236826912];
% savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\jr_4°running_average.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\jr_4°running_average.jpg','Resolution',300)