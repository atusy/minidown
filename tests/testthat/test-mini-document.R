test_that("render skeleton.Rmd", {
  rendered_file <- rmarkdown::render(
    path_mini_resources(
      "templates", "mini_document", "skeleton", "skeleton.Rmd"
    ),
    output_file = tempfile(fileext = ".html"),
    quiet = TRUE
  )
  expect_true(file.exists(rendered_file))
})
