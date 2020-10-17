test_that("fold returns a character vector", {
  expect_identical(code_folding_options(), default_folding)
  folding <- default_folding
  folding[["source"]] <- "show"
  expect_identical(code_folding_options("show"), folding)
  expect_identical(code_folding_options(list(source = "show")), folding)
  folding[] <- "show"
  expect_identical(code_folding_options(as.list(folding)), folding)
})

test_that("Raise error", {
  expect_error(code_folding_options("foo"))
  expect_error(code_folding_options(default_folding))
})
