library(rgl)

# Data
D <- c(0.312, 0.555, 0.24, 0.979)

# Log posterior
U <- function(mu, sigma) {
  dunif(mu, 0, 1, log = T) +
    dunif(sigma, 0, 1, log = T) +
    sum(dnorm(D, mu, sigma, log = T))
}

# Nonlog posterior
nonlog_U <- function(mu, sigma) {
  dunif(mu, 0, 1) *
    dunif(sigma, 0, 1) *
    prod(dnorm(D, mu, sigma))
}

# Grid.
mus <- seq(0, 1, length.out = 70)
sigmas <- seq(0, 1, length.out = 70)

grid <- expand.grid(mus = mus, sigmas = sigmas)

# Compute posteriors.
posteriors <- sapply(seq_len(nrow(grid)), function(i) U(grid$mus[i], grid$sigmas[i]))
nonlog_posteriors <- sapply(seq_len(nrow(grid)), function(i) nonlog_U(grid$mus[i], grid$sigmas[i]))

# HACK scale!
posteriors <- pmax(-6, posteriors)
posteriors <- (posteriors + 6) / 6

# RGL stuff.
rgl.open()
rgl.bg(color = "white")
rgl.viewpoint(theta = 180 + 45, phi = 45, fov = 0, zoom = 1)
par3d("windowRect" = c(50, 50, 1500, 800))

x <- grid$mus
z <- grid$sigmas

rgl.points(x, posteriors, z, color = ifelse(posteriors == 0, "white", "gray"))
rgl.surface(x = mus, z = sigmas,y = matrix(nonlog_posteriors, nrow = length(mus), ncol = length(sigmas)), color = "blue")

rgl.lines(range(x), c(0, 0), c(0, 0), color = "blue")
rgl.lines(c(0, 0), range(posteriors), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), range(z), color = "green")

rgl.texts(0, max(posteriors), 0, "log posterior", adj = c(1, 0, 0), color = "black")
rgl.texts(max(x), 0, 0, "mus", adj = c(1, 0, 0), color = "black")
rgl.texts(0, 0, max(z), "sigmas", adj = c(1, 0, 0), color = "black")

ep <- 0.05
for (i in seq(0, max(x), by = 0.1)) {
  rgl.lines(c(0, -ep), c(0, 0), c(i, i), color = "black")
  rgl.texts(0 - ep, 0, i, paste0(i), adj = c(1, 0, 0), color = "black")
}

for (i in seq(0, max(z), by = 0.1)) {
  rgl.lines(c(i, i), c(0, 0), c(0, -ep), color = "black")
  rgl.texts(i, 0, 0 - ep, paste0(i), adj = c(1, 0, 0), color = "black")
}
