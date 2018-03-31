
% Function nchoosekOrLess(V,k) returns all k-tuples obtainable from V if V
% contains at least k elements, or the only possible tuple if V contains
% less than k elements.
function C = nchoosekOrLess(V,k)
    % check number of elements in V
    if size(V,2) < k
        C = V;
    else
        C = nchoosek(V, k);
    end
end
