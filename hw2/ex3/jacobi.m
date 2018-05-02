
function [X, nIt] = jacobi(A, B, threshold)
    assert(all(all(diag(A) >= A)));
    D = diag(diag(A));
    Dinv = diag(1 ./ diag(A));
    L = tril(A) - D;
    U = triu(A) - D;
    P = Dinv * (-L -U);
    n = size(A,1);
    X = zeros(n,1);
    err = ones(n,1);
    nIt = 0;
    while norm(err,2) > threshold
        preX = X;
        X = P * preX + Dinv * B;
        err = X - preX;
        nIt = nIt + 1;
    end
end