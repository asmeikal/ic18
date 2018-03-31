
% Function findIdentifiabilityMatrix(testMatrix, maxFailures) computes the
% identifiability matrix given by testMatrix for up to maxFailures
% failures. The identifiability matrix is 1 in position (k,v) iff node v is
% (k-1)-identifiable. 0-identifiable nodes are monitored nodes.
function ID = findIdentifiabilityMatrix(testMatrix, maxFailures)
    % find number of nodes
    nNodes = size(testMatrix,2);
    % initialise identifiability matrix
    % (ID(k,v) == 1) <==> (v is k-1 identifiable)
    ID = zeros(maxFailures+1,nNodes,'logical');
    % 0-identifiable nodes are monitored nodes
    ID(1,:) = arrayfun(@(i) any(testMatrix(:,i)), 1:nNodes);
    % save monitored nodes
    monitoredNodes = find(ID(1,:));
    % cicle up to maxFailures
    for k = 1:maxFailures
        %fprintf("Computing %d identifiability...\n", k);
        % k-identifibility implies (k-1) identifiability
        ID(k+1,:) = ID(k,:);
        % cicle on all nodes
        for v = 1:nNodes
            % skip node if not (k-1)-identifiable
            if ID(k+1,v) == 0
                continue;
            end
            % choices are made on monitored nodes different from current
            nodeChoice = [1:(v-1) (v+1):nNodes];
            nodeChoice = intersect(nodeChoice, monitoredNodes);
            % choose k-1 nodes for F1 (containing v)
            for A = nchoosekOrLess(nodeChoice, k-1)'
                % choose k nodes for F2 (not containing v)
                for B = nchoosekOrLess(nodeChoice, k)'
                    % compute OR of F1 and F2 columns
                    T1 = orReduce(testMatrix,[A' v]);
                    T2 = orReduce(testMatrix,B');
                    % check for equality
                    if all(T1 == T2)
                        % if equal, mark as non-identifiable all nodes
                        % contained only in F1 or F2
                        for v1 = setxor([A' v], B')
                            ID(k+1, v1) = 0;
                        end
                        % break if node is not identifiable
                        break;
                    end
                end
                % break if node is not identifiable
                if ID(k+1,v) == 0
                    break;
                end
            end
        end
        % if current row is all zero, exit
        if ~any(ID(k+1,:))
            %fprintf("No k-identifiable nodes for k >= %d, breaking.\n", k);
            break;
        end
    end
end
