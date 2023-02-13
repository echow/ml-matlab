function predictive_dist
% Bayesian regression with 9 Gaussian basis functions
% and thus we need the posterior distribution for 9 weights

% generate synthetic data
fun = @(x) sin(2*pi*x); % true function
beta = 1/0.02; % inverse noise variance
x = [0.3 0.6]'; % choose the locations of the data points
%x = [0 0.3 0.6 1]'; % choose the locations of the data points
%x = rand(25,1);
y = fun(x) + sqrt(1/beta)*randn(size(x));
n = length(y);

% prior distribution:  N(0, (1/alpha) I)
alpha = 1;

% Phi matrix has 9 columns (one for each basis function or weight)
%  and n rows (one for each data point)
Phi = [];
for i = 1:n
  Phi = [Phi; phifunc_t(x(i))];
end

% posterior distribution for weights w
Sn = inv(alpha*eye(9) + beta*Phi'*Phi); % n-by-n covariance matrix
mn = beta*Sn*Phi'*y;                    % mean

% plot predictive distribution
xx = 0:0.01:1;
yy = [];
vari = [];
for xval = xx;
  yval = phifunc_t(xval)*mn;
  yy = [yy yval];
  % calculate the variance at each x value
  vari = [vari (1/beta + phifunc_t(xval)*Sn*phifunc_t(xval)')];
end
clf
plot(xx,fun(xx),'--');
hold on
plot(xx,yy);
plot(x,y,'ko');
lo = yy-sqrt(vari);
hi = yy+sqrt(vari);
h = patch([xx xx(end:-1:1) xx(1)], [lo hi(end:-1:1) lo(1)], 'b');
set(h, 'EdgeAlpha',0, 'FaceColor',[.8 .7 .6], 'FaceAlpha',.3)

% plot a few examples of functions from the predictive distribution
chol_Sn = chol(Sn, 'lower');
centers = [0:1/8:1]; % centers of 9 Gaussian basis functions
s = 0.1;              % Gaussian "standard deviation" or width
for example = 1:5
  w = mn + chol_Sn*randn(9,1)
  ff = zeros(size(xx));
  for k = 1:9
    ff = ff + w(k)*exp(-0.5/(s*s)*(xx-centers(k)).^2);
  end
  plot(xx,ff,'k-');
end

function phi_t = phifunc_t(x)
% row vector of basis functions evaluated at a scalar x
centers = [0:1/8:1]; % centers of 9 Gaussian basis functions
s = 0.1;              % Gaussian "standard deviation" or width
phi_t = exp(-0.5/(s*s)*(x-centers).^2);

