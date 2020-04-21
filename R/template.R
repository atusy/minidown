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

  pos = which(template == "$if(math)$")
  template <- template[-seq(pos, pos + 2L)]
  writeLines(template, path)


  path
}

