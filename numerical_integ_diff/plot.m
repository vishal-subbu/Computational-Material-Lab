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
semilogx(h,fdash,'ro','linewidth',4.0);
hold on;
semilogx(h,analytic,'linewidth',4.0);
legend('Numerical','Analytical');
xlabel('Step size');
ylabel('Derivative of F')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
grid on;
