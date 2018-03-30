
function M = makeSparse(n, s)
    M = zeros(n);
    for i = 1:n
        for j = 1:n
            if rand(1) <= s
                M(i,j) = randi(100);
            end
        end
    end
end
