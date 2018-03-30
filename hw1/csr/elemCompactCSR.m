
% Function elemCompactCSR(C,i,j) returns element at
% position M(i,j), where M is the full matrix associated
% to CSR matrix C.
function x = elemCompactCSR(C, i, j)
    % element is initially zero
    x = 0;
    % get start and end index of row i
    i_start = C.I(i);
    i_end = C.I(i+1) - 1;
    % check that row is not empty
    if i_start <= i_end
        % find column j of row i
        c_j = find(C.J(i_start:i_end) == j);
        % check that row i actually has column j
        if ~isempty(c_j)
            % get element
            A = C.A(i_start:i_end);
            x = A(c_j);
        end
    end
end