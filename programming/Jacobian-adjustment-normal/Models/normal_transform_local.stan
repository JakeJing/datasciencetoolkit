data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real mu;
  real<lower=0> sigma;
}
model {
  // Method 1: prior on log(sigma) --> lead to a different prior on sigma
  target += normal_lpdf(log(sigma) | 0, 5);
  target += lognormal_lpdf(sigma | 0, 5); // equivalently

  // Method 2: prior on local variable sigma_log with Jacobian adjustment
  // real sigma_log = log(sigma);
  // target += normal_lpdf(sigma_log | 0, 5);

  // Priors
  target += normal_lpdf(mu | 0, 10);

  // Likelihood
  target += normal_lpdf(y | mu, sigma);
}
