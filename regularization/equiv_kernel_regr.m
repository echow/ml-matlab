function equiv_kernel_regr(s)
% equiv_kernel_regr(s)
%  Regression using a Gaussian kernel function with width s

% generate synthetic data
fun = @(x) x;        % true function
n = 10;              % number of observations
x = (1:n)';
y = x + randn(n,1);

% plot observations
clf
plot(x,y,'o', 'markerfacecolor','b');
hold on

% define kernel function
kfun = @(x,y) exp(-0.5/(s^2)*(x-y)^2);

% loop over test points and plot predictions
for xx = 1:0.1:10
  tot = 0;          % prediction
  coeftot = 0;      % sum of coefficients
  for i = 1:n
    coef = kfun(xx, x(i));
    coeftot = coeftot + coef;
    tot = tot + coef*y(i);
  end
  tot = tot/coeftot;
  plot(xx, tot, 'rx');
end

% print the weights for the given test point at 5.5
xtest = 5.5;
fprintf('Coefficients for the test point %f\n', xtest);
coef = zeros(n,1);
for i = 1:n
  coef(i) = kfun(xtest, x(i));
end
fprintf('%2d   % f\n', [(1:n)' coef/sum(coef)]');

