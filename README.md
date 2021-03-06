
# Table of Contents

1.  [Jumble - llmII&rsquo;s collection of Janet utilities](#org92cfa3f)
    1.  [Installation:](#orgfcd93a2)
    2.  [Use:](#org6bf2532)
2.  [Submodules](#org50d4ec0)
    1.  [`jumble/aliasing`](#org1d472aa)
    2.  [`jumble/moddoc`](#orgd3f1e19)
    3.  [Future: `jumble/defun`](#org2a1c3cf)
3.  [NOTES:](#orgd3f90e8)
    1.  [Create tests](#org54bc507)
    2.  [Fix jumble-redef to expose a better interface](#orga0a6c29)


<a id="org92cfa3f"></a>

# Jumble - llmII&rsquo;s collection of Janet utilities

For some reason I believe others may find these useful. Rather than having
these hide in other things I write as non-exported definitions, the things
that inspire that belief will find their place here.


<a id="orgfcd93a2"></a>

## Installation:

One can install this with `jpm install https://github.com/llmII/jumble`


<a id="org6bf2532"></a>

## Use:

We&rsquo;ll strive to have a decent doc string for things where we can so just use
the REPL and Janet&rsquo;s `doc` function. When such seems insufficient, or
something warrants a deeper explanation, we&rsquo;ll place such near the end of the
README.

The main thing however, is `(import jumble)` and use `jumble/*`. That or you
could `(use jumble)` where living with the prefix `jumble` seems like too much
noise for you.


<a id="org50d4ec0"></a>

# Submodules


<a id="org1d472aa"></a>

## `jumble/aliasing`

When you import `jumble` these should be available under `jumble/*` and are
utilities for creating aliases to a symbol such that when you have a symbol
`sym` you can create aliases like `sym-alias` that will share all properties
that `sym` has (meaning the doc string for both will be the same), with there
being an option to have one property that is differing from the original
`sym`, being whether or not the new alias `sym-alias` is exported.


<a id="orgd3f1e19"></a>

## `jumble/moddoc`

Utilities for modifying the doc strings of dyns.


<a id="org2a1c3cf"></a>

## Future: `jumble/defun`


<a id="orgd3f90e8"></a>

# NOTES:

README.md is generated from the README.org file, so there may be instances
where the README.org is more up to date, though we&rsquo;ll try to avoid that.


<a id="org54bc507"></a>

## TODO Create tests


<a id="orga0a6c29"></a>

## TODO Fix jumble-redef to expose a better interface

Right now it has a few definitions for redef with export as true or not. Need
to do this in a better way.

