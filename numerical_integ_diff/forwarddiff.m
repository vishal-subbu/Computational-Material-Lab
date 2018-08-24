%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: numerical_integ_diff
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
% Initialisation of variables
h= [0.1,0.005,0.001,0.0005,0.0001,0.00001];
x = 0.4;
fdash_analytically = 0.6745418604
%Calculating Fdash for different values of h
for i = 1:6 
fdash(i) = ( f(x+h(i)) - f(x) )/h(i);
end
fdash
%Calcualting the relative error in Fdash for different values of h
error = zeros(6,1);
for i = 1:6 
    error(i) = (fdash(i) - fdash_analytically)*100/fdash_analytically;
end
%Plotting
loglog (h,error,'-o','linewidth',4.0);
xlabel('Step size');
ylabel('Relative error (in %)')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
grid on;
function y = f(x) 
y = x^2*cos(x) ;
end 
