
% Function makeTestMatrix(G, paths) creates a test matrix for graph G given
% a set of monitoring paths. The monitoring paths must be a row vector of
% cells, each cell representing a path.
function testMatrix = makeTestMatrix(G, paths)
    % find number of nodes
    nNodes = size(G.Nodes,1);
    % find number of paths
    nPaths = size(paths,2);
    % create empty matrix
    testMatrix = zeros(nPaths, nNodes, 'logical');
    % loop on paths
    for i = 1:nPaths
        % convert cell to matrix
        path = cell2mat(paths(i));
        % loop on nodes in path
        for j = path
            testMatrix(i,j) = 1;
        end
    end 
end