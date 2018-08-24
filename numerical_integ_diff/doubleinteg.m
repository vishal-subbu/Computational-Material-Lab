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
%Definig the function
fun = @(x,y) x.^2 + - 3.*(y.^2) + x .* ( y.^3) ;
%Defining the limits
xmin = 0;
xmax = 4;
ymin = -2;
ymax = 2;
%Performing Integration
integ = integral2 (fun , xmin,xmax,ymin,ymax);
%Printing the output
integ
