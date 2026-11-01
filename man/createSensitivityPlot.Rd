\name{createSensitivityPlot}
\alias{createSensitivityPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sensitivity plot under the smoothness restriction
}
\description{
  Plots how the robust confidence sets change with M under \eqn{\Delta^{SD}(M)}, \eqn{\Delta^{SDB}(M)} or \eqn{\Delta^{SDM}(M)}, next to the original confidence interval. For \pkg{fect} output, \code{plot(type = "sens", restrict = "sm")} in the \pkg{fect} package draws a similar figure.
}
\usage{
createSensitivityPlot(robustResults, originalResults,
                      rescaleFactor = 1, maxM = Inf, add_xAxis = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{robustResults}{
  Data frame of robust confidence sets from \code{createSensitivityResults()}, with columns \code{method}, \code{lb}, \code{ub} and \code{M}.
  }
  \item{originalResults}{
  Data frame with the original confidence interval from \code{constructOriginalCS()}, with columns \code{method}, \code{lb} and \code{ub}.
  }
  \item{rescaleFactor}{
  Scalar that rescales the M values and the bounds of the confidence sets. Default equals one.
  }
  \item{maxM}{
  Largest M value to plot. Default equals infinity, which plots all values.
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
  robustResults <-
    createSensitivityResults(betahat, sigma, numPrePeriods = 3, numPostPeriods = 4,
                             method = "C-LF", Mvec = c(0, 0.02), l_vec = rep(0.25, 4))
  originalResults <-
    constructOriginalCS(betahat, sigma, numPrePeriods = 3, numPostPeriods = 4,
                        l_vec = rep(0.25, 4))
  createSensitivityPlot(robustResults, originalResults)
}
}
