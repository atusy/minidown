#' Lightweight CSS frameworks meta data
#'
#' To see the names of the frameworks, run `names(frameworks)`.
#' To see the names of themes of a framework, say `"mini"`, run
#' `names(frameworks$mini$stylesheet)`
#'
#' @docType data
#' @format A list
#' @export
frameworks <- list(
  # First element is the default
  sakura = list(
    name = "sakura",
    version = "1.1.0",
    stylesheet = c(
      default = "sakura.css",
      dark_solarized = "sakura-dark-solarized.css",
      dark = "sakura-dark.css",
      earthly = "sakura-earthly.css",
      vader = "sakura-vader.css"
    )
  ),
  spcss = list(
    name = "spcss",
    version = "0.6.0",
    stylesheet = c(
      "spcss" = "spcss.min.css"
    )
  ),
  water = list(
    name = "water",
    version = "1.4.0",
    stylesheet = c(
      light = "light.min.css",
      dark = "dark.min.css"
    )
  ),
  mini = list(
    name = "mini",
    version = "3.0.1",
    stylesheet = c(
      default = "mini-default.min.css",
      nord = "mini-nord.min.css",
      dark = "mini-dark.min.css"
    ),
    meta = list(viewport = "width=device-width, initial-scale=1")
  )
)

default_framework <- names(frameworks)[[1L]]

html_dependency_framework <- function(framework = "sakura",
                                      theme = "default",
                                      all_files = FALSE) {
  if (framework == "all") {
    deps <- lapply(
      names(frameworks),
      function(framework) {
        dep <- html_dependency_framework(framework, all_files = TRUE)[[1L]]
        if (framework != default_framework) {
          dep$stylesheet <- NULL
        }
        dep
      }
    )

    return(deps)
  }
  arguments <- frameworks[[framework]]
  theme <- match.arg(theme, c("default", names(arguments$stylesheet)))
  arguments$src <- path_mini_frameworks(framework)
  arguments$stylesheet <-
    arguments$stylesheet[[if (theme == "default") 1L else theme]]
  arguments$all_files <- all_files
  list(do.call(
    htmltools::htmlDependency,
    arguments[names(arguments) %in% names(formals(htmltools::htmlDependency))]
  ))
}
