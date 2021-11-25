function [root_lines, fig] = plot_root_locus(roots, color_list, img_width, img_height)
    figure(22), hold on, grid on, box on;
    fig = get(groot,'CurrentFigure');
    
    set(fig,'units','centimeters','position', [0 0 img_width img_height])
    movegui(fig, 'center')

    iter = size(roots,1);
    legend_list = cell(iter,1);
    
    for i=1:iter
        %legend: p1, p2 .. p_{iter}
        legend_list{i} = strcat('p', num2str(i));
        % plot poles and save line properties
        root_lines(i)=plot(real(roots(i,:)), imag(roots(i,:)),'linestyle', '-', 'linewidth', 2, 'color', color_list{i}); hold on, grid on, box on;
    end
    
    for i=1:iter
        % plot initial and last marker
        plot(real(roots(i,1)), imag(roots(i,1)), 'Marker','+','MarkerSize', 10, 'color', color_list{i}, 'linewidth', 1); hold on, grid on, box on;
        plot(real(roots(i,end)), imag(roots(i,end)), 'Marker','o','MarkerSize', 10, 'color',  color_list{i}, 'linewidth', 2); hold on, grid on, box on;
    end    
    
%     r1=plot(real(r(1,:)), imag(r(1,:)),'linestyle', '-', 'linewidth', 2, 'color', color1); hold on, grid on, box on;
%     r2=plot(real(r(2,:)), imag(r(2,:)),'linestyle', '-', 'linewidth', 2, 'color', color2); hold on, grid on, box on;
%     r3=plot(real(r(3,:)), imag(r(3,:)),'linestyle', '-', 'linewidth', 2, 'color', color3); hold on, grid on, box on;
%     r4=plot(real(r(4,:)), imag(r(4,:)),'linestyle', '-', 'linewidth', 2, 'color', color4); hold on, grid on, box on;

%     plot(real(r(1,1)), imag(r(1,1)), 'Marker','+','MarkerSize', 10, 'color', color1, 'linewidth', 1); hold on, grid on, box on;
%     plot(real(r(1,end)), imag(r(1,end)), 'Marker','o','MarkerSize', 10, 'color',  color1, 'linewidth', 2); hold on, grid on, box on;
% 
%     plot(real(r(2,1)), imag(r(2,1)), 'Marker','+','MarkerSize', 10, 'color', color2, 'linewidth', 1); hold on, grid on, box on;
%     plot(real(r(2,end)), imag(r(2,end)), 'Marker','o','MarkerSize', 10, 'color',  color2, 'linewidth', 2); hold on, grid on, box on;
% 
%     plot(real(r(3,1)), imag(r(3,1)), 'Marker','+','MarkerSize', 10, 'color', color3, 'linewidth', 1); hold on, grid on, box on;
%     plot(real(r(3,end)), imag(r(3,end)), 'Marker','o','MarkerSize', 10, 'color',  color3, 'linewidth', 2); hold on, grid on, box on;   
% 
%     plot(real(r(4,1)), imag(r(4,1)), 'Marker','+','MarkerSize', 10, 'color', color4, 'linewidth', 1); hold on, grid on, box on;
%     plot(real(r(4,end)), imag(r(4,end)), 'Marker','o','MarkerSize', 10, 'color',  color4, 'linewidth', 2); hold on, grid on, box on;
    
    
    legend(legend_list, 'Interpreter', 'latex','Location','northoutside', 'Orientation','horizontal')
    
    xlabel('Real axis (Hz)', 'Interpreter','latex'),
    ylabel('Imaginary axis (Hz)', 'Interpreter','latex'),
   
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')
end