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

minidown_meta <- new.env()

hook_start_results_folding <- function(knit_hook_source = NULL) {
  base_hook <- if (is.null(knit_hook_source)) {
    knitr::render_markdown()
    knitr::knit_hooks$get("source")
  } else {
    knit_hook_source
  }

  function(x, options) {
    # knit_hooks$set(source = start_results_folding(results_folding))
    base_source <- base_hook(x, options)
    if (is.null(options$results.folding)) {
      return(base_source)
    }

    opening <- c(
        show = " open", hide = ""
      )[match.arg(options$results.folding, c("show", "hide"))]
    summary <- if (is.null(options$summary.results)) {
        "Results"
      } else {
        options$results.summary
      }

    result <- paste0(
      if (identical(minidown_meta$chunk_label, options$label)) {
        "`</details>`{=html}\n\n"
      } else {
        ""
      },
      base_source,
      sprintf(
        "\n\n`<details%s class='chunk-results'><summary>%s</summary>`{=html}\n\n",
        opening,
        summary
      )
    )

    minidown_meta$chunk_label <- options$label

    result
  }
}

hook_end_results_folding <- function() function(options, before) {
  # knit_hooks$set(results_folding = end_results_folding(results_folding))
  if (!before) {
    return("\n\n`</details>`{=html}\n\n")
  }
}
