
function M = swapCol(M, i, j)
    tmp = M(:,i);
    M(:,i) = M(:,j);
    M(:,j) = tmp;
end
