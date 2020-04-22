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
        path_mini_document("css"),
        stylesheet = c("style.css", if (toc_float) "toc-float.css")
      )
    ),
    extra_dependencies
  )
}

mini_pandoc_args <- function(pandoc_args = NULL, mini) {
  lua <- dir(path_mini_document("lua"), pattern = "\\.lua$", full.names = TRUE)
  c(
    pandoc_args,
    c(rbind(rep_len("--lua", length(lua)), lua)),
    if (mini) '--mathjax'
  )
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

mini_post_processor <- function(post) {
  force(post)
  function(metadata, input_file, output_file, clean, verbose) {
    output <- readLines(output_file)
    math <- readLines(path_mini_document('katex.html'))
    position <- which(grepl(" *<!--math placeholder-->", output))[1L]
    writeLines(append(output, math, position)[-position], output_file)
    post(metadata, input_file, output_file, clean, verbose)
  }
}

#' Convert to an HTML document powered by the 'mini.css' framework.
#' @param ... Arguments passed to `rmarkdown::html_document`
#' @inheritParams rmarkdown::html_document
#' @export
mini_document <- function(
                          code_folding = c("none", "show", "hide"),
                          pandoc_args = NULL,
                          extra_dependencies = NULL,
                          theme = "mini",
                          includes = list(),
                          template = "default",
                          toc = FALSE,
                          toc_float = FALSE,
                          ...) {
  mini <- identical(theme, "mini")

  fmt <- rmarkdown::html_document(
    theme = if (mini) NULL else theme,
    pandoc_args = mini_pandoc_args(pandoc_args, mini),
    extra_dependencies = mini_depends(extra_dependencies, mini, toc_float),
    template = mini_template(template, mini),
    includes = mini_includes(includes, mini),
    toc = toc,
    toc_float = !mini && toc_float,
    ...
  )

  fmt$opts_hooks <- mini_opts_hooks(code_folding)

  fmt$post_processor <- mini_post_processor(fmt$post_processor)

  fmt
}
