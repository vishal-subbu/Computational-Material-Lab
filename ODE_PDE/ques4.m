clear all
clc
clf

h= 0.01;
x= 0:h:1;
n = 1/h + 1;
r = 1;
k = r*h^2;
t_now = zeros(n,1);
t0 = zeros(n,1);
ae = zeros(n,1);
aw = zeros(n,1);
ap = zeros(n,1);
su = zeros(n,1);
for i = 1:n
    t0(i) = sin(pi*x(i));
end

    

t_before =t0;
plot (x,t_before,'LineWidth',4,'DisplayName','Inital Profile');
hold on ;
title ("Temperature Profile across length")   ;
ylabel("Temperature ");
xlabel("Length");
box  on ;
grid on ;
for time = 0:k:0.2
    ap(1) = 1.0;
    su(1) = 0.0;
    ae(1) = 0.0;
    aw(1) = 0.0;
    for i = 2:n-1
        ap(i) = 2+2*r;
        ae(i) = -r;
        aw(i) = -r;
        su(i) = (2-2*r)*t_before(i) + r*(t_before(i-1) + t_before(i+1));
    end
    ap(n) = 1.0;
    su(n) = 0.0;
    ae(n) = 0.0;
    aw(n) = 0.0;
    for i = 1:n
        if(ap(i) == 0)
            disp ("Error ap becomes zero");
        end
    end
    ae(1) = ae(1)/ap(1);
    su(1) = su(1)/ap(1);
    ap(1) = 1.0;
    for i = 2:n
        ap(i) = ap(i) - ae(i-1)*aw(i)/ap(i-1) ;
        su(i) = su(i) - su(i-1)*aw(i)/ap(i-1) ;
        aw(i) = 0;
        ae(i) = ae(i) / ap(i);
        aw(i) = aw(i) / ap(i);
        su(i) = su(i) / ap(i);
        ap(i) = 1.0;
    end
    t_now(n) = su(n)/ap(n);
    for i = 2 : n
        j = n-i + 1;
        t_now(j) = (su(j) - ae(j)*t_now(j+1))/(ap(i)) ;
    end
    t_before = t_now;
    
    
end
% For plotting properly
plot (x,t_now,'LineWidth',4,'DisplayName','Temperature Profile at t=0.2');
hold on ;
title ("Temperature Profile across length")   ;
ylabel("Temperature ");
xlabel("Length");
box  on ;
grid on ;
legend('show')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
