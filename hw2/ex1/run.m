
addpath('../common');

n = 10;
s = 0.6;
threshold = 1.0e-9;

A = full(sprand(n,n,s));

while det(A) == 0
    A = full(sprand(n,n,s));
end

B = rand(n,1);

X = A \ B;

[T1, B1, Movie, S] = gaussianElimination(A, B);

X1 = solve(T1,B1);

disp(all((X - X1) < threshold));

movie(Movie);
