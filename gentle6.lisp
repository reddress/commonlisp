(defun mystery (x) (first (last (reverse x))))

(defun make-palindrome (lst)
  (append lst (reverse lst)))

;; 6.36
(defun swap-first-last (lst)
  (append (append (last lst) (reverse (cdr (reverse (rest lst))))) (list (first lst))))