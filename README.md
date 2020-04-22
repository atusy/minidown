
# minidown

<!-- badges: start -->
<!-- badges: end -->

Create simple yet powerful html documents with the mini.css framework.

* mini.css
    * Much smaller and JavaScript-free compared to Bootstrap which is employed by `rmarkdown::html_document`
* Features
    * Code folding
      * for source, output, message, warning, and error
    * Accordions
    * Tooltip
    * Floating TOC
    * Math with KaTeX
    * and more!
* HTML5
  * The Pandoc's HTML5 template is minimally modified by
    * removing math section to support KaTeX CDN even if self contained
    * wrapping body paragraphs by the `<article>` tag.

## Installation

``` r
remotes::install_github("atusy/minidown")
```


