function demo_svm

%rng(2);

% generate 2-D synthetic data in two classes
x1 = randn(20,2)-1.8;
x2 = randn(20,2)+1.8;
x = [x1; x2]';
y = [-ones(20,1); ones(20,1)];

[a b] = smo_simplified2(x, y, 1, 1e-6, 30);
fprintf('done minimization\n');

% plot discriminant
xx = -5:.01:5;
yy = -5:.01:5;
Z = zeros(length(yy),length(xx)); % bugfix
for i = 1:length(xx)
for j = 1:length(yy)
  xquery = [xx(i); yy(j)];
  temp = b;
  for k = 1:length(y)
    temp = temp + a(k)*y(k)*innerprod(xquery, x(:,k));
  end
  Z(j,i) = temp;
end
end
fprintf('done Z\n');

clf
h=pcolor(xx,yy,sign(Z));
set(h, 'edgecolor', 'none');
caxis([-5 5]);
hold on

% plot points
x = x';
plot(x(1:20,1),x(1:20,2),'bx');
hold on
plot(x(21:40,1),x(21:40,2),'rx');

% identify support vectors
%sup = find(a ~= 0);
%length(sup)
%plot(x(sup,1),x(sup,2),'ks');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kernel function or inner product
function prod = innerprod(x, y)
% prod = x'*y;
prod = exp(-0.5/1*norm(x-y)^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% discriminant function
function f = fun(a, y, x, b, xquery)
%f = b + (xquery'*x)*(a.*y);
f = b;
n = length(y);
for i = 1:n
  f = f + a(i)*y(i)*innerprod(x(:,i),xquery);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [a, b] = smo_simplified2(x, y, C, tol, max_passes)
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
      %disp([i,j]);

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
