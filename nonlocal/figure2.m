%% nonlocal KE cascade Figure 2B
%% 计算全球平均errorbar(24年)
clear;clc;close all
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
l=dtt/dt;
kkk=1./dtt;
load('D:\nonlocal KE cascade Data\ER\E_gm24_all.mat','EL_gm24y','ES_gm24y','ER_gm24y')

M=24;
for k2=1:48
    [c1,lags1]=xcov(squeeze(ES_gm24y(:,k2)),M-1,'coeff');
    [c2,lags2]=xcov(squeeze(EL_gm24y(:,k2)),M-1,'coeff');
    [c3,lags3]=xcov(squeeze(ER_gm24y(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));
        C2(lag)=sum(c2(M-lag:M+lag));
        C3(lag)=sum(c3(M-lag:M+lag));
    end
    df1=M/max(C1);%degree of freedom
    df2=M/max(C2);
    df3=M/max(C3);
    stes(k2)=2*std(squeeze(ES_gm24y(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
    stel(k2)=2*std(squeeze(EL_gm24y(:,k2)),0)/sqrt(df2);
    ster(k2)=2*std(squeeze(ER_gm24y(:,k2)),0)/sqrt(df3);
end
load('D:\nonlocal KE cascade Data\ER\E_gm24y.mat','el_gm','es_gm','er_gm')
aa=sqrt((6378.1*pi/180*cos((0)*pi/180))*(6378.1*pi/180));

figure
set(gcf,'position',[1000 500 450 350]);
%errorbar(kkk/aa*2*pi*1e5,mean(pif_temp)*1e10,ste*1e10,'color','#B0C4DE')
% s1=shadedErrorBar(kkk/aa1*2*pi*1e5,mean(pif_tempA1)*1e10,steA1*1e10,'transparent',false);
s1=shadedErrorBar(kkk/aa,el_gm,stel);
% %set(s1.edge,'color','#ADD8E6')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#294390';
hold on
p1=plot(kkk/aa,el_gm,'color','#3A5FCD','Linewidth',1.5);
hold on
%s2=shadedErrorBar(kkk/aa2*2*pi*1e5,mean(pif_tempA2)*1e10,steA2*1e10,'transparent',false);

s2=shadedErrorBar(kkk/aa,es_gm,stes);
set(s2.edge,'color',[1 1 1])
%set(s2.edge,'color','#DDA0DD')
s2.patch.FaceColor = '#952D2D';
hold on
p2=plot(kkk/aa,es_gm,'color','#BA3838','Linewidth',1.5);
s3=shadedErrorBar(kkk/aa,er_gm,ster);
set(s3.edge,'color',[1 1 1])
%set(s2.edge,'color','#DDA0DD')
s3.patch.FaceColor = '#CC7000';
hold on
p3=plot(kkk/aa,er_gm,'color','#FFBF71','Linewidth',1.5);
grid on
% xlim([0 25])
% set(gca,'YTick',[-2:3:12]);
set(gca,'FontSize',15,'FontWeight','Bold','FontName','Times New Roman')
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',15,'FontName','Times New Roman');
xlim([0 0.02])
ylabel('Energy(J/m^3)','fontsize',15,'FontName','Times New Roman');
legend([p1,p2,p3],'KE_L^{g}','KE_S^{g}','KE_R^{g}','fontsize',15,'location','east')
box on
title('Global','fontsize',20,'fontweight','bold','FontName','Times New Roman')

savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\global_ke_g.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\global_ke_g.jpg','Resolution',300)


%% 计算全球errorbar(288个月)
M=288;
load('D:\nonlocal KE cascade Data\ER\E_gmm_all.mat','EL_gmm','ES_gmm','ER_gmm')
for k2=1:48
    [c1,lags1]=xcov(squeeze(ES_gmm(:,k2)),M-1,'coeff');
    [c2,lags2]=xcov(squeeze(EL_gmm(:,k2)),M-1,'coeff');
    [c3,lags3]=xcov(squeeze(ER_gmm(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));
        C2(lag)=sum(c2(M-lag:M+lag));
        C3(lag)=sum(c3(M-lag:M+lag));
    end
    df1=M/max(C1);%degree of freedom
    df2=M/max(C2);
    df3=M/max(C3);
    stes1(k2)=2*std(squeeze(ES_gmm(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
    stel1(k2)=2*std(squeeze(EL_gmm(:,k2)),0)/sqrt(df2);
    ster1(k2)=2*std(squeeze(ER_gmm(:,k2)),0)/sqrt(df3);
end
load('D:\nonlocal KE cascade Data\ER\E_gm24y.mat','el_gm','es_gm','er_gm')
aa=sqrt((6378100*pi/180*cos((0)*pi/180))*(6378100*pi/180));

figure
set(gcf,'position',[0 0 450 350]);
%errorbar(kkk/aa*2*pi*1e5,mean(pif_temp)*1e10,ste*1e10,'color','#B0C4DE')
% s1=shadedErrorBar(kkk/aa1*2*pi*1e5,mean(pif_tempA1)*1e10,steA1*1e10,'transparent',false);
s1=shadedErrorBar(kkk/aa*2*pi*1e5,el_gm,stel);
% %set(s1.edge,'color','#ADD8E6')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#4876FF';
hold on
p1=plot(kkk/aa*2*pi*1e5,el_gm,'color','#3A5FCD','Linewidth',2);
hold on
%s2=shadedErrorBar(kkk/aa2*2*pi*1e5,mean(pif_tempA2)*1e10,steA2*1e10,'transparent',false);

s2=shadedErrorBar(kkk/aa*2*pi*1e5,es_gm,stes);
set(s2.edge,'color',[1 1 1])
%set(s2.edge,'color','#DDA0DD')
s2.patch.FaceColor = '#CD5C5C';
hold on
p2=plot(kkk/aa*2*pi*1e5,es_gm,'color','#B22222','Linewidth',2);
s3=shadedErrorBar(kkk/aa*2*pi*1e5,er_gm,ster);
set(s3.edge,'color',[1 1 1])
%set(s2.edge,'color','#DDA0DD')
s3.patch.FaceColor = '#FFA500';
hold on
p3=plot(kkk/aa*2*pi*1e5,er_gm,'color','#FF8C00','Linewidth',2);
grid on
xlim([0 25])
% set(gca,'YTick',[-2:3:12]);
xlabel('K(m^-^1×10^-^5)','fontsize',12,'FontWeight','Bold','FontName','Times New Roman');
ylabel('Energy(J/m^3)','fontsize',12,'FontWeight','Bold','FontName','Times New Roman');
legend([p1,p2,p3],'E_L','E_S','E_R','fontsize',12)
set(gca,'FontSize',12,'FontWeight','Bold','FontName','Times New Roman')
box on
title('Global','fontsize',16,'fontweight','bold','FontName','Times New Roman')