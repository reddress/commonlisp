(use 'clojure.repl)
(doc doc)

(defn square [x] (* x x))

(map square '(1 2 3))

(defn zerop [n]
  (= 0 n))

(defn lowest [lst]
  (zerop lst))

