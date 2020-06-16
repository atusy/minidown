# minidown 0.0.1.8

* New features
  * `mini_document` adds `results_folding` option to fold entire results including figures and tables.
  * `mini_document()` adds `code_download` option
  * Add `download_rmd_button()` so that users can place a download button anywhere
    in the document.
  * Add `set_results_folding()`. This function adds results folding feature to any R Markdown output formats that creates HTML.
* Template and layouts
  * On template, Elements aftter `include-before` and `include-after` are wrapped by `<main>`
    element. Accordingly, `mini_document(toc_float = TRUE)` applies CSS Grid Layout on `<main>` element and its contents. In this way, users can safely include additional contents.
  * For the consistency with `mini_document(code_folding = TRUE)`, the max-width of body become 900px when `code_folding = FALSE`
* Bug fix
  * fix `self_contained: false` not working properly
  * exclude `toc_float`-related CSS if the `toc` option is `FALSE` (#15).

# minidown 0.0.1

* Initial release with the support of following frameworks:
  * mini.css
  * sakura
  * Water.css
