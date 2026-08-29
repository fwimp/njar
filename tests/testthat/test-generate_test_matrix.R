test_that("test matrix makes the correct matrix", {
  set.seed(123456)
  out <- generate_test_matrix(5)
  expect_equal(
    out,
    structure(
      c(FALSE, FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FALSE,
        FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE,
        TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE), dim = c(5L, 5L
        )
      )
    )
})
