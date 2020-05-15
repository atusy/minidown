spec_pre_knit <- function(code_download_html = NULL) {
  if (is.null(code_download_html)) return(NULL)
  function(input, ...) {
    writeLines(
      htmltools::renderTags(
        htmltools::tags$aside(
          htmltools::tags$button(
            xfun::embed_file(input, text = "Download Rmd", class = "button")
          )
        )
      )$html,
      code_download_html
    )
  }
}
