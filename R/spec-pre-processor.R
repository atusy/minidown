spec_pre_processor <- function(code_download_html = NULL) {
  if (is.null(code_download_html)) {
    return(NULL)
  }
  function(
           metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    c("--include-before", code_download_html)
  }
}
