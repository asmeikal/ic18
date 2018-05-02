
function err = exact_error(X, preX, param)
    err = norm(param - X, 2);
end
