(defun f (x) (/ 1 x))

(defun g (x) (+ 1 (f x)))

;; (g 0)

(g 2)

(g 0)
