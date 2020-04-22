#' Generate post processor
#'
#' @noRd
#' @param post An inheriting post processor.
#' @param mini Using 'mini.css' (`TRUE` or `FALSE`)?
mini_post_processor <- function(post, mini = TRUE) {
  if (!mini) return(post)
  force(post)
  function(metadata, input_file, output_file, clean, verbose) {
    output <- readLines(output_file)
    math <- readLines(path_mini_document('katex.html'))
    position <- which(grepl(" *<!--math placeholder-->", output))[1L]
    writeLines(append(output, math, position)[-position], output_file)
    post(metadata, input_file, output_file, clean, verbose)
  }
}
