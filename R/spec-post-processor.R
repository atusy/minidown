spec_post_processor <- function(results_folding = c("none", "show", "hide")) {
  results_folding <- match.arg(results_folding)

  if (results_folding == "none") {
    return(NULL)
  }

  results_folding_blank <- paste0(
    "\n",
    sprintf(results_folding_start, "( open)?", "[^\n]*"),
    "\n*",
    results_folding_end,
    "\n"
  )

  function(metadata, input_file, output_file, clean, verbose) {
    output <- xfun::read_utf8(output_file)

    # Remove blank results_folding
    output <- gsub(results_folding_blank, "", paste(output, collapse = "\n"))
    cat(output)

    # finalize
    xfun::write_utf8(output, output_file)
    return(output_file)
  }
}
