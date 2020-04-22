#' Render an example Rmd file of the 'minidown' package.
#' @param browing `TRUE` (default) or `FALSE` to browse the result
#' @param ... Parameters passed to `rmarkdown::render`
#' @export
mini_example <- function(browsing = interactive(), ...) {
  input <- "example.Rmd"
  file.copy(path_mini_document(input), input)
  output <- rmarkdown::render(input, ...)
  if (browsing) {
    browseURL(output)
  }
  output
}
