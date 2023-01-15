## Statistics Background

[**linear_regression.m**](linear_regression.m)

A first MATLAB example, showing how to solve a linear least squares
problem $\min_w \left\Vert y-Xw \right\Vert_2^2$ using `w = X \ y`.

[**estimate_variance_dis.m**](estimate_variance_dis.m)

Estimate the variance of a Gaussian distribution from a sample.
Compare the result using the biased and unbiased estimators
for the variance by commenting in/out the lines:

```matlab
  S2(i) = diff'*diff/n;     % biased estimate
  S2(i) = diff'*diff/(n-1); % unbiased estimate
```

[**estimate_variance_pop.m**](estimate_variance_pop.m)

The above estimators for the variance have nothing to do with the
Gaussian distribution. In this example, we estimate the variance of a
population from a sample of that population. The population itself is
generated from a uniform distribution. The variance of the population in
this example should be close to the variance of the uniform distribution
which is $(b-a)^2/12$ for a uniform distribution in the interval $[a,b]$.

