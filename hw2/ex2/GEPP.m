
function [T, B, cols] = GEPP(A, B)
    [T, B, cols] = GE(A, B, @PartialPivoting);
end

function [T, B, cols] = PartialPivoting(T, B, cols, i)
    n = size(T,1);
    col = T(i:n,i);
    [~,I] = max(abs(col));
    j = i+I(1)-1;
    T = swapRow(T,i,j);
    B = swapRow(B,i,j);
end
