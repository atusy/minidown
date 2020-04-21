path_pkg <- function(...) system.file(..., package = "minidown")

path_mini_document <- function(...) {
  path_pkg("rmarkdown", "templates", "mini_document", ...)
}

path_minicss <- function(...) {
  path_pkg("resource", "minicss", ...)
}
