defaults <- list(
  code_folding = list(
    source = "show", output = "show", message = "hide", warning = "hide"
  ),
  toc = TRUE, toc_float = TRUE,
  self_contained = TRUE, lib_dir = "../docs/resources"
)

framework = c(
  sakura = "index.html",
  water = "water.html",
  mini = "mini.html"
)

Map(
  function(output_file, framework) {
    rmarkdown::render(
      "example/index.Rmd",
      do.call(
        minidown::mini_document,
        dplyr::glimpse(c(defaults, list(framework = framework)))
      ),
      output_file = file.path("../docs", output_file)
    )
  },
  output_file = framework,
  framework = names(framework)
)

file.copy("example/index.Rmd", "docs/index.Rmd", overwrite = TRUE)

if (interactive()) browseURL("docs/index.html")
