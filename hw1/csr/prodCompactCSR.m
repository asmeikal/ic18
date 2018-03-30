
function C = prodCompactCSR(A,B)
    n = length(A.I)-1;
    % allocate empty matrices
    % TODO: find size of C.A, C.J beforehand (how??)
    C_A = [];
    C_I = zeros(1,n+1);
    C_J = [];
    % start index for row i in result matrix
    count_I = 1;
    for i = 1:n
        % set start index for row i in result matrix
        C_I(i) = count_I;
        for j = 1:n
            % get cols on row i for matrix A
            A_rows_i = A.I(i):A.I(i+1)-1;
            A_cols_i = A.J(A_rows_i);
            % get rows on col j for matrix B
            B_cols_j = find(B.J == j);
            B_rows_j = arrayfun(@(j) find(B.I <= j, 1, 'last'), B_cols_j);
            % find common non-zero elements on A(i,:) and B(:,j)
            [IJ, IA, JB] = intersect(A_cols_i, B_rows_j);
            % check for non-emptyness
            if ~isempty(IJ)
                A_vals_i = A.A(A_rows_i);
                B_vals_j = B.A(B_cols_j);
                % compute value C(i,j) in result matrix
                r = dot(A_vals_i(IA), B_vals_j(JB));
                % store col index, value in result matrix
                C_A = [C_A; r];
                C_J = [C_J; j];
                % increase counter for row of result matrix
                count_I = count_I + 1;
            end
        end
    end
    % set last row index in result matrix
    C_I(n+1) = length(C_J) + 1;
    % create result matrix
    C = struct('A', C_A, 'I', C_I, 'J', C_J);
end
