
function [X, nIt] = jacobi_CSR(A_CSR, B, threshold, compute_error, param)
    n = size(A_CSR.I,2) - 1;
    X = zeros(n,1);
    nIt = 0;
    err = norm(ones(n,1), 2);
    while err > threshold
        preX = X;
        row_start = A_CSR.I(1);
        row_end = A_CSR.I(2) - 1;
        diag_pos = row_start + find(A_CSR.J(row_start:row_end) == 1, 1, 'first') - 1;
        if diag_pos < row_end
            C = dot(A_CSR.A((diag_pos+1):row_end), preX(A_CSR.J((diag_pos+1):row_end)));
        else
            C = 0;
        end
        X(1) = (B(1) - C) / A_CSR.A(diag_pos);
        if n > 2
            for i = 2:(n-1)
                row_start = A_CSR.I(i);
                row_end = A_CSR.I(i+1) - 1;
                diag_pos = row_start + find(A_CSR.J(row_start:row_end) == i, 1, 'first') - 1;
                if diag_pos < row_end
                    C = dot(A_CSR.A((diag_pos+1):row_end), preX(A_CSR.J((diag_pos+1):row_end)));
                else
                    C = 0;
                end
                if diag_pos > row_start
                    D = dot(A_CSR.A(row_start:(diag_pos-1)), preX(A_CSR.J(row_start:(diag_pos-1))));
                else
                    D = 0;
                end
                X(i) = (B(i) - C - D) / A_CSR.A(diag_pos);
            end
        end
        row_start = A_CSR.I(n);
        row_end = A_CSR.I(n+1) - 1;
        diag_pos = row_start + find(A_CSR.J(row_start:row_end) == n, 1, 'first') - 1;
        if diag_pos > row_start
            D = dot(A_CSR.A(row_start:(diag_pos-1)), preX(A_CSR.J(row_start:(diag_pos-1))));
        else
            D = 0;
        end
        X(n) = (B(n) - D) / A_CSR.A(diag_pos);
        nIt = nIt + 1;
        err = compute_error(X, preX, param);
    end
end