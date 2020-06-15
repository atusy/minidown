# minidown 0.0.1.7

* New features
  * Implement `results_folding` option to fold entire results including figures and tables.
  * Implement `code_download` option for `mini_document()`
  * Add `download_rmd_button()` so that users can place a download button anywhere
    in the document.
* Template
  * Elements aftter `include-before` and `include-after` are wrapped by `<main>`
    element.
* Layout
  * CSS Grid layout for floating TOC is applied to `<main>` instead of `<body>`
    so that `include-before` and `include-after` works safely.
  * For the consistency with `code_folding = TRUE`,
    the max-width of body become 900px when `code_folding = FALSE`
* Bug fix
  * fix `self_contained: false` not working properly
  * exclude `toc_float`-related CSS if the `toc` option is `FALSE` (#15).
    

# minidown 0.0.1

* Initial release with the support of following frameworks:
  * mini.css
  * sakura
  * Water.css
