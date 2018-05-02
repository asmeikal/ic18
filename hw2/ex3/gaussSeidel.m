
function [X, nIt] = gaussSeidel(A, B, threshold)
    assert(all(all(diag(A) >= A)));
    n = size(A,1);
    X = zeros(n,1);
    nIt = 0;
    err = ones(n,1);
    while norm(err,2) > threshold
        preX = X;
        X(1) = (B(1) - A(1,2:n) * preX(2:n)) / A(1,1);
        if n > 2
            for i = 2:(n-1)
               X(i) = (B(i) - A(i,1:(i-1)) * X(1:(i-1)) - A(i,(i+1):n) * preX((i+1):n)) / A(i,i);               
            end
        end
        X(n) = (B(n) - A(n,1:(n-1)) * X(1:(n-1))) / A(n,n);
        nIt = nIt + 1;
        err = X - preX;
    end
end