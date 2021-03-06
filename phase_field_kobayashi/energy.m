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
p = -0.2:0.01:1.2;
alpha = 0.9;
gamma = 10.0;
Teq = 1;
temp = 0;
mfactor =(alpha/3.1415)*atan(gamma*(Teq - temp));
F = 0.25.*(p.^4) - (0.5 -(1/3)*mfactor).*(p.^3) + (0.25 - 0.5*mfactor).*(p.^2);

plot(p,F)
