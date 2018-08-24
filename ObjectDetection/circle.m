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