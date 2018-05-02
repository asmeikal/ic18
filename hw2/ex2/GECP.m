
function [T, B, cols] = GECP(A, B)
    [T, B, cols] = GE(A, B, @CompletePivoting);
end

function [T, B, cols] = CompletePivoting(T, B, cols, i)
    n = size(T,1);
    subT = T(i:n,i:n);
    [V,J] = max(abs(subT));
    [~,I] = max(V);
    j = i+J(I(1))-1;
    k = i+I(1)-1;
    T = swapRow(T,i,j);
    B = swapRow(B,i,j);
    T = swapCol(T,i,k);
    cols = swapCol(cols, i, k);
end
