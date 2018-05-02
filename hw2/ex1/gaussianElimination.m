
function [T, B, Movie, S] = gaussianElimination(A, B)
    % checks
    assert(size(A,1) == size(A,2));
    assert(size(A,1) == size(B,1));
    % get matrix size
    n = size(A,1);
    % initialise output
    T = A;
    % initialise movie
    set(gcf,'Visible','off')
    Movie = struct('cdata',[],'colormap',[]);
    % initialise plots
    S = zeros(n,1);
    for i = 1:(n-1)
        if (T(i,i) == 0)
            % find first non-zero element on column i
            k = find(T((i+1):n,i), 1);
            j = i+k;
            % swap row i with row j
            T = swapRow(T,i,j);
            B = swapRow(B,i,j);
        end
        row = T(i,i:n);
        col = T((i+1):n,i);
        mul = col / row(1);
        T((i+1):n,i:n) = T((i+1):n,i:n) - mul * row;
        B((i+1):n,:) = B((i+1):n,:) - mul * B(i,:);
        T((i+1):n,i) = 0;
        spy(T);
        Movie(i) = getframe;
        S(i) = sparsity(T);
    end
    close(gcf);
end
