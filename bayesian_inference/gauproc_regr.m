% Gaussian process regression

% generate synthetic data
fun = @(x) sin(2*pi*x); % true function
sigma2 = 0; % noise variance
% sigma2 = 0.1;
x = rand(4,1);
y = fun(x) + sqrt(sigma2)*randn(size(x));

% form covariance matrix
n = length(x);
K = zeros(n,n);
s = 0.1;
for i = 1:n
for j = 1:n
  K(i,j) = exp(-0.5/(s^2) * (x(i)-x(j))^2);
end
end
C = K + sigma2*eye(n);

% calculate predictions
xx = 0:0.01:1;
yy = [];
vari = [];
for xval = xx;
  kvec = exp(-0.5/(s^2) * (x-xval).^2);
  yval = kvec'*(C\y);
  yy = [yy yval];
  vari = [vari (1-kvec'*(C\kvec))];
end

% plot results
clf
plot(xx,fun(xx),'--');   % true function
hold on
plot(x,y,'ko');          % data points
plot(xx,yy);             % mean function
lo = yy-sqrt(vari);
hi = yy+sqrt(vari);
h = patch([xx xx(end:-1:1) xx(1)], [lo hi(end:-1:1) lo(1)], 'b');
set(h, 'EdgeAlpha',0, 'FaceColor',[.8 .7 .6], 'FaceAlpha',.3)
