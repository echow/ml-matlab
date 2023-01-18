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

[**t_distribution.m**](t_distribution.m)

The Student's t-distribution often arises when the variance is not known
and must be estimated with an unbiased estimator.
This example shows that the distribution of the mean of samples from a
Gaussian distribution follows the t-distribution when the variance
of the Gaussian distribution is estimated.

The distribution of the mean of $n$ samples has variance
```math
\text{Var}(\bar{x}) = \text{Var}(x)/n
```
which does not depend on the distribution of the samples.
In our example, we use samples from a Gaussian distribution with variance 2.

Things to try:

- The example uses the unbiased estimate for the variance.
  What happens when you use a biased estimate for the variance?
- What happens when you use the exact variance of the Gaussian distribution
  that generated the samples?
- What happens as the sample size $n$ increases? Note that the corresponding
  t-distribution has degrees of freedom $n-1$.
- What happens when the Gaussian distribution that generates the samples
  has nonzero mean?
  


