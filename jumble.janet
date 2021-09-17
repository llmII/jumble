(import jumble/aliasing :as aliasing)
(import jumble/moddoc   :as moddoc :export true)
# NOTE: until this is deemed working, don't export it under jumble as if it
# does work, especially since it may mean causing jumble to fail on import!
# (import jumble-defun :export true)


# Re-export symbols (you'll end up creating a function/macro to help with this
# at some point most likely)

(each alias-export
    '(defalias* defclone* defclone-* defclone+* defalias defclone defclone+
       defclone- defaliases* defaliases)
  (aliasing/defclone+*
   (symbol "aliasing/" alias-export)
   (symbol alias-export)))
