#' Convert to an HTML document powered by the lightweight CSS framework.
#'
#' @param frameworks A string to specify the CSS framework.
#' @param code_folding Setup code folding by a string or a named list.
#'   A choice for the string are `"none"` to disable,
#'   `"show"` to enable and show all by default), and
#'   `"hide"` to enable and hide all by default.
#'   If a named list, each element may have one of the above strings.
#'   Names are some of "source", "output", "message", "warning", and "error".
#'   If the list does not have some of the element with the above name,
#'   they are treated as `"none"`.
#' @param theme A theme of the document. Default is `"mini"`. Themes of
#'   `rmarkdown::html_document` are also available.
#'
#' @param ... Arguments passed to `rmarkdown::html_document`
#' @inheritParams rmarkdown::html_document
#' @export
mini_document <- function(
                          code_folding = c("none", "show", "hide"),
                          pandoc_args = NULL,
                          extra_dependencies = NULL,
                          framework = "sakura",
                          theme = "default",
                          includes = list(),
                          template = "default",
                          toc = FALSE,
                          toc_float = FALSE,
                          mathjax = "default",
                          ...) {
  framework <- match.arg(framework, c("bootstrap", names(frameworks)))
  html5 <- framework != "bootstrap"

  fmt <- rmarkdown::html_document(
    theme = if (html5) NULL else theme,
    pandoc_args = spec_pandoc_args(pandoc_args, html5),
    extra_dependencies =
      spec_dependencies(extra_dependencies, toc_float, html5, framework),
    template = spec_template(template, html5),
    includes = spec_includes(includes, html5),
    toc = toc,
    toc_float = !html5 && toc_float,
    code_folding = "none", # As minidown offers different approach
    mathjax = if (html5) NULL else mathjax,
    ...
  )

  fmt$knitr$opts_chunk[names(default_opts_chunk)] <- default_opts_chunk
  fmt$knitr$opts_hooks <- spec_opts_hooks(code_folding)

  if (html5) fmt$pandoc$to <- "html5"

  fmt
}
