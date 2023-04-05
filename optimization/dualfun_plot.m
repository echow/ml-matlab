function dualfun_plot

% plot the Lagrangian function for different lambda >= 0
figure(1)
clf
qind = 0:0.25:2;
qval = [];
for lambda = qind
  xind = -1:.1:3;
  xval = [];
  for x = xind
    xval = [xval 0.5*(x-.5)*(x-.5) + lambda*(1-x)];
  end
  pause
  [min_xval index] = min(xval);
  fprintf('For lambda % f, min value of Lagrangian is: % f\n', lambda, min(xval));
  qval = [qval min_xval];
  plot(xind, xval)
  hold on
  plot(xind(index), min_xval, 'ko')
  xlim([-1 3])
  ylim([-1.5 1])
  grid on
end

% plot the dual function
figure(2)
clf
plot(qind, qval, '-o');
grid on
