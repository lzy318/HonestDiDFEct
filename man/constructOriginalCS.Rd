\name{constructOriginalCS}
\alias{constructOriginalCS}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Original confidence interval for the target
}
\description{
  Constructs the usual confidence interval for l_vec'beta_post from the post-treatment coefficients as given, with no differencing. \code{fect_sens()} stores this interval as the original one. The robust confidence sets are built after subtracting the coefficient at s = 0 from every coefficient, but this interval is not. If \code{l_vec} sums to one, its center and the center of the robust confidence set at Mbar = 0 differ by the coefficient at s = 0.
}
\usage{
constructOriginalCS(betahat, sigma,
                    numPrePeriods, numPostPeriods,
                    l_vec = .basisVector(index = 1, size = numPostPeriods),
                    alpha = 0.05)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{betahat}{
  Vector of coefficients for consecutive placebo periods ending at s = 0, then for the post-treatment periods 1, 2, ..., with no reference period.
  }
  \item{sigma}{
  Covariance matrix of \code{betahat}.
  }
  \item{numPrePeriods}{
  Number of placebo periods, counting s = 0.
  }
  \item{numPostPeriods}{
  Number of post-treatment periods.
  }
  \item{l_vec}{
  Vector of length \code{numPostPeriods} that defines the target, l_vec'beta_post. Default equals the first basis vector, (1, 0, ..., 0).
  }
  \item{alpha}{
  Desired size of the confidence interval. Default equals 0.05, which gives a 95\% confidence interval.
  }
}
\value{
Returns a data frame with columns
  \item{lb}{
  Lower bound of the original confidence interval, based on asymptotic normality.
  }
  \item{ub}{
  Upper bound of the original confidence interval, based on asymptotic normality.
  }
  \item{method}{
  Set to \code{"Original"}.
  }
  \item{Delta}{
  Set to \code{NA}.
  }
}
\examples{
  # Placebo periods -2, -1 and 0, then post periods 1 to 4. fect_sens() makes this
  # call for you on a fect() run with placeboTest = TRUE.
  betahat <- c("-2" = 0.02, "-1" = -0.01, "0" = 0.01,
               "1" = 0.08, "2" = 0.10, "3" = 0.09, "4" = 0.12)
  sigma   <- 0.0004 * 0.5^abs(outer(1:7, 1:7, "-")) + 0.0001
  constructOriginalCS(betahat, sigma, numPrePeriods = 3, numPostPeriods = 4,
                      l_vec = rep(0.25, 4))
}
