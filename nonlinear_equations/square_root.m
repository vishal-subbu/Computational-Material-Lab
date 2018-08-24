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
initial_guess = 1.0;
a = 2.34886276;
x_0 = initial_guess;
x_1 = x_0;
xdash = 0.0;
while converge > 0.0001
    x_1 = x_0 + a/x_0;
    x_1 = x_1/2.0;
    converge  = abs(x_1-x_0);
    x_0 = x_1;
    x_1
end
converge
