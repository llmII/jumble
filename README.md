
# Table of Contents

1.  [Create tests](#orga57deb0)
2.  [Fix jumble-redef to expose a better interface](#orga7e055b)
3.  [Jumble - llmII&rsquo;s collection of Janet utilities](#orgf84c935)
    1.  [Installation:](#org6467b3f)
    2.  [Use:](#orgabf4df3)
4.  [Submodules](#org7609671)
    1.  [`jumble-redef`](#org9ddebb9)
        1.  [Future: `jumble-defun`](#orge5469c6)
5.  [NOTES:](#orgf21f1ae)

\#+TITLE jumble - llmII&rsquo;s collection of Janet utilities


<a id="orga57deb0"></a>

# TODO Create tests


<a id="orga7e055b"></a>

# TODO Fix jumble-redef to expose a better interface

Right now it has a few definitions for redef with export as true or not. Need
to do this in a better way.


<a id="orgf84c935"></a>

# Jumble - llmII&rsquo;s collection of Janet utilities

For some reason I believe others may find these useful. Rather than having
these hide in other things I write as non-exported definitions, the things
that inspire that belief will find their place here.


<a id="org6467b3f"></a>

## Installation:

One can install this with `jpm install https://github.com/llmII/jumble`


<a id="orgabf4df3"></a>

## Use:

We&rsquo;ll strive to have a decent doc string for things where we can so just use
the REPL and Janet&rsquo;s `doc` function. When such seems insufficient, or
something warrants a deeper explanation, we&rsquo;ll place such near the end of the
README.

The main thing however, is `(import jumble)` and use `jumble/*`. That or you
could `(use jumble)` where living with the prefix `jumble` seems like too much
noise for you.


<a id="org7609671"></a>

# Submodules


<a id="org9ddebb9"></a>

## `jumble-redef`

When you import `jumble` these should be available under `jumble/*` and are
utilities for creating aliases to a symbol such that when you have a symbol
`sym` you can create aliases like `sym-alias` that will share all properties
that `sym` has (meaning the doc string for both will be the same), with there
being an option to have one property that is differing from the original
`sym`, being whether or not the new alias `sym-alias` is exported.


<a id="orge5469c6"></a>

### Future: `jumble-defun`


<a id="orgf21f1ae"></a>

# NOTES:

README.md is generated from the README.org file, so there may be instances
where the README.org is more up to date, though we&rsquo;ll try to avoid that.

