spec_opts_chunk <- function(result_folding = c("none", "show", "hide")) {
  opts <- default_opts_chunk

  result_folding <- match.arg(result_folding)
  if (result_folding == "none") return(opts)

  opts$result.folding = result_folding
  opts
}
