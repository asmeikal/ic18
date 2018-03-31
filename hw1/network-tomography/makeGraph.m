
% Function makeGraph(nNodes, nEdges) creates a random undirected  graph
% over nNodes vertices and with nEdges edges.
function G = makeGraph(nNodes, nEdges)
    % create graph
    G = graph();
    % add nodes to graph
    G = G.addnode(nNodes);
    % compute all possible edges
    edges = nchoosek(1:nNodes, 2);
    % shuffle edges
    chosen = randperm(size(edges,1));
    % choose first nEdges indexes
    chosen = chosen(1:nEdges);
    % pick nEdges shuffled
    edges = edges(chosen,:);
    % add edges to graph
    G = G.addedge(edges(:,1), edges(:,2));
end
