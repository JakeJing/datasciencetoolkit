data {
  int<lower=0> N; // number of observations
  vector[N] y; // observed data
}

parameters {
  real mu; // mean parameter
  real sigma; // standard deviation parameter
}
model {
  // Priors
  target += normal_lpdf(mu | 0, 10); // prior for mean
  target += normal_lpdf(sigma | 0, 5); // prior for standard deviation
  
  // Likelihood
  target += normal_lpdf(y | mu, sigma); // data follows normal distribution
}
