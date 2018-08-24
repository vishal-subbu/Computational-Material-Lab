

N = 8;
A = zeros(N);
X = zeros(N,1);
B = zeros(N,1);
% Setting up the coefficient matrix 

A(1,1) = 1.0; A(1,3) = -1; A(1,7) = -1;B(1) = 0;
A(2,1) = 1.0; A(2,2) =  1; A(2,4) = -1;B(2) = 0;
A(4,4) = 1.0; A(4,5) = -1; A(4,6) = -1;B(4) = 0;
A(5,8) = 1.0; A(5,6) =  1; A(5,5) =  1;A(5,7) = -1;B(5) = 0;

A(3,1) = -2; A(3,2) = 20; A(3,3) = -50; B(3) = -10;
A(8,2) =-20; A(8,6) =-25;A(8,8) =   1; B(8) = -3;
A(7,3) = 50; A(7,7) =-345/13; A(7,8) =  -1; B(7) =  3;
A(6,5) = -30; A(6,6) = 25;  B(6) = 3;

% A(1,1) = 2 ; A(1,2) = 0;A(1,3) = 17;B(1) = 35;
% A(1,2) = 0;A(2,2) = -3 ;A(2,3) = 9;B(2) = 36;
% A(3,1) = -1;A(3,2) = -1; A(3,3) = 34; B(3) = 34;

A
B

X = inv(A) *B;
X
% Gauss Elimination 
for i = 2:N 
    for j = 1:i-1
         B(i) = B(i) - B(j)*A(i,j)/A(j,j);
        for k = N:-1:j
            A(i,k) = A(i,k) - A(j,k)*A(i,j)/A(j,j);
        end
    end
end

%Back Substitutionclear 
for i = N:-1:1
    sum = 0;
    for j = N:-1:i+1
        sum = sum + A(i,j)*X(j);
    end
    X(i) = (B(i) - sum)/(A(i,i));
end

X

            
            