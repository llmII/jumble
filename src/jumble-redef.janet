# Definition from:
#   https://github.com/janet-lang/spork/blob/master/spork/path.janet
# License: MIT
# Copyright: 2019 Calvin Rose
# Overall Copyright: 2020 Calvin Rose and contributors
(defn redef
  "Redef a value, keeping all metadata."
  [from to]
  (setdyn (symbol to) (dyn (symbol from))))

(defn redef-clone
  "Redef a value, keeping all metadata."
  [from to]
  (setdyn (symbol to) (table/clone (dyn (symbol from)))))

(defn redef-
  "Redef a value, then set it private in it's metadata."
  [from to]
  (redef-clone from to)
  (set ((dyn (symbol to)) :private) true))

(defn redef+
  "Redef a value, then set it private in it's metadata."
  [from to]
  (redef-clone from to)
  (set ((dyn (symbol to)) :private) false))

(defmacro redef-symbol
  "Redef, minus the string conversions/usage."
  [from to]
  ~(redef+ ,(string from) ',to))

(defn redef-multi*
  ```
  Helper for redef-multi, does redefs over an indexed collection. Makes each
  new symbol exported.
  ```
  [from to]
  (redef+ from (get to 0))
  (var idx (- (length to) 1))
  (while (> idx 0)
    (redef+ (string (get to 0)) (get to idx))
    (-- idx)))

(defmacro redef-multi
  "Redef each symbol after the first as the first."
  [from & to]
     (var i 0)
     (let [len        (length to)
           collecting @[]]
       (while (< i len)
         (array/push collecting (get to i))
         (++ i))
       ~(redef-multi* ,(string from) ',collecting)))
