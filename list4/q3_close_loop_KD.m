% root locus and bode diagram for close-loop analysis when C = kd*s + kp


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
%% root-locus: Close loop system with PD control
clc, close all,
I1 = 1; I2=0.1;
K = 0.2; D = 0.003;

clear r kkd kkp;
for i=1:4000
    kp=0.0001*(i);
    kd=0.00001*(i);
    
    r(:,i) = roots([(I1*I2), (I1*D+I2*D), (I1*K+I2*K+kd*D), (kd*K+kp*D), kp*K]);
    kkd(i) = kd;
    kkp(i) = kp;
end

img_width = 15;
img_height = 8;

[r1,r2,r3,r4, fig] = plot_root_locus(r, color_list, img_width, img_height);

[data_index_inestabilty] = plot_data_tip_rlocus(r(1,:), kkp, kkd, r1);
    
 
% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list4\images\question3');
file_name     = fullfile(image_path, 'q3_rlocus_KD_CL');
saveas(gcf,file_name,'epsc')     

%% bode
clc, close all,
I1 = 1; I2=0.1;
K = 0.2; D = 0.003;
data_len = 1000;
s = tf('s');
mag = zeros(data_len, 3);
phase = zeros(data_len, 3);
wout = zeros(data_len, 3);

control_list = [40, 400, 4000];
for i=1:3
    kp = kkp(control_list(i));
    kd = kkd(control_list(i));
    sys_2_KD_OL = (kd*s + kp)*(D*s + K)/( (I1*I2)*s^4 + (I1*D+I2*D)*s^3 + (I1*K+I2*K)*s^2);
 
    w = linspace(1,2, data_len);
    figure(1), margin(sys_2_KD_OL, w); hold on
    [mag(:,i),phase(:,i),wout(:,i)] = bode(sys_2_KD_OL, w);
end

mag = squeeze(mag); mag= 20*log10(mag);
phase=squeeze(phase);

img_width = 18;
img_height = 20;

plot_bode_diagram(mag, phase, wout, img_width, img_height, color_list);

% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list4\images\question3');
file_name     = fullfile(image_path, 'q3_bode_KD_OL');
saveas(gcf,file_name,'epsc')  

%%
clc, close all, clear all
I1 = 1; I2=0.1;
K = 0.2; D = 0.003;
kp = 0.04; kd=0.004;

s = tf('s');
sys_2_KD_OL = (kd*s + kp)*(D*s + K)/( (I1*I2)*s^4 + (I1*D+I2*D)*s^3 + (I1*K+I2*K)*s^2);
sys_2_KD_CL = feedback(sys_2_KD_OL,1);

t=0:0.1:2500;
u = 1 + 0*t;
y2 = lsim(sys_2_KD_CL, u, t);
uu = u;

figure(1), hold on, box on, grid on,
    plot(t, y2)
    ylabel('Amplitude (rad)', 'Interpreter','latex'),
    xlabel('Time (s)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 10;
    set(gca,'TickLabelInterpreter','latex')   

%% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list4\images\question3');
file_name     = fullfile(image_path, 'q3_step_KD_CL');
saveas(gcf,file_name,'epsc')  
