% Illustration of the Student's t-distribution

vari = 2; % variance of the Gaussian distribution for the samples

n  = 10;             % sample size
ns = 500000;         % number of samples
means = zeros(ns,1); % array storing the mean for each sample
for i = 1:ns
  x = randn(n,1)*sqrt(vari);
  S2 = var(x,0);     % unbiased estimate of standard
  means(i) = mean(x)/sqrt(S2/n); % studentize the mean
end

% compute standardized histogram
% (so it can be compared with a standard Gaussian and t-distribution)
binwidth = 0.10;       % bin width
c = -2.5:binwidth:2.5; % bin centers
f = hist(means,c)/ns/binwidth; % standardize the frequencies

% plot histogram
clf
plot(c,f,'o')
hold on

% plot t-distribution
y = tpdf(c,n-1);
plot(c,y,'b-')

% plot standard Gaussian
y = normpdf(c,0,1); % parameters: mean 0, standard deviation 1
plot(c,y,'k:')

legend('histogram','t-distribution','Gaussian dist.')
