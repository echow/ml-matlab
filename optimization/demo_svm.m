function demo_svm

rng(1);

% generate 2-D synthetic data in two classes
x1 = randn(20,2)-1.8;
x2 = randn(20,2)+1.8;
x = [x1; x2]';
y = [-ones(20,1); ones(20,1)];

[a b] = smo_simplified(x, y, 1, 1e-6, 3000);

% compute discriminant
w = x*(a.*y);

% plot points
x = x';
clf
plot(x(1:20,1),x(1:20,2),'bx');
hold on
plot(x(21:40,1),x(21:40,2),'rx');

sup = find(a ~= 0);
length(sup)
plot(x(sup,1),x(sup,2),'ks');

xx = -8:0.1:6;
yy = -b/w(2) -w(1)/w(2)*xx;
plot(xx,yy);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kernel function or inner product
function prod = innerprod(x, y)
prod = x'*y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% discriminant function
function f = fun(a, y, x, b, xquery)
%f = b + (xquery'*x)*(a.*y);
f = b;
n = length(y);
for i = 1:n
  f = f + a(i)*y(i)*innerprod(x(:,i),xquery);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a, b] = smo_simplified(x, y, C, tol, max_passes)
% Sequential Minimal Optimization

% number of training points 
n = length(y);

% initialize solution
a = zeros(n,1);
b = 0;

passes = 0;
while (passes < max_passes)
  num_changed_alphas = 0;
  for i = 1:n
    Ei = fun(a, y, x, b, x(:,i)) - y(i);

    if ( (y(i)*Ei < -tol && a(i) < C) || ...
         (y(i)*Ei >  tol && a(i) > 0) )

      % select j ~= i randomly
      temp = randperm(n);
      j = temp(1);
      if (j == i), j = temp(2); end

      Ej = fun(a, y, x, b, x(:,j)) - y(j);

      ai = a(i);
      aj = a(j);

      % calculate L and H
      if (y(i) ~= y(j))
        L = max(0, aj-ai);
        H = min(C, C+aj-ai);
      else
        L = max(0, ai+aj-C);
        H = min(C, ai+aj);
      end
      if (L == H), continue; end

      eta = 2*innerprod(x(:,i),x(:,j)) ...
            - innerprod(x(:,i),x(:,i)) ...
            - innerprod(x(:,j),x(:,j));
      if (eta >= 0), continue; end

      % calculate a(j) and clip
      a(j) = a(j) - y(j)*(Ei-Ej)/eta;
      if (a(j) > H)
        a(j) = H;
      elseif (a(j) < L)
        a(j) = L;
      end
      if abs(a(j)-aj) < 1e-5, continue; end

      % calculate a(i)
      a(i) = a(i) + y(i)*y(j)*(aj-a(j));

      % compute b
      b1 = b - Ei - y(i)*(a(i)-ai)*innerprod(x(:,i),x(:,i)) - y(j)*(a(j)-aj)*innerprod(x(:,i),x(:,j));
      b2 = b - Ej - y(i)*(a(i)-ai)*innerprod(x(:,i),x(:,j)) - y(j)*(a(j)-aj)*innerprod(x(:,j),x(:,j));
      if (0 < a(i) < C)
        b = b1;
      elseif (0 < a(j) < C)
        b = b2;
      else
        b = (b1+b2)/2;
      end

      num_changed_alphas = num_changed_alphas + 1;

    end
  end
  if num_changed_alphas == 0
    passes = passes + 1;
  else
    passes = 0;
  end
end

