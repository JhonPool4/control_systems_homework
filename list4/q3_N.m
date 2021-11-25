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
%% Filtro de Notch
clc, close all,

s = tf('s');

N = (s*s + 1)/(s+20)^2;

[mag, phase, wout]=bode(N);
mag = squeeze(mag); mag= 20*log10(mag);
phase=squeeze(phase);

img_width = 18;
img_height = 15;

fig = plot_bode_diagram(mag, phase, wout, img_width, img_height, color_list, 1);

% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list4\images\question3');
file_name     = fullfile(image_path, 'q3_bode_N');
saveas(gcf,file_name,'epsc')     


%% TF + PD + Filtro de Notch
clc, close all,

s = tf('s');

N = (s*s + 1)/(s+20)^2;

I1 = 1; I2=0.1;
K = 0.2; D = 0.003;
kp = 0.04; kd=0.004;

sys_2_KD_OL = (kd*s + kp)*(D*s + K)/( (I1*I2)*s^4 + (I1*D+I2*D)*s^3 + (I1*K+I2*K)*s^2);
%sys_2_KD_CL = feedback(sys_2_KD_OL,1);

sys_2_KD_OL_N = sys_2_KD_OL*N;

figure(1), margin(sys_2_KD_OL_N);
[mag, phase, wout]=bode(sys_2_KD_OL_N);
mag = squeeze(mag); mag= 20*log10(mag);
phase=squeeze(phase);

img_width = 18;
img_height = 15;

fig = plot_bode_diagram(mag, phase, wout, img_width, img_height, color_list, 1);

% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list4\images\question3');
file_name     = fullfile(image_path, 'q3_bode_OL_PD_N');
saveas(gcf,file_name,'epsc')     

%% TF + PD + Filtro de Notch: Root locus
clc, close all,

s = tf('s');

N = (s*s + 1)/(s+20)^2;

I1 = 1; I2=0.1;
K = 0.2; D = 0.003;
%kp = 0.04; kd=0.004;

sys_2_OL = (D*s + K)/( (I1*I2)*s^4 + (I1*D+I2*D)*s^3 + (I1*K+I2*K)*s^2);

sys_2_OL_N = N*sys_2_OL;

sys_PD2 = (500*s + 50);

clear r kkd kkp;
for i=1:500
    kp=0.1*(i);
    kd=1*(i);
    
    sys_KD = (kd*s + kp);
    sys_2_KD_OL_N = sys_2_OL*sys_KD*N;
    sys_2_KD_CL_N = feedback(sys_2_KD_OL_N,1);
    
    sys_roots(:,i) = roots(sys_2_KD_CL_N.Denominator{1});
    kkd(i) = kd;
    kkp(i) = kp;
end

img_width = 15;
img_height = 8;

[roots_line, fig] = plot_root_locus(sys_roots, color_list, img_width, img_height);

%[data_index_inestabilty] = plot_data_tip_rlocus(r(1,:), kkp, kkd, r1);

%% step response
clc, close all,

s = tf('s');

N = (s*s + 1)/(s+20)^2;

I1 = 1; I2=0.1;

DD = linspace(0.001,0.005,6); 
KK = linspace(0.1, 0.3, 6);

y2 = zeros(301, 6);
uu = zeros(301, 6);
legend_list = cell(6,1);
for i=1:6
    D = DD(i);
    K = KK(i);
    sys_2_OL = (D*s + K)/( (I1*I2)*s^4 + (I1*D+I2*D)*s^3 + (I1*K+I2*K)*s^2);
    sys_2_OL_N = N*sys_2_OL;
    sys_PD2 = (500*s + 50);

    sys_2_CL_N_PD = feedback(sys_2_OL_N*sys_PD2, 1);

    t=0:0.1:30;
    u = 1 + 0*t;
    y2(:,i) = lsim(sys_2_CL_N_PD, u, t);
    uu(:,i) = u;
    legend_list{i} = strcat('$K=$', num2str(K), ', $D=$', num2str(D));
end

% image parameters
img_width= 15;
img_height= 15;
cnt_img_h = 1;
cnt_img_v = 1;
space_size = 1;
img_size = 12;
legend_flag = 'vertical';

figure(1), hold on, grid on, box on;
    fig = get(groot,'CurrentFigure');
    set(fig,'units','centimeters','position', [0 0 img_width img_height]);

    plot(t, y2,'linestyle', '-', 'linewidth', 1), hold on, box on, hold on
    ylabel('Amplitude (rad)', 'Interpreter','latex'),
    xlabel('Time (s)', 'Interpreter','latex'),
    ax = gca; % current axes
    ax.FontSize = 10;
    set(gca,'TickLabelInterpreter','latex')   
    legend(legend_list, 'interpreter', 'latex', 'location', 'northoutside')
    

% Save image
image_path = fullfile('C:\Users\USERTEST\Desktop\control_systems_homework\list4\images\question3');
file_name     = fullfile(image_path, 'q3_step_CL_PD_N');
saveas(gcf,file_name,'epsc')     
    
   