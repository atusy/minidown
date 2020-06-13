spec_opts_chunk <- function(results_folding = c("none", "show", "hide")) {
  opts <- default_opts_chunk

  results_folding <- match.arg(results_folding)
  if (results_folding == "none") return(opts)

  opts$results.folding = results_folding
  opts
}
