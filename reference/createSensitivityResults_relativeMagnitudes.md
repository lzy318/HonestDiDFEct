# Robust confidence sets under the relative-magnitudes restriction

Constructs robust confidence sets for a vector of Mbar values under the
relative-magnitudes restriction \\\Delta^{RM}(Mbar)\\ of Rambachan and
Roth (2023). This restriction bounds each change in the violation of
parallel trends after s = 0 by Mbar times the largest change between
consecutive placebo periods. The function also covers
\\\Delta^{SDRM}(Mbar)\\ and the variants with a sign or monotonicity
restriction. It takes the coefficients of a `fect()` run with placebo
periods, and `fect_sens()` in the fect package calls it for you. The
confidence sets come from test inversion.

## Usage

``` r
createSensitivityResults_relativeMagnitudes(betahat, sigma,
                                            numPrePeriods, numPostPeriods,
                                            bound = "deviation from parallel trends",
                                            method = "C-LF",
                                            Mbarvec = NULL,
                                            l_vec = .basisVector(index = 1,
                                                                 size = numPostPeriods),
                                            monotonicityDirection = NULL,
                                            biasDirection = NULL,
                                            alpha = 0.05,
                                            gridPoints = 10^3,
                                            grid.ub = NA,
                                            grid.lb = NA,
                                            parallel = FALSE,
                                            seed = 0)
```

## Arguments

- betahat:

  Vector of coefficients for consecutive placebo periods ending at s =
  0, then for the post-treatment periods 1, 2, ..., with no reference
  period. Here s = 1 is the first treated period and s = 0 is the last
  untreated period. If the vector has names, they must be these periods.

- sigma:

  Covariance matrix of `betahat`.

- numPrePeriods:

  Number of placebo periods, counting s = 0. Must be at least two, and
  at least three if `bound = "deviation from linear trend"`.

- numPostPeriods:

  Number of post-treatment periods.

- bound:

  String that selects the base restriction. A sign or monotonicity
  restriction, if specified, is added to it. This must be either
  `"deviation from parallel trends"`, which selects
  \\\Delta^{RM}(Mbar)\\, or `"deviation from linear trend"`, which
  selects \\\Delta^{SDRM}(Mbar)\\. Default equals
  `"deviation from parallel trends"`. See Rambachan and Roth (2023) for
  a discussion of these restrictions.

- method:

  String that specifies the method for constructing robust confidence
  sets. This must be either `"Conditional"` or `"C-LF"`, the conditional
  least-favorable hybrid. Default equals `"C-LF"`, as Rambachan and
  Roth (2023) recommend.

- Mbarvec:

  Vector of Mbar values for which to construct robust confidence sets.
  If `NULL`, the function uses 10 values from 0 to 2. Default equals
  `NULL`.

- l_vec:

  Vector of length `numPostPeriods` that defines the target, theta =
  l_vec'tau, where tau holds the treatment effects in the post-treatment
  periods. Default equals the first basis vector, (1, 0, ..., 0). With
  one post-treatment period, `l_vec` must equal 1.

- biasDirection:

  Adds a sign restriction. If `"positive"`, the violation in each
  post-treatment period, relative to s = 0, is restricted to be
  positive, \\\delta \ge 0\\. If `"negative"`, it is restricted to be
  negative, \\\delta \le 0\\. Default equals `NULL`.

- monotonicityDirection:

  Adds a monotonicity restriction. If `"increasing"`, the violation is
  restricted to increase over time, \\\delta_t \ge \delta\_{t-1}\\. If
  `"decreasing"`, it is restricted to decrease, \\\delta_t \le
  \delta\_{t-1}\\. Default equals `NULL`.

- alpha:

  Desired size of the robust confidence sets. Default equals 0.05, which
  gives 95% confidence sets.

- parallel:

  Logical that indicates whether to construct the robust confidence sets
  in parallel with the foreach package. Register a parallel backend
  first, for example with the doParallel package. Default equals
  `FALSE`.

- gridPoints:

  Number of grid points for the test inversion. Default equals 1000.
  Fewer points run faster.

- grid.ub:

  Upper end of the grid for the test inversion, in units of theta.
  Default sets it to the estimate of theta plus twenty times the
  standard deviation of that estimate.

- grid.lb:

  Lower end of the grid for the test inversion, in units of theta.
  Default sets it to the estimate of theta minus twenty times the
  standard deviation of that estimate.

- seed:

  Random seed for internal computations, included for reproducibility.

## Details

All restrictions apply to the violation of parallel trends relative to s
= 0, the last placebo period. The function differences `betahat` and
`sigma` from s = 0, which removes that coordinate, and runs the
inference of HonestDiD 0.2.8 on the result. Before the inference, it
moves the post-treatment coefficients so that the estimate of theta is
zero. It adds that amount back to `lb` and `ub`. This centers the
default grids on the estimate and does not change the confidence set.

With `bound = "deviation from linear trend"`, `numPrePeriods` must be at
least three. This restriction uses the non-linearity in the placebo
coefficients to bound the non-linearity after treatment, and a second
difference needs three placebo periods.

## Value

Returns a data frame with columns

- lb:

  Lower bound of the robust confidence set.

- ub:

  Upper bound of the robust confidence set.

- method:

  Method used to construct the robust confidence set.

- Delta:

  The restriction used, for example `"DeltaRM"`.

- Mbar:

  Value of Mbar for each robust confidence set.

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
  createSensitivityResults_relativeMagnitudes(betahat, sigma, numPrePeriods = 3, numPostPeriods = 4,
                                              Mbarvec = c(0, 0.5), l_vec = rep(0.25, 4),
                                              gridPoints = 200)
#> # A tibble: 2 × 5
#>        lb    ub method Delta    Mbar
#>     <dbl> <dbl> <chr>  <chr>   <dbl>
#> 1 0.0484  0.127 C-LF   DeltaRM   0  
#> 2 0.00318 0.180 C-LF   DeltaRM   0.5
# }
```
