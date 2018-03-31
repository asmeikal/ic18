nNodes = 40;
nEdges = 80;
nMonitors = 6;

G = makeGraph(nNodes,nEdges);

monitors = randperm(nNodes);
monitors = monitors(1:nMonitors);

monitor_couples = nchoosek(monitors,2);
nPaths = size(monitor_couples,1);

fprintf("%d paths.\n", nPaths);

testMatrix = zeros(nPaths, nNodes);

paths = [];

for i = 1:nPaths
    c = monitor_couples(i,:);
    path = G.shortestpath(c(1),c(2));
    paths = [paths {path}];
    for j = path
        testMatrix(i,j) = 1;
    end
end

% for path = paths
%     disp(cell2mat(path));
% end
% disp(testMatrix);

% i=1;
% 
% for path = paths
%     subplot(4,3,i);
%     H = plot(G);
%     hold on;
% 
%     XData = H.XData;
%     YData = H.YData;
% 
%     path_mat = cell2mat(path);
%     plot(XData(path_mat), YData(path_mat));
% 
%     hold off;
%     i = i + 1;
% end

identifiability = zeros(nNodes,nNodes);

identifiability(1,:) = arrayfun(@(i) any(testMatrix(:,i)), 1:nNodes);

nonZero = find(identifiability(1,:));

for k = 1:(nNodes - 1)
    fprintf("Computing %d identifiability...\n", k);
    identifiability(k+1,:) = identifiability(k,:);
    for v = 1:nNodes
        if identifiability(k+1,v) == 0
            continue;
        end
        A_choice = [1:(v-1) (v+1):nNodes];
        A_choice = intersect(A_choice, nonZero);
        B_choice = (v+1):nNodes;
        B_choice = intersect(B_choice, nonZero);
        for A = nchoosekSafe(A_choice, k-1)'
            for B = nchoosekSafe(B_choice, k)'
                T1 = orReduce(testMatrix,[A' v]);
                T2 = orReduce(testMatrix,B');
                if all(T1 == T2)
                    for v1 = setxor([A; v], B)
                        identifiability(k+1, v1) = 0;
                    end
                end
            end
        end
    end
    if ~any(identifiability(k+1,:))
        fprintf("No %d-identifiable nodes, breaking.\n", k);
        break;
    end
end

% disp(identifiability);

function G = makeGraph(nNodes, nEdges)
    G = graph();
    G = G.addnode(nNodes);
    edges = nchoosek(1:nNodes, 2);
    chosen = randperm(size(edges,1));
    chosen = chosen(1:nEdges);
    edges = edges(chosen,:);
    G = G.addedge(edges(:,1), edges(:,2));
end

function R = orReduce(M,C)
    R = zeros(size(M,1),1);
    if size(C,1) > 0
        for c = C
            R = R | M(:,c);
        end
    end
end

function C = nchoosekSafe(V,k)
    if size(V,2) == 1
        C = V;
    elseif size(V,2) < k
        C = V;
    else
        C = nchoosek(V, k);
    end
end
