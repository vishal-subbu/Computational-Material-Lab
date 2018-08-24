%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: Linear_equations
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
N = 3;
ans = zeros(N,1);
b = [17.4,23.6,30.8];
array1 = zeros(N);
L = zeros(N);
U = zeros(N);

array1 = [9,6,12;6,13,11;12,11,26];

for i = 1:N
    L(i,i) = 1;
    U(1,i) = array1(1,i);
end

for i = 2:N
    L(i,1) = array1(i,1)/ U(1,1);
end

U(2,2) = array1(2,2) - L(2,1)*U(1,2);
L(3,2) = (array1(3,2) - L(3,1)*U(1,2) )/(U(2,2));
U(2,3) = array1(2,3) - L(2,1)*U(1,3);
U(3,3) = array1(3,3) - L(3,1)*U(1,3) - L(3,2)*U(2,3);




Linv = inv(L);
Uinv = inv(U);

ans1= Linv*transpose(b);
ans = Uinv*ans1



ans2 = inv(array1) * transpose(b)
