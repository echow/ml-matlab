mu1 = [-2; 0];
A1  = 0.2*[2 .8; .8 1];

mu2 = [2; 0];
A2  = 0.2*[2 .8; .8 1];

% compute values of the discriminant function on a mesh
xx = -5:.01:5;
yy = -5:.01:5;
Z = zeros(length(xx),length(yy));
invA1 = inv(A1);
invA2 = inv(A2);
logdetA1 = 0.5*log(det(A1));
logdetA2 = 0.5*log(det(A2));
for i = 1:length(xx)
for j = 1:length(yy)
  x = [xx(i); yy(j)];
  Z(j,i) = -logdetA1 -0.5*(x-mu1)'*invA1*(x-mu1) ...
           +logdetA2 +0.5*(x-mu2)'*invA2*(x-mu2) ...
           + log(.5) - log(.5);
end
end

% plot sign of discriminant function
clf
h=pcolor(xx,yy,sign(Z));
set(h, 'edgecolor', 'none');
caxis([-5 5]);
hold on

% draw two ellipses
[V D] = eig(A1);
ang = atan(V(2,1)/V(1,1));
ellipse(2*sqrt(D(1,1)), 2*sqrt(D(2,2)), ang, mu1(1), mu1(2), 'k');

[V D] = eig(A2);
ang = atan(V(2,1)/V(1,1));
ellipse(2*sqrt(D(1,1)), 2*sqrt(D(2,2)), ang, mu2(1), mu2(2), 'k');
axis equal
axis tight
