test_that("Returns list of html_dependency", {
  lapply(spec_dependencies(), expect_s3_class, "html_dependency")
  dep <- htmltools::htmlDependency("foo", "1", "bar")
  deps <- spec_dependencies(list(dep))
  lapply(deps, expect_s3_class, "html_dependency")
  expect_identical(deps[[length(deps)]], dep)
})
