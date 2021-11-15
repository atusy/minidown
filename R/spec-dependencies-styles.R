as_scss <- function(x) {
  if (grepl("\\.scss$", x)) return(x)
  scss <- tempfile(fileext = ".scss")
  file.copy(x, scss)
  return(scss)
}

process_sass <- function(
  framework,
  theme,
  toc_float = FALSE,
  tabset = FALSE,
  ...
) {
  inputs <- c(
    as_scss(path_mini_frameworks(framework, theme)),
    path_mini_resources("html", "styles", c(
      if (length(framework) != 0L) c(
        paste0(framework, ".scss"), "common.scss",
        if (framework != "mini") "feat-tooltip.scss"
      ),
      if (toc_float) "feat-toc-float.scss"
    )),
    if (tabset) path_mini_resources("html", "tabset", "tabset.scss")
  )
  sass::sass(lapply(inputs, sass::sass_file), ...)
}

choose_frameworks <- function(framework) {
  if (is.null(framework)) return(list(name = NULL))
  if (identical(framework, "all")) return(rev(frameworks))
  if (identical(framework, "default")) return(framework[1L])
  frameworks[match.arg(framework, names(frameworks))]
}

choose_themes <- function(framework, theme) {
  if (is.null(framework)) return(c(vanilla = NA_character_))

  themes <- frameworks[[framework]][["stylesheet"]]
  if (identical(theme, "all")) return(themes)
  if (identical(theme, "default")) return(themes[1L])
  themes[match.arg(theme, names(themes))]
}

html_dependency_theme <- function(
  framework = "sakura",
  theme = "default",
  toc_float = FALSE,
  tabset = FALSE,
  args_htmlDependency = list(),
  src = tempfile(),
  ...
) {
  dir.create(src, showWarnings = FALSE)
  if (framework == "all") theme <- "all"
  for (.framework in choose_frameworks(framework)) {
    .themes <- choose_themes(.framework[["name"]], "all")
    stylesheet <- paste0(.framework[["name"]], "-", names(.themes), ".css")
    for (i in seq_along(.themes)) {
      process_sass(
        framework = .framework[['name']],
        theme = .themes[i],
        toc_float = toc_float,
        tabset = tabset,
        output = file.path(src, stylesheet[i]),
        ...
      )
    }
  }
  do.call(
    function(...) {
      htmltools::htmlDependency(
        name = "minidown",
        version = packageVersion("minidown"),
        src = src,
        meta = frameworks[[framework]][["meta"]],
        stylesheet = stylesheet[[1L]],
        all_files = "all" %in% c(framework, theme),
        ...
      )
    },
    args_htmlDependency
  )
}
