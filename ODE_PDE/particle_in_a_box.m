%------------------------------------------------------------------------%
%---Finite Differencing of Time Independent Schrodinger Equation---------%
%------------------for a particle in a box-------------------------------%
%------------------------------------------------------------------------%

clc
close all
clear all

%------------------------------------------------------------------------%
%---all constant m,h,length that appears in Schrodinger equation are-----
%---taken as 1. Energy values are prescribed and wavefunction gets-------
%---updated in space using Finite difference scheme----------------------
%---Boundary condition and potential function are prescribed-------------
%------------------------------------------------------------------------%

dx=0.01;

n=1:4;

for l=1:4

%E=n(l)*n(l)*pi*pi/2; % Griffiths second edition, pp 44, Eq [2.27]

E=n(l)*n(l)*pi*pi/2 ;
%---Potential Energy Function for a Square well--------------------------%

N=100;
U=zeros(1,N);
U(1)=100;
U(N)=100;


K(1:N)=(2).*(E-U(1:N));
  
%------------------------------------------------------------------------%

W(1)=0; % initial condition
W(2)=1;

% updating the wave function---------------------------------------------%

for i=2:N-1
    W(i+1)=W(i)*(2-K(i)*dx*dx)-W(i-1);
end

% Normalizing probability density funtion of the particle----------------%

Ws=W.*W./trapz(W.*W);

%--for visualization purpose, maipulate arrays---------------------------%
%--extend arrays on both sides to visualize a potential well-------------%
%--scale amplitude of potential to view it with probability density------%
%--function--------------------------------------------------------------%

V=ones(1,N+100).*100;
Wtemp=zeros(1,N+100);

V(51:N+50)=U;
V=(V./100).*max(Ws);
Wtemp(51:N+50)=Ws;
Wa(l,:)=Wtemp;
L=length(Wtemp);
X=linspace(0,2,L)-1;

figure(1)
subplot(4,2,l)
plot(X,Wa(l,:),'linewidth',2)
hold on
plot(X,V,'r','linewidth',2)
h=gca; 
get(h,'FontSize') 
set(h,'FontSize',14)
axis([-1 1 0 0.025])
xlabel('X','fontSize',14);
ylabel('\psi','fontSize',14);
fh = figure(1);
set(fh, 'color', 'white'); 

end

%------------------------------------------------------------------------%

