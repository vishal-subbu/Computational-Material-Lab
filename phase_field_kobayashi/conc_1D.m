%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: phase_field_kobayashi
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
clear all
clc
clf

xstart = 0;
xend  = 1;
delx = 0.01;
diffusivity = 1;
delt =  (delx*delx)/ (4*diffusivity);
x = xstart:delx:xend;
N = (xend-xstart)/delx + 1;
c_new = zeros(N,1);
c_old = zeros(N,1);
%Initialising initial profile 
% m = 2;
% for i = 1:N
%     c_old(i) = 0.5*sin ( m*x(i)*3.1415 /xend) + 0.5;
% end

for i = 1:N/2+1
    c_old(i) = 0.4;
    c_old(N + 1-i) = 0.6;
end
plot(x,c_old,'ro','linewidth',4.0,'DisplayName','InitialProfile');
hold on;
xlabel('Length');
ylabel('Concenrtion')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
grid on;
for j = 1:10
    for i = 1:400
        k = 2;
        c_new(k) = c_old(k) + delt*diffusivity*(c_old(k+1) - c_old(k) )/(delx*delx) ;
        for k = 3 :N-2
            c_new(k) = c_old(k) + delt*diffusivity*(c_old(k+1) + c_old(k-1) - 2*c_old(k) )/(delx*delx) ;
        end
        k = N-1;
        c_new(k) = c_old(k) + delt*diffusivity*( c_old(k-1) - c_old(k) )/(delx*delx) ;
        c_new(1) = c_new(2);
        c_new(N) = c_new(N-1);
        c_old = c_new;
    end
    time = delt*(i-1) + (j-1)*40*delt;
    str = ['n=',num2str(time)];
    plot(x,c_old,'linewidth',4.0,'DisplayName',str);
    hold on;
    xlabel('Length');
    ylabel('Concenrtion')
    ax = gca ;
    set(ax, 'linewidth',2.0);
    axis('square');
end
title('Concenration profile as a function of time');
legend('show');  


