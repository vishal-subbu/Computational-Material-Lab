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
clear all
clc
clf

% Domain for dendritic soldiifcation
xlength = 9.0;
halfx = xlength/2.0;
ylength = 9.0;
halfy = ylength/2.0;
Nx = 301;
Ny = 301;
% Domain for directional soldiifcation
% xlength = 12.0;
% halfx = xlength/2.0;
% ylength = 3.0;
% halfy = ylength/2.0;
% Nx = 401;
% Ny = 101;
delx = xlength/(Nx-1);
dely = ylength/(Ny-1);
x = zeros(Nx,1);
y = zeros(Ny,1);
for i = 2:Nx
x(i) = x(i-1) + delx;
end
for i = 2:Ny
y(i) = y(i-1) + dely;
end
[X,Y] = meshgrid(x,y);
Teq = 1.0;
temp_old = zeros(Nx,Ny);
temp_new = zeros(Nx,Ny);
p_new = zeros(Nx,Ny);
p_old = zeros(Nx,Ny);
angle = zeros(Nx,Ny);
delpy = zeros(Nx,Ny);
delpx = zeros(Nx,Ny);
% Values for variables
theta0 = 0.0;
j = 4;
delta = 0.02;
alpha = 0.9;
gamma = 10.0;
K = 2.0;
a=0.01;
tau = 0.0003;
epsilonbar = 0.01;
delt = 0.0002;
temp_old(:,:) = 0;
% Function handles
mfactor = @(temp) (alpha/3.1415)*atan(gamma*(Teq - temp));
sigma = @(theta) 1 + delta*cos(j*(theta - theta0));
epsilon = @(theta) epsilonbar*sigma(theta);
epsilondash = @(theta) epsilonbar*delta*j*(-sin(j*(theta-theta0)));
value = [1,0.5];
%initial profile
% For directional soldiification
%p_old(1:20,:) = 1.0;
% For dendritic soldiification
for m = 2:Nx-1
for n = 2:Ny-1
    dist = (x(m) - halfx)^2 + (y(n))^2;
    dist = sqrt(dist);
    if(dist <= 0.25)
        p_old(m,n) = 1.0;
    end
end
end
mesh(p_old);
view(2);
hold off
ax = gca ;
set(ax, 'linewidth',2.0);
pause(1);

for i = 1:3500
    str = ['i = ',num2str(i)];
    disp(str);
    for m = 2:Nx-1
        for n = 2:Ny-1 
           delpy(m,n) = (p_old(m,n+1) - p_old(m,n-1))/(2*dely);
           delpx(m,n) = (p_old(m+1,n) - p_old(m-1,n))/(2*delx);
           if(delpy(m,n) == 0 )
               angle(m,n) = 0;
           else
               angle(m,n) = atan(delpy(m,n)/delpx(m,n));
           end
        end
    end
    
    for m = 2:Nx-1
        for n = 2:Ny-1 
           term1 = ((epsilon(angle(m+1,n)) - epsilon(angle(m-1,n)))*(...
           epsilondash(angle(m,n))*delpy(m,n))/(2*delx));
           term2 = ((epsilondash(angle(m+1,n)) - epsilondash(angle(m-1,n)))*(...
           epsilon(angle(m,n))*delpy(m,n))/(2*delx));
           term3 = ((delpy(m+1,n) - delpy(m-1,n))*epsilon(angle(m,n))*(...
           epsilondash(angle(m,n)))/(2*delx));
           
           term4 = ((epsilon(angle(m,n+1)) - epsilon(angle(m,n-1)))*(...
           epsilondash(angle(m,n))*delpx(m,n))/(2*dely));
           term5 = ((epsilondash(angle(m,n+1)) - epsilondash(angle(m,n-1)))*(...
           epsilon(angle(m,n))*delpx(m,n))/(2*dely));
           term6 = ((delpx(m,n+1) - delpx(m,n-1))*epsilon(angle(m,n))*(...
           epsilondash(angle(m,n)))/(2*dely));
           
           term7 = (2*epsilon(angle(m,n))*delpx(m,n)*(epsilon(angle(m+1,n)) -(...
           epsilon(angle(m-1,n)))/(2*delx)));
           term8 = epsilon(angle(m,n))*epsilon(angle(m,n))*(...
           (p_old(m+1,n)+p_old(m-1,n)- 2*p_old(m,n) )/(delx*delx));
           
           term9 = (2*epsilon(angle(m,n))*delpy(m,n)*(epsilon(angle(m,n+1)) -(...
           epsilon(angle(m,n-1)))/(2*dely)));
           term10 = epsilon(angle(m,n))*epsilon(angle(m,n))*(...
           (p_old(m,n+1)+p_old(m,n-1)- 2*p_old(m,n) )/(dely*dely));
           term11 = p_old(m,n)*(1-p_old(m,n))*(...
           (p_old(m,n) - 0.5 + mfactor(temp_old(m,n))));
           if((p_old(m,n)>=0.5)&&(p_old(m,n)<1))
           term12 = a*p_old(m,n)*(1-p_old(m,n))*(rand() - 0.5);
           else
               term12 = 0.0;
           end
           p_new(m,n) = p_old(m,n) + delt*(-term1 - term2 - term3 + (...
            term4 + term5 + term6 + term7 + term8 + term9 + term10 + (...
            term11 + term12 )/tau)) ;
           
           temp_new(m,n) = temp_old(m,n) + delt*(temp_old(m+1,n) +(...
           temp_old(m-1,n) -2*temp_old(m,n))/(delx*delx)); 
           temp_new(m,n) = temp_new(m,n) + delt*(temp_old(m,n+1) +(... 
           temp_old(m,n-1) -2*temp_old(m,n))/(dely*dely));
           temp_new(m,n) = temp_new(m,n) + K*(p_new(m,n) - p_old(m,n));
        end
    end
    temp_new(1,:) = temp_new(2,:);
    temp_new(Nx,:) = temp_new(Nx-1,:);
    temp_new(:,1) = temp_new(:,2);
    temp_new(:,Ny) = temp_new(:,Ny-1);
    temp_old = temp_new;
    p_new(1,:) = p_new(2,:);
    p_new(Nx,:) = p_new(Nx-1,:);
    p_new(:,1) = p_new(:,2);
    p_new(:,Ny) = p_new(:,Ny-1);
    p_old = p_new;
    if(mod(i,100) == 0 )
    contour(p_new,value, 'linewidth',2.0)
    view(2);
    hold off
    ax = gca ;
    set(ax, 'linewidth',2.0);
    pause(1);
    end
    if(mod(i,500) == 0 )
        figure(2);
        str1 = ['aniso',num2str(i)];
        print(str1,'-dpng');
    end
    
end
