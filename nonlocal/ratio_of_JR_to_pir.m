%% 1. 初始化和加载数据 ---
clear; clc; close all;

try
    disp('正在加载数据...');
    load('F:\nonlocal KE cascade Data\pais_and_js\Pil24ym.mat', 'pil_24ym');
    load('F:\nonlocal KE cascade Data\pais_and_js\Pis24ym.mat', 'pis_24ym');
    load('F:\nonlocal KE cascade Data\pais_and_js\Pir24ym.mat', 'pir_24ym');
    load('F:\global_JR_mask.mat', 'global_JR_mask');
    load('F:\nonlocal KE cascade Data\pais_and_js\JR.mat');
    disp('数据加载完成。');
catch ME
    error('数据文件加载失败，请检查文件路径是否正确：%s', ME.message);
end

%% 2. 计算每个尺度下的百分比 ---

percentage_jr = zeros(1, 12);

fprintf('开始计算...\n');
for i = 1:12
    scale_index = 4 * i;

    pil_slice = pil_24ym(:, :, scale_index);
    pis_slice = pis_24ym(:, :, scale_index);
    pir_slice = pir_24ym(:, :, scale_index);
    jr_slice = jr(:, :, scale_index);
    mask_slice = global_JR_mask(:, :, scale_index);

    pil=mean(pil_24ym(:,:,scale_index),[1 2],'omitnan');
    pis=mean(pis_24ym(:,:,scale_index),[1 2],'omitnan');
    pir=mean(pir_24ym(:,:,scale_index),[1 2],'omitnan');

    % 条件A: pir的贡献显著的区域
    % abs(pir) > 0.1 * (abs(pil) + abs(pis)) / 2
    condition_A_mask = abs(pir_slice) > 0.1 * (abs(pil) + abs(pis)) / 2;

    valid_data_mask = ~isnan(condition_A_mask);
    condition_A_mask = condition_A_mask & valid_data_mask;

    count_A = sum(condition_A_mask, 'all');

    % 条件B (已修改): JR的贡献大于pir的30% (不使用global_JR_mask)
    condition_B_mask = abs(jr_slice) > 0.3 * abs(pir_slice);

    combined_mask = condition_A_mask & condition_B_mask;

    count_combined = sum(combined_mask, 'all');

    if count_A > 0
        percentage_jr(i) = (count_combined / count_A) * 100;
    else
        percentage_jr(i) = NaN;
    end
    
    fprintf('尺度 %d (索引 %d) 计算完成，百分比为: %.2f%%\n', i, scale_index, percentage_jr(i));
end

%% 3. 结果可视化 ---

disp('所有尺度计算完成。');
disp('最终百分比向量:');
disp(percentage_jr);

figure;
plot(1:12, percentage_jr, 'Color', '#B22222', 'LineStyle', '-', 'LineWidth', 2, 'Marker', 'o', 'MarkerFaceColor', '#B22222');
set(gca, 'FontSize', 12, 'FontName', 'Times New Roman');
set(gcf,"Position",[617.8000000000001 529 526.4 281.6])
grid on;
box on;
xlim([1, 12]);
xticks(1:2:12);
ylim([95, 100]);
xlabel('   (degree)','FontName','times new roman');
ylabel('Percentage (%)', 'FontName', 'Times New Roman','FontWeight','bold');
title('Percentage of |\itJ_{R}^{g}\rm| > 30% |\Pi_{\itR}^{\itg}\rm|', 'FontName', 'Times New Roman', 'FontSize', 15);
savefig('C:\Users\1\Desktop\陈儒nonlocal论文\figure\fig\ratio_jr.fig')
exportgraphics(gcf,'C:\Users\1\Desktop\陈儒nonlocal论文\figure\jpg\ratio_jr.jpg','Resolution',300)
