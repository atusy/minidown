#' Helper functions that return paths
#' @noRd
#' @inheritParams file.path
path_mini_resources <- function(...) {
  file.path(
    system.file(
      "rmarkdown", "templates", "mini-document", "resources", package = pkg
    ),
    ...
  )
}
