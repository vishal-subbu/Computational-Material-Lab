clear all
clf
clc
no_of_nuclei = 100;
n = 100;
% x_center = randi([5,Nx-5],no_of_nuclei);
% y_center = randi([5,Ny-5],no_of_nuclei);

x = gallery('uniformdata',[no_of_nuclei 2],5);
[v,c] = voronoin(x); 
seeds = gallery('uniformdata',[no_of_nuclei 2],0);


DT = delaunayTriangulation(seeds);

[v,c] = voronoiDiagram(DT);
for i = 1:length(c) 
if all(c{i}~=1)   % If at least one of the indices is 1, 
                  % then it is an open region and we can't 
                  % patch that.
patch(v(c{i},1),v(c{i},2),i); % use color i.
end
end
xlim ([0 1])
ylim ([0 1])

grain_old = zeros(100,100);
x = 0:0.01:0.99;
y = 0:0.01:0.99;
[X,Y] = meshgrid(x,y);
for k = 1:length(c)
    if all(c{k}~=1)   % If at least one of the indices is 1,
        % then it is an open region and we can't
        % patch that.
        [in,on] = inpolygon(X,Y,v(c{k},1),v(c{k},2));
        for i = 1:100
            for j = 1:100
                if(in(i,j))
                    grain_old(i,j) = k;
                end
            end
        end
    end
end
imwrite(grain_old,'voronoi.png');

