
function [T, B, cols] = GE(A, B, Pivot)
    n = size(A,1);
    T = A;
    cols = 1:n;
    for i = 1:(n-1)
        [T, B, cols] = Pivot(T, B, cols, i);
        row = T(i,i:n);
        col = T((i+1):n,i);
        mul = col / row(1);
        T((i+1):n,i:n) = T((i+1):n,i:n) - mul * row;
        B((i+1):n,:) = B((i+1):n,:) - mul * B(i,:);
        T((i+1):n,i) = 0;
    end
end
