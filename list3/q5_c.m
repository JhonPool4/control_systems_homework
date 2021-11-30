
% Course: Control Systems
% Author: Jhon Charaja
% List number: 3 
% Question: 5 (c)
% Info: sisotool G(s)

clc, clear all, close all;

% laplace operator
s = tf('s');

kp = 0.09; kv = -0.532;
T = kp*65/(s*s + (37 + 65*kv)*s + kp*65);

% step response of open-loop system
dt = 0.001;
t = 0:dt:5;
len = length(t);
u = ones(len, 1);
y = lsim(T, u, t);
% plot settings
img_width= 14;
img_height=14;
legend_list = {'system response','input signal'};

figure(1), hold on, grid on, box on,
    fig = get(groot,'CurrentFigure');
    set(fig,'units','centimeters','position', [0 0 img_width img_height]);
    axis([0, t(end) 0 1.5])

    plot_fig = plot(t, y,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on
    plot(t, u,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on  
    ylabel('Amplitude', 'Interpreter','latex'),
    xlabel('Time (s)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')   
    legend(legend_list, 'interpreter', 'latex', 'location', 'northoutside')
    
    datatip_index = find(y == max(y));
    label_list = {'Time (s): ','Force (N): '};
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'northeast');
    datatip_index = find(y>=1, 1);
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'southeast');
    
    
% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list3\images\');
file_name     = fullfile(image_path, 'q5_step_response_T');
saveas(gcf,file_name,'epsc')     
%%
psi = 0.0962;
tr = 1;
wn = (pi- atan(sqrt(1-psi*psi)/psi)) / (tr*sqrt(1-psi*psi));

eq = s*s + 2*psi*wn*s + wn*wn

