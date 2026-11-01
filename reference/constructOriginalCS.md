# Original confidence interval for the target

Constructs the usual confidence interval for l_vec'beta_post from the
post-treatment coefficients as given, with no differencing.
`fect_sens()` stores this interval as the original one. The robust
confidence sets are built after subtracting the coefficient at s = 0
from every coefficient, but this interval is not. If `l_vec` sums to
one, its center and the center of the robust confidence set at Mbar = 0
differ by the coefficient at s = 0.

## Usage

``` r
constructOriginalCS(betahat, sigma,
                    numPrePeriods, numPostPeriods,
                    l_vec = .basisVector(index = 1, size = numPostPeriods),
                    alpha = 0.05)
```

## Arguments

- betahat:

  Vector of coefficients for consecutive placebo periods ending at s =
  0, then for the post-treatment periods 1, 2, ..., with no reference
  period.

- sigma:

  Covariance matrix of `betahat`.

- numPrePeriods:

  Number of placebo periods, counting s = 0.

- numPostPeriods:

  Number of post-treatment periods.

- l_vec:

  Vector of length `numPostPeriods` that defines the target,
  l_vec'beta_post. Default equals the first basis vector, (1, 0, ...,
  0).

- alpha:

  Desired size of the confidence interval. Default equals 0.05, which
  gives a 95% confidence interval.

## Value

Returns a data frame with columns

- lb:

  Lower bound of the original confidence interval, based on asymptotic
  normality.

- ub:

  Upper bound of the original confidence interval, based on asymptotic
  normality.

- method:

  Set to `"Original"`.

- Delta:

  Set to `NA`.

## Examples

``` r
  # Placebo periods -2, -1 and 0, then post periods 1 to 4. fect_sens() makes this
  # call for you on a fect() run with placeboTest = TRUE.
  betahat <- c("-2" = 0.02, "-1" = -0.01, "0" = 0.01,
               "1" = 0.08, "2" = 0.10, "3" = 0.09, "4" = 0.12)
  sigma   <- 0.0004 * 0.5^abs(outer(1:7, 1:7, "-")) + 0.0001
  constructOriginalCS(betahat, sigma, numPrePeriods = 3, numPostPeriods = 4,
                      l_vec = rep(0.25, 4))
#> # A tibble: 1 × 4
#>   lb[,1] ub[,1] method   Delta
#>    <dbl>  <dbl> <chr>    <lgl>
#> 1 0.0632  0.132 Original NA   
```
