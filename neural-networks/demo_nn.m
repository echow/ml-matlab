function neuralnets

rng(0);

% 2D problem (2 inputs to network) and 1 output
% generate n points in 2D
n = 15;
x = rand(2,n);

% generate +1/-1 labels separated by a discriminant function
w = [.3 .5 -1]';
y = zeros(1,n);
for i = 1:n
  y(i) = sign(w'*[1; x(1,i); x(2,i)]);
end

% specify a neural network and set initial guess for weights

% h(x) = actfun(b2 + W2' * actfun(b1 + W1' x));

L = 2; % number of layers
W = cell(L,1);
W{1} = rand(2,2)-.5;
W{2} = rand(2,1)-.5;
b = cell(L,1);
b{1} = rand(2,1)-.5;
b{2} = rand(1,1)-.5;

% now train the network with above data
[W b] = gradient_descent(x, y, W, b);

% plot training points
for i = 1:size(x,2)
  if y(i) > 0
    plot(x(1,i), x(2,i), 'bo'); hold on
  else
    plot(x(1,i), x(2,i), 'kx'); hold on
  end
end

% predict and plot labels for random test points
for i = 1:100
  x = rand(2,1);
  h = neuralnet_predict(x, W, b);
  if h > 0
    plot(x(1), x(2), 'co'); hold on
  else
    plot(x(1), x(2), 'mx'); hold on
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [W b] = gradient_descent(x, y, W, b)
%

% print initial objective value
v = neuralnet_lossfun(x, y, W, b);
fprintf('%6d   %f\n', 0, v);

eta = 0.1;
for i = 1:10000
  [dW db] = neuralnet_gradient(x, y, W, b);
  for l = 1:length(W)
    % W = W - eta*dW;
    % b = b - eta*db;
    W{l} = W{l} - eta*dW{l};
    b{l} = b{l} - eta*db{l};
  end
  v = neuralnet_lossfun(x, y, W, b);
  if mod(i,100) == 0
    fprintf('%6d   %f\n', i, v);
  end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v = neuralnet_lossfun(x, y, W, b)
%
v = 0;
for p = 1:size(x,2)
  h = neuralnet_predict(x(:,p), W, b);
  v = v + (h - y(p))^2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function x = neuralnet_predict(x, W, b)
%
for l = 1:length(W)
  x = actfun(b{l} + W{l}'*x);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dW db] = neuralnet_gradient(x, y, W, b)

% number of layers
L = length(W);

% parts of the gradient
dW = cell(L,1);
db = cell(L,1);
for l = 1:L
  dW{l} = zeros(size(W{l}));
  db{l} = zeros(size(b{l}));
end

s = cell(L,1); % activations
z = cell(L,1); % post-activations
d = cell(L,1); % sensitivities

% loop over data points
% an optimization is to make this the inner loop
n = size(x,2);
for p = 1:n

  % forward propagation
  temp = x(:,p);
  for l = 1:L
    s{l} = b{l} + W{l}'*temp;
    z{l} = actfun(s{l});
    temp = z{l};
  end

  % back propagation to compute sensitivities;
  % note biases are not used
  d{L} = dactfun(s{L});
  for l = L-1:-1:1
    d{l} = (W{l+1}*d{l+1}) .* dactfun(s{l});
  end

  % compute gradient (accumulate for each data point)
  errorfun_factor = 2*(z{L} - y(p)); % could premultiply into each d{l} if many layers
  temp = x(:,p);
  for l = 1:L
    dW{l} = dW{l} + temp*d{l}'*errorfun_factor;  % outer product
    db{l} = db{l} + d{l}*errorfun_factor;
    temp = z{l};
  end

end

function z = actfun(s)
% activation function
z = tanh(s);

function z = dactfun(s)
% derivative of activation function
z = tanh(s); % an optimization is to not compute tanh again (computed already in actfun)
z = 1 - z.*z;

