test_that("Returns a list", {
  expect_type(spec_includes(), "list")
  expect_type(spec_includes(list(), math = "katex"), "list")
})
