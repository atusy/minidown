check_pandoc_version <- function(minimum = "2.0.0", recommend = "2.7.2") {
  if(!rmarkdown::pandoc_available(minimum)) {
    warning("minidown supports Pandoc >=", recommend, ", ",
            "but system uses Pandoc < 2.0 which is too old.")
    return(FALSE)
  }

  if (!rmarkdown::pandoc_available(recommend)) {
    warning("minidown supports Pandoc >= ", recommend, " ",
            "Pandoc with older versions may result in unexpected behaviors.")
  }

  TRUE
}
