function logistic_2d_cubics

% generate 2-D synthetic data in two classes
x1 = randn(20,2)-.8;
x2 = randn(20,2)+.8;
x = [x1; x2];
y = [zeros(20,1); ones(20,1)];

% call optimizer
options = optimoptions(@fminunc,'Display','iter','Algorithm','quasi-newton');
fun = @(w) neglog_likelihood(w,x,y);
w = fminunc(fun, [0 0 0 0 0 0 0 0 0 0]', options);
w

% plot discriminant
xx = -4:.01:4;
yy = -4:.01:4;
Z = zeros(length(xx),length(yy));
for i = 1:length(xx)
for j = 1:length(yy)
  x1 = xx(i);
  x2 = yy(j);
  Z(j,i) = w(1) + w(2)*x1 + w(3)*x2 + w(4)*x1*x1 + w(5)*x1*x2 + w(6)*x2*x2 ...
         + w(7)*x1*x1*x1 + w(8)*x1*x1*x2 + w(9)*x1*x2*x2 + w(10)*x2*x2*x2;
end
end

clf
h=pcolor(xx,yy,sign(Z));
set(h, 'edgecolor', 'none');
caxis([-5 5]);
hold on
% plot points
plot(x(1:20,1),x(1:20,2),'bo');
plot(x(21:40,1),x(21:40,2),'rx');


function v = neglog_likelihood(w,x,y)
% negative log likelihood of the parameters w given data (x,y)
v = 0;
for i = 1:length(x)
  % compute w'*phi(x)
  % here, w is ten dimensional (up to cubic functions)
  x1 = x(i,1);
  x2 = x(i,2);
  s = w(1) + w(2)*x1 + w(3)*x2 + w(4)*x1*x1 + w(5)*x1*x2 + w(6)*x2*x2 ...
    + w(7)*x1*x1*x1 + w(8)*x1*x1*x2 + w(9)*x1*x2*x2 + w(10)*x2*x2*x2;
  if y(i) == 1
    v = v + log(1+exp(-s));
  else
    v = v + log(1+exp(s));
  end
end


