
% question 1
clc, close all,

image_path = fullfile('/home/jhon/Desktop/control_systems_homework/list4/images/question2');


t=0:0.01:5;
x = 1*sin(0.628*t)+ 0.48*sin(6.28*t-0.2618) + 0.0796*sin(62.8*t - 1.08);

img_width = 12;
img_height = 8;
figure(1), hold on, grid on, box on;
    set(gcf,'units','centimeters','position', [0 0 img_width img_height])
    plot(t,x,'linestyle', '-', 'linewidth', 2, 'color', [0 0 0])
    ylabel('Reference', 'Interpreter','latex'),
    xlabel('Time (s)', 'Interpreter','latex'),
   
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')    

% Save image
file_name     = fullfile(image_path, 'act_2a');
saveas(gcf,file_name,'epsc')  


%% question 3
I1 = 1; I2 = 0.1;
D = linspace(0.001,0.005,6); K = linspace(0.1, 0.3, 6);

y1 = zeros(101, 6);
y2 = zeros(101, 6);
uu = zeros(101, 6);
for i=1:6
    A = [0,1,0,0;-K(i)/I1, -D(i)/I1, K(i)/I1, D(i)/I1; 0, 0, 0, 1; K(i)/I2, D(i)/I2, -K(i)/I2, D(i)/I2];
    B = [0; 1/I1; 0; 0];
    
    sys_1 = ss(A,B,[1, 0, 0, 0],[0]);
    sys_2 = ss(A,B,[0, 0, 1, 0],[0]);

    t=0:0.1:10;
    u = 0.1*sin(2*pi*0.1*t);
    %[u,t] = gensig("square",10,20);
    y1(:,i) = lsim(sys_1, u, t);
    y2(:,i) = lsim(sys_2, u, t);
    uu(:,i) = u;
end
%% question 3-c
clc, close all,

% colors
color1 = [0, 0.4470, 0.7410];                % dark red        --alpha=0.1 
color2 = [0.6350, 0.0780, 0.1840];       % dark blue      --alpha=0.5
color3 = [0.4660, 0.6740, 0.1880];       % dark green    --alpha=0.8
color4 = [0 0 0];

img_width = 15;
img_height = 10;
figure(1), hold on, grid on, box on;
    set(gcf,'units','centimeters','position', [0 0 img_width img_height])
    
    plot( t, y1(:,1),'linestyle', '-', 'linewidth', 2, 'color', color1); hold on, grid on, box on;
    plot( t, y2(:,1),'linestyle', '-', 'linewidth', 2, 'color', color2); hold on, grid on, box on;
    plot( t, u,'linestyle', '-', 'linewidth', 2, 'color', color3); hold on, grid on, box on;

    plot( t, y1,'linestyle', '-', 'linewidth', 2, 'color', color1); hold on, grid on, box on;
    plot( t, y2,'linestyle', '-', 'linewidth', 2, 'color', color2); hold on, grid on, box on;

    legend({'$\theta_1(t)$','$\theta_2(t)$', '$\tau(t)$'}, 'Interpreter', 'latex','Location','best')
    xlabel('Time (s)', 'Interpreter','latex'),
    ylabel('Angle (rad)', 'Interpreter','latex'),
   
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')

% Save image
image_path = fullfile('/home/jhon/Desktop/control_systems_homework/list4/images/question3');
file_name     = fullfile(image_path, 'q3_OL');
saveas(gcf,file_name,'epsc')  

%% question 3-d
clc, close all,
I1 = 1; I2=0.1;
K(1) = 0.2; D(1) = 0.003; i = 1;

A = [0,1,0,0;-K(i)/I1, -D(i)/I1, K(i)/I1, D(i)/I1; 0, 0, 0, 1; K(i)/I2, D(i)/I2, -K(i)/I2, D(i)/I2];
B = [0; 1/I1; 0; 0];

sys_1 = ss(A,B,[1, 0, 0, 0],[0]);
sys_2 = ss(A,B,[0, 0, 1, 0],[0]);

%%
clc, close all
%figure(1), rlocus(sys_2);

img_width = 10;
img_height = 8;

[r, k] = rlocus(sys_2);
figure(2), hold on, grid on, box on;
    set(gcf,'units','centimeters','position', [0 0 img_width img_height])

    plot(real(r(1,:)), imag(r(1,:)),'linestyle', '-', 'linewidth', 2, 'color', color1); hold on, grid on, box on;
    plot(real(r(2,:)), imag(r(2,:)),'linestyle', '-', 'linewidth', 2, 'color', color2); hold on, grid on, box on;
    plot(real(r(3,:)), imag(r(3,:)),'linestyle', '-', 'linewidth', 2, 'color', color3); hold on, grid on, box on;
    plot(real(r(4,:)), imag(r(4,:)),'linestyle', '-', 'linewidth', 2, 'color', color4); hold on, grid on, box on;

     plot(real(r(1,1)), imag(r(1,1)), 'Marker','+','MarkerSize', 10, 'color', color1, 'linewidth', 1); hold on, grid on, box on;
     plot(real(r(1,end)), imag(r(1,end)), 'Marker','o','MarkerSize', 10, 'color',  color1, 'linewidth', 2); hold on, grid on, box on;
     
     plot(real(r(2,1)), imag(r(2,1)), 'Marker','+','MarkerSize', 10, 'color', color2, 'linewidth', 1); hold on, grid on, box on;
     plot(real(r(2,end)), imag(r(2,end)), 'Marker','o','MarkerSize', 10, 'color',  color2, 'linewidth', 2); hold on, grid on, box on;
     
     plot(real(r(3,1)), imag(r(3,1)), 'Marker','+','MarkerSize', 10, 'color', color3, 'linewidth', 1); hold on, grid on, box on;
     plot(real(r(3,end)), imag(r(3,end)), 'Marker','o','MarkerSize', 10, 'color',  color3, 'linewidth', 2); hold on, grid on, box on;
     
     plot(real(r(4,1)), imag(r(4,1)), 'Marker','+','MarkerSize', 10, 'color', color4, 'linewidth', 1); hold on, grid on, box on;
     plot(real(r(4,end)), imag(r(4,end)), 'Marker','o','MarkerSize', 10, 'color',  color4, 'linewidth', 2); hold on, grid on, box on;
    legend({'$p_1$','$p_2$','$p_3$','$p_4$'}, 'Interpreter', 'latex','Location','northoutside', 'Orientation','horizontal')
    xlabel('Real axis (Hz)', 'Interpreter','latex'),
    ylabel('Imaginary axis (Hz)', 'Interpreter','latex'),
   
    ax = gca; % current axes
    ax.FontSize = 12;
    set(gca,'TickLabelInterpreter','latex')
    axis([-100 100 -80 80])

% Save image
image_path = fullfile('/home/jhon/Desktop/control_systems_homework/list4/images/question3');
file_name     = fullfile(image_path, 'q3_rlocus_K_CL');
saveas(gcf,file_name,'epsc')      


%%

clc, close all,

w = linspace(0.1,10, 1000);
%figure(1), margin(sys_2,w);
[mag,phase,wout] = bode(sys_2, w);

mag = squeeze(mag); mag= 20*log10(mag);
phase=squeeze(phase);

img_width = 18;
img_height = 12;
figure(2), grid on, box on;
    set(gcf,'units','centimeters','position', [0 0 img_width img_height])

bode_data = [mag, phase];
name = ["Magnitude (dB)", "Phase (deg)"];
name_dt = ["Mag. (dB): ", "Phase (deg): "];
data_index = [38;163];
for i=1:2
    subplot(2,1,i), 
    s = semilogx(wout, bode_data(:,i),'linestyle', '-', 'linewidth', 2, 'color', [0 0 0]); hold on, grid on, box on;
    s.DataTipTemplate.DataTipRows(1).Label = 'Frec. (rad/s):';
    s.DataTipTemplate.DataTipRows(2).Label = name_dt(i);
            
    dt1 = datatip(s, wout(data_index(1)) ,bode_data(data_index(1), i)  );
    dt1.Location = 'northwest';
    dt1.FontSize = 8;
    
    dt2 = datatip(s, wout(data_index(2)), bode_data(data_index(2), i) );
    dt2.FontSize = 8; 
    ylabel(name(i), 'Interpreter','latex'),
    xlabel( 'Frecuency ($\mathrm{\frac{rad}{s}}$)', 'Interpreter','latex'),
   
    ax = gca; % current axes
    ax.FontSize = 10;
    set(gca,'TickLabelInterpreter','latex')
end

% Save image
image_path = fullfile('/home/jhon/Desktop/control_systems_homework/list4/images/question3');
file_name     = fullfile(image_path, 'q3_bode_K_OL');
saveas(gcf,file_name,'epsc')  