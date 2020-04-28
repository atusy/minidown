#' Convert to an HTML document powered by the lightweight CSS framework.
#'
#' The output format is HTML5 except. When `framework = "bootstrap"` is
#' given, the output format is HTML4 and comparable to `rmarkdown::html_document`
#' except for the behavior of the `code_folding` option.
#'
#' @param framework,theme A string to specify the name of a framework
#'   (default: `"sakura"`) and its theme (default: `"default"`).
#'   Note that `theme = "default"` is a special keyword which selects a theme
#'   defined as default internally. See `frameworks` for available light weight
#'   CSS frameworks and their themes.
#' @param toc_float TRUE to float the table of contents to the left of the main
#'  document content.
#' @param code_folding Setup code folding by a string or a named list.
#'   A choice for the string are `"none"` to disable,
#'   `"show"` to enable and show all by default), and
#'   `"hide"` to enable and hide all by default.
#'   If a named list, each element may have one of the above strings.
#'   Names are some of "source", "output", "message", "warning", and "error".
#'   If the list does not have some of the element with the above name,
#'   they are treated as `"none"`.
#' @param code_download If `TRUE` and `framework = "bootstrap"`, the output
#' includes Rmd file itself and supplies download button of it.
#' @param math A string to specify math rendering engine (default: `"katex"`).
#'  If the value is other than `"katex"`, the result depends on the `framework`
#'  option. When the given `framework` is `"bootstrap"`, the `math` option is
#'  passed to the `mathjax` option of `rmarkdown::html_document`. Otherwise,
#'  Pandoc's built-in feature renders math expressions to unicode characters.
#' @param template Pandoc template. If "default", the package's internal template
#' is used. If a path, user's original template is used. If `NULL`, Pandoc's
#' internal template is used.
#' @inheritParams rmarkdown::html_document
#' @param ... Arguments passed to `rmarkdown::html_document`
#'
#' @examples
#' \dontrun{
#' library(rmarkdown)
#' library(minidown)
#' render("input.Rmd", mini_document)
#' }
#' @export
mini_document <- function(framework = "sakura",
                          theme = "default",
                          toc = FALSE,
                          toc_float = FALSE,
                          code_folding = c("none", "show", "hide"),
                          code_download = FALSE,
                          math = "katex",
                          extra_dependencies = NULL,
                          includes = NULL,
                          template = "default",
                          pandoc_args = NULL,
                          ...) {
  framework <- match.arg(framework, c("bootstrap", names(frameworks)))
  html5 <- framework != "bootstrap"
  katex <- identical(math, "katex")

  fmt <- rmarkdown::html_document(
    theme = if (html5) NULL else theme,
    pandoc_args = spec_pandoc_args(pandoc_args, html5, katex),
    extra_dependencies =
      spec_dependencies(extra_dependencies, toc_float, html5, framework, theme),
    template = spec_template(template, html5),
    includes = spec_includes(includes, katex),
    toc = toc,
    toc_float = !html5 && toc_float,
    code_folding = "none", # As minidown offers different approach
    code_download = code_download && !html5,
    mathjax = if (katex) NULL else math,
    ...
  )

  fmt$knitr$opts_chunk[names(default_opts_chunk)] <- default_opts_chunk
  fmt$knitr$opts_hooks <- spec_opts_hooks(code_folding)

  if (html5) fmt$pandoc$to <- "html5"

  fmt
}
