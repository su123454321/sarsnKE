clear;clc
load(strcat('F:\DATA\Data\pais_and_js\Pil24ym.mat'),'pil_24ym')
load(strcat('F:\DATA\Data\pais_and_js\Pis24ym.mat'),'pis_24ym')
load(strcat('F:\DATA\Data\pais_and_js\Pir24ym.mat'),'pir_24ym')
load('F:\DATA\Data\pais_and_js\pi_gmm_all.mat','piL_gmm','piS_gmm','piR_gmm')
%%
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
lon=(1/8):(1/4):360;lat=(-90+1/8):(1/4):90;%全球，1/4度分辨率
loni=lon(1:4:1440);lati=lat(1:4:720);
[y,x]=meshgrid(lati,loni);
lon1=interp1(lon,1:0.5:1440);lat1=interp1(lat,1:0.5:720);
[y0,x0]=meshgrid(lat1,lon1);

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

%% 分离区域
i1=find(loni>150 & loni<225);
j1=find(lati>10 & lati<22);y1=y(i1,j1);% 副热带环流

i2=find(loni>130 & loni<170);
j2=find(lati>29 & lati<42);y2=y(i2,j2);%黑潮延伸体

i3=find(loni>282 & loni<307);
j3=find(lati>29 & lati<42);y3=y(i3,j3);%湾流延伸体

i4=find(loni>25 & loni<150);
j4=find(lati>-65 & lati<-40);y4=y(i4,j4);%南大洋-印度洋

i5=find(loni>150 & loni<287);
j5=find(lati>-65 & lati<-40);y5=y(i5,j5);%南大洋-太平洋

i6=find(loni>287 & loni<360);
j6=find(lati>-65 & lati<-40);y6=y(i6,j6);%南大洋-大西洋
i7=find(loni>0 & loni<25);
j7=find(lati>-65 & lati<-40);y7=y(i7,j7);%南大洋-大西洋
%% pir大面图
figure
set(gca,'FontSize',11)
set(gcf,'Units','centimeters','Position',[5 5 20 16])
m_proj('robinson','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,mke);shading flat;
c=colorbar('fontsize',11,'fontweight','bold');
% c.Location='southoutside';
% c.Position=[0.278902083333333,0.211044270833333,0.473075,0.034691620979946];
% set(get(c,'Title'),'string','W/m^3','position',[292.6846781250001,0.386269276502744,0]);
c.Location='eastoutside';
c.Position=[0.929463315696649,0.361059062380953,0.018305434303351,0.31432895845238];
set(get(c,'Title'),'string','W/m^3','position',[2.939590624999937,146.5796155539997,0]);
clim([-5e-6 5e-6]); 
set(c,'ytick',[-5e-6 -2.5e-6 0 2.5e-6 5e-6])


%  set(gca,'ColorScale','log')
c.Label.FontSize = 11;
 
%  colormap(othercolor('YlOrBr9'));
load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
% colormap(Spectral5o1);
color3=color(50:206,:);
colormap(color3);
% colormap(othercolor('Set33'));

% colormap(othercolor('Spectral5'));
m_grid('linestyle','none','linewidth',1.2,'tickdir','out','xaxisloc',...
    'bottom','yaxisloc','left','fontsize',11,'BackgroundColor', [0.7 0.7 0.7]);
hold on;
m_coast('patch',[.7 .7 .7],'edgecolor','k');
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',1.5);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end
% set(gcf,'color','w','Position',get(0,'ScreenSize'));  
% title('Global distribution of \Pi_R','fontsize',12,'fontweight','bold','FontName','Times New Roman')

savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\pir_amp_5°running_average.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\pir_amp_5°running_average.jpg','Resolution',300)
%% Pil

pil1 = nanconv(squeeze(pil_24ym(:,:,8)),h,'edge','nanout');
% pil2 = squeeze(pil_24ym(:,:,40));
pil2 = nanconv(squeeze(pil_24ym(:,:,20)),h,'edge','nanout');

% 创建 figure
figure;
set(gcf,"Position",[141 292.2 1472.8 651.2]);

ha=tight_subplot(1,2,[0.1 0.01],[.1 .1],[.1 .1]);

% 载入 colormap
load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5e-6 5e-6];

axes(ha(1));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, pil1); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
colormap(color3);
clim(clim_range);

axes(ha(2));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, pil2); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
colormap(color3);
clim(clim_range);
set(ha(2),'YTickLabel','none');

% c = colorbar;  % 可以改成 'southoutside' 放到底部
% c.Location = 'southoutside';
% c.FontSize = 11;
% c.FontWeight = 'bold';
% c.Limits = clim_range;
% c.Ticks = [-5e-6 -2.5e-6 0 2.5e-6 5e-6];
% c.Label.String = 'W/m^3';  % 设置 colorbar 标注
% c.TickLength = 0.005;
% c.Position = [0.098316132536665 0.15970515970516 0.80228136882129 0.031510236826912];


%% pis
pis1 = nanconv(squeeze(pis_24ym(:,:,8)),h,'edge','nanout');
pis2 = nanconv(squeeze(pis_24ym(:,:,20)),h,'edge','nanout');

% 创建 figure
figure;
set(gcf,"Position",[141 292.2 1472.8 651.2]);

ha=tight_subplot(1,2,[0.1 0.01],[.1 .1],[.1 .1]);

% 载入 colormap
load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5e-6 5e-6];

axes(ha(1));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, pis1); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
colormap(color3);
clim(clim_range);

axes(ha(2));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, pis2); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
colormap(color3);
clim(clim_range);
set(ha(2),'YTickLabel','none');

%% pir
pir1 = nanconv(squeeze(pir_24ym(:,:,8)),h,'edge','nanout');
pir2 = nanconv(squeeze(pir_24ym(:,:,20)),h,'edge','nanout');

% 创建 figure
figure;
set(gcf,"Position",[141 292.2 1472.8 651.2]);

ha=tight_subplot(1,2,[0.1 0.01],[.1 .1],[.1 .1]);

% 载入 colormap
load('E:\matlab\toolbox\colorbardata_cmocean\balance-rgb.mat')
color3 = color(50:206,:);

% 设定统一的 clim 以确保颜色一致
clim_range = [-5e-6 5e-6];

axes(ha(1));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, pir1); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
colormap(color3);
clim(clim_range);

axes(ha(2));
m_proj('miller', 'lon', [0 360], 'lat', [-80 80]); hold on;
m_pcolor(x0, y0, pir2); shading flat;
m_grid('linestyle', ':', 'linewidth', 1.2, 'xaxisloc', ...
    'bottom', 'yaxisloc', 'left', 'fontsize', 11);
m_coast('patch', [.7 .7 .7], 'edgecolor', 'k');
colormap(color3);
clim(clim_range);
set(ha(2),'YTickLabel','none');

c = colorbar;  % 可以改成 'southoutside' 放到底部
c.Location = 'southoutside';
c.FontSize = 14;
c.FontWeight = 'bold';
c.Limits = clim_range;
c.Ticks = [-5e-6 -2.5e-6 0 2.5e-6 5e-6];
c.Label.String = 'W/m^3';  % 设置 colorbar 标注
c.TickLength = 0.005;
c.Position = [0.098316132536665 0.124078624078624 0.80228136882129 0.031510236826912];
