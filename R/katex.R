#' Download KaTeX
#' @noRd
download_katex <- function(dev = TRUE) {
  base <- if (dev) {
    "./inst/resource/katex"
  } else {
    path_pkg("resource", "katex")
  }
  url <- gsub(
    '" .*$', "",
    gsub('^.*(src=|href=)"', "", readLines(path_mini_document("katex.html")))
  )
  Map(download.file, url, file.path(base, basename(url)))
}
