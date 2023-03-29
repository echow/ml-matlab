function demo_logistic

% generate synthetic data in two classes
n = 10; % number of observations in each class
x1 = sqrt(1.5)*randn(n,1) - 2;
x2 = sqrt(1.5)*randn(n,1) + 2;
x = [x1; x2];
y = [zeros(n,1); ones(n,1)];
[x ind] = sort(x);
y = y(ind);
clf
plot(x,y,'o');
hold on

% call optimizer
fun = @(w) neglog_likelihood(w,x,y);
w = fminunc(fun, [0 1]');
w

xx = -5:.01:5;
ss = w(1)+w(2)*xx;
yy = 1./(1+exp(-ss));
plot(xx,yy);


function v = neglog_likelihood(w,x,y)
% negative log likelihood of the parameters w given data (x,y)
v = 0;
for i = 1:length(x)
  if y(i) == 1
    v = v + log(1+exp(-w(1)-w(2)*x(i)));
  else
    v = v + log(1+exp(+w(1)+w(2)*x(i)));
  end
end


