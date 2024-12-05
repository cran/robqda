\name{Robust quadratic discriminant analysis}
\alias{robqda}
\title{
Robust quadratic discriminant analysis
}

\description{
Robust quadratic discriminant analysis.
}

\usage{
robqda(xnew, x, ina, quantile.used = floor((n + p + 1)/2), nsamp = "best")
}

\arguments{
\item{xnew}{
A matrix with the new data whose group is to be predicted. They have to be continuous.
}
\item{x}{
A matrix with the available data. They have to be continuous.
}
\item{ina}{
A group indicator variable for the avaiable data.
}
\item{quantile.used}{
A number, the minimum number of the data points regarded as good points.
}
\item{nsamp}{
The number of samples or "best", "exact", or "sample". The limit If "sample" the number chosen is min(5*p, 3000), taken from Rousseeuw and Hubert (1997). If "best" exhaustive enumeration is done up to 5000 samples: if "exact" exhaustive enumeration will be attempted.
}
}

\details{
Robust quadratic discriminant analysis is performed where robust estimates (MCD method) of the multivariate location and scatter are used.
}

\value{
A list including:
\item{mesos}{
The estimated robust multivariate locations.
}
\item{sk}{
The estimated robust scatter matrices.
}
\item{est}{
The estimated group membership of the new data.
}
}

\references{
P. Rousseeuw and M. Hubert (1997) Recent developments in PROGRESS.
In L1-Statistical Procedures and Related Topics ed Y. Dodge, IMS Lecture Notes volume 31, pp. 201--214.

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
\code{\link{robqda.cv}
}
}

\examples{
x <- as.matrix(iris[, 1:4]) + matrix(rnorm(150 * 4), ncol = 4 )
ina <- iris[, 5]
mod <- robqda(x, x, ina)
table(ina, mod$est)
}

