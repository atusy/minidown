test_that("render skeleton.Rmd", {
  output_file <- tempfile(fileext = ".html")
  rendered_file <- rmarkdown::render(
    path_mini_resources(
      "templates", "mini_document", "skeleton", "skeleton.Rmd"
    ),
    output_file = output_file
  )
  expect_identical(output_file, rendered_file)
})
