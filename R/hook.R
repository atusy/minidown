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

spec_opts_hooks <- function(code_folding) {
  folding <- fold(code_folding)
  list(
    class.source = hook_code_class("source", folding["source"]),
    class.output = hook_code_class("output", folding["output"]),
    class.message = hook_code_class("message", folding["message"]),
    class.warning = hook_code_class("warning", folding["warning"]),
    class.error = hook_code_class("error", folding["error"])
  )
}
