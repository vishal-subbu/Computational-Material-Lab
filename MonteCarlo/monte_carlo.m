%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: Monte Carlo
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
clear all
clf
clc

Nx = 50;
Ny = 50;
grain_old = zeros(Nx,Ny);
N = 200;
KbT = 10;
no_of_orientations = 16;
r = randi([10 200],no_of_orientations);
order = [-1,-1;-1,0;-1,1;0,1;1,1;1,0;1,-1;0,-1];
for i = 2:Nx-2
    for j = 2:Ny-2
        rand  = randi([1 no_of_orientations],1);
        grain_old(i,j) = r(rand ,1);
    end
end

pcolor(grain_old)
shading flat;
view(2);
pause(1);
str1 = ['initialgrain'];
print(str1,'-dpng');
for t = 1:1000
    for m = 1:N
        x = randi([2 Nx-2],1);
        y = randi([2 Nx-2],1);
        H1 = calc_H(grain_old,x,y);
        temp = grain_old(x,y);
        neighbour = randi([1 8],1);
        grain_old(x,y) = grain_old(x+order(neighbour,1),y+order(neighbour,2));
        H2 = calc_H(grain_old,x,y);
        delH = H2-H1;
        prob = exp(-delH/(KbT));
        trans = rand();
        if(trans>prob)
            grain_old(x,y) = temp;
        end
    end
    if(mod(t,100) == 0)
        t
        pcolor(grain_old);
        view(2);
        shading flat;
        str1 = ['grain',num2str(t)];
        print(str1,'-dpng');
        pause(1);
    end
end

function y = delta(a,b)
if(a==b)
    y = 1;
else
    y = 0;
end
end

function y = calc_H(A,i,j)
y = 0;
k = 10;
order = [-1,-1;-1,0;-1,1;0,1;1,1;1,0;1,-1;0,-1];
for l = 1:8
    y = y + (k/2)*(1-delta(A(i,j),A(i+order(l,1),j+order(l,2))));
end
end
