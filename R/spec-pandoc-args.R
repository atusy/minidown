#' Specify pandoc_args
#' @noRd
spec_pandoc_args <- function(pandoc_args = NULL,
                             html5 = TRUE,
                             katex = TRUE,
                             footnote_tooltip = FALSE) {
  lua <- if (check_pandoc_version(minimum = "2.0.0", recommend = "2.7.2")) {
    path_mini_resources(
      "lua",
      c(
        if (html5) "tooltip.lua",
        if (footnote_tooltip) "footnote-tooltip.lua",
        "code-folding.lua"
      )
    )
  }

  c(
    pandoc_args,
    c(rbind(rep_len("--lua-filter", length(lua)), lua)),
    if (katex) "--mathjax"
  )
}

