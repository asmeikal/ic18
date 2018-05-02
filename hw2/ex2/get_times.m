
addpath('../common');

sizes = 50:10:150;

s = 0.6;
threshold = 1.0e-9;

n_trials=30;

times_GECP = zeros(1, size(sizes,1));
times_GEPP = zeros(1, size(sizes,1));
times_GERP = zeros(1, size(sizes,1));

for n = sizes
    times_trial_GECP = zeros(1,n_trials);
    times_trial_GEPP = zeros(1,n_trials);
    times_trial_GERP = zeros(1,n_trials);

    for i = 1:n_trials
        A = full(sprand(n,n,s));

        while det(A) == 0
            A = full(sprand(n,n,s));
        end

        B = rand(n,1);

        tic;
        GEPP(A, B);
        times_trial_GEPP(i) = toc;

        tic;
        GECP(A, B);
        times_trial_GECP(i) = toc;

        tic;
        GERP(A, B);
        times_trial_GERP(i) = toc;
    end
    
    idx = find(sizes == n, 1, 'first');
    times_GEPP(idx) = mean(times_trial_GEPP);
    times_GERP(idx) = mean(times_trial_GERP);
    times_GECP(idx) = mean(times_trial_GECP);
end

plot(sizes, times_GEPP, sizes, times_GECP, sizes, times_GERP);
legend('GEPP','GECP','GERP');
