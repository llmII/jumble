(import jumble-redef :as jredef)
# NOTE: until this is deemed working, don't export it under jumble as if it
# does work, especially since it may mean causing jumble to fail on import!
# (import jumble-defun :export true)


# Re-export symbols (you'll end up creating a function/macro to help with this
# at some point most likely)

(each redef-export
    '(redef redef-clone redef- redef+ redef-symbol redef-multi* redef-multi)
  (jredef/redef+ (string "jredef/" redef-export) (string redef-export)))
