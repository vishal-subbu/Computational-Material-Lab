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
Nx = 1000;
Ny = 1200;
A = zeros(Nx,Ny);

r = randi([6 10],1); % Number of objects 

for i = 1:r 
    obj_id = randi([1 2],1);
    if(obj_id==1) % For creating rectangles
        x_center = randi([10,Nx-20],1);
        y_center = randi([10,Ny-20],1);
        length = randi([50,Nx/10],1);
        breadth = randi([50,Nx/10],1);
        for  m = x_center : x_center+length
            for n = y_center : y_center +breadth
                A(m,n) = 1;
            end
        end
    elseif(obj_id==2)    % For creating circles
        rad = randi([10,70],1);
        x_center = randi([5,Nx-4],1);
        y_center = randi([5,Ny-4],1);
        for  m = 3:Nx-2
            for n = 3:Ny-2
                distx = m-x_center ;
                disty =n-y_center;
                dist = sqrt(distx^2 + disty^2);
                if(dist <= rad )
                    A(m,n) = 1;
                end
            end
        end
    end
end
  
g = im2uint8(A);
imshow(g);
imwrite(g,'squares.jpg');
