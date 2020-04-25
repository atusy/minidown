#' Generate post processor
#'
#' @noRd
#' @param post An inheriting post processor.
#' @param html5 Using HTML5 (`TRUE` or `FALSE`)?
#' @param framework Currently ignored.
spec_post_processor <- function(post, html5 = TRUE, framework = NULL) {
  if (!html5) {
    return(post)
  }
  force(post)
  function(metadata, input_file, output_file, clean, verbose) {
    output <- readLines(output_file)
    math <- readLines(path_mini_resources("html", "katex.html"))
    position <- which(grepl(" *<!--math placeholder-->", output))[1L]
    writeLines(append(output, math, position)[-position], output_file)
    post(metadata, input_file, output_file, clean, verbose)
  }
}
