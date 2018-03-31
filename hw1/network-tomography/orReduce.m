
% Function orReduce(M,C) computes the OR between the columns of M indexed
% by vector C.
function R = orReduce(M,C)
    % initialise answer as all 0s
    R = zeros(size(M,1),1);
    % check that at least an index is provided
    if size(C,1) > 0
        % compute OR of all columns
        for c = C
            R = R | M(:,c);
        end
    end
end