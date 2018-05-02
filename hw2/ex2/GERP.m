
function [T, B, cols] = GERP(A, B)
    [T, B, cols] = GE(A, B, @RookPivoting);
end

function [T, B, cols] = RookPivoting(T, B, cols, i)
    n = size(T,1);
    % j is row, k is column
    j = i;
    [~,K] = max(abs(T(j,i:n)));
    k = i+K(1)-1;
    while 1
        if all(abs(T(j,k)) >= abs(T(i:n,k)))
            break
        end
        [~,J] = max(abs(T(i:n,k)));
        j = i+J(1)-1;
        if all(abs(T(j,k)) >= abs(T(j,i:n)))
            break
        end
        [~,K] = max(abs(T(j,i:n)));
        k = i+K(1)-1;
    end
    T = swapRow(T,i,j);
    B = swapRow(B,i,j);
    T = swapCol(T,i,k);
    cols = swapCol(cols, i, k);
end
