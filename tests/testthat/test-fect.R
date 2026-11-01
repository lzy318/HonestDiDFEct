test_that("fect_sens() runs on a placebo fit", {
  skip_on_cran()
  skip_if_not_installed("fect")
  utils::data("simdata", package = "fect", envir = environment())
  set.seed(1)
  fit <- suppressMessages(fect::fect(Y ~ D, data = simdata, index = c("id", "time"), method = "fe", force = "two-way",
                                     se = TRUE, nboots = 30, placeboTest = TRUE, placebo.period = c(-1, 0),
                                     parallel = FALSE))
  out <- quiet(fect::fect_sens(fit, post.periods = 1:2, Mbarvec = 0.5, Mvec = 0.1, periodMbarvec = 0.5,
                               periodMvec = 0.1))
  expect_named(as.data.frame(out$sensitivity.rm$results), c("lb", "ub", "method", "Delta", "Mbar"))
  expect_named(as.data.frame(out$sensitivity.smooth$results), c("lb", "ub", "method", "Delta", "M"))
  expect_true(all(out$sensitivity.rm$results$lb < out$sensitivity.rm$results$ub))
})
