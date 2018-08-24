clear all
clc
clf
a = 0.5; %in nm 
delx =0.01;
x = 0:delx:a;
N = a/delx + 1;
E = 1.50;
psi = ones(N,1);
ae = zeros(N,1);
aw = zeros(N,1);
ap = zeros(N,1);
su = zeros(N,1);
for i = 1:N
    psi(i) = sin(3.1415*x(i)/a);
end
plot (x,psi,'LineWidth',4);
title ("Psi across length")   ;
ylabel("Psi ");
xlabel("Length");
box  on ;
grid on ;
pause();
for i = 2:N-1
    ap(i) = -2/(delx*delx) + 0.663*E;
    ae(i) = 1.0/(delx*delx);
    aw(i) = 1.0/(delx*delx);
    su(i) = 0.0;
end
i=1;
ap(i) = 1.0;
ae(i) = 0.0;
aw(i) = 0.0;
su(i) = 0.00001;
i=N;
ap(i) = 1.0;
ae(i) = 0.0;
aw(i) = 0.0;
su(i) = 0.00001;

for i = 1:N
    if(ap(i) == 0)
        disp ("Error ap becomes zero");
        i
    end
end

ae(1) = ae(1)/ap(1);
su(1) = su(1)/ap(1);
ap(1) = 1.0;
for i = 2:N 
  ap(i) = ap(i) - ae(i-1)*aw(i)/ap(i-1) ;
  su(i) = su(i) - su(i-1)*aw(i)/ap(i-1) ;
  aw(i) = 0;
  ae(i) = ae(i) / ap(i);
  aw(i) = aw(i) / ap(i);
  su(i) = su(i) / ap(i);
  ap(i) = 1.0;
end

psi(N) = su(N)/ap(N);
for i = 2 : N
    j = N-i + 1;
    psi(j) = (su(j) - ae(j)*psi(j+1))/(ap(i)) ;
end

% For plotting properly
plot (x,psi,'LineWidth',4);
title ("Psi across length")   ;
ylabel("Psi ");
xlabel("Length");
box  on ;
grid on ;
