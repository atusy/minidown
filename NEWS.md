# minidown 0.0.2.2

* Layouts
  * Fixed css jitter by `a.button:hover` on the sakura framework (thanks, @jmbuhr, #20)
* Bug fix
  * Internal `check_pandoc_version()` warned even if systems have Pandoc >= 2.7.2 (thanks, @eddelbuettel, #19).

# minidown 0.0.2

* New features
  * `mini_document()` adds `results_folding` option to fold entire results including figures and tables.
  * `mini_document()` adds `code_download` option
  * Add `download_rmd_button()` so that users can place a download button anywhere
    in the document.
  * `mini_document()` warns if Pandoc is older than expected. Especially, if Pandoc < 2.0, `--lua-filters` pandoc argument is omitted.
* Template and layouts
  * On template, Elements after `include-before` and `include-after` are wrapped by `<main>`
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
