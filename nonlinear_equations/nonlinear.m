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
fun = @non_linear;
%x0 = [1.5 3];
%x0 = [0 0 ];
%x0 =  [-2.5 -3];
%x0 = [-4 3]
diary('nonlinear.txt');
diary on;
x0 = [1 1]
options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
x = fsolve(fun,x0);
x

x0 = [-4 3]
options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
x = fsolve(fun,x0);
x

x0 =  [-2.5 -3]
options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
x = fsolve(fun,x0);
x

x0 = [0 0 ]
options = optimoptions('fsolve','Display','none','PlotFcn',@optimplotfirstorderopt);
x = fsolve(fun,x0);
x


diary off; 
fimplicit(@(x,y)x.^2 + y.^2 - 17,'LineWidth',2.0)
hold on;
fimplicit(@(x,y)x.^2 + 2*x - 5 - y,'LineWidth',2.0)
function F = non_linear(x)

F(1) = x(1)*x(1) + x(2)*x(2) - 17;
F(2) = x(1)*x(1) + 2*x(1) - x(2) - 5 ;
end



