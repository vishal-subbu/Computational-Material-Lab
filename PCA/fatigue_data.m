mean = zeros(len(2),1);
sum_col = zeros(len(2),1);
% To make the mean zero
for j = 1:len(2)
    sum_col(j) = sum(fatiguedatademo(:,j));
    mean(j) = sum_col(j)/len(1);
end
for j = 1:len(2)
    for i = 1:len(1)
       fatiguedatademo(i,j) = fatiguedatademo(i,j) - mean(j);
    end
end

%% Calculating the principal components
[U,S,V] = svd(fatiguedatademo','econ') ;
error = zeros(26,1);
%% Calculating the error while reconstructing data
for k = 1:26
num_comp  = k ;
 c1 = U(:,1:num_comp)'*fatiguedatademo';
 temp = c1';
 recons = temp(:,1:num_comp)*U(:,1:num_comp)';
 for j = 1:len(2)
    for i = 1:len(1)
       recons(i,j) = recons(i,j) + mean(j);
    end
end
 err = immse(recons,fatiguedatademo);
 error(k) = max(err);
end


%% To plot the maximum error as function of components considered
comp = 1:26;
plot(comp,error,'-ro','linewidth',2.0);
xlabel('Number of Components');
ylabel('Max error in Data')
ax = gca ;
set(ax, 'linewidth',1.5);
xlim([2 10])
axis('square');
grid on;

%% To make scatter plots
scatter(c1(1,:),c1(5,:));
xlabel('PC1');
ylabel('PC5')
ax = gca ;
set(ax, 'linewidth',1.5);
axis('square');
grid on;


%% To make a Pareto plot
s = svd(fatiguedatademo','econ') ;
pareto(s)
xlabel('Components');
ylabel('Frequency')
ax = gca ;
set(ax, 'linewidth',2.0);
grid on;
legend('Frequency','Cumulative Frequency');

