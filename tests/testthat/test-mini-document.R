testthat::skip_if(!rmarkdown::pandoc_available("2.7.2"))

test_that("render skeleton.Rmd", {
  temp_rmd <- tempfile(fileext = ".Rmd")
  file.copy(
    path_mini_resources("templates", "mini_document", "skeleton",
                        "skeleton.Rmd"),
    temp_rmd
  )
  rendered_file <- rmarkdown::render(
    temp_rmd, output_file = tempfile(fileext = ".html"), quiet = TRUE
  )
  expect_true(file.exists(rendered_file))
})
