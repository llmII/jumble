
# Table of Contents

1.  [Jumble - llmII&rsquo;s collection of Janet utilities](#orga29bac1)
    1.  [Installation:](#org3b3129c)
    2.  [Use:](#org6d87b53)
2.  [Submodules](#orga01c7e8)
    1.  [`jumble-redef`](#orga680d85)
        1.  [Future: `jumble-defun`](#org19fcdf0)
3.  [NOTES:](#orgb4f264c)

\#+TITLE jumble - llmII&rsquo;s collection of Janet utilities

1.  TODO Create tests

2.  TODO Fix jumble-redef to expose a better interface

    Right now it has a few definitions for redef with export as true or not. Need
    to do this in a better way.


<a id="orga29bac1"></a>

# Jumble - llmII&rsquo;s collection of Janet utilities

For some reason I believe others may find these useful. Rather than having
these hide in other things I write as non-exported definitions, the things
that inspire that belief will find their place here.


<a id="org3b3129c"></a>

## Installation:

One can install this with `jpm install https://github.com/llmII/jumble`


<a id="org6d87b53"></a>

## Use:

We&rsquo;ll strive to have a decent doc string for things where we can so just use
the REPL and Janet&rsquo;s `doc` function. When such seems insufficient, or
something warrants a deeper explanation, we&rsquo;ll place such near the end of the
README.

The main thing however, is `(import jumble)` and use `jumble/*`. That or you
could `(use jumble)` where living with the prefix `jumble` seems like too much
noise for you.


<a id="orga01c7e8"></a>

# Submodules


<a id="orga680d85"></a>

## `jumble-redef`

When you import `jumble` these should be available under `jumble/*` and are
utilities for creating aliases to a symbol such that when you have a symbol
`sym` you can create aliases like `sym-alias` that will share all properties
that `sym` has (meaning the doc string for both will be the same), with there
being an option to have one property that is differing from the original
`sym`, being whether or not the new alias `sym-alias` is exported.


<a id="org19fcdf0"></a>

### Future: `jumble-defun`


<a id="orgb4f264c"></a>

# NOTES:

README.md is generated from the README.org file, so there may be instances
where the README.org is more up to date, though we&rsquo;ll try to avoid that.

