---
title: "minidown::mini_document"
author: "Atsushi Yasumoto"
date: "2020-06-14"
output:
  minidown::mini_document:
    framework: sakura
    theme: default
    code_folding:
      source: show
      output: show
      message: hide
      warning: hide
      error: show
    results_folding: hide
    toc: true
    toc_float: true
    number_sections: true
    self_contained: true
    code_download: false
    keep_md: true
---







::: {style='text-align: right'}
[Download Rmd](index.Rmd){download=minidown.Rmd .button}
:::

This article introduces rich features of `minidown::mini_document` with live examples.
This format is powered by R Markdown, Pandoc, KaTeX and **light weight CSS framewroks** such as sakura (default), Water.css, mini.css, and so on.

If you haven't installed the `minidown` package on R, install it by

```r
remotes::install_github('atusy/minidown')
```

Documentation is ready at [here](pkgdown/index.html).

# Frameworks and themes

Default framework and its theme are `"sakura"` and `"default"`.
Followings are the list of available ones.
Live examples are available via links.


```{.chunk-message .details summary='Message'}
## `summarise()` ungrouping output (override with `.groups` argument)
```



framework   theme                                                                                                                                                     
----------  ----------------------------------------------------------------------------------------------------------------------------------------------------------
sakura      [default](index.html), [dark_solarized](sakura-dark_solarized.html), [dark](sakura-dark.html), [earthly](sakura-earthly.html), [vader](sakura-vader.html) 
water       [light](water-light.html), [dark](water-dark.html)                                                                                                        
mini        [default](mini-default.html), [nord](mini-nord.html), [dark](mini-dark.html)                                                                              



`</details>`{=html}

# Code folding

Code folding can be controlled by the YAML frontmatter like:

```
output:
  minidown::mini_document:
    code_folding:
      source: show
      output: show
      message: hide
      warning: hide
      error: show
```

The above results in


```{.r .numberLines .chunk-source .details .show summary='Source'}
f <- function() {
  print(1)
  message('message')
  warning('warning')
  stop('error')
}
f()
```



`<details class='chunk-results'><summary>Results</summary>`{=html}

```{.chunk-output .details .show summary='Output'}
## [1] 1
```

```{.chunk-message .details summary='Message'}
## message
```

```{.chunk-warning .details summary='Warning'}
## Warning in f(): warning
```

```{.chunk-error .details .show summary='Error'}
## Error in f(): error
```



`</details>`{=html}

If the code folding is specified for some of them,
then the code folding of the others will be `none`.

Like `rmarkdown::html_document`,
`code_folding: show` indicates source is `show` and others are `none`.

By default `code_folding` is `none`, however, you can select some chunks be folded by giving the `details` class (e.g., `source.class='details'`).

## Show/hide exceptions

When `source: show`, all the sources are shown.
In case you need exceptions, add the `hide` class to the source.
If you want to hide all with exceptions, add the `show` class to the exceptions.
Of course, this feature is not limited to the source.

````
---
output:
  minidown::mini_document:
    code_folding:
      source: show
---

```{r}
'This is shown'
```


```{r, source.class='hide'}
'This is hidden'
```
````

and `hide` classes.

## Change summary

The content of summary can be controlled via `summary.*` chunk options.
This feature is useful when you want to show the title of the source, to treat the output as a hidden answer, and so on.


```{.r .chunk-source .details .show summary='iris.R'}
# summary.source='iris.R', summary.output='Answer', class.output='hide'
head(iris)
```



`<details class='chunk-results'><summary>Results</summary>`{=html}

```{.hide .chunk-output .details summary='Answer'}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```



`</details>`{=html}

## Fold only some

Even if `none` is specified in YAML, code folding can be enabled for selected chunks by adding the `details` class.

````
---
output:
  minidown::mini_document:
    code_folding: none
---

```{r}
'This is shown'
```


```{r, source.class='details hide'}
'This is hidden'
```

````

## Prefer `rmarkdown::html_document`

If you prefer `rmarkdown::html_document` except for the code foliding,
specify the `theme` other than `"mini"`.

```yaml
output:
  minidown::mini_document:
    theme: default
    code_folding: show
```

To put the summary on right instead of left, add the following chunk in your document.

````
```{css, echo=FALSE}
.chunk-summary {text-align: right;}
```
````

The features below are available only if the `theme` is `"mini"`

# Results folding

By specifying `result_folding: show` or `hide`, you can fold entire results.

```yaml
output:
  minidown::mini_document:
    results_folding: show # hide or none
```

This is a good option when you have side effects such as drawing figures and tables.
Result button is placed on the left so that you can distinguish from code_folding buttons.


```{.r .chunk-source .details .show summary='Source'}
knitr::kable(iris[1:2, ])
```



`<details class='chunk-results'><summary>Results</summary>`{=html}



 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  



`</details>`{=html}


## Change summary text

By default, summary text is "Results".
You can change this by a chunk option, `summary.results`.
Just like `summary.*` in code folding.

## Multiple results per chunk

If you have multiple results per chunk and combine them to a single folding,
you have three options.


### Set chunk options

with `results='hold'` and/or `fig.show='hold'`.


```{.r .chunk-source .details .show summary='Source'}
'foo'
knitr::kable(iris[1:2, ])
```



`<details class='chunk-results'><summary>Results</summary>`{=html}

```{.chunk-output .details .show summary='Output'}
## [1] "foo"
```



 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  



`</details>`{=html}

### Iterate with `for` or `lapply`

or their friends.


```{.r .chunk-source .details .show summary='Source'}
for (i in 1:2) print(i)
```



`<details class='chunk-results'><summary>Results</summary>`{=html}

```{.chunk-output .details .show summary='Output'}
## [1] 1
## [1] 2
```



`</details>`{=html}

### Define a function with side effects


```{.r .chunk-source .details .show summary='Source'}
f <- function() {
  print('foo')
  knitr::knit_print(knitr::kable(iris[1:2, ]))
}

f()
```



`<details class='chunk-results'><summary>Results</summary>`{=html}

```{.chunk-output .details .show summary='Output'}
## [1] "foo"
```



 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  



`</details>`{=html}

## Make some exeptions

To disable folding for some chunks, specify `results.folding=NULL` as a chunk option.
When `results_folding: show` and you want to hide for some, then specify `results.folding='hide'` as a chunk option.
Similarly, you make exeptions for `results_folding: hide` as well.

To disable folding by default, but enable it for some chunks,
then specify `results_folding: show # or hide` as a YAML front matter,
and run `knitr::opts_chunk$set(results.folding=NULL)` at the beggining of your document.
Then, you can enable the feature for selected chunks by specifying `'show'` or `'hide'` to the `results.folding` chunk option.

~~~
---
output:
  minidown::mini_document:
    result_folding: show
---

`r''````{r, include=FALSE}
knitr::opts_knit$set(results.folding=NULL)
`r''````

`r''````{r}
'This chunk does not fold results'
`r''````


`r''````{r, result.folding='hide'}
'This chunk hides not fold results'
`r''````
~~~

# Floating TOC

Table of contents can be floated on the left of the page by specifying `toc_float: true`.
The layout is responsive to the windows size.
Thus, floating TOC is available when the viewport has the enough width.
See what happens by shrinking the width of your browser.

```yaml
output:
  minidown::mini_document:
    toc: true
    toc_float: true
```

# Accordion menu 

:::::: {.collapse}

::::: {menu='How' .show}

Add the collapse class to a heading.
Under the heading, separate blocks with Pandoc's Divs
with `menu=title` attribute.
If you add `show` class, menu is open by default.

:::::

::::: {menu='Hidden'}

This is hidden by default because of the missing 'show' class.

:::::

::::::

# Tooltips

**[[]{.icon-info}Tooltips]{tooltip='Here is a tooltip'}** are available.

```md
[text]{tooltip='tooltip'}
```

# Math with KaTeX

`$\sum_{i=1}^{10}{\alpha_i}$` becomes $\sum_{i=1}^{10}{\alpha_i}$ and

```md
$$
\sum_{i=1}^{10}{\alpha_i}
$$
```

becomes

$$
\sum_{i=1}^{10}{\alpha_i}
$$

# Others

Visit <https://minicss.org/docs> for other features available via the `mini.css` framework.

# Appendix: markdown results

## Headings (H2)

### H3

#### H4

##### H5

###### H6

## Block quotations

> Single

> Nesting
>
>> another

## Code blocks

A code block without line numbers.

```
Code block
```

A code block with line numbers.

```{.r .numberLines startFrom=10}
f <- function() {
  print(1)
  message('message')
  warning('warning')
  stop('error')
}
f()
```

### Code blocks with long lines

#### Without specifiying language

```
long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long 
```

#### With specifying language

##### Without line numbers

```{.r}
long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long 
```

##### With line numbers

```{.r .numberLines}
long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long 
```

## Lists

### Bullet lists

Tight

* Tight 1
* Tight 2
  * Tight 2-1
  * Tight 2-2

Loose

* Loose 1

* Loose 2

* Loose 3

### Ordered lists

1.  one
2.  two
3.  three

### Task lists

- [ ] an unchecked task list item
- [x] checked item

### Definition lists

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b

## Horizontal rule

___

## Table


 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  
          4.7           3.2            1.3           0.2  setosa  
          4.6           3.1            1.5           0.2  setosa  
          5.0           3.6            1.4           0.2  setosa  
          5.4           3.9            1.7           0.4  setosa  



`</details>`{=html}


## Inline formatting

- *Emphasis*
- **Strong emphasis**
- ~~Strikeout~~
- super^script^
- sub~script~
- `Verbatim`
- [Small caps]{.smallcaps}

## Link

[Atusy's Twitter](https://twitter.com/Atsushi776)

## Image

![Atusy's avator](avator.jpeg){data-external="1"}

## Footnote

See^[footnote]
