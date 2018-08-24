delx = 2.0;
N = 4;
T0 = 40.0;
T5 = 200.0;
h = -0.02;
Ta = 10.0;
r = 1;
k = r*h^2;
temp = zeros(N,1);
X = zeros(N,1);
ae = zeros(N,1);
aw = zeros(N,1);
ap = zeros(N,1);
su = zeros(N,1);

for i = 1:N
    ap(i) = -2/(delx*delx) + h;
    ae(i) = 1.0/(delx*delx);
    aw(i) = 1.0/(delx*delx);
    su(i) = h*Ta;
    if ( i == 1)
        X(i) = delx;
    else 
        X(i) = X(i-1) + delx;
    end
end

su(1) = su(1) - aw(1)*T0;
su(N) = su(N) - ae(N)*T5;
ae(N) = 0.0;
aw(1) = 0.0;

for i = 1:N
    if(ap(i) == 0)
        disp ("Error ap becomes zero");
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

temp(N) = su(N)/ap(N);
for i = 2 : N
    j = N-i + 1;
    temp(j) = (su(j) - ae(j)*temp(j+1))/(ap(i)) ;
end

% For plotting properly
plot (x,t_now,'LineWidth',4);
hold on ;
title ("Temperature Profile across length")   ;
ylabel("Temperature ");
xlabel("Length");
box  on ;
grid on ;