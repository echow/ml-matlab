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

The distribution of the mean $\bar{x}$ of $n$ samples 
$x_1, \ldots, x_n$ from an unknown distribution has variance
$$\text{Var}(\bar{x}) = \text{Var}(x)/n$$
which does not depend on the distribution of the samples.

When the distribution is Gaussian with mean $\mu$ and variance $\sigma^2$, then 
```math
\frac{\bar{x} - \mu}{\sigma / \sqrt{n}} \sim N(0,1)
```
In our example, we use samples from a Gaussian distribution with mean 0
and variance 2.

When the variance is estimated with the unbiased sample variance, $S_n^2$,
then the distribution of $\bar{x}$ follows a t-distribution with
$n-1$ degrees of freedom
```math
\frac{\bar{x} - \mu}{S_n / \sqrt{n}} \sim t_{n-1} .
```


Things to try:

- The example uses the unbiased estimate for the variance.
  What happens when you use a biased estimate for the variance?
- What happens when you use the exact variance of the Gaussian distribution
  that generated the samples?
- What happens as the sample size $n$ increases? Note that the corresponding
  t-distribution has degrees of freedom $n-1$.
- What happens when the Gaussian distribution that generates the samples
  has nonzero mean?
  


