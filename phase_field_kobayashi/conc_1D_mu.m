clear all
clc
figure(1);
clf
figure(2);
clf;



xstart = 0;
xend  = 1;
delx = 0.01;
diffusivity = 1;
delt =  0.0001*(delx*delx)/ (diffusivity);
x = xstart:delx:xend;
N = (xend-xstart)/delx + 1;
R = 8.314;
temp = 100;
omega = 2000;
%temp = 100; % T = omega/(2R) + 1 for downhill diffusion and 
%T = omega/(2R) - 1 for uphill diffsion 
c_new = zeros(N,1);
c_old = zeros(N,1);
chempot = zeros(N,1);
%Initialising initial profile 
% m = 2;
% for i = 1:N
%     c_old(i) = 0.2*sin ( m*x(i)*3.1415 /xend) + 0.5;
% end
mu = @(x) omega.*(1.-(2.*x)) + R.*temp.*(log(x./(1.-x)))  ;
for i = 1:N/2+1
    c_old(i) = 0.4;
    c_old(N + 1-i) = 0.6;
end
figure(1)
plot(x,c_old,'ro','linewidth',4.0,'DisplayName','InitialProfile');
hold on;
xlabel('Length');
ylabel('Concenrtion')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
grid on;
pause (1);
hold off;
for i = 1:21000
    str = ['i = ',num2str(i)];
    disp(str);
    chempot(1:N) = mu(c_old);
    for k = 2:N-1
        c_new(k) = c_old(k) + delt*diffusivity*(chempot(k+1) + chempot(k-1) - 2*chempot(k))/(delx*delx);
    end
    c_new(1) = c_new(2);
    c_new(N) = c_new(N-1);
    c_old = c_new;
    if(mod(i,100) == 0 )
        figure(1);
        plot(x,c_old,'linewidth',4.0);
        hold off;
        xlabel('Length');
        ylabel('Concenration')
        ax = gca ;
        set(ax, 'linewidth',2.0);
        axis('square');
        pause(1);
    end
    if(mod(i,1000) == 0 )
        figure(2)
        plot(x,chempot,'linewidth',4.0,'DisplayName',str);
        hold on;
        xlabel('Length');
        ylabel('ChemicalPotential')
        ax = gca ;
        set(ax, 'linewidth',2.0);
        axis('square');
    end
end
legend('show');