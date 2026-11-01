go <- function(b, p = 3, q = 4) {
  createSensitivityResults(b, diag(length(b)) * 1e-4 + 1e-5, p, q, method = "C-LF", Mvec = 0.02,
                           l_vec = rep(1 / q, q))
}

test_that("the guard stops on paths that do not end at s = 0", {
  b <- path_b
  names(b) <- c(-17, -16, -15, 1:4)
  expect_error(go(b), "placebo periods")
  names(b) <- c(-3, -2, -1, 1:4)
  expect_error(go(b), "placebo periods")
  names(b) <- c(-3, -1, 0, 1:4)
  expect_error(go(b), "placebo periods")
  names(b) <- c("a", "b", "c", 1:4)
  expect_error(go(b), "placebo periods")
})

test_that("the guard stops on a post block that does not start at 1", {
  b <- path_b
  names(b) <- c(-2:0, 2:5)
  expect_error(go(b), "post")
  names(b) <- c(-2:0, 1, 3, 4, 5)
  expect_error(go(b), "post")
})

test_that("the guard stops outside the error handler", {
  b <- path_b
  names(b) <- c(-3, -2, -1, 1:4)
  expect_silent(try(go(b), silent = TRUE))
  expect_error(createSensitivityResults_relativeMagnitudes(b, path_V, 3, 4, l_vec = path_l), "placebo periods")
})

test_that("one placebo period is not enough", {
  expect_error(go(path_b[3:7], p = 1), "two placebo periods")
})

test_that("the guard passes good paths and unnamed paths", {
  expect_s3_class(quiet(go(path_b)), "data.frame")
  expect_s3_class(quiet(go(unname(path_b))), "data.frame")
})

test_that("the target must make sense", {
  expect_error(createSensitivityResults(path_b, path_V, 3, 4, l_vec = rep(0, 4)), "all zeros")
  expect_error(createSensitivityResults(path_b[1:4], path_V[1:4, 1:4], 3, 1, l_vec = 2), "equal 1")
})

test_that("conformability is checked first", {
  expect_error(createSensitivityResults(path_b, path_V, 3, 5, l_vec = rep(0.2, 5)), "non-conformable")
})
