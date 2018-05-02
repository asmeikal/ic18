
function X = solve(A, B)
    assert(all(all(0 == (tril(A) - diag(diag(A))))));
    assert(all(0 ~= diag(A)));
    n = size(A,1);
    X = zeros(n,1);
    for j = 1:n
        i = n - j + 1;
        X(i) = (B(i) - A(i,(i+1):n) * X((i+1):n)) / A(i,i);
    end
end
