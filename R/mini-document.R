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
#' @param toc_highlight This is an experimental feature. `TRUE` highlights the
#'  table of contents according to the browser's viewport.
#' @param code_folding Setup code folding by a string or a named list.
#'  A choice for the string are `"none"` to disable,
#'  `"show"` to enable and show all by default), and
#'  `"hide"` to enable and hide all by default.
#'  If a named list, each element may have one of the above strings.
#'  Names are some of "source", "output", "message", "warning", and "error".
#'  If the list does not have some of the element with the above name,
#'  they are treated as `"none"`.
#' @param results_folding Setup results folding by a string, `"none"`, `"show"`,
#'  or `"hide"`. This feature will fold entire results, including side effects
#'  such as figures and tables.
#' @param tabset `TRUE` converts sections to tabs if they belong to the
#'  `tabset`-class section. The tabs inherit names from the corresponding
#'  sections. Unlike `rmarkdown::html_document`, the tabs can be navigated by
#'  table of contents, and can be shared by unique URLs. Note that
#'  `framework = "bootstrap"` falls back to the native feature of
#'  `rmarkdown::html_document`. This feature also requires `section_divs = TRUE`.
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
                          toc_highlight = FALSE,
                          section_divs = TRUE,
                          code_folding = c("none", "show", "hide"),
                          results_folding = c("none", "show", "hide"),
                          tabset = FALSE,
                          code_download = FALSE,
                          self_contained = TRUE,
                          math = "katex",
                          template = "default",
                          extra_dependencies = NULL,
                          includes = list(),
                          keep_md = FALSE,
                          pandoc_args = NULL,
                          ...) {
  framework <- match.arg(framework, c("bootstrap", names(frameworks), "all"))
  html5 <- framework != "bootstrap"
  katex <- identical(math, "katex")

  fmt <- rmarkdown::html_document(
    theme = if (html5) NULL else theme,
    pandoc_args = spec_pandoc_args(pandoc_args, html5, katex),
    extra_dependencies = spec_dependencies(
        extra_dependencies,
        html5 = html5,
        framework = framework,
        theme = theme,
        tabset = tabset && html5 && section_divs,
        toc_float = toc && toc_float,
        toc_highlight = toc_highlight
    ),
    template = spec_template(template, html5),
    includes = spec_includes(includes, katex),
    toc = toc,
    toc_float = !html5 && toc_float,
    code_folding = "none", # As minidown offers different approach
    code_download = code_download && !html5,
    mathjax = if (katex) NULL else math,
    self_contained = self_contained,
    keep_md = keep_md,
    ...
  )

  code_download_html <- if (code_download && html5) tempfile(fileext = ".html")

  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options(
      opts_chunk = spec_opts_chunk(results_folding),
      opts_hooks = spec_opts_hooks(code_folding),
      knit_hooks = spec_knit_hooks(
          knit_hook_source = fmt$knitr$knit_hooks$source,
          results_folding = results_folding
        )
    ),
    pandoc = if (html5) list(to = "html5"),
    keep_md = keep_md,
    clean_supporting = self_contained,
    pre_knit = spec_pre_knit(code_download_html),
    pre_processor = spec_pre_processor(code_download_html),
    post_processor = spec_post_processor(results_folding),
    base_format = fmt
  )
}
