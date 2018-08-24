%
% Copyright (c) 2018, Vishal_S
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Title: PCA
% 
% Developer: Vishal S
% 
% Contact Info: vishalsubbu97@gmail.com
%
len = length(VarName1);

mean1 = sum(VarName1)/len;
mean2 = sum(VarName2)/len;
mean3 = sum(VarName3)/len;
mean4 = sum(VarName4)/len;
mean = [mean1 mean2 mean3 mean4];
for i = 1:len
    VarName1(i) = VarName1(i) - mean1;
    VarName2(i) = VarName2(i) - mean2;
    VarName3(i) = VarName3(i) - mean3;
    VarName4(i) = VarName4(i) - mean4;
end


matrix = zeros(len,4);

for i = 1:len
    matrix(i,1) = VarName1(i);
    matrix(i,2) = VarName2(i);
    matrix(i,3) = VarName3(i);
    matrix(i,4) = VarName4(i);
end

[U,S,V] = svd(matrix','econ') 
num_comp  = 3 ;
 c1 = U(:,1:num_comp)'*matrix';
 scatter(c1(1,:),c1(2,:));
 temp = c1';
 recons = temp(:,1:num_comp)*U(:,1:num_comp)';
 recons = bsxfun(@plus,recons,mean);
 err = immse(recons,matrix);
 max(err)
