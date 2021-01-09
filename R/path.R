#' Helper functions that return paths
#' @noRd
#' @inheritParams file.path
path_mini_pkg <- function() {
  system.file(package = pkg)
}

path_mini_resources <- function(...) {
  file.path(
    path_mini_pkg(), "rmarkdown", ...
  )
}

path_mini_frameworks <- function(...) {
  file.path(
    path_mini_pkg(), "frameworks", ...
  )
}
