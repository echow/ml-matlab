% Estimate the variance of a Gaussian distribution from a sample

vari = 2; % variance of the distribution
fprintf('distribution variance %f\n', vari);

% compute average of sample variance for small samples
n  = 10;          % sample size
ns = 5000;        % number of samples
S2 = zeros(ns,1); % array storing the sample variance for each sample
for i = 1:ns
  x = randn(n,1)*sqrt(vari);
  diff = x - mean(x); 
  S2(i) = diff'*diff/n;       % biased estimate
  % S2(i) = diff'*diff/(n-1); % unbiased estimate
end
fprintf('ave sample variance   %f\n', mean(S2));
