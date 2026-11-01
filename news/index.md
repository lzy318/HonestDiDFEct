# Changelog

## HonestDiDFEct 1.0.0

First release as a separate package, forked from HonestDiD 0.2.8 by
Ashesh Rambachan and Jonathan Roth.

- [`createSensitivityResults()`](https://lzy318.github.io/HonestDiDFEct/reference/createSensitivityResults.md)
  and
  [`createSensitivityResults_relativeMagnitudes()`](https://lzy318.github.io/HonestDiDFEct/reference/createSensitivityResults_relativeMagnitudes.md)
  take the placebo output of **fect** as it comes, with `numPrePeriods`
  counting s = 0. They difference the coefficients from s = 0 and then
  run the code of HonestDiD, so every restriction and method of these
  two functions works on **fect** output.
- The default grids are centered on the estimate, so a bound no longer
  stops at the edge of a grid centered on zero. `grid.lb` and `grid.ub`
  are in units of the target.
- The two functions stop with a message unless the coefficients are
  consecutive placebo periods ending at s = 0, followed by
  post-treatment periods 1, 2, and so on. A run with `loo = TRUE` stops
  here.
- [`constructOriginalCS()`](https://lzy318.github.io/HonestDiDFEct/reference/constructOriginalCS.md)
  works as in HonestDiD, on the coefficients as given.
- `computeConditionalCS_*()`, `findOptimalFLCI()`,
  `DeltaSD_lowerBound_Mpre()` and `DeltaSD_upperBound_Mpre()` are now
  internal, because they expect coefficients with a reference period
  left out.
- Two fixes to the code of HonestDiD are kept. The conditional test no
  longer stops with an error when a variance is zero, and the grid for
  the test inversion accepts ends that are 1 x 1 matrices.
