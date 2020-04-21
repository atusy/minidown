mini_depends <- function(extra_dependencies = NULL) {
  c(
    list(
      htmltools::htmlDependency(
        "minicss", "3.0.1",
        path_minicss(), stylesheet = "mini-default.min.css"
      ),
      htmltools::htmlDependency(
        "minidown", packageVersion("minidown"),
        path_mini_document(), stylesheet = "style.css"
      ),
      extra_dependencies
    )
  )
}

mini_pandoc_args <- function(pandoc_args = NULL) {
  lua <- dir(path_mini_document(), pattern = "\\.lua$", full.names = TRUE)
  c(pandoc_args, c(rbind(rep_len("--lua", length(lua)), lua)))
}

mini_includes <- function(includes = list()) {
  includes$in_header <-
    c(includes$in_header, path_mini_document("head.html"))
  includes
}

#' Convert to an HTML document powered by the 'mini.css' framework.
#' @param ... Arguments passed to `rmarkdown::html_document`
#' @inheritParams rmarkdown::html_document
#' @export
mini_document <- function(
                          code_folding = c("none", "show", "hide"),
                          pandoc_args = NULL,
                          keep_md = FALSE,
                          includes = list(),
                          extra_dependencies = NULL,
                          ...) {
  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options(
      opts_chunk = default_opts_chunk,
      opts_hooks = mini_opts_hooks(code_folding)
    ),
    pandoc = NULL,
    keep_md = keep_md,
    base_format = rmarkdown::html_document(
      theme = NULL,
      pandoc_args = mini_pandoc_args(pandoc_args),
      includes = mini_includes(includes),
      extra_dependencies = mini_depends(extra_dependencies),
      ...
    )
  )
}
