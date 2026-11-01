test_that("the entry step differences from s = 0 and moves the post block", {
  e <- HonestDiDFEct:::.fectEntry(path_b, path_V, 3L, 4L, path_l)
  h <- by_hand(path_b, path_V, 3L, 4L, path_l)
  expect_equal(e$numPrePeriods, 2L)
  expect_equal(e$betahat, h$betahat)
  expect_equal(e$sigma, h$sigma)
  expect_equal(e$shift, h$shift)
  expect_equal(sum(path_l * e$betahat[3:6]), 0)
  expect_equal(e$betahat[1:2], unname(path_b[1:2] - path_b[3]))
  expect_true(isSymmetric(e$sigma))
})

test_that("input shapes do not change the answer", {
  a <- quiet(createSensitivityResults(path_b, path_V, 3, 4, method = "C-LF", Mvec = 0.02, l_vec = path_l))
  b <- quiet(createSensitivityResults(unname(path_b), path_V, 3, 4, method = "C-LF", Mvec = 0.02, l_vec = path_l))
  d <- quiet(createSensitivityResults(cbind(path_b), path_V, 3, 4, method = "C-LF", Mvec = 0.02,
                                      l_vec = matrix(path_l, ncol = 1)))
  expect_equal(a, b)
  expect_equal(a, d)
})

test_that("a common level in the coefficients does not matter", {
  a <- quiet(createSensitivityResults(path_b, path_V, 3, 4, method = "C-LF", Mvec = 0.02, l_vec = path_l))
  b <- quiet(createSensitivityResults(path_b + 7, path_V, 3, 4, method = "C-LF", Mvec = 0.02, l_vec = path_l))
  expect_equal(a, b)
})

test_that("results scale with the outcome", {
  a <- quiet(createSensitivityResults_relativeMagnitudes(path_b, path_V, 3, 4, Mbarvec = 0.5, l_vec = path_l,
                                                         method = "Conditional", gridPoints = 100))
  k <- 1e6
  b <- quiet(createSensitivityResults_relativeMagnitudes(path_b * k, path_V * k^2, 3, 4, Mbarvec = 0.5, l_vec = path_l,
                                                         method = "Conditional", gridPoints = 100))
  expect_equal(b$lb / k, a$lb, tolerance = 1e-6)
  expect_equal(b$ub / k, a$ub, tolerance = 1e-6)
})

test_that("grid arguments are in units of theta", {
  r <- quiet(createSensitivityResults_relativeMagnitudes(path_b, path_V, 3, 4, Mbarvec = 0, l_vec = path_l,
                                                         gridPoints = 100, grid.lb = -0.25, grid.ub = 0.25))
  h <- by_hand(path_b, path_V, 3L, 4L, path_l)
  e <- quiet(HonestDiDFEct:::computeConditionalCS_DeltaRM(h$betahat, h$sigma, 2L, 4L, l_vec = path_l, Mbar = 0,
                                                          hybrid_flag = "LF", gridPoints = 100,
                                                          grid.lb = -0.25 - h$shift, grid.ub = 0.25 - h$shift))
  expect_equal(r$lb, min(e$grid[e$accept == 1]) + h$shift)
  expect_equal(r$ub, max(e$grid[e$accept == 1]) + h$shift)
})

test_that("the original interval stays raw", {
  r <- constructOriginalCS(path_b, path_V, 3, 4, l_vec = path_l)
  m <- sum(path_l * path_b[4:7])
  s <- sqrt(c(path_l %*% path_V[4:7, 4:7] %*% path_l))
  expect_equal(c(r$lb), m - qnorm(0.975) * s)
  expect_equal(c(r$ub), m + qnorm(0.975) * s)
})

test_that("the package exports only the entry functions", {
  expect_setequal(getNamespaceExports("HonestDiDFEct"),
                  c("createSensitivityResults", "createSensitivityResults_relativeMagnitudes", "constructOriginalCS",
                    "createSensitivityPlot", "createSensitivityPlot_relativeMagnitudes", "createEventStudyPlot",
                    "basisVector"))
})
