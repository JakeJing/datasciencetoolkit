data {
  int<lower=0> N; // number of observations
  vector[N] y; // observed data
}
parameters {
  real mu; // mean parameter
  real sigma_z; // unconstrained standard deviation parameter
}
transformed parameters {
  real sigma = exp(sigma_z);
}
model {
  // Method 1: prior on sigma, with transformed block and Jacobian adjustment
  target += normal_lpdf(sigma | 0, 5); // prior for the transformed standard deviation

  // Method 2: local variable sigma, no transformed block, but with Jacobian adjustment
  // real sigma = exp(sigma_z);
  // target += normal_lpdf(sigma | 0, 5); // prior for the transformed standard deviation

  target += normal_lpdf(mu | 0, 10); // prior for mean
  
  // Likelihood
  target += normal_lpdf(y | mu, sigma) + log(sigma); // add Jacobian adjustment
  // target += normal_lpdf(y | mu, sigma) + sigma_z; // alternatively
}

