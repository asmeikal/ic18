
function R = extractRowCompactCSR(C,i)
    n = length(C.I) - 1;
    R = zeros(1,n);
    % get row start and end positions
    i_start = C.I(i);
    i_end = C.I(i+1) - 1;
    % test for emptyness
    if i_start <= i_end
        % get values on row i
        A_tmp = C.A(i_start:i_end);
        % get cols of values on row i
        J_tmp = C.J(i_start:i_end);
        % zip together and assign to result
        for x_j = [A_tmp'; J_tmp']
            R(x_j(2)) = x_j(1);
        end
    end
end
