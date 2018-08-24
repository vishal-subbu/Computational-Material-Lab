%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: nonlinear_equations
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
converge = 1.0;
initial_guess = 1.5;
x_0 = initial_guess;
x_1 = x_0;
xdash = 0.0;
while converge > 0.0001
    xdash = fdash(x_0);
    if(xdash == 0 )
        print "Fdash becomes zero. choose different initial guess " 
    end
    x_1 = x_0 - (f(x_0)/xdash);
    converge  = abs(x_1-x_0);
    x_0 = x_1
end
converge

function y = f(x)
y = x*x*x - 6*x*x + 3*x +10 ;
end

function y = fdash(x)
y = 3*x*x -12*x + 3 ;
end
