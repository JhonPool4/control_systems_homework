function [u, t] = velocity_reductor_signal(t1, t2, A)

    % sampling time
    dt = 0.01;
    % time vector
    t = 0:dt:(2*t1+t2);
    % quantity of elements
    len = length(t);
    % time limits
    tt1 = t1/dt;
    tt2 = len-tt1;
    % singal vector
    u = zeros(len,1);
    %if (t<=t1)
    u(1:tt1, 1) = 0 + (A/t1)*t(1:tt1); 
    %if (t<=t2)
    u(tt1+1:tt2,1)=A;
    % if(t>t2)
    u(tt2+1:end, 1)=A - (A/t1)*(t(tt2+1:end)- t(tt2));

end