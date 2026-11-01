# HonestDiDFEct

**R** package for sensitivity analysis of event studies estimated with
[**fect**](https://yiqingxu.org/packages/fect/). It is forked from
[**HonestDiD**](https://github.com/asheshrambachan/HonestDiD) by Ashesh
Rambachan and Jonathan Roth and is based on version 0.2.8. It reports
robust confidence sets for treatment effects when parallel trends may
fail by a bounded amount, under the relative-magnitudes and smoothness
restrictions of Rambachan and Roth (2023). You normally run it through
`fect_sens()` in **fect**.

The package works only with the placebo output of **fect**, that is, a
`fect()` run with `placeboTest = TRUE` and `se = TRUE`. Covariates,
unbalanced panels, and estimators such as interactive fixed effects
(IFE) and Gsynth are supported as long as placebo periods are used. Runs
with `loo = TRUE` are not supported.

For a cohort-level analysis under staggered adoption, see
[**CohortHonestDiD**](https://github.com/lzy318/CohortHonestDiD) and Liu
(2026), [Cohort-Anchored HonestDiD](https://arxiv.org/abs/2509.01829).

**Installation:**

``` r
install.packages("fect")
# install.packages("remotes")
remotes::install_github("lzy318/HonestDiDFEct")
```

On Debian or Ubuntu, install the GLPK library (`libglpk-dev`) first,
because the Rglpk dependency needs it.

**Source Code:** [GitHub](https://github.com/lzy318/HonestDiDFEct)

**User Manual:** [Website](https://lzy318.github.io/HonestDiDFEct/) with
a [short
tutorial](https://lzy318.github.io/HonestDiDFEct/articles/tutorial.html)
and the help pages.

**Main References:**

Chiu, Albert, Xingchen Lan, Ziyi Liu, and Yiqing Xu. (2026). [Causal
Panel Analysis Under Parallel Trends: Lessons from a Large Reanalysis
Study](https://www.cambridge.org/core/journals/american-political-science-review/article/causal-panel-analysis-under-parallel-trends-lessons-from-a-large-reanalysis-study/219275E0CE901F099F2CFFBA07079243).
*American Political Science Review*, 120(1): 245–266.

Rambachan, Ashesh, and Jonathan Roth (2023). [A More Credible Approach
to Parallel Trends](https://doi.org/10.1093/restud/rdad018). *Review of
Economic Studies* 90 (5): 2555-2591.

**Report bugs:** Open a [GitHub
issue](https://github.com/lzy318/HonestDiDFEct/issues) or email
zyliu2023 \[at\] berkeley.edu, and include a short script, a small data
set that shows the problem, and the output of
[`sessionInfo()`](https://rdrr.io/r/utils/sessionInfo.html).
