#' Specify template
#' @noRd
spec_template <- function(template = "default",
                          html5 = TRUE) {
  if (html5 && identical(template, "default")) {
    return(path_mini_resources("templates", "mini_document", "default.html"))
  }
  template
}

