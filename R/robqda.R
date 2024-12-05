robqda <- function(xnew, x, ina, quantile.used = floor((n + p + 1)/2), nsamp = "best") {
  p <- dim(x)[2]
  xnew <- as.matrix(xnew)
  xnew <- matrix(xnew, ncol = p)
  nu <- dim(xnew)[1]  ## number of the new observations
  ina <- as.numeric(ina)
  nc <- max(ina)
  ng <- numeric(nc)
  ta <- matrix(nrow = nu, ncol = nc)
  mesos <- matrix(nrow = nc, ncol = p)
  sk <- vector("list", nc)

  for (i in 1:nc) {
    xi <- x[ina == i, ]
    n <- dim(xi)[1]
    mod <- MASS::cov.rob(xi, quantile.used = quantile.used, method = "mcd", nsamp = nsamp)
    ng[i] <- length(mod$best)
    mesos[i, ] <- mod$center
    sk[[ i ]] <- mod$cov
  }
  n <- sum(ng)
  ci <- 2 * log(ng / n)
  for (j in 1:nc)   ta[, j] <- ci[j] - log( det( sk[[ i ]] ) ) - Rfast::mahala( xnew, mesos[j, ], sk[[ i ]] )

  est <- Rfast::rowMaxs(ta)
  list(mesos = mesos, sk = sk, est = est)
}
