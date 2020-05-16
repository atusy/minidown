#' Knitr's hooks
#'
#' @noRd
#' @param type One of source, output, message, warning, error
#' @inheritParams rmarkdown::html_document
hook_code_class <- function(type, code_folding = c("none", "show", "hide")) {
  force(type)
  details <- list(
    none = NULL, show = c("details", "show"), hide = "details"
  )[[match.arg(code_folding)]]
  class_type <- paste0("class.", type)
  attr_type <- paste0("attr.", type)
  summary_type <- paste0("summary.", type)

  function(options) {
    .class <- c(options[[class_type]], paste0("chunk-", type), details)
    .attr <- options[[attr_type]]
    if ((code_folding == "show") && any(grepl("(^| )\\.?hide( |$)", .class))) {
      .class <- .class[.class != "show"]
    }
    if ("details" %in% .class) {
      summary <- paste0(
        "summary='",
        if (is.null(options[[summary_type]])) {
          default_summary[type]
        } else {
          options[[summary_type]]
        },
        "'"
      )
      .attr <- c(.attr, summary)
    }
    options[[class_type]] <- .class
    options[[attr_type]] <- .attr
    options
  }
}
