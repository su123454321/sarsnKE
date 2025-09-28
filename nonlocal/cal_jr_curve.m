%% 区域平均-副热带环流
clear;clc
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
l=dtt/dt;
kkk=1./dtt;
load('D:\nonlocal KE cascade Data\pais_and_js\JR_all.mat')
load('F:\JR_sounew.mat')
M=288;

for k2=1:48
    [c1,lags1]=xcov(squeeze(JR_sgm(:,k2)-mean(JR_sgm(:,k2),1,'omitnan')),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    df1 = 288/19;
    stejr1(k2)=2*std(squeeze(JR_sgm(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr1=mean(JR_sgm);
aa=sqrt((6378.1*pi/180*cos((16)*pi/180))*(6378.1*pi/180));
figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr1*1e05,stejr1*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr1*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
set(gca,'YTick',-1.2:.4:.8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
ylim([-1.2 0.8])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'\itJ^{g}_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('Subtropical Gyre','fontsize',20,'fontweight','bold','FontName','Times New Roman')
% savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\subgyre_jr.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\subgyre_jr.jpg','Resolution',300)

%% 区域平均-黑潮延伸体
% load('F:\JR_KE.mat')
M=288;
for k2=1:48
    [c1,lags1]=xcov(squeeze(JR_kem(:,k2)),M-1,'coeff');
    % [c1,lags1]=xcov(squeeze(jr_regionmean(k2,:)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stejr2(k2)=2*std(squeeze(JR_kem(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr2=mean(JR_kem);
aa=sqrt((6378.1*pi/180*cos((35.5)*pi/180))*(6378.1*pi/180));
figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr2*1e05,stejr2*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr2*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
% set(gca,'YTick',-12:4:8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
% ylim([-12 8])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'\itJ^{g}_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('Kuroshio Extension','fontsize',20,'fontweight','bold','FontName','Times New Roman')
% savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\kuroshio_jr_changeRegion.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\kuroshio_jr_changeRegion.jpg','Resolution',300)
 
%% 区域平均-湾流延伸体
M=288;
for k2=1:48
    [c1,lags1]=xcov(squeeze(JR_gem(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stejr3(k2)=2*std(squeeze(JR_gem(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr3=mean(JR_gem);
aa=sqrt((6378.1*pi/180*cos((35.5)*pi/180))*(6378.1*pi/180));
figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr3*1e05,stejr3*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr3*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
% set(gca,'YTick',-12:4:8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
% ylim([-12 8])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'\itJ^{g}_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('Gulf Stream','fontsize',20,'fontweight','bold','FontName','Times New Roman')
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\gulf_jr.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\gulf_jr.jpg','Resolution',300)

%% 区域平均-南大洋-印度洋
M=288;
jr_indsou = jr_indsou';
for k2=1:48
    [c1,lags1]=xcov(squeeze(jr_indsou(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stejr4(k2)=2*std(squeeze(jr_indsou(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr4=mean(jr_indsou);
aa=sqrt((6378.1*pi/180*cos((-47.5)*pi/180))*(6378.1*pi/180));
figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr4*1e05,stejr4*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr4*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
% set(gca,'YTick',-12:4:8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
% ylim([-12 8])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'J_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('Indian Spot of the Southern Ocean','fontsize',16,'fontweight','bold','FontName','Times New Roman')
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\indsou_jr.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg/indsou_jr.jpg','Resolution',300)

%% 区域平均-南大洋-太平洋
M=288;
jr_pacsou = jr_pacsou';
for k2=1:48
    [c1,lags1]=xcov(squeeze(jr_pacsou(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stejr5(k2)=2*std(squeeze(jr_pacsou(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr5=mean(jr_pacsou);
aa=sqrt((6378.1*pi/180*cos((-47.5)*pi/180))*(6378.1*pi/180));
figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr5*1e05,stejr5*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr5*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
% set(gca,'YTick',-12:4:8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
% ylim([-1 2])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'J_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('Pacific Spot of the Southern Ocean','fontsize',16,'fontweight','bold','FontName','Times New Roman')
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\pacsou_jr.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\pacsou_jr.jpg','Resolution',300)

%% 区域平均-南大洋-大西洋
M=288;
jr_altsou = jr_altsou';
for k2=1:48
    [c1,lags1]=xcov(squeeze(jr_altsou(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stejr6(k2)=2*std(squeeze(jr_altsou(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr6=mean(jr_altsou);
aa=sqrt((6378.1*pi/180*cos((-52)*pi/180))*(6378.1*pi/180));

figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr6*1e05,stejr6*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr6*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
% set(gca,'YTick',-12:4:8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
% ylim([-12 8])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'\itJ^{g}_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('A Spot of the Southern Ocean','fontsize',20,'fontweight','bold','FontName','Times New Roman')
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\atlsou_spot_jr.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\atlsou_spot_jr.jpg','Resolution',300)
%% 区域平均-南大洋整体
load('D:\nonlocal KE cascade Data\pais_and_js\JR_pi_so.mat','JR_so')
M=288;
for k2=1:48
    [c1,lags1]=xcov(squeeze(JR_so(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stejr7(k2)=2*std(squeeze(JR_so(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end
jr7=mean(JR_so);
aa=sqrt((6378.1*pi/180*cos((-47.5)*pi/180))*(6378.1*pi/180));

figure
% set(gcf,'unit','centimeters','position',[10 10 14 7.5])
set(gcf,'position',[1000 500 450 350]);
s1=shadedErrorBar(kkk/aa,jr7*1e05,stejr7*1e05);
% set(s1.edge,'color','#294390')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,jr7*1e05,'color','#3A5FCD','Linewidth',2);
hold on
oo=linspace(0,0,length(dtt));
plot(kkk/aa,oo,'--','color',[0.5 0.5 0.5],'linewidth',1.5)
grid on
% set(gca,'YTick',-12:4:8);
set(gca,'FontWeight','Bold','fontsize',15)
xlim([0 0.02])
% ylim([-12 8])
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
ylabel('Spatial Transport (10^-^5 W/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1],'J_R','fontsize',15,'FontWeight','Bold','location','northeast')
box on
title('the Southern Ocean','fontsize',16,'fontweight','bold','FontName','Times New Roman')
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\sou_jr.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\sou_jr.jpg','Resolution',300)