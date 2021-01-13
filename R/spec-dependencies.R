#' Specify extra dependencies
#' @noRd
spec_dependencies <- function(extra_dependencies = NULL,
                              html5 = TRUE,
                              framework = "sakura",
                              theme = "default",
                              tabset = FALSE,
                              toc_float = FALSE,
                              toc_highlight = FALSE) {
  if (!html5) {
    return(extra_dependencies)
  }

  version = utils::packageVersion(pkg)

  c(
    list(
      html_dependency_framework(framework, theme),
      htmltools::htmlDependency(
        name = pkg,
        version = version,
        src = path_mini_resources("html", "styles"),
        stylesheet = c(
          paste0(framework, ".css"),
          if (framework != "mini") c("feat-tooltip.css", "feat-accordion.css"),
          "common.css",
          if (toc_float) "feat-toc-float.css"
        ),
        all_files = FALSE
      )
    ),
    if (tabset) {list(htmltools::htmlDependency(
      name = "tabset",
      version = version,
      src = path_mini_resources("html", "tabset"),
      script = "tabset.js",
      stylesheet = "tabset.css"
    ))},
    if (toc_float && toc_highlight) {list(htmltools::htmlDependency(
        name = "highlightToC",
        version = version,
        src = path_mini_resources("html", "highlightToC"),
        script = "highlightToC.js"
    ))},
    extra_dependencies
  )
}
