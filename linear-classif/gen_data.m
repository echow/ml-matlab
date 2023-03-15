mu = [0; 0];
A = [2 -1; -1 2];

% plot samples from this Gaussian distribution
clf
L = chol(A, 'lower');
for i = 1:300
  z = randn(2,1);
  x = L*z;
  hold on
  plot(x(1),x(2),'ro');
end

% draw ellipse with 2 standard deviation contour
[V D] = eig(A);
ang = atan(V(2,1)/V(1,1));
ellipse(2*sqrt(D(1,1)), 2*sqrt(D(2,2)), ang, mu(1), mu(2), 'k');
axis equal

