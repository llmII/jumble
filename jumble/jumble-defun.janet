(def defun-error
  {:keyword-tuple-3
     "A keyword argument must be a tuple with less than 3 members"
   :keyword-symbol-2
     (string "Cannot specify more than a keyword and symbol when assigning"
             " the keyword for a symbol")})

(defn- process-key
  [args point opt-args defaults bounds]
  (array/push opt-args '&keys)
  (var idx (+ 1 point))

  (let [len (- (length args) bounds)]
    (while (< idx len)
      (def [key sym body] (process-single-key (get args idx)))
      (put keys key sym)
      (array/concat defaults body))))

(defn- process-single-key
  [arg]
  (def [sym key body] [nil nil @[]])
  (match (type arg)
    :symbol (do
              (set sym arg)
              (set key (keyword sym)))
    :tuple  (do
              # error on length > 3!
              (when (> (length arg) 3)
                (error (defun-error :keyword-tuple-3)))
              # figure out the symbol and keyword
              (match (type (get arg 0))
                :symbol (do
                          (set sym arg)
                          (set key (keyword sym)))
                :tuple  (do
                          (when (> length (get arg 0) 2)
                            (error (defun-error :keyword-symbol-2)))
                          (set key (get (get arg 0) 0))
                          (set sym (get (get arg 0) 1))))
              # figure out the body it'll end up pushing in
              (if (= (length arg) 3)
                # default and sentinel
                (array/concat body
                              [~(def ,(get arg 2) (= ,sym nil))]
                              [~(def ,sym (default ,sym) ,(get arg 1))])
                # default or sentinel
                (if (symbol? (get arg 1))
                  (array/push body ~(def ,(get arg 1) (= ,sym nil)))
                  (array/push body
                              ~(def ,sym (default ,sym ,(get arg 1)))))))))
  [key sym [body]]))

(defn- process-opt
  [args point opt-args defaults bounds]
  (array/push opt-args '&opt)
  (var idx (+ 1 point))
  (let [len (- (length args) bounds)]
    (while (< idx len)
      (def cur (get args idx))
      (match (type cur)
        :symbol (array/push opt-args cur)
        :tuple  (do
                  (def [v d] cur)
                  (array/push opt-args v)
                  (array/push defaults
                              ~(def ,v (default ,v ,d)))))
      (++ idx))))

(defn- key-or-opt?
  [args i]
  (case (get args i)
    '&opt :opt
    '&key :key
    _     :none))

(defn- illegal-opt-and-keys?
  [args idx]
  (and (index-of '&key args) (index-of '&opt args)))

(defn- specifier?
  [arg]
  (or (not (symbol? arg))
      (= '&key arg)
      (= '&opt arg)
      (= '& arg)))

(defn variadic?
  [args]
  (= (get args (- (length args) 2)) '&))
# like common lisp?
(defmacro defun
  ```

  Allow for optional and keyword args to have default values specified in the
  args-form. There is support for 4 types of arguments, mandatory arguments,
  optional arguments, keyword arguments, and variadic arguments, of which only
  optional and keyword arguments must not mix. Variadic arguments can only
  come at the very end of the parameter list and if it is specified then the
  entire function is treated as variadic except for mandtory arguments
  (meaning this will prefix the body of the function to pull arguments from
  the variadic set and place them into either keyword or optional arguments).
  Variadic arguments are the set of arguments left after all other argument
  types are consumed.

  Mandatory arguments describe an immutable var to which a value will be
  bound. Mandatory arguments must come before \`&opt\` or \`&keys\` or \`&\`
  symbols. It is optional to specify mandatory arguments.

  Optional arguments are found after the \`&opt\` symbol and before the \`&\`
  symbol. It is optional to specify optional arguments.

  Keyword arguments are found after the \`&keys\` symbol and before the \`&\`
  symbol. It is optional to specify keyword arguments.

  Variadic arguments are found after all symbols, if any are used, are
  specified along with their variables to be bound, and the \`&\` symbol.
  There is only one variadic argument and it's name is specified by the user.
  It is optional to specify variadic arguments.

  Optional arguments may specify a default by using a form instead of a symbol
  for there specification. For example, optional arguments without a form are
  specified like \`... &opt a b c ...\`. With defaults are specified like
  \`... &opt (a 10) (b true) ...\`

  Keyword arguments are specified in a few ways. The first, where the keyword
  assumes the name of the symbol prefixed with a colon, is like
  \`... &key a b c ...\` which to the caller of the defined function would be
  like \`(name ... :a "val" :b "val")\` which to the defined function would be
  that they use values bound to the symbols \`a\` and \`b\` and \`c\`. The
  caller can specify each key at their option (no keyword argument is
  mandatory for the caller to specify a value for), in which case the defined
  function sees a default value of \`nil\`. The definintion must define a
  variable for the value of the keyword argument to be bound to, but may
  optionally specify the keyword the caller would use. To specify the keyword
  a caller would use the definition would be \`... &key ((:keyword symbol))\`.
  When specifying the keyword to be used, the definition becomes a tuple, but
  otherwise, is just a symbol so when used in combination with other
  specification options for a default value or such, the specification would
  be like \`... &key a b c\` for keys without extra specification information,
  replacing each symbol with a tuple in the case a keyword is specified like
  defined prior. When the specification of the keyword has extra information,
  it is like \`... &key (symbol-or-tuple info...)\`. Possible info is either
  a default value (a value) or a symbol (bound to a value determining if the
  caller specified the value in their call) or both. The full form for a
  keyword, is like \`... &key (key-spec default-val sentinel)\` with all but
  key-spec being optional. A few examples:
  \`\`\`
  ... &key (a 0 a-set?) ...
  ... &key ((:kw a) a-set?) ...
  ... &key ((:kw a) 0 a-set?) ...
  ... &key ((:kw a)) ...
  ... &key (a aset?) ...
  \`\`\`
  After the elipsis either more keys can be specified or a final \`&\` symbol,
  followed by a variable to be bound to the value of a list of the rest of the
  arguments. Note that \`nil\` is always a "user did not supply argument" so
  to use sentinel you need a falsey not false value known to your application,
  false sort of works.

  A defun is a (defun optional-doc-string args body)
  The last tuple is assumed to be the body.

  ```
  [& forms]
  (let [body      (array/pop forms)
        args      @[]
        docstring nil
        name      (get forms 0)
        begin     (array/remove forms 0)
        opt-args  @[]
        defaults  @[]
        len       (length forms)]
    (var i 0)
    # have docstring?
    (when (= (type (get forms i)) :string)
      (set docstring (get forms i))
      (++ i))

    # build mandatory
    (while (< i len)
      (def arg (get begin i))
      (when (specifier? arg) break)
      (array/push arg)
      (++ i))

    # variadic?
    (var bounded 0)
    (if (variadic? begin)
      # the rest of args is just & spec
      (do
        (set bounded 2)
        (array/push (get begin (- (length args) 2)))
        (array/push (get begin (- (length args) 1)))
        # build body...
        )
      # process opt or kw? illegal-opt-and-keys will throw an error or return
      # false so everything in an unless block :)
      (unless (illegal-opt-and-keys? begin)
        (match (key-or-opt? begin i)
          :opt (process-opt begin i opt-args defaults)
          :key (process-key begin i opt-args defaults))))

    ))

