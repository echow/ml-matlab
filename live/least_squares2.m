% generate X matrix of size n by 2
rng(0)
n = 10;
X = rand(n,1)-.5;
X = [X X+rand(n,1)*1e-8];

% known solution
w = [1 2]';

% generate y vector with this known solution
y = X*w;

fprintf('Solution using normal equations\n');
inv(X'*X)*(X'*y)

fprintf('Another solution using normal equations\n');
(X'*X)\(X'*y)

fprintf('Solution using QR factorization\n');
[Q R] = qr(X,0); % Q is n by 2
R\(Q'*y)

fprintf('Solution using Matlab\n');
X\y

% try a different X matrix
