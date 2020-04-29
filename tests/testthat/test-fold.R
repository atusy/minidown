test_that("fold returns a character vector", {
  expect_identical(fold(), default_folding)
  folding <- default_folding
  folding[["source"]] <- "show"
  expect_identical(fold("show"), folding)
  expect_identical(fold(list(source = "show")), folding)
  folding[] <- "show"
  expect_identical(fold(as.list(folding)), folding)
})

test_that("Raise error", {
  expect_error(fold("foo"))
  expect_error(fold(default_folding))
})
