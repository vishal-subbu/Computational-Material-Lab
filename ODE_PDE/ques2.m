clear all
clf
clc
h=1;

length = 10;
x = 0:h:length
size = length/h + 1;
T = zeros(size,1);
T(1) = 240;
Z0 = -88.6 %Our guess at the first derivative
for i = 2:size
    T(i) = T(i-1) + Z0*h;
    Z1 = Z0 + 0.15*T(i-1)*h;
    Z0 =Z1;
end
T(size)
plot (x,T,'LineWidth',4);
hold on;
title ("Temperature Profile")   ;
xlabel("Distance (in m)");
ylabel("Temperature");
box  on ;
grid on ;
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');