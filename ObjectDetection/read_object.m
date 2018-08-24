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
%Reading the file
file = imread('object_1.jpg');
g = mat2gray(file);
N = size(g);
Nx = N(1);
Ny = N(2);
kernel = [-1,-1,-1;-1,8,-1;-1,-1,-1];
B =zeros(Nx,Ny);
% Thresholding the image to make it binary
for i= 1:Nx
    for j = 1:Ny
        if(g(i,j)<0.5)
            g(i,j) =0;
        else
            g(i,j) = 1;
        end
    end
end
%% Implementation of Kernel operation for edge detection 
for i = 2:Nx-1
    for j = 2:Ny-1
        for m = -1:1
            for n = -1:1
                B(i,j) = B(i,j) + kernel(m+2,n+2)*g(i+m,j+n);
            end
        end
    end
end
for i= 2:Nx-1
    for j = 2:Ny-1
        if((B(i,j) >=0) &&(B(i,j)<0.5))
            B(i,j) =0;
        else
            B(i,j) = 1;
        end
    end
end
Bdash = zeros(Nx,Ny);
contours = zeros(Nx,Ny);
for i= 2:Nx-1
    for j = 2:Ny-1
        if((B(i,j)==1) &&(g(i,j)==1))
            Bdash(i,j) = 1;
        end
    end
end

image = im2uint8(B);
imshow(image);
pause(1);
count = 0;
count_before = 0;
%% To reduce the number of edge pixcels in the Moore neighbourhood
order = [-1,-1;-1,0;-1,1;0,1;1,1;1,0;1,-1;0,-1];
k1 = [0,1,0;1,0,0;0,0,0];
k2 = [0,1,0;0,0,1;0,0,0];
k3 = [0,0,0;1,0,0;0,1,0];
k4 = [0,0,0;0,0,1;0,1,0];
for i = 2:Nx-1
    for j = 2:Ny-1
        if(Bdash(i,j) ==1)
            sum1 = 0;
            sum2 = 0;
            sum3 = 0;
            sum4 =0;
            for m = -1:1
                for n = -1:1
                    sum1 = sum1 + k1(m+2,n+2)*Bdash(i+m,j+n);
                    sum2 = sum2 + k2(m+2,n+2)*Bdash(i+m,j+n);
                    sum3 = sum3 + k3(m+2,n+2)*Bdash(i+m,j+n);
                    sum4 = sum4 + k4(m+2,n+2)*Bdash(i+m,j+n);
                end
            end
            if((sum1==2)||(sum2==2)||(sum3==2)||(sum4==2))
                Bdash(i,j) = 0;
            end
        end
    end
end
%% Finding the number of objects
B = Bdash;
for i = 2:Nx-1
    for j = 2:Ny-1
        if(Bdash(i,j) == 1)
            count = count +1;
            B(i,j) =0;
            contours(i,j) = count;
            oldi = i;
            oldj = j-1;
            m = i; n =j;
            starti = i;
            startj = j;
            for l = 1:8
                if((i+order(l,1) == oldi) && (j+order(l,2)==oldj))
                    k = l+1;
                    break
                end
            end
            if(k==9)
                k = 1;
            end
            for a = 1:8
                if(Bdash(m+order(k,1),n+order(k,2)) == 1)
                    B(m,n) =0;
                    contours(m,n) = count;
                    oldi = m;
                    oldj = n;
                    m = m+order(k,1);
                    n = n+order(k,2);
                    for l = 1:8
                        if((m+order(l,1) == oldi) && (n+order(l,2)==oldj))
                            k = l+1;
                        end
                    end
                    if(k==9)
                        k=1;
                    end
                else
                    k=k+1;
                    
                    if(k==9)
                        k=1;
                    end
                end
            end
            while((m~=starti)||(n~=startj))
                if(Bdash(m+order(k,1),n+order(k,2)) == 1)
                    B(m,n) = 0;
                    contours(m,n) = count;
                    oldi = m;
                    oldj = n;
                    m = m+order(k,1);
                    n = n+order(k,2);
                    for l = 1:8
                        if((m+order(l,1) == oldi) && (n+order(l,2)==oldj))
                            k = l+1;
                            break
                        end
                    end
                    if(k==9)
                        k=1;
                    end
                else
                    k=k+1;
                    
                    if(k==9)
                        k=1;
                    end
                end
            end
        end
        if(count~=count_before)
            count_before = count;
            Bdash = B;
            count
            i=1;
            j=2;
            image = im2uint8(Bdash);
            imshow(image);
            pause(1);
        end
        
    end
end
count

%% To Tag the pixcels in the interior to the object
for i = 2:Nx-1
    for j = 2:Ny-1
        if((contours(i,j-1)==0)&&(contours(i,j)~=0))
            j=j+1;
            while(g(i,j)==1)
                contours(i,j) = contours(i,j-1);
                j=j+1;
            end
        end
    end
end

%% Assigning different colours to different objects and then printing

image_contour = zeros(Nx,Ny,3);
red_index = randi([30,230],count);
blue_index = randi([30,230],count);
green_index = randi([30,230],count);
for i = 1:Nx
    for j = 1:Ny
        if(contours(i,j)~=0)
            image_contour(i,j,1) = red_index (contours(i,j));
            image_contour(i,j,2) = blue_index (contours(i,j));
            image_contour(i,j,3) = green_index (contours(i,j));
        end
    end
end

image = uint8(image_contour);
imshow(image);
