
nNodes = 10;
nEdges = 20;
nMonitors = 4;

fprintf("%d vertices, %d edges.\n", nNodes, nEdges);

G = makeGraph(nNodes,nEdges);

monitoredNodes = randperm(nNodes);
monitoredNodes = monitoredNodes(1:nMonitors);

paths = makePaths(G, monitoredNodes);

nPaths = size(paths,2);
fprintf("%d paths.\n", nPaths);

for path = paths
    disp(cell2mat(path));
end

testMatrix = makeTestMatrix(G, paths);

fprintf("Test matrix:\n");
disp(testMatrix);

identifiability = findIdentifiabilityMatrix(testMatrix, nNodes - 1);

fprintf("Identifiability matrix:\n");
disp(identifiability);

maxID = maxIdentifiable(testMatrix);

fprintf("Max identifiable: %d.\n", maxID);

for k = 1:maxID
    ID = findIdentifiable(testMatrix,k);
    fprintf("%d-identifiables:\n", k);
    disp(ID);
end

plotGraph(G, paths);
