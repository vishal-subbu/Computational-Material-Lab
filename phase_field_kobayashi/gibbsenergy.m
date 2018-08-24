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



delc = 0.01;
diffusivity = 1;
delt =  (delc*delc)/ (400000*diffusivity);
c = 0:delc:1;
N = 1.0/delc + 1;
R = 8.314;
temp = 50;
omega = 2000;
%temp = omega/(2*8.314) + 1; % T = omega/(2R) + 1 for downhill diffusion and 
%T = omega/(2R) - 1 for uphill diffsion 
for i = 1:N
    gibbs(i) = omega*(1-c(i))*c(i) + R*temp*(c(i)*log(c(i)) + (1-c(i))*log(1-c(i)));
end
plot(c,gibbs,'linewidth',4.0);
hold on;
xlabel('Concenration');
ylabel('GibbsEnergy')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
