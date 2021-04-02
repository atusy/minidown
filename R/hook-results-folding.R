minidown_meta <- new.env()

no_linebreaks <- function(x) {
  if (grepl("\n", x)) {
    warning("Removing `\\n` from `results.summary` chunk option.")
    x <- gsub("\n", "", x)
  }

  x
}

as_raw_html <- function(x) {
  sprintf("\n\n```{=html}\n%s\n```\n\n", x)
}
results_folding_start <- '<details%s class="chunk-results"><summary>%s</summary>'
results_folding_end <- "</details>"
results_folding_start_escaped <- as_raw_html(results_folding_start)
results_folding_end_escaped <- as_raw_html(results_folding_end)

hook_start_results_folding <- function(
  knit_hook_source = knitr::knit_hooks$get("source")
) {
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
      no_linebreaks(options$results.summary)
    }

    result <- paste0(
      if (identical(minidown_meta$chunk_label, options$label)) {
        results_folding_end_escaped
      } else {
        ""
      },
      base_source,
      sprintf(results_folding_start_escaped, opening, summary)
    )

    minidown_meta$chunk_label <- options$label

    result
  }
}

hook_end_results_folding <- function() function(options, before) {
  # knit_hooks$set(results_folding = end_results_folding(results_folding))
  if (!before) {
    minidown_meta$chunk_label <- NULL
    return(results_folding_end_escaped)
  }
}


#' Folding chunk results in R Markdown documents
#'
#' The folding covers entire results including figures and tables. Note that
#' this feature only works with HTML outputs.
#'
#' @param results_folding Setup results folding by a string, `"none"`, `"show"`,
#'  or `"hide"`. If `"none"`, the feature appears to be disabled, however,
#'  can be opt-in per chunk by specifying `"show"` or `"hide"` on the
#'  `results.folding` chunk option.
#' @param knit_hook_source A base hook for the source. By default, the function
#'  seeks for the current hook and overlay it.
#'
#' @return Invisible `NULL`
#'
#' @examples
#' set_results_folding()
#'
#' # New hooks
#' knitr::knit_hooks$get()[c("source", "results.folding")]
#'
#' @noRd
set_results_folding <- function(
  results_folding = c("none", "show", "hide"),
  knit_hook_source = knitr::knit_hooks$get("source")
) {
  results_folding = match.arg(results_folding)
  knitr::opts_chunk$set(
    results.folding = if (results_folding != "none") results_folding
  )
  knitr::knit_hooks$set(
    source = hook_start_results_folding(
      knit_hook_source = knitr::knit_hooks$get("source")
    ),
    results.folding = hook_end_results_folding()
  )

  invisible(NULL)
}
