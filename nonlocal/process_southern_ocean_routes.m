%% 首先把global_pir.m中的南大洋_大西洋处理好的pi数据和cal_jr_curve.m中的对应区域的j数据保存下来

% save('C:\Users\1\Desktop\陈儒nonlocal论文\nonlocality程序\cd_smalledSou.mat','stel','stes','ster','piL_sam','piS_sam'...
%     ,'piR_sam','jr_altsou','stejr6')

%% 然后计算gr
clear;clc
load('C:\Users\1\Desktop\陈儒nonlocal论文\nonlocality程序\cd_smalledSou.mat')
num_years = 24;
num_months_per_year = 12;
num_wavenumbers = 48;
monthly_data = jr_altsou; % Your 288x48 matrix

% 2. Reshape the 2D matrix into a 3D matrix
% The new dimensions will be (months, years, wavenumbers)
% This groups the 12 months for each year together.
data_3d = reshape(monthly_data, num_months_per_year, num_years, num_wavenumbers);

% 3. Calculate the mean along the first dimension (the 'months' dimension)
yearly_data_reshaped_3d = mean(data_3d, 1);

% 4. The result is now 1x24x48. Use squeeze() to remove the singleton dimension.
yearly_data_reshaped = squeeze(yearly_data_reshaped_3d);
jr_altsouy = yearly_data_reshaped;

piR_sam = piL_sam-piS_sam;

gr = jr_altsouy - piR_sam;
%% 接下来计算gr的置信度
M=24;
for k2=1:48
    [c1,lags1]=xcov(squeeze(gr(:,k2)),M-1,'coeff');
    for lag=1:M-1
        C1(lag)=sum(c1(M-lag:M+lag));     
    end
    df1=M/max(C1);%degree of freedom
    stegr(k2)=2*std(squeeze(gr(:,k2)),0)/sqrt(df1);%95%置信区间标准误差
end

%% 接下来选第9个波数(200km)，分析缩小后的南大洋区域routes+errorbar
jr6=mean(jr_altsou);
pil=mean(piL_sam);pis=mean(piS_sam);pir=mean(piR_sam);
grmean = mean(gr);
pilkl = pil(9);piskl = pis(9);pirkl = pir(9);
jrkl = jr6(9);grkl = grmean(9);
stpil = stel(9);stpis = stes(9);stpir = ster(9);stjr = stejr6(9);stgr = stegr(9);
