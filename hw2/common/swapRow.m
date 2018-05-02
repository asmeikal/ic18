
function M = swapRow(M, i, j)
    tmp = M(i,:);
    M(i,:) = M(j,:);
    M(j,:) = tmp;
end
