spec_pre_processor <- function(
  code_download_html = NULL,
  math = "katex_serverside"
) {
  force(code_download_html)
  force(math)

  function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    katex <- if (identical(math, "katex")) {
      if (identical(runtime, "static")) {
        c(
          "--include-in-header",
          path_mini_resources("html", "katex", "partial.html")
        )
      } else {
        msg <- c(
          "When using non-static runtime, ",
          'math should be "katex_serverside" rather than "katex".'
        )
        if (is.null(metadata$runtime)) stop(msg)
        warning(msg, ' Falling back to "katex_serverside"')
        NULL
      }
    }

    code_download <- if (!is.null(code_download_html)) {
      c("--include-before", code_download_html)
    }

    return(c(katex, code_download))
  }
}
