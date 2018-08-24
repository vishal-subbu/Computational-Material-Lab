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
fun = @(x) abs( x.^5 - 15.*(x.^4) + 85.*(x.^3) - 225.*(x.^2) + 274.*x - 120 );
%Performing Integration using integral()
integ1 = integral(fun,1,5);
integ1
%Performing Integration using int()
syms x
integ2 = int(fun,x,1,5);
integ2
%Performing Integration using trapz()
X = 1:0.01:5;
Y = fun(X);
integ3 = trapz(X,Y);
integ3
