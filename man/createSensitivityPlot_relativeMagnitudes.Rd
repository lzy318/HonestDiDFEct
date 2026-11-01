\name{createSensitivityPlot_relativeMagnitudes}
\alias{createSensitivityPlot_relativeMagnitudes}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sensitivity plot under the relative-magnitudes restriction
}
\description{
  Plots how the robust confidence sets change with Mbar under \eqn{\Delta^{RM}(Mbar)}, \eqn{\Delta^{SDRM}(Mbar)} and their variants with a sign or monotonicity restriction, next to the original confidence interval. For \pkg{fect} output, \code{plot(type = "sens", restrict = "rm")} in the \pkg{fect} package draws a similar figure.
}
\usage{
createSensitivityPlot_relativeMagnitudes(robustResults, originalResults,
                                         rescaleFactor = 1, maxMbar = Inf,
                                         add_xAxis = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{robustResults}{
  Data frame of robust confidence sets from \code{createSensitivityResults_relativeMagnitudes()}, with columns \code{method}, \code{lb}, \code{ub} and \code{Mbar}.
  }
  \item{originalResults}{
  Data frame with the original confidence interval from \code{constructOriginalCS()}, with columns \code{method}, \code{lb} and \code{ub}.
  }
  \item{rescaleFactor}{
  Scalar that rescales the Mbar values and the bounds of the confidence sets. Default equals one.
  }
  \item{maxMbar}{
  Largest Mbar value to plot. Default equals infinity, which plots all values.
  }
  \item{add_xAxis}{
  Logical that specifies whether to draw a horizontal line at zero. Default equals \code{TRUE}.
  }
}
\value{
Returns a ggplot object.
}
\references{
  Rambachan, Ashesh, and Jonathan Roth (2023). A More Credible Approach to Parallel Trends. \emph{Review of Economic Studies} 90 (5): 2555-2591. \doi{10.1093/restud/rdad018}
}
\author{
  Ashesh Rambachan
}
\examples{
\donttest{
  # Placebo periods -2, -1 and 0, then post periods 1 to 4. fect_sens() makes this
  # call for you on a fect() run with placeboTest = TRUE.
  betahat <- c("-2" = 0.02, "-1" = -0.01, "0" = 0.01,
               "1" = 0.08, "2" = 0.10, "3" = 0.09, "4" = 0.12)
  sigma   <- 0.0004 * 0.5^abs(outer(1:7, 1:7, "-")) + 0.0001
  kwargs <- list(betahat = betahat, sigma = sigma, numPrePeriods = 3,
                 numPostPeriods = 4, l_vec = rep(0.25, 4))
  robustResults   <- do.call(createSensitivityResults_relativeMagnitudes,
                             c(kwargs, list(Mbarvec = c(0, 0.5), gridPoints = 200)))
  originalResults <- do.call(constructOriginalCS, kwargs)
  createSensitivityPlot_relativeMagnitudes(robustResults, originalResults)
}
}
