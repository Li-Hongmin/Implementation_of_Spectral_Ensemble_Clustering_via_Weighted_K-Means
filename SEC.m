function label = SEC(baseCls,k)
    % Input
    % baseCl: base partitions
    % k: the number of clusters
    
    [N,M] = size(baseCls);

    maxCls = max(baseCls);
    for i = 1:numel(maxCls)-1
        maxCls(i+1) = maxCls(i+1)+maxCls(i);
    end

    cntCls = maxCls(end);
    baseCls(:,2:end) = baseCls(:,2:end) + repmat(maxCls(1:end-1),N,1); clear maxCls

    B=sparse(repmat([1:N]',1,M),baseCls(:),1,N,cntCls); clear baseCls
    colB = sum(B);
    B(:,colB==0) = [];
    
    sumb = sum(B);
    wb = B*sumb';
    
    %% kmeans with weight
    opts.weight = wb;
    label = fkmeans(B./wb, k, opts);
    
end
