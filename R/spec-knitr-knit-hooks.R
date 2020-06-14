spec_knit_hooks <- function(
    knit_hook_source = NULL, results_folding = c("none", "show", "hide")
) {
  results_folding = match.arg(results_folding)
  if (results_folding == "none") return(NULL)

  list(
    source = hook_start_results_folding(knit_hook_source),
    results.folding = hook_end_results_folding()
  )
}
