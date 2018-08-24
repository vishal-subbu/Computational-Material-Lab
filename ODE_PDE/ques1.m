%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: ODE_PDE
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
clear all
clc
clf

func = @(x,y) y*x^3 - 1.5*y;
x0 = 0;
y0 = 1;
h = [0.01,0.05,0.1,0.2,0.3,0.4,0.5];
size_h = 7;
y2 = 2.718281;
analytic = zeros(size_h,1);
euler = zeros(size_h,1);
error_euler = zeros(size_h,1);
heun = zeros(size_h,1);
error_heun = zeros(size_h,1);
rk = zeros(size_h,1);
error_rk = zeros(size_h,1);
for i = 1:size_h
    analytic(i) = y2 ;
end
%Euler method
for i = 1:size_h
    y1 = y0;
    x1 = x0;
    while (x1<=2)
        y1 = y1 + h(i)*func(x1,y1);
        x1 = x1 + h(i);
    end
    euler(i) = y1;
    error_euler(i) = abs((y1 - y2)*100 /y2);
end


%Heun's method
for i = 1:size_h
    y1 = y0;
    x1 = x0;
    while (x1<=2)
        y10 = y1 + h(i)*func(x1,y1);
        y1 = y1 + 0.5*h(i)*(func(x1,y1) + func(x1,y10));
        x1 = x1 + h(i);    
    end
    heun(i) = y1;
    error_heun(i) = abs((y1 - y2)*100 /y2);
end

%Runge-Kutta
for i = 1:size_h
    y1 = y0;
    x1 = x0;
    while (x1<=2)
        k1 = h(i)*func(x1,y1);
        k2 = h(i)*func(x1 + 0.5*h(i),y1 + 0.5*k1);
        k3 = h(i)*func(x1 + 0.5*h(i),y1 + 0.5*k2);
        k4 = h(i)*func(x1 + h(i),y1 + k3);
        y1 = y1 + 1/6*(k1 + 2*k2 + 2*k3 + k4);
        x1 = x1 + h(i);
    end
    rk(i) = y1;
    error_rk(i) = abs((y1 - y2)*100 /y2);
end
hold on;

loglog (h,error_euler,'-o','linewidth',4.0,'DisplayName','Euler');
loglog (h,error_heun,'-s','linewidth',4.0,'DisplayName','Heun');
loglog (h,error_rk,'-x','linewidth',4.0,'DisplayName','RungaKutta');
xlabel('Step size');
ylabel('Relative error (in %)');
ax = gca ;
set(ax, 'linewidth',2.0);
grid on;
legend('show');


