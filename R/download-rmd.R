#' Generate an HTML widget to download input Rmd file
#'
#' The button can self-contain the input data by base64 encoding.
#'
#' @param input Filename of the input. If `NULL`, the function automatically
#'  detects the name of the knitting Rmd file.
#' @inheritParams xfun::embed_file
#' @param ... Arguments passed to the `embed` function.
#' @param align Align the button by CSS's `text-align` attribute.
#'  This feature is disabled when aside is `FALSE`
#' @param embed A function to embed file(s).
#'  One of `xfun::embed_file`, `xfun::embed_files`, or `xfun::embed_dir`.
#'
#' @return `shiny.tag` class object.
#'
#' @examples
#' input <- tempfile()
#' download_rmd_button(input)
#'
#' input <- tempdir()
#' download_rmd_button(input, embed = xfun::embed_dir)
#'
#' @export
download_rmd_button <- function(input = NULL,
                                text = "Download Rmd",
                                ...,
                                align = "right",
                                class = "button",
                                aside = TRUE,
                                embed = xfun::embed_file
) {
  if (is.null(input)) {
    input <- knitr::current_input()
    if (is.null(input)) stop("Auto detection of the input file failed.")
  }

  button <- embed(input, text = text, class = class, ...)

  if (!aside) return(button)

  htmltools::tags$aside(button, style = paste0("text-align:", align))
}
