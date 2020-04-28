#' Specify includes option
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
