#' Convert to an HTML document powered by the lightweight CSS framework.
#'
#' The output format is HTML5 in general. If `framework = "bootstrap"` is given,
#' the output format becomes HTML4 and comparable to `rmarkdown::html_document`
#' except for the behavior of the `code_folding` option.
#'
#' @param framework,theme A string to specify the name of a framework
#'  (default: `"sakura"`) and its theme (default: `"default"`).
#'  Note that `theme = "default"` is a special keyword which selects a theme
#'  defined as default internally. See `frameworks` for available light weight
#'  CSS frameworks and their themes.
#' @param toc_float TRUE to float the table of contents to the left of the main
#'  document content.
#' @param code_folding Setup code folding by a string or a named list.
#'  A choice for the string are `"none"` to disable,
#'  `"show"` to enable and show all by default), and
#'  `"hide"` to enable and hide all by default.
#'  If a named list, each element may have one of the above strings.
#'  Names are some of "source", "output", "message", "warning", and "error".
#'  If the list does not have some of the element with the above name,
#'  they are treated as `"none"`.
#' @param code_download If `TRUE` and `framework = "bootstrap"`, the output
#'  includes Rmd file itself and supplies download button of it.
#' @param math A string to specify math rendering engine (default: `"katex"`).
#'  If the value is other than `"katex"`, the result depends on the `framework`
#'  option. When the given `framework` is `"bootstrap"`, the `math` option is
#'  passed to the `mathjax` option of `rmarkdown::html_document`. Otherwise,
#'  pandoc's built-in feature renders math expressions to unicode characters.
#' @param template Pandoc template. If "default", the package's internal template
#'  is used. If a path, user's original template is used. If `NULL`, pandoc's
#'  internal template is used.
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
                          self_contained = TRUE,
                          math = "katex",
                          template = "default",
                          extra_dependencies = NULL,
                          includes = list(),
                          keep_md = FALSE,
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

  code_download_html <- if (code_download && html5) tempfile(fileext = ".html")

  rmarkdown::output_format(
    knitr = list(
      opts_chunk = default_opts_chunk,
      opts_hooks = spec_opts_hooks(code_folding)
    ),
    pandoc = list(to = "html5"),
    keep_md = keep_md,
    clean_supporting = self_contained,
    pre_knit = spec_pre_knit(code_download_html),
    pre_processor = spec_pre_processor(code_download_html),
    base_format = fmt
  )
}

