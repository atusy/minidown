test_that("Returns a list", {
  expect_type(spec_includes(), "list")
  expect_type(spec_includes(list(), katex = FALSE), "list")
})
