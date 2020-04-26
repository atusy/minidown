---
title: "Minidown's features"
author: "Atsushi Yasumoto"
date: "2020-04-26"
output:
  minidown::mini_document:
    framework: water
    code_folding:
      source: show
      output: show
      message: hide
      warning: hide
      error: show
    toc: true
    toc_float: true
    keep_md: true
    number_sections: true
---

::: {style='text-align: right'}
[Download Rmd](index.Rmd){download=minidown.Rmd .button}
:::

This article introduces rich features of `minidown::mini_document` with live examples.
These are powered by R Markdown, Pandoc, KaTeX and **light weight CSS framewroks** such as water, mini, and so on.

If you haven't installed the `minidown` package on R, install it by

```r
remotes::install_github('atusy/minidown')
```

# Frameworks and themes



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

```{.hide .chunk-output .details summary='Answer'}
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

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

# Floating TOC

Table of contents can be floated on the left of the page by specifying `toc_float: true`.
The layout is responsive to the windows size.
Thus, floating TOC is available when the viewport has the enough width.
See what happens by shrinking the width of your browser.

```yaml
output:
  minidown::mini_document:
    toc_float: true
```

# Accordion menu 

:::::: {.collapse}

::::: {menu='How' .show}

Add the collapse class to a heading.
Under the heading, separate blocks with Pandoc's Divs
with `menu=title` attribute.
If you add `show` class, menu is open by default.

::: {}

foo

:::


:::::

::::: {menu='Hidden'}

This is hidden by default because of the missing 'show' class.

:::::

::::::

# Tooltips

[[]{.icon-info}tooltips]{tooltip='Here is a tooltip'} are available.

```md
[text]{tooltip='tooltip'}
```

# Icons

Visit https://minicss.org/docs#icons for available icons.

[]{.icon-alert}
[]{.icon-bookmark}
[]{.icon-calendar}
[]{.icon-cart}
[]{.icon-credit}

```md
[]{.icon-alert}
[]{.icon-bookmark}
[]{.icon-calendar}
[]{.icon-cart}
[]{.icon-credit}
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

# H1

## H2

### H3

#### H4

##### H5

###### H6

# Block quotations

> Single

> Nesting
>
>> another

# Code blocks

```
Code block
```

```{.r .numberLines startFrom=100}
f <- function() {
  print(1)
  message('message')
  warning('warning')
  stop('error')
}
f()
```


```{.css .chunk-source .details .show summary='Source'}
.chunk-summary+pre,
.chunk-summary+div.sourceCode {
  margin-top: 2px;
}
```


<style type="text/css">
.chunk-summary+pre,
.chunk-summary+div.sourceCode {
  margin-top: 2px;
}
</style>

## Code blocks with long lines

### Class-less

```
long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long 
```

### Classed

#### Without line numbers

```{.r}
long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long 
```

#### With line numbers

```{.r .numberLines}
long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long long 
```





# Lists

## Bullet lists

Tight

* Tight 1
* Tight 2
  * Tight 2-1
  * Tight 2-2

Loose

* Loose 1

* Loose 2

* Loose 3

## Ordered lists

1.  one
2.  two
3.  three

## Task lists

- [ ] an unchecked task list item
- [x] checked item

## Definition lists

Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b

# Horizontal rule

___

# Table


 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  
          4.7           3.2            1.3           0.2  setosa  
          4.6           3.1            1.5           0.2  setosa  
          5.0           3.6            1.4           0.2  setosa  
          5.4           3.9            1.7           0.4  setosa  


# Inline formatting

- *Emphasis*
- **Strong emphasis**
- ~~Strikeout~~
- super^script^
- sub~script~
- `Verbatim`
- [Small caps]{.smallcaps}

# Link

[Atusy's Twitter](https://twitter.com/Atsushi776)

# Image

![Atusy's avator](https://avatars2.githubusercontent.com/u/30277794?s=400&u=04af2c7daa8d62aa104be62896021983644b1658&v=4){width=50%}

# Footnote

See^[footnote]
