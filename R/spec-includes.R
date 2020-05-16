#' Specify includes option
#'
#' As KaTeX is expected to be relatively a heavy library,
#' it is place at the last of the in_header
#'
#' @noRd
spec_includes <- function(includes = list(),
                          katex = TRUE) {
  if (katex) {
    includes$in_header <- c(
      includes$in_header,
      path_mini_resources("html", "math-katex.html")
    )
  }
  includes
}
