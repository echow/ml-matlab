function mcmc
% Example of Markov Chain Monte Carlo
% for sampling from an unnormalized distribution

nsamp = 10000000;              % number of samples
c = zeros(nsamp,1);            % array for storing the samples
numacc = 0;                    % number of accepted candidates
x = 0.2;                       % initial state

% MCMC sampling
for k = 1:nsamp
  y = x + 0.1*randn;           % candidate from proposal distribution
  a = min(1, qfun(y)/qfun(x)); % acceptance probability
  t = rand;
  if t < a
    numacc = numacc + 1;       % count accepted candidate
    x = y;                     % new state is accepted state
  else
    x = x;                     % new state is same as current state
  end
  c(k) = x;                    % store the new state
end

fprintf('Fraction of accepted candidates: %f\n', numacc/nsamp);

% plot results
bw = 1/100;                    % histogram bin widths
x = bw/2:bw:1-bw/2;            % histogram centers
h = hist(c, x);                % count number of states in each bin
clf
plot(x, h, 'rx');              % plot histogram
hold on
fun = @(x) abs(sin(2*pi*x)).*x - (x-.5).^2 + .5^2;
y = fun(x);
plot(x,y/max(y)*max(h),'bo-'); % plot normalized original distribution

function p = qfun(x)
% unnormalized distribution from which we want to sample
if x < 0 || x > 1
  p = 0;
else
  p = abs(sin(2*pi*x))*x - (x-.5)^2 + .5^2;
end
