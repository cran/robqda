robqda.cv <- function(x, ina, nfolds = 10, quantile.used = floor((n + p + 1)/2), nsamp = "best",
                      folds = NULL, stratified = TRUE, seed = NULL) {
  ina <- as.numeric(ina)
  p <- dim(x)[2]
  nc <- max(ina) ## number of groups
  ng <- per <- numeric(nc)
  mesos <- matrix(nrow = nc, ncol = p)
  sk <- vector("list", nc)

  if ( is.null(folds) )  folds <- .makefolds(ina, nfolds = nfolds, stratified = stratified, seed = seed)
  nfolds <- length(folds)

  runtime <- proc.time()
  for ( vim in 1:nfolds ) {
    xtest <- x[ folds[[ vim ]], , drop = FALSE]  ## test sample
    id <- ina[ folds[[ vim ]] ] ## groups of test sample
    xtrain <- x[ -folds[[ vim ]], , drop = FALSE]   ## training sample
    ida <- ina[ -folds[[ vim ]] ]  ## groups of training sample
    ta <- matrix(nrow = dim(xtest)[1], ncol = nc)

    for (i in 1:nc) {
      xi <- xtrain[id == i, ]
      n <- dim(xi)[1]
      mod <- MASS::cov.rob(xi, quantile.used = quantile.used, method = "mcd", nsamp = nsamp)
      ng[i] <- length(mod$best)
      mesos[i, ] <- mod$center
      sk[[ i ]] <- mod$cov
    }
    n <- sum(ng)
    ci <- 2 * log(ng / n)
    for (j in 1:nc)   ta[, j] <- ci[j] - log( det( sk[[ i ]] ) ) - Rfast::mahala( xtest, mesos[j, ], sk[[ i ]] )
    per[vim] <- mean( Rfast::rowMaxs(ta) == id)

  }
  runtime <- proc.time() - runtime

  percent <- mean(per)
  list(per = per, percent = percent, runtime = runtime)
}





.makefolds <- function(ina, nfolds = 10, stratified = TRUE, seed = NULL) {
  names <- paste("Fold", 1:nfolds)
  runs <- sapply(names, function(x) NULL)
  if ( !is.null(seed) )  set.seed(seed)

  if ( !stratified ) {
    rat <- length(ina) %% nfolds
    suppressWarnings({
      mat <- matrix( Rfast2::Sample.int( length(ina) ), ncol = nfolds )
    })
    mat[-c( 1:length(ina) )] <- NA
    for ( i in 1:c(nfolds - 1) )  runs[[ i ]] <- mat[, i]
    a <- prod(dim(mat)) - length(ina)
    runs[[ nfolds ]] <- mat[1:c(nrow(mat) - a), nfolds]
  } else {
    labs <- unique(ina)
    run <- list()
    for (i in 1:length(labs)) {
      names <- which( ina == labs[i] )
      run[[ i ]] <- sample(names)
    }
    run <- unlist(run)
    for ( i in 1:length(ina) ) {
      k <- i %% nfolds
      if ( k == 0 )  k <- nfolds
      runs[[ k ]] <- c( runs[[ k ]], run[i] )
    }
  }

  for (i in 1:nfolds)  {
    if ( any( is.na(runs[[ i ]]) ) )  runs[[ i ]] <- runs[[ i ]][ !is.na(runs[[ i ]]) ]
  }

  if ( length(runs[[ nfolds ]]) == 0 ) runs[[ nfolds ]] <- NULL
  runs
}



