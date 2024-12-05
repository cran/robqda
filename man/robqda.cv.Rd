\name{Cross-validation for the robust quadratic discriminant analysis}
\alias{robqda.cv}
\title{
Cross-validation for the robust quadratic discriminant analysis
}

\description{
Cross-validation for the robust quadratic discriminant analysis.
}

\usage{
robqda.cv(x, ina, nfolds = 10, quantile.used = floor((n + p + 1)/2),
nsamp = "best", folds = NULL, stratified = TRUE, seed = NULL)
}

\arguments{
\item{x}{
A matrix with the data.
}
\item{ina}{
A group indicator variable for the avaiable data.
}
\item{nfolds}{
The number of folds in the cross validation.
}
\item{folds}{
If you have the list with the folds supply it here. You can also leave it NULL and it will create folds.
}
\item{quantile.used}{
A number, the minimum number of the data points regarded as good points.
}
\item{nsamp}{
The number of samples or "best", "exact", or "sample". The limit If "sample" the number chosen is min(5 * p, 3000), taken from Rousseeuw and Hubert (1997). If "best" exhaustive enumeration is done up to 5000 samples: if "exact" exhaustive enumeration will be attempted.
}
\item{stratified}{
Do you want the folds to be created in a stratified way? TRUE or FALSE.
}
\item{seed}{
You can specify your own seed number here or leave it NULL.
}
}

\details{
Cross validation is performed to estimate the rate of accuracy in the robust quadratic discriminant analysis.
}

\value{
A list including:
\item{per}{
A vector with the estimated rate of correct classification for every fold.
}
\item{percent}{
A matrix with the mean estimated rates of correct classification.
}
\item{runtime}{
The time required by the cross-validation procedure.
}
}

\references{
Friedman Jerome, Trevor Hastie and Robert Tibshirani (2009).
The elements of statistical learning, 2nd edition. Springer, Berlin.
}

\author{
Michail Tsagris.

R implementation and documentation: Michail Tsagris \email{mtsagris@uoc.gr}.
}

%\note{
%%  ~~further notes~~
%}

\seealso{
\code{\link{robqda}
}
}

\examples{
x <- as.matrix(iris[, 1:4]) + matrix(rnorm(150 * 4), ncol = 4 )
mod <- robqda.cv(x, iris[, 5], nfolds = 5)
mod
}

