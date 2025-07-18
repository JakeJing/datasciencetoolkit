data {
  int<lower=0> N;
  vector[N] y;
}
parameters {
  real mu;
  real<lower=0> sigma;
} 
transformed parameters {
  // Method 1: simple transformation without a prior for the transformed parameter
  real log_sigma = log(sigma); 
}
model {
  // Priors
  target += normal_lpdf(mu | 0, 10);
  target += normal_lpdf(sigma | 0, 5); // prior on sigma

  // Likelihood
  target += normal_lpdf(y | mu, sigma);
}
