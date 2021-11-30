
% Course: Control Systems
% Author: Jhon Charaja
% List number: 2 
% Question: 5
% Info: Step response of the open-loop system: G(s) = 1/s

clc, clear all, close all;

% laplace operator
s = tf('s');
% open-loop system
G = 1/s;
% input signal
t1 = 10; t2=10; A = 1;
[u,t] = velocity_reductor_signal(t1,t2, A);
% open-loop system response
[y]=lsim(G, u, t, 0);
% plot settings
img_width= 14;
img_height=14;
legend_list = {'system response','input signal'};

figure(1), hold on, grid on, box on,
    fig = get(groot,'CurrentFigure');
    set(fig,'units','centimeters','position', [0 0 img_width img_height]);

    plot(t, y,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on
    plot(t, u,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on   
    ylabel('Amplitude', 'Interpreter','latex'),
    xlabel('Time (s)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')   
    legend(legend_list, 'interpreter', 'latex', 'location', 'northoutside')
    

% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list2\images\');
file_name     = fullfile(image_path, 'q5_system_response');
saveas(gcf,file_name,'epsc')       




