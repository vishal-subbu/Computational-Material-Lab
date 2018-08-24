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
Nx = 10;
Ny = 20;
A = zeros(Nx,Ny);

for i = 2:Nx-1
    for j = 2:Ny-1
        distx = i - Nx/2;
        disty = j-Ny/2;
        dist = sqrt(distx^2 + disty^2);
        if(dist <= 2 )
            A(i,j) = 1;
        end
    end
end

g = im2uint8(A);
imwrite(g,'circle.jpg');
