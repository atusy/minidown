gen_hook_code_folding <- function(code_folding) {
  types <- names(code_folding)
  opts_class <- paste0("class.", types)
  opts_attr <- paste0("attr.", types)
  opts_summary <- paste0("summary.", types)
  details_dict <- list(
    none = NULL, show = c("details", "show"), hide = "details")
  details <- lapply(code_folding, function(x) details_dict[[x]])
  summaries <- ifelse(code_folding == "none", list(NULL), default_summary)

  function(options) {
    options[opts_class] <- Map(code_folding_class, options[opts_class], details)
    options[opts_attr] <- Map(
      code_folding_attr, options[opts_attr], summaries, options[opts_summary])
    options
  }
}

#' Add classes to a code block
#' @noRd
code_folding_class <- function(base, additions) {
  is_show <- additions == "show"
  c(
    base,
    if (any(is_show) && (any(grepl("(^| )\\.?hide( |$)", base)))) {
      additions[!is_show]
    } else {
      additions
    }
  )
}

#' Add a summary to a code block
#' @noRd
code_folding_attr <- function(base, default, specified = NULL) {
  c(
    base,
    sprintf("summary='%s'", if (is.null(specified)) default else specified)
  )
}

#' Resolve code folding conditions
#'
#' @param code_folding
#'  - A string of none, show, or hide.
#'  - A named list
#'    whose names are subset of source, output, message, warning, and error,
#'    and
#'    whose values are a string of none, show, or hide.
#'
#' @return A character vector with 5 elements. Each elements are one of none,
#' show, or hide. The vector is named by and ordered by source, output, message,
#' warning, and error.
#'
#' @noRd
#' @inheritParams mini_document
code_folding_options <- function(code_folding = c("none", "show", "hide")) {
  folding <- default_folding
  .names <- names(code_folding)

  if (is.character(code_folding)) {
    folding["source"] <- match.arg(code_folding, c("none", "show", "hide"))
    return(folding)
  }

  if (is.null(.names) || !is.list(code_folding)) {
    stop("`code_folding` must be a string or a named list.")
  }


  for (nm in .names) {
    folding[nm] <- code_folding[[nm]]
  }
  return(folding)
}
