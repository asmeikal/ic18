
function s = sparsity(M)
    s = (numel(M) - size(find(M),1)) / numel(M);
end
