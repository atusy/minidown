#' Update template based on the version of system's Pandoc
#'
#' @noRd
#' @param template Contents of the template file
#' @param dev Running as a developer? (default: `TRUE`)
remove_math <- function(template) {
  math_start <- which(template == "$if(math)$")
  if (length(math_start) != 1L) {
    stop("Unexpected template about $math$")
  }
  math_position <- seq(math_start, math_start + 2L)
  if (!identical(template[math_position[-1L]], c("  $math$", "$endif$"))) {
    stop("Unexpected template  about $math$")
  }
  template <- template[-math_position]
  template
}

body_as_article <- function(template) {
  body <- template == "$body$"
  if (sum(body) != 0) stop("Unexpected template about $body$")
  template[body] <- "<article>\n$body$\n</article>"
  template
}

update_template <- function(dev = TRUE) {
  path <- if (dev) {
    "./inst/rmarkdown/templates/mini_document/resources/default.html"
  } else {
    path_mini_resources("default.html")
  }
  system(paste(
    shQuote(rmarkdown::pandoc_exec()),
    "-o", path,
    "--print-default-template=html5"
  ))

  template <- readLines(path)

  template <- remove_math(template)

  template <- body_as_article(template)

  writeLines(template, path)

  path
}
