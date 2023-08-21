% generate X matrix 
rng(0)
n = 10;
X = rand(n,2)-.5;
X = [X X(:,1)+X(:,2)];
X(1,1) = X(1,1) + 1e-7;

rng(1)
v = rand(n,1)-.5;
X = [ones(n,1) v 1+v+rand(n,1)*1e-6];

% known solution
w = [1 2 3]';

% generate y vector with this known solution
y = X*w;

fprintf('Solution using normal equations\n');
inv(X'*X)*(X'*y)

fprintf('Another solution using normal equations\n');
(X'*X)\(X'*y)

fprintf('Solution using QR factorization\n');
[Q R] = qr(X,0); % Q is n by 3
R\(Q'*y)

fprintf('Solution using Matlab\n');
X\y

% try a different X matrix
