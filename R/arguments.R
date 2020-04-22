#' Generate arguments to rmarkdown::html_document
#'
#' @noRd
#'
#' @param mini Using 'mini.css' (`TRUE` or `FALSE`)?
#' @inheritParams rmarkdown::html_document
NULL

mini_depends <- function(extra_dependencies = NULL,
                         mini = TRUE,
                         toc_float = FALSE) {
  if (!mini) return(extra_dependencies)
  c(
    list(
      htmltools::htmlDependency(
        "minicss", "3.0.1",
        path_minicss(), stylesheet = "mini-default.min.css",
        meta = list(viewport = "width=device-width, initial-scale=1")
      ),
      htmltools::htmlDependency(
        "minidown", packageVersion("minidown"),
        path_mini_document("css"),
        stylesheet = c("style.css", if (toc_float) "toc-float.css")
      )
    ),
    extra_dependencies
  )
}

mini_pandoc_args <- function(pandoc_args = NULL, mini = TRUE) {
  lua <- dir(path_mini_document("lua"), pattern = "\\.lua$", full.names = TRUE)
  c(
    pandoc_args,
    c(rbind(rep_len("--lua", length(lua)), lua)),
    if (mini) '--mathjax'
  )
}

mini_template <- function(template = "default", mini = TRUE) {
  if (mini && identical(template, "default")) {
    return(path_mini_document('default.html'))
  }
  template
}

mini_includes <- function(includes = list(), mini = TRUE) {
  if (mini) {
    includes$in_header <- c(
      includes$in_header,
      path_mini_document('math.html')
    )
  }
  includes
}
