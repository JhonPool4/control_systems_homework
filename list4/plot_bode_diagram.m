function [fig] = plot_bode_diagram(mag, phase, wout, img_width, img_height, color_list, cnt_plots)
% image parameters
cnt_img_h = 1;
cnt_img_v = 2;
space_size = 1;
img_size = 5;
legend_flag = true;

figure(20), grid on, box on;
fig = get(groot,'CurrentFigure');
set(fig,'units','centimeters','position', [0 0 img_width img_height])

name_diagrams = ["Magnitude (dB)", "Phase (deg)"];

for m=1:cnt_plots

    [rows, cols, list_index] = get_subplot_index(cnt_img_h, cnt_img_v, 1, img_size, space_size, legend_flag);
    subplot(rows, cols, list_index),
    semilogx(wout, mag(:,m),'linestyle', '-', 'linewidth', 2, 'color', color_list{m}); hold on, grid on, box on;
    ylabel(name_diagrams(1), 'Interpreter','latex'),
    xlabel( 'Frecuency ($\mathrm{\frac{rad}{s}}$)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 10;
    set(gca,'TickLabelInterpreter','latex')
    %axis([1 2 -60 30])

    [rows, cols, list_index] = get_subplot_index(cnt_img_h, cnt_img_v, 2, img_size, space_size, legend_flag);
    subplot(rows, cols, list_index),
    semilogx(wout, phase(:,m),'linestyle', '-', 'linewidth', 2, 'color', color_list{m}); hold on, grid on, box on;
    ylabel(name_diagrams(2), 'Interpreter','latex'),
    xlabel( 'Frecuency ($\mathrm{\frac{rad}{s}}$)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 10;
    set(gca,'TickLabelInterpreter','latex')   


end

% add legend
% L(1)=plot(0,0, 'color', color_list{1});
% L(2)=plot(0,0, 'color', color_list{2});
% L(3)=plot(0,0, 'color', color_list{3});
% Lgnd1 = legend(L,{'kp=$0.0040$, kd=$0.0004$, Gm=$36.7$ dB', 'kp=$0.0400$, kd=$0.0040$, Gm=$16.7$ dB', 'kp=$0.4000$, kd=$0.0400$, Gm=$-3.27$ dB'}, 'interpreter', 'latex', 'Orientation','vertical');
% get(Lgnd1,'Position');
% Lgnd1.FontSize = 12;
% Lgnd1.Position(1) = 0.27;
% Lgnd1.Position(2) = 0.83;
end