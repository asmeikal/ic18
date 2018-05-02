
addpath('../common');
addpath('../../hw1/csr');

n = 50;
mul = 5;

A = randi(mul, n, n) .* full(sprand(n,n,s));
A = A + diag(randi([n,mul*n],n,1));

B = rand(n,1);

threshold = 1.0e-5;

Xtrue = A \ B;

A_CSR = toCompactCSR(A);

[X1, nIt] = jacobi_CSR(A_CSR, B, threshold, @change_error, 0);

disp(X1);
disp(nIt);

[X2, nIt] = gaussSeidel_CSR(A_CSR, B, threshold, @change_error, 0);

disp(X2);
disp(nIt);

[X3, nIt] = jacobi_CSR(A_CSR, B, threshold, @exact_error, Xtrue);

disp(X3);
disp(nIt);

[X4, nIt] = gaussSeidel_CSR(A_CSR, B, threshold, @exact_error, Xtrue);

disp(X4);
disp(nIt);
