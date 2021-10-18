(use jumble/moddoc)
(defn- is-export?
  "Figure out if in an array, this index is :export, and next is true/false."
  [arg idx]
  (and (= (get arg idx) :export) (= (type (get arg (+ idx 1))) :boolean)))

(defn exported?*
  "Checks if a symbol is exported. Function form."
  [symbol]
  ((dyn symbol) :private))

(defmacro exported?
  "Checks if a symbol is exported."
  [symbol]
  ~((dyn ',symbol) :private))

# Definition from:
#   https://github.com/janet-lang/spork/blob/master/spork/path.janet
# License: MIT
# Copyright: 2019 Calvin Rose
# Overall Copyright: 2020 Calvin Rose and contributors
# Definition modified heavily.
(defn defalias*
  ```
  	`sym`   **:symbol**

  	`alias` **:symbol**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is shared so if it is changed at a later time on
  either `alias` or `sym` the other aliases defined with this, as well as
  the original symbol will reflect the changes. Function form.
  ```
  [sym alias]
  (setdyn alias (dyn sym)))

(defn defclone*
  ```
  	`sym`     **:symbol**

  	`alias`   **:symbol**

  	`:export` **:boolean**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is cloned not shared. The clone will be an
  exported symbol dependent upon the keyword `:export`'s value. Function
  form.
  ```
  [sym alias &keys {:export export}]
  (default export false)
  (setdyn alias (table/clone (dyn sym)))
  (set ((dyn alias) :private) (not export)))

(defn defclone-*
  ```
  	`sym`     **:symbol**

  	`alias`   **:symbol**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is cloned not shared. The clone is an exported
  symbol. Function form.
  ```
  [sym alias]
  (defclone* sym alias :export false))

(defn defclone+*
  ```
  	`sym`     **:symbol**

  	`alias`   **:symbol**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is cloned not shared. The clone is not an
  exported symbol. Function form.
  ```
  [sym alias]
  (defclone* sym alias :export true))

(defmacro defalias
  ```
  	`sym`   **:symbol**

  	`alias` **:symbol**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is shared so if it is changed at a later time on
  either `alias` or `sym` the other aliases defined with this, as well as
  the original symbol will reflect the changes. Macro form.
  ```
  [sym alias]
  ~(defalias* (symbol ',sym) ',alias))

(defmacro defclone
  ```
  	`sym`     **:symbol**

  	`alias`   **:symbol**

  	`:export` **:boolean**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is cloned not shared. The clone will be an
  exported symbol dependent upon the keyword `:export`'s value. Macro form.
  ```
  [sym alias &keys {:export export}]
  (default export false)
  ~(defclone* (symbol ',sym) ',alias :export ,export))

(defmacro defclone+
  ```
  	`sym`     **:symbol**

  	`alias`   **:symbol**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is cloned not shared. The clone is an exported
  symbol. Macro form.
  ```
  [sym alias]
  ~(defclone* (symbol ',sym) ',alias :export true))

(defmacro defclone-
  ```
  	`sym`     **:symbol**

  	`alias`   **:symbol**


  Define an `alias` for symbol `sym`. `alias` retains all the metadata
  from `sym`. The metadata is cloned not shared. The clone is an exported
  symbol. Macro form.
  ```
  [sym alias]
  ~(defclone* (symbol ',sym) ',alias :export false))

(defn defaliases*
  ```
  	`sym`     **:symbol**

  	`aliases` **indexed?**

  	`:export` **:boolean**


  Define each alias in `aliases` as an alias to `sym`. The first alias made is
  a clone of `sym` and the rest are aliases to this clone so as to allow for
  `:export` to determine whether the symbol is exported or not. None of the
  aliases share data with the symbol, just with the first alias created. The
  first alias created clones the metadata of the `sym`. Function form.

  ```
  [sym aliases &keys {:export export}]
  # Always clone symbol here (in case the original symbol gets modified to not
  # exported).
  (default export false)
  (printf "DEFALIASES* %q %q %q" sym aliases export)
  (defclone* sym (get aliases 0) :export export)

  (var idx (- (length aliases) 1))
  (while (> idx 0)
    (defalias* (symbol (get aliases 0)) (get aliases idx))
    (-- idx)))

# defaliases?
(defmacro defaliases
  ```
  	`sym`     **:symbol**

  	`aliases` **indexed?**

  	`:export` **:boolean**


  Define each alias in `aliases` as an alias to `sym`. The first alias made is
  a clone of `sym` and the rest are aliases to this clone so as to allow for
  `:export` to determine whether the symbol is exported or not. None of the
  aliases share data with the symbol, just with the first alias created. The
  first alias created clones the metadata of the `sym`. Macro form.

  Notes: the keyword argument `:export` may be placed anywhere in the call
  to `defaliases`. `(defalias a b c :export true)` and
  `(defalias a b :export true c)` are the exact same, unlike with normal
  keyword argument calls.
  ```
  [sym & aliases]

  (var i 0)
  (let [len        (length aliases)
        collecting @[]
        rest       @[]]
    (while (< i len)
      (if (is-export? aliases i)
        # export keyword args
        (do
          (array/concat rest (array/slice aliases i (+ i 2)))
          (+= i 2))
        # not export keyword args!
        (do
          (array/push collecting (get aliases i))
          (++ i))))

    ~(defaliases* (symbol ',sym) ',collecting ,;rest)))
(replace-definition defaliases
                    "(defaliases from &keys {:export} & to)")
