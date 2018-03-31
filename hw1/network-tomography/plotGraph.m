
% Function plotGraph(G, paths) plots graph G and all paths in paths. The
% paths parameter must be a vector of cells (of possibly different sizes).
function plotGraph(G, paths)
    % store number of paths
    nPaths = size(paths,2);
    % compute number of columns to make square plot
    nCols = ceil(sqrt(nPaths));
    % compute smallest number of rows to make square plot
    nRows = nCols;
    while ((nRows - 1) * nCols) >= nPaths
        nRows = nRows - 1;
    end
    % loop on all paths
    for i = 1:nPaths
        % select subplot
        subplot(nRows,nCols,i);
        % plot graph
        H = plot(G);
        % wait before plotting
        hold on;
        % get plot data
        XData = H.XData;
        YData = H.YData;
        % get path
        path = cell2mat(paths(i));
        % plot path
        plot(XData(path), YData(path));
        % resume plotting
        hold off;
    end
end