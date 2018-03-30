nNodes = 10;
nEdges = 20;
nMonitors = 5;

G = makeGraph(nNodes,nEdges);

plot(G);

monitors = randperm(nNodes);
monitors = monitors(1:nMonitors);

monitor_couples = nchoosek(monitors,2);
nPaths = size(monitor_couples,1);

testMatrix = zeros(nNodes, nPaths);

paths = [];

for i = 1:nPaths
    c = monitor_couples(i,:);
    path = G.shortestpath(c(1),c(2));
    paths = [paths {path}];
    for j = path
        testMatrix(i,j) = 1;
    end
end

for path = paths
    disp(cell2mat(path));
end
disp(testMatrix);

function G = makeGraph(nNodes, nEdges)
    G = graph();
    G.addnode(nNodes);
    edges = nchoosek(1:nNodes, 2);
    chosen = randperm(size(edges,1));
    chosen = chosen(1:nEdges);
    edges = edges(chosen,:);
    G = G.addedge(edges(:,1), edges(:,2));
end