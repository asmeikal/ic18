
function R = extractColCompactCSR(C,j)
    n = length(C.I) - 1;
    R = zeros(n,1);
    % find position of elements on col j
    J_tmp = find(C.J == j);
    % test for emptyness
    if ~isempty(J_tmp)
        % find values on col j
        A_tmp = arrayfun(@(j) C.A(j), J_tmp);
        % find row indeces of elements on col j
        I_tmp = arrayfun(@(j) find(C.I <= j, 1, 'last'), J_tmp);
        % zip together and assign to result
        for x_i = [A_tmp'; I_tmp']
           R(x_i(2)) = x_i(1); 
        end
    end
end
