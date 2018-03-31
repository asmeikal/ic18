
% Function findIdentifiable(testMatrix, k) returns the list of all
% k-identifiable nodes.
function V = findIdentifiable(testMatrix, k)
    % compute identifiability matrix for given k
    ID = findIdentifiabilityMatrix(testMatrix, k);
    % k-identifiable nodes have 1 on the k+1 row
    V = find(ID(k+1,:));
end