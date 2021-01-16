test_that("Returns a html_dependency", {
  for (framework in c(names(frameworks), "all")) {
    lapply(
      html_dependency_framework(framework),
      expect_s3_class,
      "html_dependency"
    )
  }
})
