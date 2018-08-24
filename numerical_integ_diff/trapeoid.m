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
% variables in SI units  
g = 9.8 ;
cd = 0.25;
m = 70;
t0 = 0;
tend = 10;
h = 0.01;

% Definiton of function to be integrated
fun = @(t) sqrt(g*m/cd)*tanh(sqrt(g*cd/m)*t);
time = t0:h:tend;
i = 1;
integ = 0;
% Loop to implement Trapezoidal method
while time(i) < tend
    integ = integ + 0.5*(fun(time(i)+h) + fun(time(i)) )*h;
    i = i+1;
end

integ
    
