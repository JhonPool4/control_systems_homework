
syms t11 t12 t21 t22

T = [t11 t12; t21 t22];
A = [-2, 1; -2, 0];
Am = [-2, -2; 1, 0];

b = [1; 3];
bm = [1; 0];

S = solve(A*T == T*Am, b==T*b, {t11, t12, t21, t22})    


%%

syms R1 R2 c L s

A = [-1/(R1*c), 0; 0, -R2/(L)];
B = [1/(c*R1); 1/L];
C = [-1/R1, 1];
D = [1/R1];

%s = tf('s');

G = C*inv(s*eye(2) -  A)*B + D

num = roots([R2*c, (1+R2*R2*c/L), R2/L])

den = roots([1, (R2/L+ R2), R2*R2/L])


%% 
close all, clear all, clc
A = [-1, -2, -2; 0, -1, 1; 1, 0, -1];
B = [2;0;1];
C = [0 0 5];
D = [0];

%p =  [-5;-15 + 5*i;-15-5*i];
w = 1;
psi = 1;
alpha = 5;
p = roots([1, 2*psi*w+alpha*w, w*w+2*psi*alpha*w*w, alpha*w*w]);
k = place(A, B, p);
sysCL = ss(A-B*k, B, C, D);

kr = 1/dcgain(sysCL);

sysCL2 = ss(A-B*k, B*kr, C, D);
[y, t]= step(sysCL2);
si = stepinfo(y,t);

figure(1), hold on, grid on, box on;
    plot(t, y, '-k', 'LineWidth', 2)
    plot(t(199), y(199), 'MarkerSize', 10, 'Marker','o', 'MarkerFaceColor', 'r')
    set(gcf,'units','centimeters','position', [0 0 10.0 10.0])


image_path = '/home/jhon/Desktop/control_systems_homework/list3/images';
% Save image
file_name     = fullfile(image_path, 'step_response');
saveas(gcf,file_name,'epsc')    
%%
clc, clear all, close all;

s = tf('s');
G = 10/s/(s+2)/(s+8);       

Ac = [-10 1 0; -16 0 1; 0 0 0];
Bc = [0; 0 ;10];
Cc = [1 0 0];
Dc = 0;


% controller
des_poles = [-1.4, -1+2.15*i, -1-2.15*i ];
kc = acker(Ac, Bc, des_poles );

% observer
des_poles = [-4.25, -3+6.4*i, -3-6.4*i];
ko = acker(Ac', Cc', des_poles)';
Ae = Ac-ko*Cc;


% close loop: controller
%sys_cl = ss(Ac-Bc*kc, Bc, Cc, Dc);
%t  = 0:0.1:100;
%u = zeros(1, length(t)); 
%x0 = [1; 0 ;0];

%[Y,T,X] = lsim(sys_cl, u, t, x0) ;

%figure(1), plot(T , Y, '-k')

% close loop:  controller + observer
A_cl = [Ac  -Bc*kc; ko*Cc  Ae-Bc*kc-ko*Dc*kc];
B_cl = [0;0;0;0;0;0];
C_cl = [0 0 0 0 0 0];
D_cl= 0;

t  = 0:0.05:10;
u = zeros(1, length(t)); 
x0 = [1; 0 ;0; 1; 0; 0];

sys_cl_co = ss(A_cl, B_cl, C_cl, D_cl);
[Y,T,X] = lsim(sys_cl_co, u, t, x0) ;

figure(2), hold on, grid on, box on;
    plot(T, X(:,1), '-k', 'LineWidth', 2)
    plot(T, X(:,4), '--r', 'LineWidth', 2)
    xlabel('Time (s)', 'Interpreter','latex')
    ylabel('Amplitude', 'Interpreter','latex')
    leg=legend({'measured','observed'}, 'Interpreter','latex');
    title(leg, 'states')
    set(gcf,'units','centimeters','position', [0 0 10.0 10.0])


image_path = '/home/jhon/Desktop/control_systems_homework/list3/images';
% Save image
file_name     = fullfile(image_path, 'plot_question_3d');
saveas(gcf,file_name,'epsc')    