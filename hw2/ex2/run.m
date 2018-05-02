
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

[T2, B2, cols2] = GEPP(A, B);
X2_tmp = solve(T2,B2);
X2(cols2) = X2_tmp;
X2 = X2';
disp(all((X - X2) < threshold));

[T3, B3, cols3] = GECP(A, B);
X3_tmp = solve(T3,B3);
X3(cols3) = X3_tmp;
X3 = X3';
disp(all((X - X3) < threshold));

[T4, B4, cols4] = GERP(A, B);
X4_tmp = solve(T4,B4);
X4(cols4) = X4_tmp;
X4 = X4';
disp(all((X - X4) < threshold));
