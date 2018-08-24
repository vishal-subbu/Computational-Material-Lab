clear all
clc
clf


length = 12;
del = 2;
tol = 1e-08;
t_bottom = 100;
t_left = 100;
t_right = 100;
t_top = 0;
maxit = 20;
n = length/del +2;
x = zeros(n,1);
y = zeros(n,1); 
temp = zeros(n,n);
ap = zeros(n,n);
aw = zeros(n,n);
ae = zeros(n,n);
an = zeros(n,n);
as = zeros(n,n);
su = zeros(n,n);
x(1) = 0 ;
y(1) = 0;
x(2) = del/2;
y(2) = del/2;
for i = 3 : n-1
    x(i) = x(i-1) + del;
    y(i) = y(i-1) + del;
end
x(n) = x(n-1) + del/2;
y(n) = y(n-1) + del/2;

for i = 2:n-1
    for j = 2:n-1
        ap(i,j) = -4.0/(del*del) ;
        aw(i,j) = 1.0/(del*del) ;
        ae(i,j) = 1.0/(del*del) ;
        an(i,j) = 1.0/(del*del) ;
        as(i,j) = 1.0/(del*del) ;
        su(i,j) = 0.0;
    end
end

ap(:,1) = 1.0;
su(:,1) = t_bottom;
ap(:,n) = 1.0;
su(:,n) = t_top;
ap(1,:) = 1.0;
su(1,:) = t_left;
ap(n,:) = 1.0;
su(n,:) = t_right;


A = zeros(n*n,n*n);
Su = zeros(n*n,1); 
for i = 2:n-1
    for j = 2:n-1
        k = n*(i-1) + j ;
        A(k,k) = ap(i,j);
        A(k,k+1) = an(i,j);
        A(k,k-1) = as(i,j);
        A(k,k+n) = ae(i,j);
        A(k,k-n) = aw(i,j);
    end
end
for i = 1:n 
    j = 1;
    k = n*(i-1) + j;
    A(k,k) = ap(i,j);
    Su(k) = su(i,j);
    j = n;
    k = n*(i-1) + j;
    A(k,k) = ap(i,j);
    Su(k) = su(i,j);
end
for j = 1:n
    i= 1;
    k = n*(i-1) + j;
    A(k,k) = ap(i,j);
    Su(k) = su(i,j);
    i =n;
    k = n*(i-1) + j;
    A(k,k) = ap(i,j);
    Su(k) = su(i,j);   
end
%
% {
% [L,U] = ilu (A,struct('type','ilutp','droptol',1e-06));
% [t,fl1,rr1,it1,rv1] = bicg(A,Su,tol,maxit,L,U);
% }
%
t = inv(A)*Su;
for i = 1:n
    for j = 1:n
        k = n*(i-1) + j ;
        temp(i,j) = t(k);
    end
end

[X,Y] = meshgrid(x,y);
mesh(X,Y,temp);
view(2);


%Plotting along j correspoing to 6
temp1 = zeros(n,1) ;
% n = 2 
if( del == 2)
    j = 4;
    for i = 1:n
        temp1(i) = (temp(j,i) + temp(j+1,i ))/2;
    end
end
%Plotting along j correspoing to 6
% n = 4
if( del == 4)
    j = 3;
    for i = 1:n
        temp1(i) = temp(j,i) ;
    end
end
hold on
 str = ['delx=',num2str(del)];
plot (y,temp1,'LineWidth',4,'DisplayName',str);
title ("Temperature Profile across length for x = 6")   ;
ylabel("Temperature ");
xlabel("Length");
box  on ;
grid on ;
legend('show');
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');




