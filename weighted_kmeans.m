function [label, centroid, dis] = weighted_kmeans(X, k, weight)

n = size(X,1);
% option defaults


k = X(randsample(size(X,1),k),:);
% generate initial labeling of points
[~,label] = max(bsxfun(@minus,k*X',0.5*sum(k.^2,2)));
k = size(k,1);
last = 0;
while any(label ~= last)
    
    % remove empty clusters
    %         [tmp,~,label] = unique(label);
    [~,~,label] = unique(label);
    % transform label into indicator matrix
    ind = sparse(label,1:n,weight,k,n,n);
    % compute centroid of each cluster
    centroid = (spdiags(1./sum(ind,2),0,k,k)*ind)*X;
    % compute distance of every point to each centroid
    distances = repmat(weight,1,k)'.*bsxfun(@minus,centroid*X',0.5*sum(centroid.^2,2));
    % assign points to their nearest centroid
    last = label';
    [~,label] = max(distances);
end
dis = ind*(sum(X.^2,2) - 2*max(distances)');
end
