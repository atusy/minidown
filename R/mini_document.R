default_summary <- c(
  "source" = "Source", "output" = "Output",
  "message" = "Message", "warning" = "Warning", "error" = "Error"
)

default_folding <- c(
  source = "none",
  output = "none",
  message = "none",
  warning = "none",
  error = "none"
)

hook_code_class <- function(type, code_folding = c("none", "show", "hide")) {
  force(type)
  details <- list(
    none = NULL, show = c("details", "show"), hide = "details"
  )[[match.arg(code_folding)]]
  class_type <- paste0("class.", type)
  attr_type <- paste0("attr.", type)
  summary_type <- paste0("summary.", type)

  function(options) {
    .class <- c(options[[class_type]], paste0("chunk-", type), details)
    .attr <- options[[attr_type]]
    if ((code_folding == "show") && any(grepl('(^| )\\.?hide( |$)', .class))) {
      .class <- .class[.class != "show"]
    }
    if ("details" %in% .class) {
      summary <- paste0(
        "summary='",
        if (is.null(options[[summary_type]])) {
          default_summary[type]
        } else {
          options[[summary_type]]
        },
        "'"
      )
      .attr <- c(.attr, summary)
    }
    options[[class_type]] <- .class
    options[[attr_type]] <- .attr
    options
  }
}



fold <- function(code_folding = c("none", "show", "hide")) {
  folding <- default_folding

  if (is.character(code_folding)) {
    folding["source"] <- match.arg(code_folding, c("none", "show", "hide"))
    return(folding)
  }

  if (is.null(names(code_folding)) || !is.list(code_folding)) {
    stop("`code_folding` must be a string or a named list.")
  }


  for (nm in names(code_folding)) {
    folding[nm] <- code_folding[[nm]]
  }
  return(folding)
}


#' Convert to an HTML document powered by the 'mini.css' framework.
#' @param ... Arguments passed to `rmarkdown::html_document`
#' @inheritParams rmarkdown::html_document
#' @export
mini_document <- function(
                          code_folding = c("none", "show", "hide"),
                          pandoc_args = NULL,
                          keep_md = FALSE,
                          includes = list(),
                          ...) {
  folding <- fold(code_folding)
  dir_template <-
    system.file("rmarkdown", "templates", "mini_document", package = "minidown")
  css_dependency <- htmltools::htmlDependency(
    "style", "0.0.1", dir_template,
    stylesheet = "style.css"
  )

  lua <- dir(dir_template, pattern = "\\.lua$", full.names = TRUE)
  pandoc_args_lua <- c(rbind(rep_len("--lua", length(lua)), lua))
  includes$in_header <-
    c(includes$in_header, file.path(dir_template, "head.html"))

  rmarkdown::output_format(
    knitr = rmarkdown::knitr_options(
      opts_chunk = list(
        class.source = "", class.output = "",
        class.message = "", class.warning = "", class.error = ""
      ),
      opts_hooks = list(
        class.source = hook_code_class("source", folding["source"]),
        class.output = hook_code_class("output", folding["output"]),
        class.message = hook_code_class("message", folding["message"]),
        class.warning = hook_code_class("warning", folding["warning"]),
        class.error = hook_code_class("error", folding["error"])
      )
    ),
    pandoc = NULL,
    keep_md = keep_md,
    base_format = rmarkdown::html_document(
      theme = NULL,
      pandoc_args = c(pandoc_args, pandoc_args_lua),
      includes = includes,
      extra_dependencies = list(css_dependency),
      ...
    )
  )
}
