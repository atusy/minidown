spec_knit_hooks <- function(base_format = list(), result_folding = c("none", "show", "hide")) {
  result_folding = match.arg(result_folding)
  if (result_folding == "none") return(NULL)

  list(
    source = hook_start_result_folding(base_format),
    result.folding = hook_end_result_folding()
  )
}
