% polynomial ridge regression

% generate synthetic data
fun = @(x) sin(2*pi*x); % true function
sigma2 = 0.1;           % noise variance
n = 10;                 % number of observations
delta = 1/(n+1);        % spacing between observations
x = (delta:delta:1-delta)';
y = fun(x) + sqrt(sigma2)*randn(size(x));

% least squares matrix
X = [ones(n,1) x x.^2 x.^3 x.^4 x.^5 x.^6 x.^7 x.^8 x.^9];
deg = 9;  % polynomial degree

% loop over different values of the regularization parameter
for ind = 16:-1:1
  lambda = 10^(-ind)  % regularization parameter

  % solve regularized least squares problem
  w = [X; sqrt(lambda)*eye(deg+1)] \ [y; zeros(deg+1,1)]

  % calculate polynomial at values of xx
  xx = (0:.01:1)';
  yy = w(1)*ones(size(xx));
  for k = 1:deg
    yy = yy + w(k+1)*(xx.^k);
  end

  % plot the true function and the polynomial
  clf
  plot(xx,fun(xx),'b--', x,y,'bo', xx,yy,'r-');
  axis([0 1 -1.5 1.5]);
  pause
end
