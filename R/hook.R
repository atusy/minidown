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


hook_start_result_folding <- function(base_format = list()) {
  base_hook <- if (is.null(base_format$knitr$knit_hooks$source)) {
    knitr::render_markdown()
    knitr::knit_hooks$get("source")
  } else {
    base_format$knitr$knit_hooks$source
  }

  function(x, options) {
    # knit_hooks$set(source = start_result_folding(result_folding))
    if (is.null(options$result.folding)) {
      return(x)
    }

    opening <- c(
        show = " open", hide = ""
      )[match.arg(options$result.folding, c("show", "hide"))]
    summary <- if (is.null(options$result.summary)) {
        "Results"
      } else {
        options$result.summary
      }

    paste0(
      base_hook(x, options),
      sprintf(
        "\n\n`<details%s class='chunk-results'><summary>%s</summary>`{=html}",
        opening,
        summary
      )
    )
  }
}

hook_end_result_folding <- function() function(options, before) {
  # knit_hooks$set(result.folding = end_result_folding(result_folding))
  if ((options$result.folding != "none") && !before) {
    return("`</details>`{=html}")
  }
}
