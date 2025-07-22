theme_prob_mass <- theme(
  plot.title = element_text(hjust = 0.5, family = "Times", size = 18),
  plot.subtitle = element_text(hjust = 0.5, family = "Times", size = 16),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.ticks.length = unit(1, "mm"),
  axis.ticks = element_line(linewidth = 0.5),
  axis.text = element_text(size = 12),
  axis.title = element_text(family = "Times", size = 16)
)

# Function to calculate and plot normal distribution probability
plot_normal_prob <- function(mu, sigma, a, b) {
  # Calculate probability
  prob <- pnorm(b, mean = mu, sd = sigma) - pnorm(a, mean = mu, sd = sigma)

  # Generate x values for the normal curve
  x_min <- mu - 4 * sigma
  x_max <- mu + 4 * sigma
  x <- seq(x_min, x_max, length.out = 1000)
  density <- dnorm(x, mean = mu, sd = sigma)
  df <- data.frame(x = x, density = density)

  p <- ggplot(df, aes(x = x, y = density)) +
    geom_line(color = "blue", linewidth = 0.3) +
    geom_area(
      data = subset(df, x >= a & x <= b),
      aes(x = x, y = density),
      fill = "lightblue",
      alpha = 0.7
    ) +
    geom_vline(xintercept = a, linetype = "dotted", color = "red") +
    geom_vline(xintercept = b, linetype = "dotted", color = "red") +
    labs(
      title = bquote("Normal(" ~ mu ~ "=" ~ .(mu) * "," ~ sigma ~ "=" ~ .(sigma) ~ ")"), 
      subtitle = glue("P({a} < X < {b}) = {round(prob, 4)}"),
      x = "X",
      y = "Density"
    ) +
    annotate("text",
      x = (a + b) / 2, y = max(density) * 0.4,
      label = paste("Area =", round(prob, 2)),
      color = "darkblue",
      family = "Times", size = 6
    ) + 
        # Add dx label at the bottom center of shaded area
    annotate("text",
      x = (a + b) / 2, y = max(density) * 0.05,
      label = "dx",
      color = "darkblue",
      family = "Times", size = 5
    ) +
    # Add f(x) label near the curve
    annotate("text",
      x = a - 0.3, y = dnorm(a, mean = mu, sd = sigma),
      label = "f(x)",
      color = "darkblue",
      family = "Times", size = 5
    ) +
    theme_prob_mass
  # print(p)
  return(p)
}

# Function to calculate and plot lognormal distribution probability
plot_lognormal_prob <- function(mu, sigma, a, b) {
  # Calculate probability for lognormal distribution
  # Note: mu and sigma are the parameters of the underlying normal distribution
  prob <- plnorm(b, meanlog = mu, sdlog = sigma) - plnorm(a, meanlog = mu, sdlog = sigma)

  # Generate y values for the lognormal curve
  y_min <- max(0.001, qlnorm(0.001, meanlog = mu, sdlog = sigma))
  y_max <- qlnorm(0.999, meanlog = mu, sdlog = sigma)

  y <- seq(y_min, y_max, length.out = 1000)
  density <- dlnorm(y, meanlog = mu, sdlog = sigma)
  df <- data.frame(y = y, density = density)

  p <- ggplot(df, aes(x = y, y = density)) +
    geom_line(color = "red", linewidth = 0.3) +
    geom_area(
      data = subset(df, y >= a & y <= b),
      aes(x = y, y = density),
      fill = "lightcoral",
      alpha = 0.7
    ) +
    geom_vline(xintercept = a, linetype = "dotted", color = "red") +
    geom_vline(xintercept = b, linetype = "dotted", color = "red") +
    labs(
      # title = glue("Lognormal(log$\\mu$ = {mu}, log$\\sigma$ = {sigma})"),
      title = bquote("Lognormal(log" ~ mu ~ "=" ~ .(mu) * ", log" ~ sigma ~ "=" ~ .(sigma) ~ ")"),
      subtitle = glue("P({round(a, 4)} < Y < {round(b, 4)}) = {round(prob, 4)}"),
      x = "Y = exp(X)",
      y = "Density"
    ) +
    annotate("text",
      x = (a + b) / 2, y = max(density) * 0.4,
      label = paste("Area =", round(prob, 2)),
      color = "darkred",
      family = "Times", size = 6
    ) + 
        # Add dy label at the bottom center of shaded area
    annotate("text",
      x = (a + b) / 2, y = max(density) * 0.05,
      label = "dy",
      color = "darkred",
      family = "Times", size = 5
    ) +
    # Add f(y) label near the curve
    annotate("text",
      x = a - 0.1, y = dlnorm(a, meanlog = mu, sdlog = sigma),
      label = "f(y)",
      color = "darkred",
      family = "Times", size = 5
    ) +
    theme_prob_mass
  # print(p)
  return(p)
}
