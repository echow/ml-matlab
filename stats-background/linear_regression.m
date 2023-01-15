% MATLAB Warmup: linear regression

x = [1.0 2.0 3.0]';
y = [5.1 6.2 7.1]';

n = length(x);
X = [ones(n,1) x];

% solve the linear least squares problem
w = X \ y;
% w = inv(X'*X)*X'*y % an explicit formula (not recommended)

% plot the data and the linear regression line
clf
plot(x,y,'o');
hold on
fun = @(x) w(1)+w(2)*x;
fplot(fun, [0 4]);
