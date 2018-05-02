
% sizes = 10:10:100;
sizes = 10:10:50;

my_times = zeros(size(sizes));
Matlab_times = zeros(size(sizes));

s = 0.2;

n_trials = 15;

for t = 1:n_trials
    for i = 1:length(sizes)
        n = sizes(i);
        A = makeSparse(n, s);
        B = makeSparse(n, s);
        A_comp = toCompactCSR(A);
        B_comp = toCompactCSR(B);
        A = full(A);
        B = full(B);
        tic;
        C = A * B;
        % C = toCompactCSR(toFullCompactCSR(A_comp) * toFullCompactCSR(B_comp));
        Matlab_times(i) = Matlab_times(i) + toc;
        tic;
        C_comp = prodCompactCSR(A_comp, B_comp);
        my_times(i) = my_times(i) + toc;
    end
end

Matlab_times = Matlab_times / n_trials;
my_times = my_times / n_trials;

disp(Matlab_times);
disp(my_times);
