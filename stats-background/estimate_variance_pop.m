% Estimate the variance of a population from a sample

m = 100000000; % population size
xpop = rand(m,1); % generate the population from the Unif[0,1] distribution

% population variance
diff = xpop - mean(xpop); 
fprintf('population variance   %f\n', diff'*diff/m);

% compute average of sample variance for small samples
n  = 10;          % sample size
ns = 5000;        % number of samples
S2 = zeros(ns,1); % array storing the sample variance for each sample
for i = 1:ns
  p = randperm(m,n); % select sample from the population (without replacement)
  x = xpop(p);
  diff = x - mean(x); 
  S2(i) = diff'*diff/n;       % biased estimate
  % S2(i) = diff'*diff/(n-1); % unbiased estimate
end
fprintf('ave sample variance   %f\n', mean(S2));
