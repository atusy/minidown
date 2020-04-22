remove_math <- function(template) {
  math_start <- which(template == "$if(math)$")
  if (length(math_start) != 1L) {
    stop("template has been changed about $math$")
  }
  math_position <- seq(math_start, math_start + 2L)
  if (!identical(template[math_position[-1L]], c('  $math$', '$endif$'))) {
    stop("template has been changed about $math$")
  }
  template <- template[-math_position]
  template
}

body_as_article <- function(template) {
  template[template == "$body$"] <- "<article>\n$body$\n</article>"
  template
}

update_template <- function(dev = TRUE) {
  path <- if (dev) {
    "./inst/rmarkdown/templates/mini_document/default.html"
  } else {
    path_mini_document('default.html')
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

