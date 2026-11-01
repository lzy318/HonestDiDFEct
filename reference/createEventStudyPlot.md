# Event study plot

Plots event study coefficients with their confidence intervals. Unlike
the other functions here, it takes coefficients with a reference period
left out of the vector, as HonestDiD does. For fect output, use
[`plot()`](https://rdrr.io/r/graphics/plot.default.html) in the fect
package.

## Usage

``` r
createEventStudyPlot(betahat, stdErrors = NULL, sigma = NULL,
                     numPrePeriods, numPostPeriods, alpha = 0.05, timeVec,
                     referencePeriod, useRelativeEventTime = FALSE)
```

## Arguments

- betahat:

  Vector of estimated event study coefficients.

- stdErrors:

  Vector of standard errors of the coefficients. Default equals `NULL`.
  Specify either `stdErrors` or `sigma`. If `stdErrors` is `NULL`, the
  function uses the square root of the diagonal of `sigma`.

- sigma:

  Covariance matrix of the coefficients. Default equals `NULL`. Specify
  either `stdErrors` or `sigma`.

- numPrePeriods:

  Number of pre-treatment periods.

- numPostPeriods:

  Number of post-treatment periods.

- alpha:

  Desired size of the confidence intervals. Default equals 0.05.

- timeVec:

  Vector of the time periods of the coefficients. It leaves out the
  reference period, which is normalized to zero.

- referencePeriod:

  Scalar that gives the reference period.

- useRelativeEventTime:

  Logical that specifies whether to plot in relative event time, which
  sets the reference period to zero. Default equals `FALSE`.

## Value

Returns a ggplot object.

## References

Rambachan, Ashesh, and Jonathan Roth (2023). A More Credible Approach to
Parallel Trends. *Review of Economic Studies* 90 (5): 2555-2591.
[doi:10.1093/restud/rdad018](https://doi.org/10.1093/restud/rdad018)

## Author

Ashesh Rambachan

## Examples

``` r
# \donttest{
  createEventStudyPlot(betahat         = BCdata_EventStudy$betahat,
                       sigma           = BCdata_EventStudy$sigma,
                       numPrePeriods   = length(BCdata_EventStudy$prePeriodIndices),
                       numPostPeriods  = length(BCdata_EventStudy$postPeriodIndices),
                       alpha           = 0.05,
                       timeVec         = BCdata_EventStudy$timeVec,
                       referencePeriod = BCdata_EventStudy$referencePeriod)

# }
```
