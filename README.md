
# Table of Contents

1.  [Jumble - llmII&rsquo;s collection of Janet utilities](#org35c0ba0)
    1.  [Installation:](#org50772c1)
    2.  [Use:](#orga3c38b5)
2.  [Submodules](#orgdcacb6b)
    1.  [`jumble-redef`](#orge2077ea)
        1.  [Future: `jumble-defun`](#orgbf37536)
3.  [NOTES:](#org2783378)
    1.  [Create tests](#org4f2c6d7)
    2.  [Fix jumble-redef to expose a better interface](#org7f1ccef)


<a id="org35c0ba0"></a>

# Jumble - llmII&rsquo;s collection of Janet utilities

For some reason I believe others may find these useful. Rather than having
these hide in other things I write as non-exported definitions, the things
that inspire that belief will find their place here.


<a id="org50772c1"></a>

## Installation:

One can install this with `jpm install https://github.com/llmII/jumble`


<a id="orga3c38b5"></a>

## Use:

We&rsquo;ll strive to have a decent doc string for things where we can so just use
the REPL and Janet&rsquo;s `doc` function. When such seems insufficient, or
something warrants a deeper explanation, we&rsquo;ll place such near the end of the
README.

The main thing however, is `(import jumble)` and use `jumble/*`. That or you
could `(use jumble)` where living with the prefix `jumble` seems like too much
noise for you.


<a id="orgdcacb6b"></a>

# Submodules


<a id="orge2077ea"></a>

## `jumble-redef`

When you import `jumble` these should be available under `jumble/*` and are
utilities for creating aliases to a symbol such that when you have a symbol
`sym` you can create aliases like `sym-alias` that will share all properties
that `sym` has (meaning the doc string for both will be the same), with there
being an option to have one property that is differing from the original
`sym`, being whether or not the new alias `sym-alias` is exported.


<a id="orgbf37536"></a>

### Future: `jumble-defun`


<a id="org2783378"></a>

# NOTES:

README.md is generated from the README.org file, so there may be instances
where the README.org is more up to date, though we&rsquo;ll try to avoid that.


<a id="org4f2c6d7"></a>

## TODO Create tests


<a id="org7f1ccef"></a>

## TODO Fix jumble-redef to expose a better interface

Right now it has a few definitions for redef with export as true or not. Need
to do this in a better way.

