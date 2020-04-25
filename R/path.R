#' Helper functions that return paths
#' @noRd
#' @inheritParams system.file
NULL
path_pkg <- function(...) system.file(..., package = "minidown")

path_mini_document <- function(...) {
  path_pkg("rmarkdown", "templates", "mini_document", ...)
}

path_minicss <- function(...) {
  path_pkg("resource", "minicss", ...)
}

path_resource <- function(...) {
  path_pkg("resource", ...)
}
