% Fisher's linear discriminant

% generate data
n = 100;
theta = 10/180*pi;
U = [cos(theta) -sin(theta); sin(theta) cos(theta)];
S = U'*[10 0; 0 1]*U;
X1 = [ 2;  2] + chol(S,'lower')*randn(2,n);
X2 = [-2; -2] + chol(S,'lower')*randn(2,n);

% plot generated data
clf
scatter(X1(1,:),X1(2,:),30,'b','filled');
hold on
scatter(X2(1,:),X2(2,:),30,'r','filled');
axis equal

% calculate and plot class empirical means
X1bar = mean(X1,2);
X2bar = mean(X2,2);
plot(X1bar(1),X1bar(2),'k+', 'linewidth', 4, 'markersize', 20);
plot(X2bar(1),X2bar(2),'k+', 'linewidth', 4, 'markersize', 20);

% compute class scatter matrices
S1 = zeros(2,2);
S2 = zeros(2,2);
for i = 1:n
  S1 = S1 + (X1(:,i)-X1bar)*(X1(:,i)-X1bar)';
  S2 = S2 + (X2(:,i)-X2bar)*(X2(:,i)-X2bar)';
end
Sw = S1 + S2;

% plot discriminant
w = Sw\(X1bar-X2bar); % Fisher's discriminant
% w = (X1bar-X2bar); % perpendicular to line joining means
fplot(@(x) -w(1)/w(2)*x, [-8 8])
