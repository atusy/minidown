#' Specify extra dependencies
#' @noRd
spec_dependencies <- function(extra_dependencies = NULL,
                              html5 = TRUE,
                              framework = "sakura",
                              theme = "default",
                              tabset = FALSE,
                              toc_float = FALSE,
                              toc_highlight = FALSE,
                              ...) {
  if (!html5) return(extra_dependencies)

  minidown_js <- c(
    if (tabset) "tabset/tabset.js",
    if (toc_float && toc_highlight) "highlightToC/highlightToC.js"
  )

  return(c(
    list(html_dependency_theme(
      framework,
      theme,
      tabset = tabset,
      toc_float = toc_float,
      ...
    )),
    if (length(minidown_js) != 0) {list(htmltools::htmlDependency(
      name = "minidown-js",
      version = utils::packageVersion(pkg),
      src = path_mini_resources("html"),
      script = minidown_js,
      all_files = FALSE
    ))},
    extra_dependencies
  ))
}
