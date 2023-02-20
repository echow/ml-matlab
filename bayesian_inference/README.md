## Bayesian Inference

[**predictive_dist.m**](predictive_dist.m)

Things to try:

- Increase the number of observations. Observe that the variance of the predictive
  distribution will generally decrease.

[**nonlinear_bayesian.m**](nonlinear_bayesian.m)

Things to try:

- Use a regression function with 2 or more weights (e.g., initial angle and speed)
- Use many observations. Observe that this will make this simple sampling method
  very expensive.

[**mcmc.m**](mcmc.m)

Things to try:

- Experiment with different proposal distributions
- Use MCMC to sample from the posterior distribution in the nonlinear Bayesian example

[**gauproc_plot.m**](gauproc_plot.m)

- Experiment with different values of the Gaussian width.

[**gauproc_regr.m**](gauproc_regr.m)

- Experiment with different values of the noise variance and different numbers
  of data points.

- Extend the code so that it also plots a few likely members of the family 
  of curves from the Gaussian process.

- The given code is not so efficient, for example, it implicitly factors
  the C matrix every time it needs to solve with it. Modify the code so that
  it is more efficient.

