function demo_sgd

% generate synthetic data
global x y
n = 10;
x = (0:1/(n-1):1)';
y = x+1;
% y = x+1 + 0.1*randn(size(x)); % noisy case

% plot contours of the error function
clf
fcontour(@E, [-2 4 -2 4],'LevelList',[0:1:30],'MeshDensity',200);
hold on

% number of epochs
nepochs = 10;

% initial guess with expected value (1,1) which is the solution,
% since y = w1*x + w0, but with a large variance
w0_init = 6*rand-2;
w1_init = 6*rand-2;
plot(w0_init, w1_init, 'o', 'markerfacecolor', 'k');

% gradient descent
w0 = w0_init;
w1 = w1_init;
eta = 0.06;
for k = 1:nepochs
  dw0 = sum(2*(w0+w1*x-y));
  dw1 = sum(2*(w0+w1*x-y).*x);
  plot([w0 w0 - eta*dw0],[w1 w1 - eta*dw1],'k-o');
  w0 = w0 - eta*dw0;
  w1 = w1 - eta*dw1;
end
fprintf(' GD final error: %e\n', E(w0,w1));

% stochastic gradient descent (will this be faster?)
w0 = w0_init;
w1 = w1_init;
eta = 0.06*n;
for k = 1:nepochs
  p = randperm(length(x));
  for j = 1:length(x)
    dw0 = sum(2*(w0+w1*x(p(j))-y(p(j))));
    dw1 = sum(2*(w0+w1*x(p(j))-y(p(j))).*x(p(j)));
    plot([w0 w0 - eta*dw0],[w1 w1 - eta*dw1],'r-o');
    w0 = w0 - eta*dw0;
    w1 = w1 - eta*dw1;
  end
  % eta = eta/1.5;
end
fprintf('SGD final error: %e\n', E(w0,w1));
% did not have to reduce eta in this example if no noise

% error function
function val = E(w0,w1)
global x y
val = 0;
for i = 1:length(x)
  val = val + (w0+w1*x(i)-y(i)).^2;
end
