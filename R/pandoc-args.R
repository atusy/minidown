#' Specify pandoc_args
spec_pandoc_args <- function(pandoc_args = NULL,
                             html5 = TRUE,
                             katex = TRUE) {
  lua <- if (html5) {
    dir(path_mini_resources("lua"), pattern = "\\.lua$", full.names = TRUE)
  } else {
    path_mini_resources("lua", "code-folding.lua")
  }

  c(
    pandoc_args,
    c(rbind(rep_len("--lua", length(lua)), lua)),
    if (katex) "--mathjax"
  )
}
