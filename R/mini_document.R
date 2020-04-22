#' Convert to an HTML document powered by the 'mini.css' framework.
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
                          theme = "mini",
                          includes = list(),
                          template = "default",
                          toc = FALSE,
                          toc_float = FALSE,
                          ...) {
  mini <- identical(theme, "mini")

  fmt <- rmarkdown::html_document(
    theme = if (mini) NULL else theme,
    pandoc_args = mini_pandoc_args(pandoc_args, mini),
    extra_dependencies = mini_depends(extra_dependencies, mini, toc_float),
    template = mini_template(template, mini),
    includes = mini_includes(includes, mini),
    toc = toc,
    toc_float = !mini && toc_float,
    code_folding = 'none', # As minidown offers different approach
    ...
  )

  fmt$knitr$opts_chunk[names(default_opts_chunk)] <- default_opts_chunk
  fmt$knitr$opts_hooks <- mini_opts_hooks(code_folding)

  fmt$post_processor <- mini_post_processor(fmt$post_processor, mini)

  fmt
}
