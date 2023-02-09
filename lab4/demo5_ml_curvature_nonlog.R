library(rgl)

D <- c(0.312, 0.555, 0.24, 0.979)

# Log Posterior.
U <- function(mu, sigma) {
  dunif(mu, 0, 1, log = T) +
    dunif(sigma, 0, 1, log = T) +
    sum(dnorm(D, mu, sigma, log = T))
}

nonlog_U <- function(mu, sigma) {
  dunif(mu, 0, 1) *
    dunif(sigma, 0, 1) *
    prod(dnorm(D, mu, sigma))
}

# Simplified gradient of log posteriour of normal (not including prior as it does not change result).
log_normal_pdf <- expression(log(1 / (sqrt(2 * pi) * sigma)) + (((xs - mu) / sigma)^2 * -0.5))
dmu <- D(log_normal_pdf, "mu")
dsigma <- D(log_normal_pdf, "sigma")

grad_U <- function(mu, sigma) {
  dx <- sum(eval(dmu, envir = list(xs = D, mu = mu, sigma = sigma)))
  dz <- sum(eval(dsigma, envir = list(xs = D, mu = mu, sigma = sigma)))
  c(dx, dz)
}


mus <- seq(0, 1, length.out = 70)
sigmas <- seq(0, 1, length.out = 70)

grid <- expand.grid(mus = mus, sigmas = sigmas)


posteriors <- sapply(seq_len(nrow(grid)), function(i) U(grid$mus[i], grid$sigmas[i]))
nonlog_posteriors <- sapply(seq_len(nrow(grid)), function(i) nonlog_U(grid$mus[i], grid$sigmas[i]))

posteriors <- pmax(-6, posteriors)
posteriors <- (posteriors + 6) / 6

rgl.open()
rgl.bg(color = "white")
rgl.viewpoint(theta = 180 + 45, phi = 45, fov = 0, zoom = 1)
par3d("windowRect" = c(50, 50, 1500, 800))

x <- grid$mus
y <- posteriors
z <- grid$sigmas

#rgl.points(x, posteriors, z, color = ifelse(y == 0, "white", "gray"))
rgl.surface(x = mus, z = sigmas,y = matrix(nonlog_posteriors, nrow = length(mus), ncol = length(sigmas)), color = "blue")


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

y <- function(x, z) {
  (U(x, z) + 6) / 6 + 0.01
}

x <- 0.2
z <- 0.3
for (i in 1:10) {

  # Compute the gradient adjusted by some factor for distance of jump.
  grad <- grad_U(x,z)

  dx <- grad[1] * 0.02
  dz <- grad[2] * 0.02

  # rgl.lines(c(x, x + dx),
  #           c(y(x, z), y(x + dx, z + dz)),
  #           c(z, z + dz), color = "black")
  # rgl.points(x, y(x, z), z, color = "black", size = 6)

  x <- x + dx
  z <- z + dz
}

ddmu <- D(D(log_normal_pdf, "mu"), "mu")
ddsigma <- D(D(log_normal_pdf, "sigma"), "sigma")

h1 <- sum(eval(ddmu, envir = list(xs = D, mu = x, sigma = z)))
h2 <- sum(eval(ddsigma, envir = list(xs = D, mu = x, sigma = z)))

aaa <- pmax(0,exp(h1 * (mus - x)^2 * 0.5))
bbb <- pmax(0,exp(h2 * (sigmas - z)^2 * 0.5 ))

aaa <- aaa/max(aaa)/2
bbb <- bbb/max(bbb)/2

rgl.linestrips(mus, aaa, rep(0, length(mus)), color = "orange")
rgl.linestrips(rep(0, length(sigmas)), bbb, sigmas, color = "orange")