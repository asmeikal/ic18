
% Function maxIdentifiable(testMatrix) computes the max k for which exists
% an identifiable node.
function k = maxIdentifiable(testMatrix)
    % store number of nodes
    nNodes = size(testMatrix,2);
    % compute identifiability matrix up to nNodes - 1
    ID = findIdentifiabilityMatrix(testMatrix, nNodes-1);
    % find last non-zero row in identifiability matrix (and subtract one
    % since row k tells us which nodes are (k-1)-identifiable)
    k = find(arrayfun(@(i) any(ID(i,:)), 1:nNodes), 1, 'last') - 1;
end