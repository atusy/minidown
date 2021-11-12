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
  if (!html5) {
    return(extra_dependencies)
  }

  version = utils::packageVersion(pkg)
  with_framework = framework != "none"
  all_frameworks = framework == "all"

  c(
    list(html_dependency_theme(
      framework,
      theme,
      tabset = tabset,
      toc_float = toc_float,
      ...
    )),
    if (tabset) {list(htmltools::htmlDependency(
      name = "tabset",
      version = version,
      src = path_mini_resources("html", "tabset"),
      script = "tabset.js",
      all_files = FALSE
    ))},
    if (toc_float && toc_highlight) {list(htmltools::htmlDependency(
        name = "highlightToC",
        version = version,
        src = path_mini_resources("html", "highlightToC"),
        script = list(src = "highlightToC.js", defer = NA)
    ))},
    extra_dependencies
  )
}
