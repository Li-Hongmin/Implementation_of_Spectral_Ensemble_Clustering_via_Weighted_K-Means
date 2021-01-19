
% X = rand(n);
[X,y] = iris_dataset;
[~,ind]=max(y);
n = size(X,2);
k = 3;
% w = ones(n,1);
m = 100;
baseCls = zeros(n,m);
for i = 1:m
    baseCls(:,i) = kmeans(X',randi([k,2*k]));
end

label = SEC(baseCls,k);


