#' Specify includes option
#'
#' As KaTeX is expected to be relatively a heavy library,
#' it is place at the last of the in_header
#'
#' @noRd
spec_includes <- function(includes = list(),
                          math = "katex_serverside") {
  if (identical(math, "katex")) {
    includes$in_header <- c(
      includes$in_header,
      path_mini_resources("html", "katex", "partial.html")
    )
  }
  includes
}
