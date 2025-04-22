clear;clc
load('F:\DATA\Data\ER\E_gmm_all.mat')
load('F:\DATA\Data\ER\E_gm24y.mat')

interval=0.25;
dtt=0.25:interval:12;
kkk=1./dtt;
aa=sqrt((6378.1*pi/180*cos((0)*pi/180))*(6378.1*pi/180));

ratio1=er_gm./es_gm;
ratio2=er_gm./el_gm;

figure
set(gcf,"Position",[1000 500 450 350])
% set(gca,'xscale','log')
grid on
% ax = gca;  % 获取当前坐标轴
% ax.GridLineStyle = '--';        % 虚线
% ax.LineWidth = 1;             % 坐标轴线宽，包括网格线粗细
% ax.GridColor = [0.5 0.5 0.5];   % 网格线颜色（可选，灰色）

colororder({'#DA5953','#1975BA'})
yyaxis left
plot(kkk./aa,ratio1,'LineWidth',2,'Color','#DA5953')
xlabel('$ \it{K} $(cpkm)','Interpreter','latex','fontsize',12,'FontName','Times New Roman');
% ylabel('$ KE_{R}/KE_{S} $','Interpreter','latex','fontsize',12,'FontName','Times New Roman');

yyaxis right
plot(kkk./aa,ratio2,'LineWidth',2,'Color','#1975BA')
% ylabel('$ KE_{R}/KE_{L} $','Interpreter','latex','fontsize',12,'FontName','Times New Roman');

legend('KE_{R}/KE_{S}','KE_{R}/KE_{L}','location','east')
set(gca,'FontSize',12,'FontWeight','Bold','FontName','Times New Roman')
title('Global','fontsize',16,'fontweight','bold','FontName','Times New Roman')

% savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\ratio.fig')
% exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\ratio.jpg','Resolution',300)
