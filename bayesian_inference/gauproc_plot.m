% Plot a sample function from a Gaussian process

% define covariance matrix using a Gaussian kernel function
x = (0:.01:1)';
n = length(x);
K = zeros(n,n);
s = 0.3; % Gaussian width
for i = 1:n
for j = 1:n
  K(i,j) = exp(-0.5/(s^2) * (x(i)-x(j))^2);
end
end

% plot a sample function
v = mvnrnd(zeros(n,1), K); % GP with zero mean function
plot(x, v, '-o');
