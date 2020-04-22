mini_depends <- function(extra_dependencies = NULL,
                         mini = TRUE,
                         toc_float = FALSE) {
  if (!mini) return(extra_dependencies)
  c(
    list(
      htmltools::htmlDependency(
        "minicss", "3.0.1",
        path_minicss(), stylesheet = "mini-default.min.css",
        meta = list(viewport = "width=device-width, initial-scale=1")
      ),
      htmltools::htmlDependency(
        "minidown", packageVersion("minidown"),
        path_mini_document(), stylesheet = "style.css"
      )
    ),
    if (toc_float) {
      list(htmltools::htmlDependency(
        "minidown", packageVersion("minidown"),
        path_mini_document(), stylesheet = "toc-float.css"
      ))
    },
    extra_dependencies
  )
}

mini_pandoc_args <- function(pandoc_args = NULL) {
  lua <- dir(path_mini_document(), pattern = "\\.lua$", full.names = TRUE)
  c(pandoc_args, c(rbind(rep_len("--lua", length(lua)), lua)), '--mathjax')
}

mini_template <- function(template, mini) {
  if (mini && identical(template, "default")) {
    return(path_mini_document('default.html'))
  }
  template
}

mini_includes <- function(includes, mini) {
  if (mini) {
    includes$in_header <- c(
      includes$in_header,
      path_mini_document('math.html')
    )
  }
  includes
}

#' Convert to an HTML document powered by the 'mini.css' framework.
#' @param ... Arguments passed to `rmarkdown::html_document`
#' @inheritParams rmarkdown::html_document
#' @export
mini_document <- function(
                          code_folding = c("none", "show", "hide"),
                          pandoc_args = NULL,
                          keep_md = FALSE,
                          extra_dependencies = NULL,
                          theme = "mini",
                          includes = list(),
                          template = "default",
                          toc = FALSE,
                          toc_float = FALSE,
                          ...) {
  mini <- identical(theme, "mini")

  fmt <- rmarkdown::output_format(
    knitr = rmarkdown::knitr_options(
      opts_chunk = default_opts_chunk,
      opts_hooks = mini_opts_hooks(code_folding)
    ),
    pandoc = NULL,
    keep_md = keep_md,
    base_format = rmarkdown::html_document(
      theme = if (mini) NULL else theme,
      pandoc_args = mini_pandoc_args(pandoc_args),
      extra_dependencies =
        mini_depends(extra_dependencies, mini, toc_float),
      template = mini_template(template, mini),
      includes = mini_includes(includes, mini),
      toc = toc,
      toc_float = if (mini) FALSE else toc_float,
      ...
    )
  )

  post <- fmt$post_processor
  fmt$post_processor <-
    function(metadata, input_file, output_file, clean, verbose) {
      output <- readLines(output_file)
      math <- readLines(path_mini_document('katex.html'))
      position <- which(grepl(" *<!--math placeholder-->", output))[1L]
      writeLines(append(output, math, position)[-position], output_file)
      post(metadata, input_file, output_file, clean, verbose)
    }

  fmt
}
