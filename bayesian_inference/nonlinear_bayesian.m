% Sample from a posterior distribution where
% the likelihood function is not Gaussian

% observation (x1, y1) is (1, 0.1)
% noise variance is 0.01 (beta = 100)

beta = 100;
fun = @(w) exp(-0.5*beta*(0.9-1./(w.*w)).^2);  % likelihood function
figure(1)
fplot(fun, [0.85,1.3]);
grid on
shg
% notice the likelihood is not Gaussian
% (cannot complete the square to make it Gaussian)

% sampling method for the posterior (expensive)
max_trials = 100000000;
num_found = 0;
array = zeros(max_trials,1);
for i = 1:max_trials
  % draw w from Gaussian prior centered at 1 and variance 0.001
  w = randn*sqrt(0.001)+1;
  x = 1;
  y = x - x*x/(w*w) + sqrt(1/beta)*randn;
  if abs(y-0.1) < 1e-3
    num_found = num_found + 1;
    array(num_found) = w;
  end
end

array = array(1:num_found);
length(array) % number of samples found
figure(2)
hist(array,100)
grid on
xlim([0.85 1.3]);
% We do not expect this posterior to be Gaussian.
% Note that the posterior estimate of w is closer to 1 than
% the MLE (maximum likelihood) since prior is centered at 1.
