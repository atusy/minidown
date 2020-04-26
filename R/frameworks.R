#' Frameworks
#' @noRd
frameworks <- list(
  mini = list(
    name = "mini",
    version = "3.0.1",
    stylesheet = c(default = "mini-default.min.css"),
    meta = list(viewport = "width=device-width, initial-scale=1")
  ),
  sakura = list(
    name = "sakura",
    version = "1.1.0",
    stylesheet = c(
      default = "sakura.css"
    )
  ),
  water = list(
    name = "water",
    version = "1.4.0",
    stylesheet = c(
      light = "light.min.css"
    )
  )
)

html_dependency_framework <- function(framework, theme = "default") {
  arguments <- frameworks[[framework]]
  theme <- match.arg(theme, c("default", names(arguments$stylesheet)))
  arguments$src <- path_mini_resources("frameworks", framework)
  arguments$stylesheet <-
    arguments$stylesheet[[if (theme == "default") 1L else theme]]
  arguments$all_files <- FALSE
  do.call(htmltools::htmlDependency, arguments)
}
