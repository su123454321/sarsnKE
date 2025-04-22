%% 绘制全球平均动能通量谱
clear
% load('G:\DATA\Data\coarse-graining\global_fluxA_coarse\global\pi_globalmean','flux_globalmean','flux_globalmean_climate')
dt=0.125; 
interval=0.25;
dtt=0.25:interval:12;
l=dtt/dt;kkk=1./dtt;

aa1=sqrt((6378.1*pi/180*cos(0*pi/180))*(6378.1*pi/180));
KK=kkk/aa1*2*pi;
L=2*pi./KK;
for k2=1:48
flux(1,k2)=max(flux_globalmean(k2,:));
flux(2,k2)=min(flux_globalmean(k2,:));
end
% flux_mean=(flux(1,:)+flux(2,:))/2;
% % load('G:\DATA\Data\trend\trend_amp_scale_globalmean.mat','amp_global')
% % [amp_max,imax]=max(amp_global);
% % [amp_min,imin]=min(amp_global);
% % flux(1,:)=flux_globalmean(:,imax);
% % flux(2,:)=flux_globalmean(:,imin);
% % flux_mean=mean(flux_globalmean,2);
% % flux_std=nanstd(flux_globalmean,2);
% [yup,ylo]=envelope
figure
set(gcf,'unit','centimeters','position',[10 10 12 7.5])
ax1 = axes;
h=fill([KK,fliplr(KK)],[pil*1e6,fliplr(pil*1e6)],'r');
% 改变边缘、面透明度
set(h,'edgealpha',0,'facealpha',0.1) 
hold on
%errorbar(kkk/aa*2*pi*1e5,mean(pif_temp)*1e10,ste*1e10,'color','#B0C4DE')
%s1=shadedErrorBar(kkk/aa1*2*pi*1e5,mean(pif_tempA1)*1e10,steA1*1e10,'transparent',false);
s1=shadedErrorBar(kkk/aa*2*pi,pil*1e6,stel*1e6);
%set(s1.edge,'color','#ADD8E6')
set(s1.edge,'color',[1 1 1])
s1.patch.FaceColor = '#4876FF';
hold on
p1=plot(kkk/aa*2*pi,pil*1e6,'color','#3A5FCD','Linewidth',2);
hold on
%s2=shadedErrorBar(kkk/aa2*2*pi*1e5,mean(pif_tempA2)*1e10,steA2*1e10,'transparent',false);

s2=shadedErrorBar(kkk/aa*2*pi,pis*1e6,stes*1e6);
set(s2.edge,'color',[1 1 1])
%set(s2.edge,'color','#DDA0DD')
s2.patch.FaceColor = '#CD5C5C';
hold on
p2=plot(kkk/aa*2*pi,pis*1e6,'color','#B22222','Linewidth',2);

s3=shadedErrorBar(kkk/aa*2*pi,pir*1e6,ster*1e6);
set(s3.edge,'color',[1 1 1])
%set(s2.edge,'color','#DDA0DD')
s3.patch.FaceColor = '#FFA500';
hold on
% xlabel('Wavenumber K (10^-^5 m^-^1)')
ylabel('Spectral energy flux(10^-^6 W/m^3)','fontsize',12,'FontName','Times New Roman');
set(gca,'FontSize',12,'FontWeight','Bold')
grid on
hold on
box on
xx=linspace(0,0,48);
plot(KK,xx,'--','color',[.5 .5 .5],'linewidth',2)
% 调整主轴与图窗最下面边界的距离
ax1.Position = [ax1.Position(1), 0.3, ax1.Position(3), ax1.Position(4)]; % 将主轴向上移动
ax2 = axes('Position', get(ax1, 'Position'), ... % 与主轴位置相同
           'XAxisLocation', 'bottom', ... % x 轴位置在底部
           'YAxisLocation', 'left', ... % y 轴位置在左侧
           'Color', 'none', ... % 透明背景
           'XColor', 'k', ... % 设置次轴的 x 轴颜色
           'YColor', 'none'); % 隐藏次轴的 y 轴

% ax2.XTick = ax1.XTick; % 同步 x 轴刻度
% ax2.XLim = ax1.XLim; % 同步 x 轴范围
% 设置次轴的刻度
ax2.XTick = ax1.XTick; % 自定义次轴的刻度
ax2.XTickLabel = {'$\ell_\infty$','125','63','42','31','25'};
ax2.XAxis.TickLabelInterpreter = 'latex';
% 设置次轴与主轴的距离
ax2.Position(2) = ax2.Position(2) - 0.15; % 将次轴向下移动 0.1 单位
xlabel(ax2, 'Length scale $\ell$ (km)','Interpreter', 'latex'); % 设置次轴的 x 轴标签
grid off; 

% 在次轴上绘制解释数据
set(ax2, 'YTick', []); % 隐藏次轴的 y 轴刻度
linkaxes([ax1, ax2], 'x'); % 链接两个轴的 x 轴
set(gca,'FontSize',12,'FontWeight','Bold')
