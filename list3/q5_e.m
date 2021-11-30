
% Course: Control Systems
% Author: Jhon Charaja
% List number: 3 
% Question: 5 (e)
% Info: close-loop system with proportional-integral control method

%% image parameters
clc, close all, clear all,
% colors
color1 = [0, 0.4470, 0.7410];            % dark red        --alpha=0.1 
color2 = [0.6350, 0.0780, 0.1840];       % dark blue      --alpha=0.5
color3 = [0.4660, 0.6740, 0.1880];       % dark green    --alpha=0.8
color4 = [0.8500 0.3250 0.0980];
color5 = [0.4940 0.1840 0.5560];
color6 = [0 0 0];

color_list = {color1, color2, color3, color4, color5, color6};

% laplace operator
s = tf('s');

for i=1:1000
    kp=0.01*(i);
    ki=0.001*(i);
    
    r(:,i) = roots([1, 37, (65*kp), (65*ki)]);
    kkp(i) = kp;
    kki(i) = ki;
end

img_width = 15;
img_height = 8;

[root_fig_lines, r_fig] = plot_root_locus(r, color_list, img_width, img_height, [-40 0 -30 30]);

datatip_index = find(imag(r(1,:)) > 0, 1);
%datatip_index = 10000;
gain_label_list = {'kp: ','ki: '};
plot_data_tip_rlocus(r(1,:), kkp, kki, gain_label_list, datatip_index, root_fig_lines(1), 'southwest')
plot_data_tip_rlocus(r(2,:), kkp, kki, gain_label_list, datatip_index, root_fig_lines(2), 'northeast')
plot_data_tip_rlocus(r(3,:), kkp, kki, gain_label_list, datatip_index, root_fig_lines(3), 'southeast')

%% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list3\images\');
file_name     = fullfile(image_path, 'q5_bode_T2');
saveas(gcf,file_name,'epsc')  


%% step response
close all, clc;

s = tf('s');
%kp = 10; ki=100; % gains for ki/kp = 10
kp = 5; ki= 0.5; % gains for ki/kp = 1/10
T = (65*kp*s + 65*ki) / (s^3 + 37*s^2 + 65*kp*s + 65*ki);

% step response of open-loop system
dt = 0.001;
t = 0:dt:1;
len = length(t);
u = ones(len, 1);
y = lsim(T, u, t);
% plot settings
img_width= 14;
img_height= 10;
legend_list = {'system response','input signal'};

figure(1), hold on, grid on, box on,
    r_fig = get(groot,'CurrentFigure');
    set(r_fig,'units','centimeters','position', [0 0 img_width img_height-2]);
    axis([0, t(end) 0 1.5])

    plot_fig = plot(t, y,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on
    plot(t, u,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on  
    ylabel('Amplitude', 'Interpreter','latex'),
    xlabel('Time (s)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')   
    %legend(legend_list, 'interpreter', 'latex', 'location', 'northoutside')
    
    datatip_index = find(y == max(y));
    label_list = {'Time (s): ','Amplitude: '};
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'southeast');
    datatip_index = find(y>=1, 1);
    add_datatip(plot_fig, datatip_index, t, y, label_list, 'southeast');
    
    
% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list3\images\');
file_name     = fullfile(image_path, 'q5_step_response_T3');
saveas(gcf,file_name,'epsc')  