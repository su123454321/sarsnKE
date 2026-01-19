clear; clc; close all;

outputPath = 'C:\Users\1\Desktop\陈儒nonlocal论文\修订提交版\figures\';
figWidth_cm = 9;        
figHeight_cm = 7;       
fontName = 'Arial';     
axisFontSize_pt = 8;    
lineWidth_pt = 1.5;     
-
fprintf('Loading and processing data for all spectra panels...\n');
dt=0.125; interval=0.25; dtt=0.25:interval:12; kkk=1./dtt;
panel_labels = {'A', 'B', 'C', 'D', 'E', 'F'};
region_names = {
    'Kuroshio Extension', 'Subtropical Gyre', 'Gulf Stream', ...
    'Southern Ocean (Indian)', 'Southern Ocean (Pacific)', 'Southern Ocean (Atlantic)'
    };
data_paths = {
    'D:\nonlocal KE cascade Data\pais_and_js\pi_kemm_all.mat', ... 
    'D:\nonlocal KE cascade Data\pais_and_js\pi_sgmm_all.mat', ... 
    'D:\nonlocal KE cascade Data\pais_and_js\pi_gemm_all.mat', ... 
    'D:\nonlocal KE cascade Data\pais_and_js\pi_simm_all.mat', ... 
    'D:\nonlocal KE cascade Data\pais_and_js\pi_spmm_all.mat', ... 
    'D:\nonlocal KE cascade Data\pais_and_js\pi_samm_all.mat'  
    };
suffixes = {'ke', 'sg', 'ge', 'si', 'sp', 'sa'};
lat_coords = [35.5, 16, 35.5, -48.5, -50.5, -52];

raw_ylims = [-9 9; -1.1 0.75; -12 12; -1.5 1; -1.3 1; -2 1.5]; 
y_ticks = { -8:4:8, -1:0.5:0.75, [], [], [], [] }; 

target_degrees = [7, 5, 3, 1];
for i = 1:6
    % fprintf('Generating Panel %s: %s\n', panel_labels{i}, region_names{i});

    data = load(data_paths{i});
    suffix = suffixes{i};
    piL_data = data.(strcat('piL_', suffix, 'm'));
    piS_data = data.(strcat('piS_', suffix, 'm'));
    
    if strcmp(suffix, 'ke')
        piR_data = piL_data - piS_data;
    else
        piR_data = data.(strcat('piR_', suffix, 'm'));
    end
    
    M=288;
    stel = zeros(1, 48); stes = zeros(1, 48); ster = zeros(1, 48);
    for k2=1:48
        [c1,~]=xcov(squeeze(piS_data(:,k2)),M-1,'coeff');
        [c2,~]=xcov(squeeze(piL_data(:,k2)),M-1,'coeff');
        [c3,~]=xcov(squeeze(piR_data(:,k2)),M-1,'coeff');
        C1 = zeros(1, M-1); C2 = zeros(1, M-1); C3 = zeros(1, M-1);
        for lag=1:M-1
            C1(lag)=sum(c1(M-lag:M+lag));
            C2(lag)=sum(c2(M-lag:M+lag));
            C3(lag)=sum(c3(M-lag:M+lag));
        end
        df1=M/max(C1); df2=M/max(C2); df3=M/max(C3);
        stes(k2)=2*std(squeeze(piS_data(:,k2)),0)/sqrt(df1);
        stel(k2)=2*std(squeeze(piL_data(:,k2)),0)/sqrt(df2);
        ster(k2)=2*std(squeeze(piR_data(:,k2)),0)/sqrt(df3);
    end
    
    pil = mean(piL_data); pis = mean(piS_data); pir = mean(piR_data);
    aa = sqrt((6378.1*pi/180*cos(lat_coords(i)*pi/180))*(6378.1*pi/180));
    
    current_ylim = raw_ylims(i, :);
    y_range = current_ylim(2) - current_ylim(1);
    new_ymax = current_ylim(2) + y_range * 0.25; 
    final_ylim = [current_ylim(1), new_ymax];

    fig = figure('Units', 'centimeters', 'Position', [10, 10, figWidth_cm, figHeight_cm]);
    ax1 = axes('Position', [0.16, 0.16, 0.78, 0.78]); 
    hold on;
    
    s1=shadedErrorBar(kkk/aa, pil*1e6, stel*1e6);
    s1.patch.FaceColor = '#294390'; s1.mainLine.Color = '#3A5FCD'; s1.mainLine.LineWidth = lineWidth_pt;
    if isfield(s1, 'edge'), set(s1.edge, 'Color', 'none'); end
    p1 = s1.mainLine;
    
    s2=shadedErrorBar(kkk/aa, pis*1e6, stes*1e6);
    s2.patch.FaceColor = '#952D2D'; s2.mainLine.Color = '#BA3838'; s2.mainLine.LineWidth = lineWidth_pt;
    if isfield(s2, 'edge'), set(s2.edge, 'Color', 'none'); end
    p2 = s2.mainLine;
    
    s3=shadedErrorBar(kkk/aa, pir*1e6, ster*1e6);
    s3.patch.FaceColor = '#CC7000'; s3.mainLine.Color = '#FFBF71'; s3.mainLine.LineWidth = lineWidth_pt;
    if isfield(s3, 'edge'), set(s3.edge, 'Color', 'none'); end
    p3 = s3.mainLine;
    
    plot(kkk/aa, zeros(size(dtt)), '--', 'color', [0.5 0.5 0.5], 'linewidth', 0.5);
    
    set(ax1, 'FontName', fontName, 'FontSize', axisFontSize_pt, ...
        'Box', 'off', ...      
        'XColor', 'k', ...     
        'YColor', 'k', ...     
        'LineWidth', 0.5, ...
        'XLim', [0 0.02], ...
        'YLim', final_ylim, ... 
        'TickDir', 'in'); 
    
    if ~isempty(y_ticks{i})
        set(ax1, 'YTick', y_ticks{i});
    end
    
    xlabel(ax1, '{\itK} (cpkm)', 'Interpreter', 'tex', ...
    'FontName', fontName, 'FontSize', axisFontSize_pt);
    ylabel(ax1, 'Cross-scale KE transfer (10^{-6} W/m^3)', 'Interpreter', 'tex');
    
    lgd = legend([p1,p2,p3], {'\Pi_L^{g}','\Pi_S^{g}','\Pi_R^{g}'}, ...
        'Interpreter', 'tex', ...
        'Location', 'northeast', ... 
        'Orientation', 'horizontal'); 
    set(lgd, 'FontName', fontName, 'FontSize', axisFontSize_pt, 'Box', 'on'); 
    
    drawnow; 
    lgd.Units = 'normalized'; 
    lgdPos = lgd.Position;    
    offset_y = 0.06; 
    lgdPos(2) = lgdPos(2) - offset_y; 
    offset_x = 0.005;
    lgdPos(1) = lgdPos(1) - offset_x;
    lgd.Position = lgdPos;

    tick_locs_K = 1 ./ (target_degrees * aa);
    ax2 = axes('Position', ax1.Position, ...
        'XAxisLocation', 'top', ...
        'YAxisLocation', 'right', ...
        'Color', 'none', ...
        'Box', 'off'); 
    
    set(ax2, ...
        'XLim', get(ax1, 'XLim'), ...
        'XTick', tick_locs_K, ...  
        'XTickLabel', [], ...      
        'YTick', [], ...           
        'XColor', 'k', ...        
        'YColor', 'k', ...        
        'TickDir', 'in', ...       
        'LineWidth', 0.5);
    
    text_y_pos = final_ylim(2) - (final_ylim(2)-final_ylim(1)) * 0.03;
    
    for t = 1:length(target_degrees)
        txt_str = sprintf('%g^{\\circ}', target_degrees(t)); 
        text(ax1, tick_locs_K(t), text_y_pos, txt_str, ...
            'HorizontalAlignment', 'center', ... 
            'VerticalAlignment', 'top', ...
            'Interpreter', 'tex', ... 
            'FontName', fontName, ...
            'FontSize', axisFontSize_pt, ...
            'Color', 'k');
    end
    
    linkaxes([ax1, ax2], 'x');
    if ~exist(outputPath, 'dir'), mkdir(outputPath); end
    fileName = sprintf('Figure5%s_CleanTicks.pdf', panel_labels{i}); 
    exportgraphics(fig, [outputPath, fileName], 'ContentType', 'vector');
    close(fig); 
end