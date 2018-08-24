%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: ODE_PDE
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
clear all
clc
clf

a = 0.5e-09 ; % in nm
h = 6.626e-34;
m = 9.1e-31;
hbar = h/(2*3.1415);
N = 1000; % Excluding the boundary points
del = a/(N+1);
H = zeros(N,N);
%Populating the Hamiltonian Matrix
value = hbar*hbar/((del*del)*m);
for i = 2:N-1
    H(i,i) = value;
    H(i,i+1) = -0.5*value;
    H(i,i-1) = -0.5*value;
end
H(1,1) = value;
H(1,2) = -0.5*value;
H(N,N) = value;
H(N,N-1) = -0.5*value;
%Finding the eigen values and eigen vectors
[e,d,w] = eig(H);
e = eig(H);
%Plotting 
no_of_levels = 10;
n = 1:no_of_levels;
y = 1:no_of_levels;
energy = zeros(10,1);
factor = (h*h)/(8*m*a*a);
for i = 1:no_of_levels
    y(i) = n(i)*n(i) * factor/(1.6e-19);
    energy(i) = e(i)/(1.6e-19);
end
plot (n,energy,'ro','LineWidth',4);
hold on;
plot (n,y,'LineWidth',4);
title ("Energy for the first 10 levels")   ;
ylabel("Energy (in eV)");
xlabel("Levels");
legend('Numerical','Analytical')
box  on ;
grid on ;
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');

hold off;

clf; 

%Plotting Eigen Vectors 
x= zeros(N+2,1);
wav = zeros(N+2,1);
for i = 2:N+2
    x(i) = x(i-1) + del;
end
Wave = zeros(N+2,no_of_levels);
for j = 1:no_of_levels
    for i = 2:N+1
        Wave(i,j) = w(i-1,j);
    end
end
for j = 1:5
    for i = 1:N+2
        wav(i) = Wave(i,j) +  (j-1)*0.5;
    end
     str = ['n=',num2str(j)];
    plot (x,wav,'LineWidth',4,'DisplayName',str);
    hold on;
    title ("Form of Psi for the first 5 levels")   ;
    xlabel("Distance (in m");
    box  on ;
    grid on ;
    ax = gca ;
    set(ax, 'linewidth',2.0);
    axis('square');
end
legend('show');
legend('location','eastoutside');
