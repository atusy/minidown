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

test_that("math rendering", {
  td <- tempfile()
  dir.create(td)
  rmd <- file.path(td, "test.Rmd")
  render <- function(..., runtime = "auto") {
    readLines(rmarkdown::render(
      rmd,
      mini_document(
        ..., self_contained = FALSE, pandoc_args = c("--metadata=title:test")
      ),
      runtime = runtime,
      quiet = TRUE
    ))
  }
  expect_pattern <- function(lines, pattern, expected = TRUE) {
    (if (expected) expect_true else expect_false)(any(grepl(pattern, lines)))
  }
  expect_katex_css <- function(lines, expected = TRUE) {
    expect_pattern(lines, '/katex.min.css"', expected)
  }
  expect_katex_js <- function(lines, expected = TRUE) {
    expect_pattern(lines, '/katex.min.js"', expected)
  }

  writeLines("", rmd)
  for (framework in c(names(frameworks), "none", "bootstrap")) {
    output <- render(math = "katex_serverside", framework = framework)
    expect_katex_css(output, TRUE)
    expect_katex_js(output, FALSE)

    output <- render(math = "katex", framework = framework)
    expect_katex_css(output, TRUE)
    expect_katex_js(output, TRUE)

    output <- render(math = NULL, framework = framework)
    expect_katex_css(output, FALSE)
    expect_katex_js(output, FALSE)
  }

  expect_pattern(
    render(math = "default", framework = "bootstrap"),
    "https://mathjax.rstudio.com/latest/MathJax.js",
    TRUE
  )

  expect_error(render(math = "default"))

  writeLines(c("---", "runtime: shiny", "---"), rmd)
  output <- suppressWarnings(render(math = "katex", framework = framework))
  expect_katex_css(output, TRUE)
  expect_katex_js(output, FALSE)
  expect_warning(render(math = "katex", framework = framework))
})
