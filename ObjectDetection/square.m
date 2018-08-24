%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: ObjectDetection
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
clear all
clf
clc
Nx = 20;
Ny = 20;
A = zeros(Nx,Ny);

for i = 3:7
    for j = 3:7
        A(i,j) = 1;
    end
end
for i = 13:17
    for j = 13:17
        A(i,j) = 1;
    end
end

g = im2uint8(A);
imwrite(g,'square.jpg');
