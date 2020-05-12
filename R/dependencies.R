#' Specify extra dependencies
#' @noRd
spec_dependencies <- function(extra_dependencies = NULL,
                              toc_float = FALSE,
                              html5 = TRUE,
                              framework = "sakura",
                              theme = "default") {
  if (!html5) {
    return(extra_dependencies)
  }

  c(
    list(
      html_dependency_framework(framework, theme),
      htmltools::htmlDependency(
        name = pkg,
        version = utils::packageVersion(pkg),
        src = path_mini_resources("css"),
        stylesheet = c(
          paste0(framework, ".css"),
          if (framework != "mini") c("feat-tooltip.css", "feat-accordion.css"),
          "common.css",
          if (toc_float) "feat-toc-float.css"
        ),
        all_files = FALSE
      )
    ),
    extra_dependencies
  )
}
