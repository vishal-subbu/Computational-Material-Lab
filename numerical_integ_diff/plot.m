semilogx(h,fdash,'ro','linewidth',4.0);
hold on;
semilogx(h,analytic,'linewidth',4.0);
legend('Numerical','Analytical');
xlabel('Step size');
ylabel('Derivative of F')
ax = gca ;
set(ax, 'linewidth',2.0);
axis('square');
grid on;