converge = 1.0;
initial_guess = 1.0;
a = 2.34886276;
x_0 = initial_guess;
x_1 = x_0;
xdash = 0.0;
while converge > 0.0001
    x_1 = x_0 + a/x_0;
    x_1 = x_1/2.0;
    converge  = abs(x_1-x_0);
    x_0 = x_1;
    x_1
end
converge