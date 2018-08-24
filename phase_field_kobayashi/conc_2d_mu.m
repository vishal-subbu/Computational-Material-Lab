clear all
clc
figure(1);
clf
figure(2);
clf;



xstart = 0;
xend  = 1;
ystart = 0;
yend  = 1;
del = 0.1;
diffusivity = 1;
delt = 0.000001* (del*del)/ (diffusivity);
x = xstart:del:xend;
y = ystart:del:yend;
N = (xend-xstart)/del + 1;
R = 8.314;
temp = 100;
omega = 2000; 
c_new = zeros(N,N);
c_old = zeros(N,N);
chempot = zeros(N,N);
%Initialising initial profile 
m = 4;
for i = 2:N-1
    for j = 2:N-1
        dist = (x(i) - xend/2)^2 + (y(j) - yend/2)^2 ;
        dist = sqrt(dist);
        c_old(i,j) = 0.1*sin (m*(dist)*3.1415/xend) + 0.5;
    end
end
c_old(1,:) = c_old(2,:);
c_old(N,:) = c_old(N-1,:);
c_old(:,1) = c_old(:,2);
c_old(:,N) = c_old(:,N-1);
figure(1);
mesh(c_old);
hold off
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
pause();
mu = @(x) omega.*(1.-(2.*x)) + R.*temp.*(log(x./(1.-x)))  ;
[X,Y] = meshgrid(x,y);
for i = 1:10000
    str = ['i = ',num2str(i)];
    disp(str);
    chempot = mu(c_old);
    for m = 2:N-1
        for n = 2:N-1 
            c_new(m,n) = c_old(m,n) + delt*diffusivity*(chempot(m+1,n) + chempot(m-1,n) + chempot(m,n+1) + chempot(m,n-1)- 4*chempot(m,n))/(del*del);
        end
    end
    c_new(1,:) = c_new(2,:);
    c_new(N,:) = c_new(N-1,:);
    c_new(:,1) = c_new(:,2);
    c_new(:,N) = c_new(:,N-1);
    c_old = c_new;
    if(mod(i,100) == 0 )
        figure(1);
        mesh(X,Y,c_old);
        view(2);
        hold off
        ax = gca ;
        set(ax, 'linewidth',2.0);
        axis('square');
        pause(1);
    end
    if(mod(i,1000) == 0 )
        figure(2)
        mesh(X,Y,chempot);
        hold off;
        ax = gca ;
        set(ax, 'linewidth',2.0);
        axis('square');
    end
end
legend('show');