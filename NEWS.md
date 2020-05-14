# minidown 0.0.1.2

* Template
  * Elements aftter `include-before` and `include-after` are wrapped by `<main>`
    element.
* Layout
  * CSS Grid layout for floating TOC is applied to `<main>` instead of `<body>`
    so that `include-before` and `include-after` works safely.
  * For the consistency with `code_folding = TRUE`,
    the max-width of body become 900px when `code_folding = FALSE`

# minidown 0.0.1

* Initial release with the support of following frameworks:
  * mini.css
  * sakura
  * Water.css
