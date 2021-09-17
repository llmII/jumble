(def- moddoc-errors
  {:know-how-def-replace
   "Don't know how to replace definition on other types yet."})

(defn- value-of
  ```
  `sym` **:symbol**

  Evaluate a symbol for it's value. Uses eval.
  ```
  [sym]
  ((dyn sym) :value))

(defn replace-definition*
  ```
  \t\`defined\`     **:symbol**
  \t\`pattern\`     **:string**
  \t\`sustitution\` **:string**

  Replaces the definition of a bound symbol in it's documentation.
  Allows for one to take a function \`fun\` with args \`a b c\` which gets
  an automatic definition in it's doc string of \`(fun a b c)\` and replace
  that part of the documentation.

  Example:
  \`\`\`
  (defn fun
    "Some documentation"
    [a b c] (print "expect that b may actually be a keyword"))
  (jumble/moddoc/replace-definition "(blah a :keyword|b c)")
  \`\`\`
  ```
  [defined substitution]
  (match (type (value-of defined))
    :function (let [doc     ((dyn defined) :doc)
                    start   (string/find (string "(" defined) doc)
                    end     (- (string/find "\n" doc) 1)
                    pattern (string/slice doc start end)]
                (set ((dyn defined) :doc)
                     (string/replace pattern substitution doc))))
  _         (error (moddoc-errors :know-how-def-replace)))
  )

(defmacro replace-definition
  ```
  \t\`defined\`     **:symbol (bound)**
  \t\`pattern\`     **:string**
  \t\`sustitution\` **:string**

  Replaces the definition of a bound symbol in it's documentation.
  Allows for one to take a function \`fun\` with args \`a b c\` which gets
  an automatic definition in it's doc string of \`(fun a b c)\` and replace
  that part of the documentation.

  Example:
  \`\`\`
  (defn fun
    "Some documentation"
    [a b c] (print "expect that b may actually be a keyword"))
  (jumble/moddoc/replace-definition "(blah a :keyword|b c)")
  \`\`\`
  ```
  [defined substitution]
  ~(replace-definition* ',defined ,substitution))
