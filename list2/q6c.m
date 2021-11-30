
% Course: Control Systems
% Author: Jhon Charaja
% List number: 2 
% Question: 6 (c)
% Info: Step response of the open-loop system: G1(s)

clc, clear all, close all;

% laplace operator
s = tf('s');

% open-loop system
k = 10; 
M = 1;
B_m = 2;
G1 = k/(M*s^2 + B_m*s + k); 

% step response of open-loop system
dt = 0.001;
t = 0:dt:5;
len = length(t);
u = ones(len, 1);
y = lsim(G1, u, t);

% plot settings
img_width= 14;
img_height=14;
legend_list = {'system response','input signal'};

figure(1), hold on, grid on, box on,
    fig = get(groot,'CurrentFigure');
    set(fig,'units','centimeters','position', [0 0 img_width img_height]);

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
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'southeast');
    datatip_index = 2560;
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'southeast');
    datatip_index = find(y>=1, 1);
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'southeast');
    
% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list2\images\');
file_name     = fullfile(image_path, 'q6_step_response_G1');
saveas(gcf,file_name,'epsc')       

%%


wn =  sqrt(10);
psi = 1/wn;

% rise time
tr = (pi- atan(sqrt(1-psi*psi)/psi)) / (wn*sqrt(1-psi*psi));
% overshoot
PO = exp(-pi*psi/(sqrt(1-psi*psi)));
% peak time
tp = pi/ (wn*sqrt(1-psi*psi));
% settling time (5%)
ts = 3/psi/wn;





