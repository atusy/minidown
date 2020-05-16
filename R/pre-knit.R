spec_pre_knit <- function(code_download_html = NULL) {
  if (is.null(code_download_html)) return(NULL)
  function(input, ...) {
    writeLines(
      htmltools::renderTags(download_rmd_button(input, align = "right"))$html,
      code_download_html
    )
  }
}
