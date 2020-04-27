#' Resolve code folding conditions
#' @noRd
#' @inheritParams mini_document
fold <- function(code_folding = c("none", "show", "hide")) {
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
