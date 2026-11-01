# Sensitivity plot under the smoothness restriction

Plots how the robust confidence sets change with M under
\\\Delta^{SD}(M)\\, \\\Delta^{SDB}(M)\\ or \\\Delta^{SDM}(M)\\, next to
the original confidence interval. For fect output,
`plot(type = "sens", restrict = "sm")` in the fect package draws a
similar figure.

## Usage

``` r
createSensitivityPlot(robustResults, originalResults,
                      rescaleFactor = 1, maxM = Inf, add_xAxis = TRUE)
```

## Arguments

- robustResults:

  Data frame of robust confidence sets from
  [`createSensitivityResults()`](https://lzy318.github.io/HonestDiDFEct/reference/createSensitivityResults.md),
  with columns `method`, `lb`, `ub` and `M`.

- originalResults:

  Data frame with the original confidence interval from
  [`constructOriginalCS()`](https://lzy318.github.io/HonestDiDFEct/reference/constructOriginalCS.md),
  with columns `method`, `lb` and `ub`.

- rescaleFactor:

  Scalar that rescales the M values and the bounds of the confidence
  sets. Default equals one.

- maxM:

  Largest M value to plot. Default equals infinity, which plots all
  values.

- add_xAxis:

  Logical that specifies whether to draw a horizontal line at zero.
  Default equals `TRUE`.

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

# }
```
