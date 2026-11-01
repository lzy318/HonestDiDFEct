\name{createEventStudyPlot}
\alias{createEventStudyPlot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Event study plot
}
\description{
Plots event study coefficients with their confidence intervals. Unlike the other functions here, it takes coefficients with a reference period left out of the vector, as \pkg{HonestDiD} does. For \pkg{fect} output, use \code{plot()} in the \pkg{fect} package.
}
\usage{
createEventStudyPlot(betahat, stdErrors = NULL, sigma = NULL,
                     numPrePeriods, numPostPeriods, alpha = 0.05, timeVec,
                     referencePeriod, useRelativeEventTime = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{betahat}{
   Vector of estimated event study coefficients.
  }
  \item{stdErrors}{
  Vector of standard errors of the coefficients. Default equals \code{NULL}. Specify either \code{stdErrors} or \code{sigma}. If \code{stdErrors} is \code{NULL}, the function uses the square root of the diagonal of \code{sigma}.
  }
  \item{sigma}{
   Covariance matrix of the coefficients. Default equals \code{NULL}. Specify either \code{stdErrors} or \code{sigma}.
  }
  \item{numPrePeriods}{
  Number of pre-treatment periods.
  }
  \item{numPostPeriods}{
  Number of post-treatment periods.
  }
  \item{alpha}{
  Desired size of the confidence intervals. Default equals 0.05.
  }
  \item{timeVec}{
  Vector of the time periods of the coefficients. It leaves out the reference period, which is normalized to zero.
  }
  \item{referencePeriod}{
  Scalar that gives the reference period.
  }
  \item{useRelativeEventTime}{
  Logical that specifies whether to plot in relative event time, which sets the reference period to zero. Default equals \code{FALSE}.
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
  createEventStudyPlot(betahat         = BCdata_EventStudy$betahat,
                       sigma           = BCdata_EventStudy$sigma,
                       numPrePeriods   = length(BCdata_EventStudy$prePeriodIndices),
                       numPostPeriods  = length(BCdata_EventStudy$postPeriodIndices),
                       alpha           = 0.05,
                       timeVec         = BCdata_EventStudy$timeVec,
                       referencePeriod = BCdata_EventStudy$referencePeriod)
}
}
