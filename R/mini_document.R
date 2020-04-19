hook_class = function(type, code_folding = c('none', 'show', 'hide')) {
  force(type)
  details <- list(
    none = NULL, show = c('details', 'open'), hide = 'details'
  )[[match.arg(code_folding)]]
  class_type = paste0('class.', type)
  function(options) {
    options[[class_type]] <- c(
      options[[class_type]],
      'source',
      details
    )
    print(options[[class_type]])
    options
  }
}

#' Convert to an HTML document powered by the 'mini.css' framework.
#' @param ... Arguments passed to `rmarkdown::html_document`
#' @inheritParams rmarkdown::html_document
#' @export
mini_document <- function(
  code_folding =  c('none', 'show', 'hide'),
  pandoc_args = NULL,
  keep_md = FALSE,
  includes = list(),
  ...
) {
  folding <- match.arg(code_folding)
  dir_template <- system.file("rmarkdown", "templates", "html5_document", package = "minidown")
  lua <- dir(dir_template, pattern = '\\.lua$', full.names = TRUE)
  pandoc_args_lua <- c(rbind(rep_len('--lua', length(lua)), lua))
  includes$in_header <- c(includes$in_header, file.path(dir_template, 'head.html'))

  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options(
        opts_chunk = list(
          class.source = '', class.message = '', class.warning = '', class.error =''
        ),
        opts_hooks = list(
          class.source = hook_class('source', folding),
          class.message = hook_class('message'),
          class.warning = hook_class('warning'),
          class.error = hook_class('error')
        )
      ),
    pandoc = NULL,
    keep_md = keep_md,
    base_format = rmarkdown::html_document(
      theme = NULL,
      pandoc_args = c(pandoc_args, pandoc_args_lua),
      includes = includes,
      ...
    )
  )
}
