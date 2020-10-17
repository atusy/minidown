spec_opts_chunk <- function(results_folding = c("none", "show", "hide")) {
  options = list()

  results_folding <- match.arg(results_folding)
  if (results_folding != "none") {
    options$results.folding <- results_folding
  }

  options
}
