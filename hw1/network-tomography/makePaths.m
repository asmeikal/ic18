
% Function makePaths(G, monitoredNodes) creates all possible (shortest)
% paths between nodes in the monitoredNodes list. Paths are returned as an
% array of cells, since paths can have different lengths.
function paths = makePaths(G, monitoredNodes)
    % create all couples of monitored nodes
    monitoredNodes_couples = nchoosek(monitoredNodes,2);
    % store number of paths
    nPaths = size(monitoredNodes_couples,1);
    % create empty array of cells
    paths = arrayfun(@(i) {}, 1:nPaths, 'UniformOutput', false);
    % loop on all couples of monitored nodes
    for i = 1:nPaths
        % get couple
        c = monitoredNodes_couples(i,:);
        % find and store shortest path
        paths(i) = {G.shortestpath(c(1),c(2))};
    end
end
