#' Generate arguments to rmarkdown::html_document
#'
#' @noRd
#'
#' @param html5 Using HTML5 (`TRUE` or `FALSE`)?
#' @inheritParams rmarkdown::html_document
NULL

spec_dependencies <- function(extra_dependencies = NULL,
                              toc_float = FALSE,
                              html5 = TRUE,
                              framework = "water",
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
          if (toc_float) "feat-toc-float.css"
        ),
        all_files = FALSE
      )
    ),
    extra_dependencies
  )
}

spec_pandoc_args <- function(pandoc_args = NULL,
                             html5 = TRUE,
                             katex = TRUE) {
  lua <- if (html5) {
    dir(path_mini_resources("lua"), pattern = "\\.lua$", full.names = TRUE)
  } else {
    path_mini_resources("lua", "code-folding.lua")
  }

  c(
    pandoc_args,
    c(rbind(rep_len("--lua", length(lua)), lua)),
    if (katex) "--mathjax"
  )
}

spec_template <- function(template = "default",
                          html5 = TRUE) {
  if (html5 && identical(template, "default")) {
    return(path_mini_resources("default.html"))
  }
  template
}

spec_includes <- function(includes = list(),
                          katex = TRUE) {
  if (katex) {
    includes$in_header <- c(
      includes$in_header,
      path_mini_resources("html", "math-katex.html")
    )
  }
  includes
}
