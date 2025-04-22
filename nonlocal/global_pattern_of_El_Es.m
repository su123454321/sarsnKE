clear;clc
load('D:\DATA\Data\ER\EL_24y.mat')
load('D:\DATA\Data\ER\ES_24y.mat')
load('D:\DATA\Data\ER\ER_24y.mat')
%% 
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
lon=(1/8):(1/4):360;lat=(-90+1/8):(1/4):90;%全球，1/4度分辨率
loni=lon(1:4:1440);lati=lat(1:4:720);
[y,x]=meshgrid(lati,loni);
lon1=interp1(lon,1:0.5:1440);lat1=interp1(lat,1:0.5:720);
[y0,x0]=meshgrid(lat1,lon1);
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
%% 绘制1° El global pattern
figure
m_proj('equidistant cylindrical','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,EL_24ym(:,:,4));shading flat; 
c=colorbar('fontsize',28,'fontweight','bold');
set(get(c,'Title'),'string','J/m^3');
set(gca,'ColorScale','log')
c.Label.FontSize = 28;
caxis([0.1 1e2]);  
%  colormap(othercolor('YlOrBr9'));
colormap(othercolor('BuDRd_18'));
%   colormap(othercolor('GnBu9'));
% colormap(color);
m_grid('linestyle','none','linewidth',1.2,'xaxisloc',...
    'bottom','yaxisloc','left','fontsize',24);
hold on;m_coast('patch',[.7 .7 .7],'edgecolor','k');
set(gca,'LineWidth',1.5);
set(gcf,'color','w','Position',get(0,'ScreenSize'));  
title('Large-scale Kinetic Energy KE_L','fontsize',36,...
    'fontweight','bold','FontName','Times New Roman')
hold on
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',3);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end

savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\El_1d.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\El_1d.jpg','Resolution',300)
%% 绘制1° Es global pattern
figure
m_proj('equidistant cylindrical','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,ES_24ym(:,:,4));shading flat;
c=colorbar('fontsize',28,'fontweight','bold');
set(get(c,'Title'),'string','J/m^3');
set(gca,'ColorScale','log')
c.Label.FontSize = 28;
caxis([0.1 1e1]);  
%  colormap(othercolor('YlOrBr9'));
colormap(othercolor('BuDRd_18'));
%   colormap(othercolor('GnBu9'));
% colormap(color);
m_grid('linestyle','none','linewidth',1.2,'xaxisloc',...
    'bottom','yaxisloc','left','fontsize',24);
hold on;m_coast('patch',[.7 .7 .7],'edgecolor','k');
set(gca,'LineWidth',1.5);
set(gcf,'color','w','Position',get(0,'ScreenSize'));  
title('Small-scale Kinetic Energy KE_S','fontsize',36,...
    'fontweight','bold','FontName','Times New Roman')
hold on
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',3);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\Es_1d.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\Es_1d.jpg'...
    ,'Resolution',300)
%% 绘制1° Er global pattern
figure
m_proj('equidistant cylindrical','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,ER_24ym(:,:,4));shading flat; 
c=colorbar('fontsize',28,'fontweight','bold');
set(get(c,'Title'),'string','J/m^3');
    set(gca,'ColorScale','log')
c.Label.FontSize = 28;
caxis([0.1 10]);  
%  colormap(othercolor('YlOrBr9'));
colormap(othercolor('BuDRd_18'));
%   colormap(othercolor('GnBu9'));
% colormap(color);
m_grid('linestyle','none','linewidth',1.2,'xaxisloc',...
    'bottom','yaxisloc','left','fontsize',24);
hold on;m_coast('patch',[.7 .7 .7],'edgecolor','k');
set(gca,'LineWidth',1.5);
set(gcf,'color','w','Position',get(0,'ScreenSize'));  
title('Residual Kinetic Energy KE_R','fontsize',36,...
    'fontweight','bold','FontName','Times New Roman')
hold on
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',3);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end
% savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\Er_1d.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\Er_1d.jpg',...
%     'Resolution',300)
%% 5°
figure
m_proj('equidistant cylindrical','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,ER_24ym(:,:,20));shading flat;
c=colorbar('fontsize',28,'fontweight','bold');
set(get(c,'Title'),'string','J/m^3');
%     set(gca,'ColorScale','log')
c.Label.FontSize = 28;
caxis([-10 10]);  
%  colormap(othercolor('YlOrBr9'));
colormap(othercolor('BuDRd_18'));
%   colormap(othercolor('GnBu9'));
% colormap(color);
m_grid('linestyle','none','linewidth',1.2,'xaxisloc',...
    'bottom','yaxisloc','left','fontsize',24);
hold on;m_coast('patch',[.7 .7 .7],'edgecolor','k');
set(gca,'LineWidth',1.5);
set(gcf,'color','w','Position',get(0,'ScreenSize'));  
title('Residual Kinetic Energy KE_R','fontsize',36,...
    'fontweight','bold','FontName','Times New Roman')
hold on
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',3);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\Er_5d.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\Er_5d.jpg'...
    ,'Resolution',300)
%% 10°
figure
m_proj('equidistant cylindrical','lon',[0 360],'lat',[-80 80]);hold on;
m_pcolor(x0,y0,ER_24ym(:,:,40));shading flat; 
c=colorbar('fontsize',28,'fontweight','bold');
set(get(c,'Title'),'string','J/m^3');
%     set(gca,'ColorScale','log')
c.Label.FontSize = 28;
caxis([-10 10]);  
%  colormap(othercolor('YlOrBr9'));
colormap(othercolor('BuDRd_18'));
%   colormap(othercolor('GnBu9'));
% colormap(color);
m_grid('linestyle','none','linewidth',1.2,'xaxisloc',...
    'bottom','yaxisloc','left','fontsize',24);
hold on;m_coast('patch',[.7 .7 .7],'edgecolor','k');
set(gca,'LineWidth',1.5);
set(gcf,'color','w','Position',get(0,'ScreenSize'));  
title('Residual Kinetic Energy KE_R','fontsize',36,...
    'fontweight','bold','FontName','Times New Roman')
hold on
for rr=1:7    
    eval(['xx=loni(i',num2str(rr),'(1));'])
    eval(['yy=lati(j',num2str(rr),'(1));'])
    eval(['len1=length(i',num2str(rr),');'])
    eval(['len2=length(j',num2str(rr),');'])  
    
    m_rectangle(xx,yy,len1,len2,1,'color','k','LineWidth',3);    
    %        m_text(xx1,yy1,[num2str(climate),num2str(rr)],'color','#4DBEEE','fontsize',10)
    hold on  
end
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\Er_10d.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\Er_10d.jpg',...
    'Resolution',300)