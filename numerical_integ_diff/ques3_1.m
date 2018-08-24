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
%Defining the function
fun =  @(x) abs(x.^5 - 15.*x.^4 + 85.*x.^3 - 225.*x.^2 + 274.*x - 120);
%Integrating for different values of h
h= [0.1,0.05,0.01,0.005,0.001,0.0005];
integ = zeros(6,1)
for i = 1:6
    x=1:h(i):5;
    y = fun(x);
    integ(i) = trapz(x,y);
end
%Calculating Error
error = zeros(6,1);
for i = 1:6
    error(i) = abs((19/3) - integ(i)) /(19/3);
end
%Plotting
loglog(h,error,'-o','linewidth',4.0);
xlim([0.0003 0.11]);
xlabel('Step size');
ylabel('Relative error (in %)')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
grid on;
