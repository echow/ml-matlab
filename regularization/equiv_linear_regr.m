function equiv_linear_regr(xtest)
% equiv_linear_regr(xx)
%  Linear regression using the equivalent kernel
%  Also print the weights for the test point xtest.

% generate synthetic data
fun = @(x) x;        % true function
n = 10;              % number of observations
x = (1:n)';
y = x + randn(n,1);

% plot observations
clf
plot(x,y,'o', 'markerfacecolor','b');
hold on

% define Phi and S matrices
Phi = [ones(n,1) x];
S = inv(Phi'*Phi);

% print the weights for the given test point
fprintf('Coefficients for the test point %f\n', xtest);
for i = 1:n
  coef = [1; xtest]' * S * [1; x(i)];
  fprintf('%2d   % f\n', i, coef);
end

% loop over many test points and plot predictions
for xx = 1:0.1:10
  tot = 0;          % prediction
  for i = 1:n
    coef = [1; xx]' * S * [1; x(i)];
    tot = tot + coef*y(i);
  end
  plot(xx, tot, 'rx');
end

