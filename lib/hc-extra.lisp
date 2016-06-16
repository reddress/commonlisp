;;;; auxiliary and extra functions available in clojure

(defun range (n)
  (loop for i from 0 to (- n 1) collecting i))

(defun repeat (n x)
  (loop for i from 1 to n collecting x))

;;; take the first n items of lst
(defun first-n (n lst)
  (reverse
   (nthcdr (- (length lst) n) (reverse lst))))
