
% Function toCompactCSR(M) converts matrix M to the 
% Compressed Sparse Row format.
function C = toCompactCSR(M)
    % transpose matrix, and find non-zero elements
    % A is (row-wise) list of non-zero elements
    % J associates element A(i) with its col. J(i)
    % II associates element A(i) with its row II(i)
    [J, II, A] = find(M');
    % get number of rows
    M_size = size(M);
    n = M_size(1);
    % count number of elements in each row
    I2 = arrayfun(@(i) nnz(II == i), 1:n);
    % array I tells us where does each row start
    % row i starts at 1 + sum_{j = 1}^{i-1} I2[j]
    % we also have a "pointer" to the row after the last
    I  = arrayfun(@(i) 1 + sum(I2(1:i-1)), 1:(n+1));
    % compose everything in a struct
    C = struct('A', A, 'J', J, 'I', I);
end
