library(rgl)

D <- c(0.312, 0.555, 0.24, 0.979)

# Log Posterior.
U <- function(mu, sigma) {
  # Simplifiy
  dunif(mu, 0, 1) *
    dunif(sigma, 0, 1) *
    prod(dnorm(D, mu, sigma))
}

mus <- seq(0, 1, length.out = 70)
sigmas <- seq(0, 1, length.out = 70)

grid <- expand.grid(mus = mus, sigmas = sigmas)

posteriors <- sapply(seq_len(nrow(grid)), function(i) U(grid$mus[i], grid$sigmas[i]))

rgl.open()
rgl.bg(color = "white")
rgl.viewpoint(theta = 180 + 45, phi = 45, fov = 0, zoom = 0.7)
par3d("windowRect" = c(50, 50, 1500, 800))

x <- grid$mus
y <- posteriors
z <- grid$sigmas

rgl.points(x, y, z, color = ifelse(y == 0, "white", "gray"))

rgl.lines(range(x), c(0, 0), c(0, 0), color = "blue")
rgl.lines(c(0, 0), range(y), c(0, 0), color = "red")
rgl.lines(c(0, 0), c(0, 0), range(z), color = "green")

rgl.texts(0, max(y), 0, "posterior", adj = c(1, 0, 0), color = "black")
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

x <- 0.4
z <- 0.5

rgl.texts(x, 0, z, "start", col = "red")
rgl.points(x, 0, z, col = "red")

xs <- NULL
zs <- NULL

for (i in 1:2000) {

  x.new <- rnorm(1, mean = x, sd = 0.02)
  z.new <- rnorm(1, mean = z, sd = 0.02)

  a <- U(x.new, z.new) / U(x, z)
  u <- runif(1, 0, 1)

  accept <- (a >= u)

  if (accept) {
    x <- x.new
    z <- z.new
    rgl.points(x, 0, z, col = "black")

    xs <- c(xs, x)
    zs <- c(zs, z)
  }
  else {
    eps <- 0.01
    rgl.lines(c(x.new + eps, x.new - eps), 0, c(z.new + eps, z.new - eps), col = "black")
    rgl.lines(c(x.new - eps, x.new + eps), 0, c(z.new + eps, z.new - eps), col = "black")
  }
}
d <- density(xs)
yy <- d$y / max(d$y) * max(posteriors)
rgl.linestrips(d$x, yy, rep(0, length(mus)), color = "orange")

d <- density(zs)
yy <- d$y / max(d$y) * max(posteriors)
rgl.linestrips(rep(0, length(mus)), yy, d$x, color = "orange")