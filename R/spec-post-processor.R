spec_post_processor <- function(
  results_folding = c("none", "show", "hide"),
  math = "katex_serverside"
) {
  results_folding <- match.arg(results_folding)

  function(metadata, input_file, output_file, clean, verbose) {
    output <- if (
      identical(math, "katex_serverside") ||
      (identical(math, "katex") &&
       !is.null(metadata$runtime) &&
       !identical(metadata$runtime, "static"))
    ) {
      katex::render_math_in_html(output_file)
    } else {
      xfun::read_utf8(output_file)
    }

    # Remove blank results_folding
    if (!identical(results_folding, "none")) {
      results_folding_blank <- paste0(
        "\n",
        sprintf(results_folding_start, "( open)?", "[^\n]*"),
        "\n*",
        results_folding_end,
        "\n"
      )
      output <- gsub(results_folding_blank, "", paste(output, collapse = "\n"))
    }

    # finalize
    xfun::write_utf8(output, output_file)
    return(output_file)
  }
}
