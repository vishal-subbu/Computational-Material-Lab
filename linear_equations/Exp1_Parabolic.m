constants = zeros(3,1);

A = zeros(3,3);
B = zeros(3,1);
Z = [50,135,90];
X = [15,60,105];
for i = 1:3
    A(i,1) = X(i)*X(i);
    A(i,2) = X(i);
    A(i,3) = 1.0;
    B(i) = Z(i);
end


Ainv = inv(A);
constants = Ainv*B;
constants


target  = -constants(2) - sqrt((constants(2)*constants(2)) - (4*constants(1)*constants(3)));
target = target/(2*constants(1))

vx = (X(2) - X(1) )/( 10);

time = (target - X(3))/vx