#' Specify pandoc_args
#' @noRd
spec_pandoc_args <- function(pandoc_args = NULL,
                             html5 = TRUE,
                             math = "katex_serverside") {

  lua <- if (check_pandoc_version(minimum = "2.0.0", recommend = "2.7.2")) {
    if (html5) {
      dir(path_mini_resources("lua"), pattern = "\\.lua$", full.names = TRUE)
    } else {
      path_mini_resources("lua", "code-folding.lua")
    }
  } else {
    character(0L)
  }

  c(
    pandoc_args,
    c(rbind(rep_len("--lua-filter", length(lua)), lua)),
    if (!is.null(math)) "--mathjax"
  )
}
