
function M = toFullCompactCSR(C)
    n = length(C.I)-1;
    M = zeros(n);
    for i = 1:n
        M(i,:) = extractRowCompactCSR(C,i);
    end
end
