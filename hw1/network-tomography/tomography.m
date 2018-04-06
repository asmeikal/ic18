
% build graph

nNodes = 20;
nEdges = 40;
nMonitors = 6;

fprintf("%d vertices, %d edges.\n", nNodes, nEdges);

G = makeGraph(nNodes,nEdges);

% choose monitored nodes

monitoredNodes = randperm(nNodes);
monitoredNodes = monitoredNodes(1:nMonitors);

% build and show paths

paths = makePaths(G, monitoredNodes);

nPaths = size(paths,2);
fprintf("%d paths.\n", nPaths);

for path = paths
    disp(cell2mat(path));
end

% build and print test matrix

testMatrix = makeTestMatrix(G, paths);

fprintf("Test matrix:\n");
disp(testMatrix);

% build and print identifiability matrix

ID = buildIdentifiabilityMatrix(testMatrix, nNodes - 1);

fprintf("Identifiability matrix:\n");
disp(ID);

% compute max identifiable

maxID = maxIdentifiable(testMatrix, ID);

fprintf("Max identifiable: %d.\n", maxID);

% show all k-identifiable nodes for k <= max identifiable

for k = 1:maxID
    V = findIdentifiable(testMatrix,k,ID);
    fprintf("%d-identifiables:\n", k);
    disp(V);
end

% plot graph

plotGraph(G, paths);
