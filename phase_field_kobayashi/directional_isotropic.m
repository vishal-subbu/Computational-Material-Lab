clear all
clc
figure(1);
clf
figure(2);
clf


xlength = 12.0;
halfx = xlength/2.0;
ylength = 3.0;
halfy = ylength/2.0;
Nx = 401;
Ny = 101;
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
[X,Y] = meshgrid(y,x);
Teq = 1.0;
temp_old = zeros(Nx,Ny);
temp_new = zeros(Nx,Ny);
p_new = zeros(Nx,Ny);
p_old = zeros(Nx,Ny);
angle = zeros(Nx,Ny);
delpy = zeros(Nx,Ny);
delpx = zeros(Nx,Ny);

% Values for variables
alpha = 0.9;
gamma = 10.0;
K = 1.4;
a=0.01;
tau = 0.0003;
epsilonbar = 0.01;
delt = 0.0002;
temp_old(:,:) = 0;

mfactor = @(temp) (alpha/3.1415)*atan(gamma*(Teq - temp));
value = [1,0.5];
% For generating a circular solid in center of the domain 
%initial profile
% for m = 2:Nx-1
% for n = 2:Ny-1
%     dist = (x(m) - halfx)^2 + (y(n) - halfy)^2;
%     dist = sqrt(dist);
%     if(dist <= 3*delx)
%         p_old(m,n) = 1.0;
%     end
% end
% end

% For directional solidification part
p_old(1:20,:) = 1.0;
mesh(X,Y,p_old);
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
           term10 = epsilonbar*epsilonbar*(p_old(m,n+1)+p_old(m,n-1) + p_old(m+1,n)+p_old(m-1,n)- 4*p_old(m,n) )/(dely*dely);
           term11 = p_old(m,n)*(1-p_old(m,n))*(p_old(m,n) - 0.5 + mfactor(temp_old(m,n)));
           term12 = a*p_old(m,n)*(1-p_old(m,n))*(rand() - 0.5);
           p_new(m,n) = p_old(m,n) + delt*( term10 + term11 + term12 )/tau ;
           
           temp_new(m,n) = temp_old(m,n) + delt*(temp_old(m+1,n) + temp_old(m-1,n) -2*temp_old(m,n))/(delx*delx); 
           temp_new(m,n) = temp_new(m,n) + delt*(temp_old(m,n+1) + temp_old(m,n-1) -2*temp_old(m,n))/(dely*dely);
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
    figure(1)
    %contour(X,Y,p_new,value);
    mesh(X,Y,p_old);
    view(3);
    hold off
    ax = gca ;
    set(ax, 'linewidth',2.0);
    end
    if(mod(i,100) == 0 )
    figure(2)
    contour(X,Y,p_new,value,'Linewidth',2.0);
    view(2);
    hold off
    ax = gca ;
    set(ax, 'linewidth',2.0);
    pause(1);
    end
    if(mod(i,500) == 0 )
        figure(2);
        str1 = ['Iso',num2str(i)];
        print(str1,'-dpng');
        
    end
    
    
    
    
end
